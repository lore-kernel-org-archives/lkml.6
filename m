Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89014C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F11F20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F11F20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbeGaSb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:31:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727471AbeGaSb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:31:56 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6VGmfHB147222
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 12:50:46 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2kjsx74uf6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 12:50:45 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 31 Jul 2018 12:50:45 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 31 Jul 2018 12:50:42 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6VGofn764684066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 31 Jul 2018 16:50:41 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B2A1B2064;
        Tue, 31 Jul 2018 12:50:15 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0ECFB205F;
        Tue, 31 Jul 2018 12:50:14 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jul 2018 12:50:14 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 861C516C1835; Tue, 31 Jul 2018 09:50:41 -0700 (PDT)
Date:   Tue, 31 Jul 2018 09:50:41 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        tglx@linutronix.de, frederic@kernel.org, bristot@redhat.com,
        peterz@infradead.org
Subject: Re: [PATCH] nohz: Fix local_timer_softirq_pending()
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180731161358.29472-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731161358.29472-1-anna-maria@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18073116-0052-0000-0000-00000315F588
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009464; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01068514; UDB=6.00549318; IPR=6.00846723;
 MB=3.00022428; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-31 16:50:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18073116-0053-0000-0000-00005D8E2D59
Message-Id: <20180731165041.GX24813@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-31_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=964 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807310155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 06:13:58PM +0200, Anna-Maria Gleixner wrote:
> local_timer_softirq_pending() checks whether the timer softirq is
> pending with: local_softirq_pending() & TIMER_SOFTIRQ.
> 
> This is wrong because TIMER_SOFTIRQ is the softirq number and not a
> bitmask. So the test checks for the wrong bit.
> 
> Use BIT(TIMER_SOFTIRQ) instead.
> 
> Fixes: 5d62c183f9e9 ("nohz: Prevent a timer interrupt storm in tick_nohz_stop_sched_tick()")
> Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

2729 opportunities to change "1UL << x" to "BIT(x)", including
__raise_softirq_irqoff().  I did the two in RCU.  ;-)

							Thanx, Paul

> ---
>  kernel/time/tick-sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index da9455a6b42b..5b33e2f5c0ed 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -642,7 +642,7 @@ static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
> 
>  static inline bool local_timer_softirq_pending(void)
>  {
> -	return local_softirq_pending() & TIMER_SOFTIRQ;
> +	return local_softirq_pending() & BIT(TIMER_SOFTIRQ);
>  }
> 
>  static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
> -- 
> 2.18.0
> 

