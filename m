Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94796C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9D020658
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 11:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E9D020658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeIEQDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 12:03:23 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:59290 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbeIEQDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 12:03:23 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fxW3k-0001Rb-9D; Wed, 05 Sep 2018 13:33:20 +0200
Date:   Wed, 5 Sep 2018 13:33:19 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
cc:     josh@joshtriplett.org, peterz@infradead.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dzickus@redhat.com,
        brendan.jackman@arm.com, malat@debian.org,
        linux-kernel@vger.kernel.org, sramana@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpu/hotplug: Fix rollback during error-out in
 takedown_cpu()
In-Reply-To: <1536042803-6152-1-git-send-email-neeraju@codeaurora.org>
Message-ID: <alpine.DEB.2.21.1809051244500.1416@nanos.tec.linutronix.de>
References: <1536042803-6152-1-git-send-email-neeraju@codeaurora.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Sep 2018, Neeraj Upadhyay wrote:
> If takedown_cpu() fails during _cpu_down(), st->state is reset,
> by calling cpuhp_reset_state(). This results in an additional
> increment of st->state, which results in CPUHP_AP_SMPBOOT_THREADS
> state being skipped during rollback. Fix this by not calling
> cpuhp_reset_state() and doing the state reset directly in
> _cpu_down().
> 
> Fixes: 4dddfb5faa61 ("smp/hotplug: Rewrite AP state machine core")
> Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> ---
>  kernel/cpu.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index aa7fe85..9f49edb 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -970,7 +970,14 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
>  	 */
>  	ret = cpuhp_down_callbacks(cpu, st, target);
>  	if (ret && st->state > CPUHP_TEARDOWN_CPU && st->state < prev_state) {
> -		cpuhp_reset_state(st, prev_state);
> +		/*
> +		 * As st->last is not set, cpuhp_reset_state() increments
> +		 * st->state, which results in CPUHP_AP_SMPBOOT_THREADS being
> +		 * skipped during rollback. So, don't use it here.
> +		 */
> +		st->rollback = true;
> +		st->target = prev_state;
> +		st->bringup = !st->bringup;

No, this is just papering over the actual problem.

The state inconsistency happens in take_cpu_down() when it returns with a
failure from __cpu_disable() because that returns with state = TEARDOWN_CPU
and st->state is then incremented in undo_cpu_down().

That's the real issue and we need to analyze the whole cpu_down rollback
logic first.

Thanks,

	tglx























