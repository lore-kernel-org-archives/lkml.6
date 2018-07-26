Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58083C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130B320846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130B320846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbeGZKUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:20:48 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49127 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbeGZKUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:20:48 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ficCX-0003Vg-SQ; Thu, 26 Jul 2018 11:04:50 +0200
Date:   Thu, 26 Jul 2018 11:04:49 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: [PATCH RT] rtc: Disable RTC_DRV_EFI on RT
Message-ID: <20180726090449.hfvtey3ruzzhzdaz@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on measurements the EFI functions get_variable /
get_next_variable take up to 2us. The functions get_time, set_time take
around 10ms. Those 10ms are too much. Even one ms would be too much.
The funny part is that EFI is invoked with enabled interrupts.
According to my tracing I see the interrupt almost 10ms later which
indicates that EFI is disabling interrupts while doing its thing.

This was observed on "EFI v2.60 by SoftIron Overdrive 1000". I don't say
that every EFI implementation does this but given that it has to access a
slow bus like I2C/SPI it is expected.

Disable EFI's RTC driver on RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/rtc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index a2ba5db36145..248d72711650 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1087,7 +1087,7 @@ config RTC_DRV_DA9063
 
 config RTC_DRV_EFI
 	tristate "EFI RTC"
-	depends on EFI && !X86
+	depends on EFI && !X86 && !PREEMPT_RT_BASE
 	help
 	  If you say yes here you will get support for the EFI
 	  Real Time Clock.
-- 
2.18.0

