Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C23C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5955A218D0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 23:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NypsjIdA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbfBZXg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 18:36:56 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46102 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728729AbfBZXg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 18:36:56 -0500
Received: by mail-pg1-f196.google.com with SMTP id 196so6948418pgf.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 15:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n8q94zZi+D1uUg0/ig6itn9R3+pd02EnClmqjqkWQnE=;
        b=NypsjIdAYo6L/jO9AlpSyMSePo6ucvRN086mH6ChxMb4IzrRtC1Rmpd7Gl2IFsckZs
         J/IfhGgKHIpkfUnCygIdg1LywbCmwjEPfh3LcMisruZIWFgr6TdkMMDekTwfK2m/3vSv
         2StdOd6S7lZlK0FmAu216d7jRKw4Tr73Uk6hE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n8q94zZi+D1uUg0/ig6itn9R3+pd02EnClmqjqkWQnE=;
        b=OVtdj3zkDLI6Fu0NpNLk0zJpOgsZVujcUP/mPypWMc1gbR1G+bOYBROBk3EnnsoqAX
         G+DySY1uUmY4nO/Etp0PDO++Pj6vrfkTGZlzCBFcTKca67LFCVcbpV/MO5JEuH78Mavu
         RJZJaCi+xqnIiWmOfVb/OEWar+3duSwdE7oQgyP21NxcJwF5LTcbx+dnlMR7MpAtDeNq
         uJ4KTcKIaU2gihLJJ6dy15QUuG9SML2pLmh1z9AoNiGpjLtB3HmG5VRatxzVDyKSEk+p
         Yf8kYTmyJqQ2OJp6rIGhlpnlf8FwTY2oYVasOtBO0RDkkSy9w2+eMIQdfSSYiqW9sYnf
         ohAQ==
X-Gm-Message-State: AHQUAubWi9duKOaiHVDR9W2UUUPG8Jd7aAzk7NN1wUjkgmeggr5m+bNL
        QGMbxG88nifaiK4BezvrHujUgBugniQ=
X-Google-Smtp-Source: AHgI3Ib2l1hkm7hH/c6XoCvlp1mVj1TCSiXDcE3ddiMYT2YtlPeGf+P8zA7Ep0xQHFXD2Rr63h3VXA==
X-Received: by 2002:a62:5789:: with SMTP id i9mr28023400pfj.75.1551224215766;
        Tue, 26 Feb 2019 15:36:55 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id 1sm33958859pfy.68.2019.02.26.15.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 15:36:54 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] x86/asm: Pin sensitive CR0 bits
Date:   Tue, 26 Feb 2019 15:36:45 -0800
Message-Id: <20190226233647.28547-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190226233647.28547-1-keescook@chromium.org>
References: <20190226233647.28547-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With sensitive CR4 bits pinned now, it's possible that the WP bit for CR0
might become a target as well. Following the same reasoning for the CR4
pinning, this pins CR0's WP bit (but this can be done with a static value).

As before, to convince the compiler to not optimize away the check for the
WP bit after the set, this marks "val" as an output from the asm() block.
This protects against just jumping into the function past where the masking
happens; we must check that the mask was applied after we do the set). Due
to how this function can be built by the compiler (especially due to the
removal of frame pointers), jumping into the middle of the function
frequently doesn't require stack manipulation to construct a stack frame
(there may only a retq without pops, which is sufficient for use with
exploits like timer overwrites).

Additionally, this avoids WARN()ing before resetting the bit, just to
minimize any race conditions with leaving the bit unset.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/special_insns.h | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
index fabda1400137..8416d6b31084 100644
--- a/arch/x86/include/asm/special_insns.h
+++ b/arch/x86/include/asm/special_insns.h
@@ -25,7 +25,28 @@ static inline unsigned long native_read_cr0(void)
 
 static inline void native_write_cr0(unsigned long val)
 {
-	asm volatile("mov %0,%%cr0": : "r" (val), "m" (__force_order));
+	bool warn = false;
+
+again:
+	val |= X86_CR0_WP;
+	/*
+	 * In order to have the compiler not optimize away the check
+	 * in the WARN_ONCE(), mark "val" as being also an output ("+r")
+	 * by this asm() block so it will perform an explicit check, as
+	 * if it were "volatile".
+	 */
+	asm volatile("mov %0,%%cr0": "+r" (val) : "m" (__force_order) : );
+	/*
+	 * If the MOV above was used directly as a ROP gadget we can
+	 * notice the lack of pinned bits in "val" and start the function
+	 * from the beginning to gain the WP bit for sure. And do it
+	 * without first taking the exception for a WARN().
+	 */
+	if ((val & X86_CR0_WP) != X86_CR0_WP) {
+		warn = true;
+		goto again;
+	}
+	WARN_ONCE(warn, "Attempt to unpin X86_CR0_WP, cr0 bypass attack?!\n");
 }
 
 static inline unsigned long native_read_cr2(void)
-- 
2.17.1

