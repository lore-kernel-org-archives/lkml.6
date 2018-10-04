Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507F1C64EBD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3FB20684
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3FB20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeJDU7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:59:35 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36296 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727380AbeJDU7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:59:35 -0400
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1g84GR-0002ic-8G; Thu, 04 Oct 2018 16:06:03 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 05/11] x86/fpu: set PKRU state for kernel threads
Date:   Thu,  4 Oct 2018 16:05:41 +0200
Message-Id: <20181004140547.13014-6-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181004140547.13014-1-bigeasy@linutronix.de>
References: <20181004140547.13014-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PKRU value is not set for kernel threads because they do not have
the ->initialized value set. As a result the kernel thread has a random
PKRU value set which it inherits from the previous task.
It has been suggested by Paolo Bonzini to set it for kernel threads, too
because it might be a fix.
I *think* this is not required because the kernel threads don't copy
data to/from userland and don't have access to any userspace mm in
general.
However there is this use_mm(). If we gain a mm by use_mm() we don't
have a matching PKRU value because those are per thread. It has been
suggested to use 0 as the PKRU value but this would bypass PKRU.

Set the initial (default) PKRU value for kernel threads.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/include/asm/fpu/internal.h | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 956d967ca824a..4ecaf4d22954e 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -14,6 +14,7 @@
 #include <linux/compat.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/pkeys.h>
 
 #include <asm/user.h>
 #include <asm/fpu/api.h>
@@ -573,20 +574,23 @@ static inline void switch_fpu_finish(struct fpu *new_fpu, int cpu)
 	bool load_fpu;
 
 	load_fpu = static_cpu_has(X86_FEATURE_FPU) && new_fpu->initialized;
-	if (!load_fpu)
-		return;
-
-	__fpregs_load_activate(new_fpu, cpu);
-
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 	if (static_cpu_has(X86_FEATURE_OSPKE)) {
 		struct pkru_state *pk;
 
-		pk = __raw_xsave_addr(&new_fpu->state.xsave, XFEATURE_PKRU);
-		if (pk->pkru != __read_pkru())
-			__write_pkru(pk->pkru);
+		if (!load_fpu) {
+			pkru_set_init_value();
+		} else {
+			pk = __raw_xsave_addr(&new_fpu->state.xsave,
+					      XFEATURE_PKRU);
+			if (pk->pkru != __read_pkru())
+				__write_pkru(pk->pkru);
+		}
 	}
 #endif
+	if (!load_fpu)
+		return;
+	__fpregs_load_activate(new_fpu, cpu);
 }
 
 /*
-- 
2.19.0

