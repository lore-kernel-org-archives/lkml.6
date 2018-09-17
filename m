Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF79FECE564
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67892088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 13:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67892088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbeIQSg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:36:26 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:54774 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbeIQSgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:36:25 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g1tH2-0005DW-3r; Mon, 17 Sep 2018 15:09:08 +0200
Message-Id: <20180917130706.973042587@linutronix.de>
User-Agent: quilt/0.65
Date:   Mon, 17 Sep 2018 14:45:34 +0200
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
Subject: [patch V2 01/11] clocksource: Provide clocksource_arch_init()
References: <20180917124533.329334911@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=clocksource--Provide-clocksource_arch_init--.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Architectures have extra archdata in the clocksource, e.g. for VDSO
support. There are no sanity checks or general initializations for this
available. Add support for that.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/clocksource.h |    5 +++++
 kernel/time/Kconfig         |    4 ++++
 kernel/time/clocksource.c   |    2 ++
 3 files changed, 11 insertions(+)

--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -241,6 +241,11 @@ static inline void __clocksource_update_
 	__clocksource_update_freq_scale(cs, 1000, khz);
 }
 
+#ifdef CONFIG_ARCH_CLOCKSOURCE_INIT
+extern void clocksource_arch_init(struct clocksource *cs);
+#else
+static inline void clocksource_arch_init(struct clocksource *cs) { }
+#endif
 
 extern int timekeeping_notify(struct clocksource *clock);
 
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -12,6 +12,10 @@ config CLOCKSOURCE_WATCHDOG
 config ARCH_CLOCKSOURCE_DATA
 	bool
 
+# Architecture has extra clocksource init called from registration
+config ARCH_CLOCKSOURCE_INIT
+	bool
+
 # Clocksources require validation of the clocksource against the last
 # cycle update - x86/TSC misfeature
 config CLOCKSOURCE_VALIDATE_LAST_CYCLE
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -937,6 +937,8 @@ int __clocksource_register_scale(struct
 {
 	unsigned long flags;
 
+	clocksource_arch_init(cs);
+
 	/* Initialize mult/shift and max_idle_ns */
 	__clocksource_update_freq_scale(cs, scale, freq);
 


