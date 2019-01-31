Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3146DC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05196218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TKOBB61t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbfAaT2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:28:32 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44452 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729199AbfAaT2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:28:30 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so1762307pgr.11
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=slcSIy5bpHZyKWwlaDTRrJC/yUTgl298Zpoh2P5XAuE=;
        b=TKOBB61tqnBNKWdp040WyjTS0OXWqJEHjq2P+NQiGg86JDwZ9FGi/8Qz6kPKnebjDc
         ChUA5SanNH183SHXa/pU4MeDsCoPM2b6QUWiS5TNNr0mv+azxx0kEo0O6Nh63+2hR91j
         /Z+2fkdTaf5s4DTA1g4+A+BEmDimNuC9rjvoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=slcSIy5bpHZyKWwlaDTRrJC/yUTgl298Zpoh2P5XAuE=;
        b=fGoe5wJTysZDcYj7e/b9berSxUckLZg8U9RO8+ZELpojgVgGhew7oDZ6tKUc5rL9HW
         60s0hh8LSiwxHrvORrWKAgJ3bWagdrGVPGIZowK5c0HWnkbhp0bnvUkbMxQqCJZXc8m4
         scyWkLar33fECFwjNr1qPyRMp2OvwYvCZCmljWRmwJRfgBZKZHcG+4guAfhhF5f011q1
         ngyrGyQKFAO/YKCZQemv3M+qQl9LHTuKvgaV1FeXMdwxPmNKETal3d9iESsy4vle5NdR
         xSdtfP0pBWNV1VbsRo+B7ukibNKJ56bWK1bblOQoe14xRkZNl7Cr/q7V6SvKTXRtnR1t
         lBvw==
X-Gm-Message-State: AJcUukfYJsfAHKhx2sN6y+WPG9wd8AKf9APHwQRZCyiZAaqMumj3e8fJ
        4foIJwqAWYTkfD+q3hxvvh6lPQ==
X-Google-Smtp-Source: ALg8bN7K7Jp37yglEz23FpvrxI3w/t8wvaBzIGcgvz2oGt1tM5UakNsoqpDPmwdjiwGArBnM4rp4kw==
X-Received: by 2002:a63:5320:: with SMTP id h32mr32738683pgb.414.1548962910189;
        Thu, 31 Jan 2019 11:28:30 -0800 (PST)
Received: from skynet.sea.corp.google.com ([2620:15c:17:4:29de:3bb1:1270:e679])
        by smtp.gmail.com with ESMTPSA id s130sm11164399pgc.60.2019.01.31.11.28.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:28:29 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Garnier <thgarnie@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 10/27] x86/power/64: Adapt assembly for PIE support
Date:   Thu, 31 Jan 2019 11:24:17 -0800
Message-Id: <20190131192533.34130-11-thgarnie@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190131192533.34130-1-thgarnie@chromium.org>
References: <20190131192533.34130-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the assembly code to use only relative references of symbols for the
kernel to be PIE compatible.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
Acked-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/power/hibernate_asm_64.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index 3008baa2fa95..9ed980efef72 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -24,7 +24,7 @@
 #include <asm/frame.h>
 
 ENTRY(swsusp_arch_suspend)
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	%rsp, pt_regs_sp(%rax)
 	movq	%rbp, pt_regs_bp(%rax)
 	movq	%rsi, pt_regs_si(%rax)
@@ -115,7 +115,7 @@ ENTRY(restore_registers)
 	movq	%rax, %cr4;  # turn PGE back on
 
 	/* We don't restore %rax, it must be 0 anyway */
-	movq	$saved_context, %rax
+	leaq	saved_context(%rip), %rax
 	movq	pt_regs_sp(%rax), %rsp
 	movq	pt_regs_bp(%rax), %rbp
 	movq	pt_regs_si(%rax), %rsi
-- 
2.20.1.495.gaa96b0ce6b-goog

