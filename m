Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7000ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9914214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9914214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbeIQSg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:36:26 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54777 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbeIQSg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:36:26 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g1tH2-0005Dd-Qy; Mon, 17 Sep 2018 15:09:08 +0200
Message-Id: <20180917130707.069167446@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 17 Sep 2018 14:45:35 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        devel@linuxdriverproject.org,
        virtualization@lists.linux-foundation.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Subject: [patch V2 02/11] x86/time: Implement clocksource_arch_init()
References: <20180917124533.329334911@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=x86-time--Implement-clocksource_arch_init--.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Runtime validate the VCLOCK_MODE in clocksource::archdata and disable
VCLOCK if invalid, which disables the VDSO but keeps the system running.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---

V2: Fix the VCLOCK_MAX check

 arch/x86/Kconfig       |    1 +
 arch/x86/kernel/time.c |   16 ++++++++++++++++
 2 files changed, 17 insertions(+)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -48,6 +48,7 @@ config X86
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
 	select ANON_INODES
 	select ARCH_CLOCKSOURCE_DATA
+	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_DISCARD_MEMBLOCK
 	select ARCH_HAS_ACPI_TABLE_UPGRADE	if ACPI
 	select ARCH_HAS_DEBUG_VIRTUAL
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -10,6 +10,7 @@
  *
  */
 
+#include <linux/clocksource.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -105,3 +106,18 @@ void __init time_init(void)
 {
 	late_time_init = x86_late_time_init;
 }
+
+/*
+ * Sanity check the vdso related archdata content.
+ */
+void clocksource_arch_init(struct clocksource *cs)
+{
+	if (cs->archdata.vclock_mode == VCLOCK_NONE)
+		return;
+
+	if (cs->archdata.vclock_mode > VCLOCK_MAX) {
+		pr_warn("clocksource %s registered with invalid vclock_mode %d. Disabling vclock.\n",
+			cs->name, cs->archdata.vclock_mode);
+		cs->archdata.vclock_mode = VCLOCK_NONE;
+	}
+}


