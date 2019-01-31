Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EE0C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA7B20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YeyM2mZh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbfAaT2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:28:40 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37996 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729161AbfAaT2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:28:37 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so1781427pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lYQCxiWY0ydX8ViY3WHUNLfCbgYkqllnTKd1RGLisYQ=;
        b=YeyM2mZhe8SOiS5B502BvG0CG8pV3RgDUT20wQrb5qdkq0nJhxRsT0FtSbnpc233Np
         zNcJmVGfDegctRup0/yIBEBiMWRApryac+IVPGGUd7ShBk1pyxYyNhaGwcA85XcF4qrD
         OFNnOQnUmKoE5xs5q/FHIiZgD2mYJhZ12n1TU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lYQCxiWY0ydX8ViY3WHUNLfCbgYkqllnTKd1RGLisYQ=;
        b=b+wkDslW6/ip8/il+Ebwuz+1SIjeu69gTAicrB+qFx+yJpd3ZBP7l8v3tc4zE+A27R
         xjcE9pV2FnBmN1N6FMoPBfgBouYcz9MCEQ3bKjkJWcUgsuHNpQoglAldXN8lHPCeTBlJ
         2lX8Ou6KSi47oWN6hewlH3G7Y57eVVHKSrbZm/zT4G8QM4+jhHS//qukxwtSdR/HNgRI
         6LHU2LykfA29027ZSm4Qk+v1cIYDACq1Pyil8BwqHkWpqvXq3NZQ6aUBtIxokNBeWC4R
         tJYtBCooo0oMLk9y3a5Poc0i4LEsc1y8I8RkFa4a7Xgz/zrP5MHYF0Src6C+A9ZVeB+D
         eD0g==
X-Gm-Message-State: AJcUukc23oIARwQQmhgNe5FAXPXYvwhEOapiHthjCCP6EGMFWTnJolSw
        TCBGc4GZyEErFHQQGa/fmjBfYQ==
X-Google-Smtp-Source: ALg8bN6J2DMUmLRDDcqCh2Oj54V4ihCjp3x9pQPDzZwdoHY+vTmcv+jVJykw92EfmG8sy+wHJijtBQ==
X-Received: by 2002:a62:1289:: with SMTP id 9mr36578574pfs.102.1548962916976;
        Thu, 31 Jan 2019 11:28:36 -0800 (PST)
Received: from skynet.sea.corp.google.com ([2620:15c:17:4:29de:3bb1:1270:e679])
        by smtp.gmail.com with ESMTPSA id s130sm11164399pgc.60.2019.01.31.11.28.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:28:36 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Garnier <thgarnie@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Garnier <thgarnie@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 13/27] x86/boot/64: Build head64.c as mcmodel large when PIE is enabled
Date:   Thu, 31 Jan 2019 11:24:20 -0800
Message-Id: <20190131192533.34130-14-thgarnie@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190131192533.34130-1-thgarnie@chromium.org>
References: <20190131192533.34130-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __startup_64 function assumes all symbols have relocated addresses
instead of the current boot virtual address. PIE generated code favor
relative addresses making all virtual and physical address math incorrect.
If PIE is enabled, build head64.c as mcmodel large instead to ensure absolute
references on all memory access. Add a global __force_order variable required
when using a large model with read_cr* functions.

To build head64.c as mcmodel=large, disable the retpoline gcc flags.
This code is used at early boot and removed later, it doesn't need
retpoline mitigation.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
---
 arch/x86/kernel/Makefile | 6 ++++++
 arch/x86/kernel/head64.c | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 00b7e27bc2b7..1f98f52eab9f 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -22,6 +22,12 @@ CFLAGS_REMOVE_early_printk.o = -pg
 CFLAGS_REMOVE_head64.o = -pg
 endif
 
+ifdef CONFIG_X86_PIE
+# Remove PIE and retpoline flags that are incompatible with mcmodel=large
+CFLAGS_REMOVE_head64.o += -fPIE -mindirect-branch=thunk-extern -mindirect-branch-register
+CFLAGS_head64.o = -mcmodel=large
+endif
+
 KASAN_SANITIZE_head$(BITS).o				:= n
 KASAN_SANITIZE_dumpstack.o				:= n
 KASAN_SANITIZE_dumpstack_$(BITS).o			:= n
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 16b1cbd3a61e..22e81275495b 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -63,6 +63,9 @@ EXPORT_SYMBOL(vmemmap_base);
 
 #define __head	__section(.head.text)
 
+/* Required for read_cr3 when building as PIE */
+unsigned long __force_order;
+
 static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
 {
 	return ptr - (void *)_text + (void *)physaddr;
-- 
2.20.1.495.gaa96b0ce6b-goog

