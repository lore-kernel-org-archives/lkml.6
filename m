Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AC0ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA6C20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 12:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA6C20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeINSGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:06:20 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49576 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbeINSGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:06:20 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g0nZm-0005vx-6L; Fri, 14 Sep 2018 14:51:58 +0200
Message-Id: <20180914125118.374798800@linutronix.de>
User-Agent: quilt/0.65
Date:   Fri, 14 Sep 2018 14:50:09 +0200
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
Subject: [patch 03/11] x86/vdso: Enforce 64bit clocksource
References: <20180914125006.349747096@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=x86-vdso--Enforce-64bit-clocksource.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All VDSO clock sources are TSC based and use CLOCKSOURCE_MASK(64). There is
no point in masking with all FF. Get rid of it and enforce the mask in the
sanity checker.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/vdso/vclock_gettime.c |    2 +-
 arch/x86/kernel/time.c               |    6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -199,7 +199,7 @@ notrace static inline u64 vgetsns(int *m
 #endif
 	else
 		return 0;
-	v = (cycles - gtod->cycle_last) & gtod->mask;
+	v = cycles - gtod->cycle_last;
 	return v * gtod->mult;
 }
 
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -120,4 +120,10 @@ void clocksource_arch_init(struct clocks
 			cs->name, cs->archdata.vclock_mode);
 		cs->archdata.vclock_mode = VCLOCK_NONE;
 	}
+
+	if (cs->mask != CLOCKSOURCE_MASK(64)) {
+		pr_warn("clocksource %s registered with invalid mask %016llx. Disabling vclock.\n",
+			cs->name, cs->mask);
+		cs->archdata.vclock_mode = VCLOCK_NONE;
+	}
 }


