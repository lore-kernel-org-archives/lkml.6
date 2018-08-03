Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B860DC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690D721758
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 10:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 690D721758
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732546AbeHCMPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 08:15:01 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50139 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbeHCMPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 08:15:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w73AJ33p3848628
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 3 Aug 2018 03:19:03 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w73AJ2qE3848625;
        Fri, 3 Aug 2018 03:19:02 -0700
Date:   Fri, 3 Aug 2018 03:19:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Palmer Dabbelt <tipbot@zytor.com>
Message-ID: <tip-08fb550cb3f8e1efff5586b938eeedddb3ba0506@git.kernel.org>
Cc:     palmer@sifive.com, arnd@arndb.de, hpa@zytor.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org,
        will.deacon@arm.com, mingo@kernel.org, shea@shealevy.com,
        linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, arnd@arndb.de,
          palmer@sifive.com, will.deacon@arm.com,
          gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
          shea@shealevy.com, mingo@kernel.org
In-Reply-To: <20180622170126.6308-2-palmer@sifive.com>
References: <20180622170126.6308-2-palmer@sifive.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] irqchip: Port the ARM IRQ drivers to
 GENERIC_IRQ_MULTI_HANDLER
Git-Commit-ID: 08fb550cb3f8e1efff5586b938eeedddb3ba0506
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  08fb550cb3f8e1efff5586b938eeedddb3ba0506
Gitweb:     https://git.kernel.org/tip/08fb550cb3f8e1efff5586b938eeedddb3ba0506
Author:     Palmer Dabbelt <palmer@sifive.com>
AuthorDate: Fri, 22 Jun 2018 10:01:22 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 3 Aug 2018 12:14:08 +0200

irqchip: Port the ARM IRQ drivers to GENERIC_IRQ_MULTI_HANDLER

GENERIC_IRQ_MULTI_HANDLER is incompatible with MULTI_IRQ_HANDLER because
they define the same symbols.  Multiple generic irqchip drivers select
MULTI_IRQ_HANDLER, which is now defined on all architectures that
provide set_handle_irq().

To solve this select GENERIC_IRQ_MULTI_HANDLER for all drivers that used to
select MULTI_IRQ_HANDLER, but only when MULTI_IRQ_HANDLER doesn't exist.

After that every architecture can be converted over from MULTI_IRQ_HANDLER
to GENERIC_IRQ_MULTI_HANDLER before removing the extra MULTI_IRQ_HANDLER
scaffolding.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux@armlinux.org.uk
Cc: catalin.marinas@arm.com
Cc: Will Deacon <will.deacon@arm.com>
Cc: jonas@southpole.se
Cc: stefan.kristiansson@saunalahti.fi
Cc: shorne@gmail.com
Cc: jason@lakedaemon.net
Cc: marc.zyngier@arm.com
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: nicolas.pitre@linaro.org
Cc: vladimir.murzin@arm.com
Cc: keescook@chromium.org
Cc: jinb.park7@gmail.com
Cc: yamada.masahiro@socionext.com
Cc: alexandre.belloni@bootlin.com
Cc: pombredanne@nexb.com
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: kstewart@linuxfoundation.org
Cc: jhogan@kernel.org
Cc: mark.rutland@arm.com
Cc: ard.biesheuvel@linaro.org
Cc: james.morse@arm.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: openrisc@lists.librecores.org
Cc: Shea Levy <shea@shealevy.com>
Link: https://lkml.kernel.org/r/20180622170126.6308-2-palmer@sifive.com

---
 drivers/irqchip/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index e9233db16e03..7527f6a9adae 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -9,6 +9,7 @@ config ARM_GIC
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
 
 config ARM_GIC_PM
@@ -35,6 +36,7 @@ config ARM_GIC_V3
 	bool
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 	select IRQ_DOMAIN_HIERARCHY
 	select PARTITION_PERCPU
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
@@ -67,6 +69,7 @@ config ARM_VIC
 	bool
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 
 config ARM_VIC_NR
 	int
@@ -94,6 +97,7 @@ config ATMEL_AIC_IRQ
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 
 config ATMEL_AIC5_IRQ
@@ -101,6 +105,7 @@ config ATMEL_AIC5_IRQ
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 
 config I8259
@@ -138,6 +143,7 @@ config FARADAY_FTINTC010
 	bool
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 
 config HISILICON_IRQ_MBIGEN
@@ -163,6 +169,7 @@ config CLPS711X_IRQCHIP
 	depends on ARCH_CLPS711X
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 	default y
 
@@ -182,6 +189,7 @@ config ORION_IRQCHIP
 	bool
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
+	select GENERIC_IRQ_MULTI_HANDLER if !MULTI_IRQ_HANDLER
 
 config PIC32_EVIC
 	bool
