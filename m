Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE777C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9062186A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 20:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SGQ/y+br"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730404AbfB0UBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:01:46 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35601 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730338AbfB0UBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 15:01:42 -0500
Received: by mail-pg1-f193.google.com with SMTP id e17so6423499pgd.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 12:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vzz1FQN1jJNmckhFM7jqyw+Eyl5dEJHVvmFRIHlT1C8=;
        b=SGQ/y+brpOs/JqYhS5bcF63efY4uCnTaDn1aLtIltGZ7xEeLWAMgMbuUymxbfABuAj
         yvzueaBcI9pMRMyk6Q0jLyZqNKjCms5YABwY5J/4ohmBI6J5gvUVlo8y4WxLVdwQtg6I
         TKmbiTxhkMY11pQfE9O4Lb4xZGHEEqbafpzd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vzz1FQN1jJNmckhFM7jqyw+Eyl5dEJHVvmFRIHlT1C8=;
        b=mdALIotBNynYX57fymuiZo9AJkrXNR1Kd4VEAJECO1Hqtyte3KehfjJHPy1kSHEwLi
         cLpU8fUbOPRfKiAO0nd+TtiGbu7jAo34t8W0uiQ1pzHL6esE93HZGdvX0d0XnyO6tzr9
         lpMM1Q+F6pXv1nxSj7+BV3Y0lDCwFP61WCPj2fL8c4DJ/8Ask5N/rK5UwM7zd+PkkGyt
         ZBySBxu2aoeU0rzEtqlpSoTZBBBaqOlAtEEsf09Bfs6HHY1197CSibgfXUfG6ORsuOIf
         cmPYzIwoTDDS2GsGfsyC6UkmWDgbL1YVMur2RWgMI05kZgePww1VcISgyEWiS7G27YzW
         IVGg==
X-Gm-Message-State: AHQUAuZFuYvUnl95CEkIqc3d8E63idGC7roYgnycCQd/1S2D3U5Lj9QH
        59v6o/x03HUHKFQH/IGuKIqezA==
X-Google-Smtp-Source: AHgI3IYt70D/0LlJK+xicUiFn5VvA2shPPKvjRnzWaY0zyjgpiWfszNSK+ubT6JIE2ABxcEYkMdunA==
X-Received: by 2002:a63:1155:: with SMTP id 21mr4378829pgr.96.1551297701730;
        Wed, 27 Feb 2019 12:01:41 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id q28sm25390719pgl.35.2019.02.27.12.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 12:01:38 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Solar Designer <solar@openwall.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: [PATCH v2 1/3] x86/asm: Pin sensitive CR0 bits
Date:   Wed, 27 Feb 2019 12:01:30 -0800
Message-Id: <20190227200132.24707-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190227200132.24707-1-keescook@chromium.org>
References: <20190227200132.24707-1-keescook@chromium.org>
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
index fabda1400137..1f01dc3f6c64 100644
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
+	 * after the cr4 write, mark "val" as being also an output ("+r")
+	 * by this asm() block so it will perform an explicit check, as
+	 * if it were "volatile".
+	 */
+	asm volatile("mov %0,%%cr0" : "+r" (val) : "m" (__force_order) : );
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

