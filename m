Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B04DC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACFA2083F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ACFA2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbeJBKTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 06:19:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726562AbeJBKTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 06:19:10 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w923Xl8X130044
        for <linux-kernel@vger.kernel.org>; Mon, 1 Oct 2018 23:38:06 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2muymva9hx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 23:38:05 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 1 Oct 2018 23:38:05 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Oct 2018 23:38:02 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w923c1qH46399624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 2 Oct 2018 03:38:01 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 57179B205F;
        Mon,  1 Oct 2018 23:36:14 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34E1FB2064;
        Mon,  1 Oct 2018 23:36:14 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.185.184])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  1 Oct 2018 23:36:14 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 36DEE16C39D4; Mon,  1 Oct 2018 20:38:01 -0700 (PDT)
Date:   Mon, 1 Oct 2018 20:38:01 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC 1/2] sched/core: Convert synchronize_rcu_mult to
 synchronize_rcu
Reply-To: paulmck@linux.ibm.com
References: <20181002012012.13133-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002012012.13133-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18100203-0052-0000-0000-0000033AD676
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009806; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01096602; UDB=6.00567046; IPR=6.00876644;
 MB=3.00023582; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-02 03:38:04
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100203-0053-0000-0000-00005E440881
Message-Id: <20181002033801.GP4222@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-01_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810020034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 06:20:11PM -0700, Joel Fernandes wrote:
> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
> 
> synchronize_rcu_mult is now obsolete since all the different RCU flavors
> have been consolidated and the API is now common on the updater side.
> sched/core.c is the only user of it. All call_rcu_<flavor> calls boil
> down to the same call_rcu. So there's no point in calling
> synchronize_rcu_mult infact it could potentially be slower due to
> waiting for the call_rcu callback twice. Just call synchronize_rcu here
> which should do the job.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Well, the theory was that I was going to keep this series hidden until
the consolidation hit mainline just to avoid confusion, but please see
5fc9d4e000b1 ("rcu: Eliminate synchronize_rcu_mult()"), which I just
now pushed to -rcu.  To your credit, you did get most of it.  ;-)

Here is the full list:

pick 1f3e6eaed8fa Apply coccinelle script to consolidate calls to RCU-bh and RCU-sched
pick 5fc9d4e000b1 rcu: Eliminate synchronize_rcu_mult()
pick a8475496801e rcu: Consolidate the RCU update functions invoked by sync.c
pick d8ffb03461ad sched/membarrier: Replace synchronize_sched() with synchronize_rcu()

Of course, I will need to rerun the coccinelle script and split the
result across subsystems, but I am waiting until the current pull
request hits mainline.  Let's face it, none of us need to do debugging
on someone consolidating their RCU updates before at least this commit
and its predecessors hit mainline:

709fdce7545c ("rcu: Express Tiny RCU updates in terms of RCU rather than RCU-sched")

I sent the pull request to Ingo a few days ago, so with some luck this
will all get to mainline during the next merge window, and then it is
open season on outside-of-RCU cleanups.  ;-)

							Thanx, Paul

> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 625bc9897f62..d8311f3cf58c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5791,7 +5791,7 @@ int sched_cpu_deactivate(unsigned int cpu)
>  	 *
>  	 * Do sync before park smpboot threads to take care the rcu boost case.
>  	 */
> -	synchronize_rcu_mult(call_rcu, call_rcu_sched);
> +	synchronize_rcu();
>  
>  	if (!sched_smp_initialized)
>  		return 0;
> -- 
> 2.19.0.605.g01d371f741-goog
> 

