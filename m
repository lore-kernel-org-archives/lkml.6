Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1D7C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7991620B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:30:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LSObIfuT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbfAaTan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:30:43 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37726 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729229AbfAaT2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:28:31 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so1931754plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e3dk7ZZLbgfAGqbWuqUoL9HQGz8pGKWmGgQPHhRwhHc=;
        b=LSObIfuTa0xQZr+bKcohW5Q4cnEUGVS1uN0e+E+t5yGY3ixq2p0ylnhjahS+VsAoud
         dfQFfu/K65GhONSXV/9Ig0S2IkwVgCuC03FqMl483WxEI8aBASFGlOqsYI9nwZ+tkzYl
         0j0jR+quzA89kEo+E3f8gJx+6sY+4pX2Wao2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e3dk7ZZLbgfAGqbWuqUoL9HQGz8pGKWmGgQPHhRwhHc=;
        b=J98yBBEKwk8KGv7hYv79z5FsZo99PhJuu5K4GM40fzuIjvsDF4+i1DyumXprQ6d5oo
         cIbK0bOUOYov03OpuptdodzFBzRylO9UbUMeG57edI86O41+6Q2fr8/qP6/comZXZvoC
         6xHqdTXiK7UwPgC3jR0+6EcImOga5oeHupCi02Tif/FVMMvxmO3i4zCmw/zNReFT6A9z
         DvtZcNdwUoB/0pNw25Qkysf94LuHBtE6+3BJ7GSOR3awywdV51CpmadmBCvY2Thld8kN
         BCOoGjX+TUUkJD860SfKeWj0oPw0TjGPni/e4tX+3Ko5VuQYVRkmE9ts20E62AeLt16y
         3wog==
X-Gm-Message-State: AHQUAuag11DxQ3HIg0MZyIdLkOaB0iQECp57fKxqljdT1wki4ULypQ1P
        qgS6YFEKE9YFejcPb3zvJlt+rg==
X-Google-Smtp-Source: AHgI3IayF4kHqDIM+q4+Y8uOrB6q1Ap2qB2KO55tlf08CInn20aam+1XuCmrMPxPHm2eZ8La9YoXPQ==
X-Received: by 2002:a17:902:e01:: with SMTP id 1mr21126754plw.251.1548962911253;
        Thu, 31 Jan 2019 11:28:31 -0800 (PST)
Received: from skynet.sea.corp.google.com ([2620:15c:17:4:29de:3bb1:1270:e679])
        by smtp.gmail.com with ESMTPSA id s130sm11164399pgc.60.2019.01.31.11.28.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:28:30 -0800 (PST)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, Thomas Garnier <thgarnie@chromium.org>,
        Juergen Gross <jgross@suse.com>,
        Alok Kataria <akataria@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 11/27] x86/paravirt: Adapt assembly for PIE support
Date:   Thu, 31 Jan 2019 11:24:18 -0800
Message-Id: <20190131192533.34130-12-thgarnie@chromium.org>
X-Mailer: git-send-email 2.20.1.495.gaa96b0ce6b-goog
In-Reply-To: <20190131192533.34130-1-thgarnie@chromium.org>
References: <20190131192533.34130-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if PIE is enabled, switch the paravirt assembly constraints to be
compatible. The %c/i constrains generate smaller code so is kept by
default.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
---
 arch/x86/include/asm/paravirt_types.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 488c59686a73..8cfcc1b463de 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -342,9 +342,17 @@ extern struct paravirt_patch_template pv_ops;
 #define PARAVIRT_PATCH(x)					\
 	(offsetof(struct paravirt_patch_template, x) / sizeof(void *))
 
+#ifdef CONFIG_X86_PIE
+#define paravirt_opptr_call "a"
+#define paravirt_opptr_type "p"
+#else
+#define paravirt_opptr_call "c"
+#define paravirt_opptr_type "i"
+#endif
+
 #define paravirt_type(op)				\
 	[paravirt_typenum] "i" (PARAVIRT_PATCH(op)),	\
-	[paravirt_opptr] "i" (&(pv_ops.op))
+	[paravirt_opptr] paravirt_opptr_type (&(pv_ops.op))
 #define paravirt_clobber(clobber)		\
 	[paravirt_clobber] "i" (clobber)
 
@@ -392,7 +400,7 @@ int paravirt_disable_iospace(void);
  */
 #define PARAVIRT_CALL					\
 	ANNOTATE_RETPOLINE_SAFE				\
-	"call *%c[paravirt_opptr];"
+	"call *%" paravirt_opptr_call "[paravirt_opptr];"
 
 /*
  * These macros are intended to wrap calls through one of the paravirt
-- 
2.20.1.495.gaa96b0ce6b-goog

