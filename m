Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbeBVCL2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 21:11:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46256 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751802AbeBVCL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 21:11:27 -0500
Date: Wed, 21 Feb 2018 18:11:47 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Byungchul Park <byungchul.park@lge.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [QUESTION] srcu: Remove the SCAN2 state
Reply-To: paulmck@linux.vnet.ibm.com
References: <1519257447-4232-1-git-send-email-byungchul.park@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519257447-4232-1-git-send-email-byungchul.park@lge.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022202-0044-0000-0000-000003E7FD16
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008573; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00993220; UDB=6.00504663; IPR=6.00772564;
 MB=3.00019680; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-22 02:11:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022202-0045-0000-0000-00000818032A
Message-Id: <20180222021147.GA2855@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-21_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802220027
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 08:57:27AM +0900, Byungchul Park wrote:
> Hello,
> 
> I'm sorry for bothering you, and I seem to be obviously missing
> something, but I'm really wondering why we check try_check_zero()
> again in the state, SCAN1, for the previous srcu_idx.
> 
> I mean, since we've already checked try_check_zero() in the previous
> grace period and gotten 'true' as a return value, all readers who see
> the flipped idx via srcu_flip() won't update the src_{lock,unlock}_count
> for the previous idx until it gets flipped back again.
> 
> Is there any reasons we check try_check_zero() again in the state, SCAN1?
> Is there any problems if the following patch's applied?

Indeed there are!  Removing the second scan exposes us to a nasty race
condition where a reader is preempted (or interrupted or whatever) just
after fetching its counter.  A detailed explanation for an essentially
equivalent race in userspace RCU may be found on the second column of
page 7 of this PDF:

http://www.computer.org/cms/Computer.org/dl/trans/td/2012/02/extras/ttd2012020375s.pdf

But please let me know if I am missing the point of your patch below.

							Thanx, Paul

> Thanks in advance,
> Byungchul
> 
> ---
>  kernel/rcu/srcutree.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index 39e50fe..215c44a 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -1125,24 +1125,10 @@ static void srcu_advance_state(struct srcu_struct *sp)
>  			mutex_unlock(&sp->srcu_gp_mutex);
>  			return; /* Someone else started the grace period. */
>  		}
> -	}
> -
> -	if (rcu_seq_state(READ_ONCE(sp->srcu_gp_seq)) == SRCU_STATE_SCAN1) {
> -		idx = 1 ^ (sp->srcu_idx & 1);
> -		if (!try_check_zero(sp, idx, 1)) {
> -			mutex_unlock(&sp->srcu_gp_mutex);
> -			return; /* readers present, retry later. */
> -		}
>  		srcu_flip(sp);
> -		rcu_seq_set_state(&sp->srcu_gp_seq, SRCU_STATE_SCAN2);
>  	}
> 
> -	if (rcu_seq_state(READ_ONCE(sp->srcu_gp_seq)) == SRCU_STATE_SCAN2) {
> -
> -		/*
> -		 * SRCU read-side critical sections are normally short,
> -		 * so check at least twice in quick succession after a flip.
> -		 */
> +	if (rcu_seq_state(READ_ONCE(sp->srcu_gp_seq)) == SRCU_STATE_SCAN1) {
>  		idx = 1 ^ (sp->srcu_idx & 1);
>  		if (!try_check_zero(sp, idx, 2)) {
>  			mutex_unlock(&sp->srcu_gp_mutex);
> -- 
> 1.9.1
> 
