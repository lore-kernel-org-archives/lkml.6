Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9791ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8FC2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 12:31:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B8FC2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeJSUhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 16:37:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59488 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727011AbeJSUhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 16:37:06 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9JCOrKb083650
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 08:31:11 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2n7f0a0ygg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 08:31:10 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 19 Oct 2018 08:31:10 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 19 Oct 2018 08:31:08 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9JCV7Bb22937634
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Oct 2018 12:31:07 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0460DB206C;
        Fri, 19 Oct 2018 12:31:07 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C84BEB2068;
        Fri, 19 Oct 2018 12:31:06 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.109])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 19 Oct 2018 12:31:06 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7B8FE16C384E; Fri, 19 Oct 2018 05:31:06 -0700 (PDT)
Date:   Fri, 19 Oct 2018 05:31:06 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] rcu: Benefit from expedited grace period in __wait_rcu_gp
Reply-To: paulmck@linux.ibm.com
References: <1539910145-24305-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539910145-24305-1-git-send-email-karahmed@amazon.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18101912-0060-0000-0000-000002C370E6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009900; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000268; SDB=6.01104923; UDB=6.00572046; IPR=6.00884974;
 MB=3.00023823; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-19 12:31:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18101912-0061-0000-0000-000046E6B818
Message-Id: <20181019123106.GX2674@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-18_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810190112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 02:49:05AM +0200, KarimAllah Ahmed wrote:
> When expedited grace-period is set, both synchronize_sched
> synchronize_rcu_bh can be optimized to have a significantly lower latency.
> 
> Improve wait_rcu_gp handling to also account for expedited grace-period.
> The downside is that wait_rcu_gp will not wait anymore for all RCU variants
> concurrently when an expedited grace-period is set, however, given the
> improved latency it does not really matter.
> 
> Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>

Cute!

Unfortunately, there are a few problems with this patch:

1.	I will be eliminating synchronize_rcu_mult() due to the fact that
	the upcoming RCU flavor consolidation eliminates its sole caller.
	See 5fc9d4e000b1 ("rcu: Eliminate synchronize_rcu_mult()")
	in my -rcu tree.  This would of course also eliminate the effects
	of this patch.

2.	The real-time guys' users are not going to be at all happy
	with the IPIs resulting from the _expedited() API members.
	Yes, they can boot with rcupdate.rcu_normal=1, but they don't
	always need that big a hammer, and use of this kernel parameter
	can slow down boot, hibernation, suspend, network configuration,
	and much else besides.	We therefore don't want them to have to
	use rcupdate.rcu_normal=1 unless absolutely necessary.

3.	If the real-time guys' users were to have booted with
	rcupdate.rcu_normal=1, then synchronize_sched_expedited()
	would invoke _synchronize_rcu_expedited, which would invoke
	wait_rcu_gp(), which would invoke _wait_rcu_gp() which would
	invoke __wait_rcu_gp(), which, given your patch, would in turn
	invoke synchronize_sched_expedited().  This situation could
	well prevent their systems from meeting their response-time
	requirements.

So I cannot accept this patch nor for that matter any similar patch.

But what were you really trying to get done here?  If you were thinking
of adding another synchronize_rcu_mult(), the flavor consolidation will
make that unnecessary in most cases.  If you are trying to speed up
CPU-hotplug operations, I suggest using the rcu_expedited sysctl variable
when taking a CPU offline.  If something else, please let me know what
it is so that we can work out how the problem might best be solved.

							Thanx, Paul

> ---
>  kernel/rcu/update.c | 34 ++++++++++++++++++++++++++++------
>  1 file changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
> index 68fa19a..44b8817 100644
> --- a/kernel/rcu/update.c
> +++ b/kernel/rcu/update.c
> @@ -392,13 +392,27 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
>  			might_sleep();
>  			continue;
>  		}
> -		init_rcu_head_on_stack(&rs_array[i].head);
> -		init_completion(&rs_array[i].completion);
> +
>  		for (j = 0; j < i; j++)
>  			if (crcu_array[j] == crcu_array[i])
>  				break;
> -		if (j == i)
> -			(crcu_array[i])(&rs_array[i].head, wakeme_after_rcu);
> +		if (j != i)
> +			continue;
> +
> +		if ((crcu_array[i] == call_rcu_sched ||
> +		     crcu_array[i] == call_rcu_bh)
> +		    && rcu_gp_is_expedited()) {
> +			if (crcu_array[i] == call_rcu_sched)
> +				synchronize_sched_expedited();
> +			else
> +				synchronize_rcu_bh_expedited();
> +
> +			continue;
> +		}
> +
> +		init_rcu_head_on_stack(&rs_array[i].head);
> +		init_completion(&rs_array[i].completion);
> +		(crcu_array[i])(&rs_array[i].head, wakeme_after_rcu);
>  	}
> 
>  	/* Wait for all callbacks to be invoked. */
> @@ -407,11 +421,19 @@ void __wait_rcu_gp(bool checktiny, int n, call_rcu_func_t *crcu_array,
>  		    (crcu_array[i] == call_rcu ||
>  		     crcu_array[i] == call_rcu_bh))
>  			continue;
> +
> +		if ((crcu_array[i] == call_rcu_sched ||
> +		     crcu_array[i] == call_rcu_bh)
> +		    && rcu_gp_is_expedited())
> +			continue;
> +
>  		for (j = 0; j < i; j++)
>  			if (crcu_array[j] == crcu_array[i])
>  				break;
> -		if (j == i)
> -			wait_for_completion(&rs_array[i].completion);
> +		if (j != i)
> +			continue;
> +
> +		wait_for_completion(&rs_array[i].completion);
>  		destroy_rcu_head_on_stack(&rs_array[i].head);
>  	}
>  }
> -- 
> 2.7.4
> 

