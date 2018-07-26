Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E076CC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9974D2083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9974D2083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbeGZNbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:31:45 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49492 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729155AbeGZNbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:31:45 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fifAf-0006O3-0h; Thu, 26 Jul 2018 14:15:05 +0200
Date:   Thu, 26 Jul 2018 14:15:04 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [PATCH RT] rtc: Disable RTC_DRV_EFI on RT
Message-ID: <20180726121504.ba35z3j3wsesryy3@linutronix.de>
References: <20180726090449.hfvtey3ruzzhzdaz@linutronix.de>
 <CAKv+Gu_+t_VwY3xDq3nWbnOTfzBc6OtQeRD2GKsseO2uK-uruw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_+t_VwY3xDq3nWbnOTfzBc6OtQeRD2GKsseO2uK-uruw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-26 11:15:52 [+0200], Ard Biesheuvel wrote:
> On 26 July 2018 at 11:04, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> > Based on measurements the EFI functions get_variable /
> > get_next_variable take up to 2us. The functions get_time, set_time take
> > around 10ms. Those 10ms are too much. Even one ms would be too much.
> 
> You cannot extrapolate from these numbers. If the lack of worst case
> guarantees on an EFI system is a problem for -rt, the only meaningful
> course of action is to disable EFI runtime services entirely.

Oh boy. I disable EFI entirely because then the bootloader won't boot
due to missing efi-stub. But I could disable the runtime-wrappers if
that is what you meant. Patch below.

> I think SetVariable() may be even worse than GetTime(), given that NOR
> flash updates may involve erasing blocks.

Here we go. "Read" can be triggered from userland via sysfs / efivars.
"Write" is (currently) limited to pstore?

> > The funny part is that EFI is invoked with enabled interrupts.
> > According to my tracing I see the interrupt almost 10ms later which
> > indicates that EFI is disabling interrupts while doing its thing.
> 
> Yes, and this is also highly implementation specific. Basing this kind
> of policy on a single implementation is not very wise imo.

even if interrupts were not disabled then there would be no context
switch on exit from interrupt path due to the preempt-disable part. So
no improvement.

> > This was observed on "EFI v2.60 by SoftIron Overdrive 1000". I don't say
> > that every EFI implementation does this but given that it has to access a
> > slow bus like I2C/SPI it is expected.
> >
> > Disable EFI's RTC driver on RT.
> >
> 
> Other calls to GetTime() would still be permitted in this case, so
> this seems like a partial solution (although no other calls seem to
> exist atm)

I *assumed* pstore would use the SetVariable during warning/bug. The
pstore thingy might be useful. Not sure.

------ >8

Subject: [PATCH RT] arm64: Disable EFI runtime services on RT

Based on meassurements the EFI functions get_variable /
get_next_variable take up to 2us which looks okay.
The functions get_time, set_time take around 10ms. Those 10ms are too
much. Even one ms would be too much.
Ard mentioned that SetVariable might even trigger larger latencies if
the firware will erase flash blocks on NOR.

The time-functions are used by efi-rtc and can be triggered during
runtimed (either via explicit read/write or ntp sync).

The variable write could be used by pstore.
These functions can be disabled without much of a loss. The poweroff /
reboot hooks will be provided by PSCI.

Disable EFI's runtime wrappers.

This was observed on "EFI v2.60 by SoftIron Overdrive 1000".

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm64/Kconfig                 | 2 +-
 drivers/firmware/efi/arm-runtime.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 111db4e44fcf..68adcb0f4de6 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1250,7 +1250,7 @@ config EFI
 	select LIBFDT
 	select UCS2_STRING
 	select EFI_PARAMS_FROM_FDT
-	select EFI_RUNTIME_WRAPPERS
+	select EFI_RUNTIME_WRAPPERS if !PREEMPT_RT_BASE
 	select EFI_STUB
 	select EFI_ARMSTUB
 	default y
diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
index 5889cbea60b8..3e96db10c034 100644
--- a/drivers/firmware/efi/arm-runtime.c
+++ b/drivers/firmware/efi/arm-runtime.c
@@ -140,8 +140,10 @@ static int __init arm_enable_runtime_services(void)
 	}
 
 	/* Set up runtime services function pointers */
+#ifdef CONFIG_EFI_RUNTIME_WRAPPERS
 	efi_native_runtime_setup();
 	set_bit(EFI_RUNTIME_SERVICES, &efi.flags);
+#endif
 
 	return 0;
 }
-- 
2.18.0

