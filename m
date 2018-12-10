Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F823C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2BE2084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 21:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2BE2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbeLJVbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 16:31:36 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:34485 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729845AbeLJVbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 16:31:36 -0500
Received: from p4fea4820.dip0.t-ipconnect.de ([79.234.72.32] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gWT97-0004lA-Vf; Mon, 10 Dec 2018 22:31:22 +0100
Date:   Mon, 10 Dec 2018 22:31:21 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        mark.rutland@arm.com, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, mingo@kernel.org, longman@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] clocksource/arm_arch_timer: fix a lockdep
 warning
In-Reply-To: <20181210140703.GM5289@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.1812102229480.1667@nanos.tec.linutronix.de>
References: <1543877121-4098-1-git-send-email-cai@gmx.us> <20181210135228.49751-1-cai@lca.pw> <20181210140703.GM5289@hirez.programming.kicks-ass.net>
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

On Mon, 10 Dec 2018, Peter Zijlstra wrote:
> On Mon, Dec 10, 2018 at 08:52:28AM -0500, Qian Cai wrote:
> > Booting this Huawei TaiShan 2280 arm64 server generated this lockdep
> > warning.
> > 
> > [    0.000000]  lockdep_assert_cpus_held+0x50/0x60
> > [    0.000000]  static_key_enable_cpuslocked+0x30/0xe8
> > [    0.000000]  arch_timer_check_ool_workaround+0x128/0x2d0
> > [    0.000000]  arch_timer_acpi_init+0x274/0x6ac
> > [    0.000000]  acpi_table_parse+0x1ac/0x218
> > [    0.000000]  __acpi_probe_device_table+0x164/0x1ec
> > [    0.000000]  timer_probe+0x1bc/0x254
> > [    0.000000]  time_init+0x44/0x98
> > [    0.000000]  start_kernel+0x4ec/0x7d4
> 
> It seems to me we want something like:
> 
> ---
>  kernel/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 91d5c38eb7e5..e1ee8caf28b5 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -313,6 +313,8 @@ void cpus_write_unlock(void)
>  
>  void lockdep_assert_cpus_held(void)
>  {
> +	if (system_state < SYSTEM_RUNNING)
> +		return;
>  	percpu_rwsem_assert_held(&cpu_hotplug_lock);
>  }
 
Hmm, no. SYSTEM_SCHEDULING is what you want because RUNNING is set way too
late.

Thanks,

	tglx
