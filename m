Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB55C04EBF
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FDD20817
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cObMuJm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5FDD20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbeKRFO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 00:14:57 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39613 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbeKRFO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 00:14:57 -0500
Received: by mail-pg1-f195.google.com with SMTP id r9-v6so12028271pgv.6
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 10:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FFyK4Oz1QZNyPCsvoKn4MQd4VSSgFUXXhCBgp8QbhcQ=;
        b=cObMuJm7WoQyjusLl+MSm4ZIOr4K71j4aNd5tPxwLRhwvXT/sYcvL7RDfA86wcLwA1
         MBgV1MZKVJe1BNu/nkLqb6788B61g2+j8XPg6DFJaa+9SwGmzpOHS6y6Xqbefq4fvVkj
         +/MH7MuuSDpYgCOZS+o5G38042o7Ps9gEKLjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FFyK4Oz1QZNyPCsvoKn4MQd4VSSgFUXXhCBgp8QbhcQ=;
        b=Ckx/ZfWYwakL41FE6VWOoRDPr2YIu26QR+n+gV3sLltM4tzJpoyr+hu0hLhRU35IGV
         530gvs9E4HD/vMC5y2fJqbS7KzsXZDXDi1drCsotj+VR9rNOIEZGg7x6WtaEFQQvlwto
         s3suJz0JHSLYViWiFgRaAC8UY8lgK/kDzpjdu7IIb1pzn/vpjqs9DG3UHxjZpItIBd9a
         yXi2he1nfLoLXUASD/WBpuAjJ38jeUGjXARsR1m0u5e7XZTfx/kc3XK1R/4bbyljLko8
         XYp4v+2BdR9U3QJ6j4JEl9aPn1c3VGR11PN2q45S3F0ohj5nNyXYDPK4yT2LCoYTQyIQ
         4yhg==
X-Gm-Message-State: AGRZ1gJ3il8AqoPaemOpAdOWmqWrqY1gfSCdmLCN2QMnftxRTDsxbFI9
        OjEzLB+qHRakV6T0B/kdHuW+Ts7Pqrz+rw==
X-Google-Smtp-Source: AJdET5eTfTm7MZO1Ys5mfFPU5yjtvrYsgtZia1/NgQb951W2tIaAMrSSEf/Q1za/zZx27f//YDj5kQ==
X-Received: by 2002:a62:da5a:: with SMTP id w26mr3755848pfl.106.1542481042106;
        Sat, 17 Nov 2018 10:57:22 -0800 (PST)
Received: from mba13.psav.com ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id u76-v6sm49550745pfa.176.2018.11.17.10.57.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 10:57:21 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Jessica Yu <jeyu@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 2/4] net/bpf: refactor freeing of executable allocations
Date:   Sat, 17 Nov 2018 10:57:13 -0800
Message-Id: <20181117185715.25198-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
References: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All arch overrides of the __weak bpf_jit_free() amount to the same
thing: the allocated memory was never mapped read-only, and so
it does not have to be remapped to read-write before being freed.

So in preparation of permitting arches to serve allocations for BPF
JIT programs from other regions than the module region, refactor
the existing bpf_jit_free() implementations to use the shared code
where possible, and only specialize the remap and free operations.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/mips/net/bpf_jit.c           |  7 ++-----
 arch/powerpc/net/bpf_jit_comp.c   |  7 ++-----
 arch/powerpc/net/bpf_jit_comp64.c |  9 +++------
 arch/sparc/net/bpf_jit_comp_32.c  |  7 ++-----
 kernel/bpf/core.c                 | 15 +++++----------
 5 files changed, 14 insertions(+), 31 deletions(-)

diff --git a/arch/mips/net/bpf_jit.c b/arch/mips/net/bpf_jit.c
index 1b69897274a1..5696bd7dccc7 100644
--- a/arch/mips/net/bpf_jit.c
+++ b/arch/mips/net/bpf_jit.c
@@ -1261,10 +1261,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
 	kfree(ctx.offsets);
 }
 
-void bpf_jit_free(struct bpf_prog *fp)
+void bpf_jit_binary_free(struct bpf_binary_header *hdr)
 {
-	if (fp->jited)
-		bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
-
-	bpf_prog_unlock_free(fp);
+	module_memfree(hdr);
 }
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index a1ea1ea6b40d..5b5ce4a1b44b 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -680,10 +680,7 @@ void bpf_jit_compile(struct bpf_prog *fp)
 	return;
 }
 
-void bpf_jit_free(struct bpf_prog *fp)
+void bpf_jit_binary_free(struct bpf_binary_header *hdr)
 {
-	if (fp->jited)
-		bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
-
-	bpf_prog_unlock_free(fp);
+	module_memfree(hdr);
 }
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 84c8f013a6c6..f64f1294bd62 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -1021,11 +1021,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 	return fp;
 }
 
-/* Overriding bpf_jit_free() as we don't set images read-only. */
-void bpf_jit_free(struct bpf_prog *fp)
+/* Overriding bpf_jit_binary_free() as we don't set images read-only. */
+void bpf_jit_binary_free(struct bpf_binary_header *hdr)
 {
-	if (fp->jited)
-		bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
-
-	bpf_prog_unlock_free(fp);
+	module_memfree(hdr);
 }
diff --git a/arch/sparc/net/bpf_jit_comp_32.c b/arch/sparc/net/bpf_jit_comp_32.c
index 01bda6bc9e7f..589950d152cc 100644
--- a/arch/sparc/net/bpf_jit_comp_32.c
+++ b/arch/sparc/net/bpf_jit_comp_32.c
@@ -756,10 +756,7 @@ cond_branch:			f_offset = addrs[i + filter[i].jf];
 	return;
 }
 
-void bpf_jit_free(struct bpf_prog *fp)
+void bpf_jit_binary_free(struct bpf_binary_header *hdr)
 {
-	if (fp->jited)
-		bpf_jit_binary_free(bpf_jit_binary_hdr(fp));
-
-	bpf_prog_unlock_free(fp);
+	module_memfree(hdr);
 }
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 1a796e0799ec..29f766dac203 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -646,25 +646,20 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 	return hdr;
 }
 
-void bpf_jit_binary_free(struct bpf_binary_header *hdr)
+void __weak bpf_jit_binary_free(struct bpf_binary_header *hdr)
 {
-	u32 pages = hdr->pages;
-
+	bpf_jit_binary_unlock_ro(hdr);
 	module_memfree(hdr);
-	bpf_jit_uncharge_modmem(pages);
 }
 
-/* This symbol is only overridden by archs that have different
- * requirements than the usual eBPF JITs, f.e. when they only
- * implement cBPF JIT, do not set images read-only, etc.
- */
-void __weak bpf_jit_free(struct bpf_prog *fp)
+void bpf_jit_free(struct bpf_prog *fp)
 {
 	if (fp->jited) {
 		struct bpf_binary_header *hdr = bpf_jit_binary_hdr(fp);
+		u32 pages = hdr->pages;
 
-		bpf_jit_binary_unlock_ro(hdr);
 		bpf_jit_binary_free(hdr);
+		bpf_jit_uncharge_modmem(pages);
 
 		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(fp));
 	}
-- 
2.17.1

