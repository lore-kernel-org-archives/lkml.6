Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82ABDC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3276520673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 13:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3276520673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbeGZObT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:31:19 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49570 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729873AbeGZObS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:31:18 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fig65-0007mM-4z; Thu, 26 Jul 2018 15:14:25 +0200
Date:   Thu, 26 Jul 2018 15:14:25 +0200
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
Message-ID: <20180726131424.nqkalmmncnfcrh2q@linutronix.de>
References: <20180726090449.hfvtey3ruzzhzdaz@linutronix.de>
 <CAKv+Gu_+t_VwY3xDq3nWbnOTfzBc6OtQeRD2GKsseO2uK-uruw@mail.gmail.com>
 <20180726121504.ba35z3j3wsesryy3@linutronix.de>
 <5052E25B-9942-40C1-BD53-86E3D7014557@linaro.org>
 <20180726124613.xgmidioqd4mcqpiw@linutronix.de>
 <8640BE46-B141-44F9-BD92-58A21A2B0EA7@linaro.org>
 <20180726131323.ffecgeqnry6th4mp@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180726131323.ffecgeqnry6th4mp@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-26 15:13:23 [+0200], To Ard Biesheuvel wrote:
> On 2018-07-26 14:52:21 [+0200], Ard Biesheuvel wrote:
> > We could also make it the default on -rt, but not disable it entirely, so that efi=runtime can be used to re-enable it.
> 
> Oh. I like that. We have something similar for RCU. So I would need
> that:
and then I could make it default off:

----- >8

Subject: [PATCH] efi: Disable runtime services on RT

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
reboot hooks may be provided by PSCI.

Disable EFI's runtime wrappers.

This was observed on "EFI v2.60 by SoftIron Overdrive 1000".

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/firmware/efi/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 232f4915223b..62c6e4b6ce3e 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -84,7 +84,7 @@ struct mm_struct efi_mm = {
 	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),
 };
 
-static bool disable_runtime;
+static bool disable_runtime = IS_ENABLED(CONFIG_PREEMPT_RT_BASE);
 static int __init setup_noefi(char *arg)
 {
 	disable_runtime = true;
-- 
2.18.0

