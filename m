Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933307AbeBVQyG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:54:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36404 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933139AbeBVQyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:54:05 -0500
Date: Thu, 22 Feb 2018 08:54:25 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Byungchul Park <byungchul.park@lge.com>
Cc: jiangshanlai@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [QUESTION] srcu: Remove the SCAN2 state
Reply-To: paulmck@linux.vnet.ibm.com
References: <1519257447-4232-1-git-send-email-byungchul.park@lge.com>
 <20180222021147.GA2855@linux.vnet.ibm.com>
 <fb00133e-776b-50c7-1a46-b56c3339622b@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb00133e-776b-50c7-1a46-b56c3339622b@lge.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18022216-0048-0000-0000-0000023DD7C6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008577; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00993514; UDB=6.00504839; IPR=6.00772854;
 MB=3.00019692; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-22 16:54:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022216-0049-0000-0000-000044385AB9
Message-Id: <20180222165425.GE2855@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-22_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802220213
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 02:05:18PM +0900, Byungchul Park wrote:
> On 2/22/2018 11:11 AM, Paul E. McKenney wrote:
> >On Thu, Feb 22, 2018 at 08:57:27AM +0900, Byungchul Park wrote:
> >>Hello,
> >>
> >>I'm sorry for bothering you, and I seem to be obviously missing
> >>something, but I'm really wondering why we check try_check_zero()
> >>again in the state, SCAN1, for the previous srcu_idx.
> >>
> >>I mean, since we've already checked try_check_zero() in the previous
> >>grace period and gotten 'true' as a return value, all readers who see
> >>the flipped idx via srcu_flip() won't update the src_{lock,unlock}_count
> >>for the previous idx until it gets flipped back again.
> >>
> >>Is there any reasons we check try_check_zero() again in the state, SCAN1?
> >>Is there any problems if the following patch's applied?
> >
> >Indeed there are!  Removing the second scan exposes us to a nasty race
> >condition where a reader is preempted (or interrupted or whatever) just
> 
> Indeed! I missed the cases. It should be as it is.
> 
> Thanks a lot for pointing it out.

Heh!  Everyone I know, myself included, who has written such an algorithm
has had this bug in their initial version.  In one case, the algorithm
was published in a high-end journal and the bug not spotted for more than
a decade.  I suppose I could brag about Mathieu's and my offerings having
been corrected before we published, but the fact remains that an earlier
publication of mine gave the aforementioned algorithm from the high-end
journal as an alternative implementation, and I did not spot the bug.
Nor did any of my co-authors.  ;-)

							Thanx, Paul

> >after fetching its counter.  A detailed explanation for an essentially
> 
> -- 
> Thanks,
> Byungchul
> 
