Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D67C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 22:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0626020861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 22:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Emne+hOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0626020861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbeKXJEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 04:04:31 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33978 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbeKXJEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 04:04:31 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so8402304wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 14:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ZFGLcFsJGBJa7lwONQ9ze1SyW/x9MifBvOkbZkDguY=;
        b=Emne+hOT+VIshM/P0PVECpzJvCjCTEAHU4CgmMgHaVVjc/CQIdqc/nhh+BSX0p41t8
         9zNZI9dpIytkxwi9W+rED1uFCrlRDR7ofv6T67YKYbF4UAF5BTvwdv8hzdRUDKfqBBlh
         xe07d88+VV0aODCzewN9dJkVy3UaruscOzP+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ZFGLcFsJGBJa7lwONQ9ze1SyW/x9MifBvOkbZkDguY=;
        b=ChQzvrOCOaJTYvPL9G/qBzoAygdrdLFSuY/caKTDQ+vLsTtcglhwU+h9Gx5yqCHh6v
         ttQXCAO9v/o9wRb/RxH9sXnXO6goRhX0AGTqhH8mWbvEUZgiJoVrdNAIXTJLJujTC6fl
         4awwU/YRnLio7fvoevllZ0B9kGqLTOxrPYBj1cw3Wxse1MIrLNdp6srhLv0cOs5Blk0b
         l+azVpu2uhNntPZfZHSUq0cz/eNUIIi3qRZ5uN2EmEDDV0VqRFbgh1RrO2CSh8YIgu5r
         H6pFM0/YdNuqOEGbIu4eDFrFhRsKfTZeDD3t2CrvIHn9j/1el88b/YULXHHqEm69XvTs
         UeFg==
X-Gm-Message-State: AGRZ1gIewVWhlVcrE6/iKFuj5YeeuJD8nw+S3hwErynniK/E1+6da5QI
        mmR8rZGDuoze9rPQcc06iPFRgeJpewY=
X-Google-Smtp-Source: AJdET5encOrdECPBMV90ODPAGTl2VHI7VPxfCXrQFujg6tzdP6uWPzErbreQOWnn+UMwFJu+4odY3A==
X-Received: by 2002:a1c:b54b:: with SMTP id e72mr15403683wmf.73.1543011505644;
        Fri, 23 Nov 2018 14:18:25 -0800 (PST)
Received: from harold.home ([2a01:cb1d:112:6f00:6913:f64b:5e59:5ba5])
        by smtp.gmail.com with ESMTPSA id y13sm12578267wrw.85.2018.11.23.14.18.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 14:18:24 -0800 (PST)
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
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
Subject: [PATCH v4 2/2] arm64/bpf: don't allocate BPF JIT programs in module memory
Date:   Fri, 23 Nov 2018 23:18:04 +0100
Message-Id: <20181123221804.440-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123221804.440-1-ard.biesheuvel@linaro.org>
References: <20181123221804.440-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm64 module region is a 128 MB region that is kept close to
the core kernel, in order to ensure that relative branches are
always in range. So using the same region for programs that do
not have this restriction is wasteful, and preferably avoided.

Now that the core BPF JIT code permits the alloc/free routines to
be overridden, implement them by vmalloc()/vfree() calls from a
dedicated 128 MB region set aside for BPF programs. This ensures
that BPF programs are still in branching range of each other, which
is something the JIT currently depends upon (and is not guaranteed
when using module_alloc() on KASLR kernels like we do currently).
It also ensures that placement of BPF programs does not correlate
with the placement of the core kernel or modules, making it less
likely that leaking the former will reveal the latter.

This also solves an issue under KASAN, where shadow memory is
needlessly allocated for all BPF programs (which don't require KASAN
shadow pages since they are not KASAN instrumented)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/memory.h |  5 ++++-
 arch/arm64/net/bpf_jit_comp.c   | 13 +++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b96442960aea..ee20fc63899c 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -62,8 +62,11 @@
 #define PAGE_OFFSET		(UL(0xffffffffffffffff) - \
 	(UL(1) << (VA_BITS - 1)) + 1)
 #define KIMAGE_VADDR		(MODULES_END)
+#define BPF_JIT_REGION_START	(VA_START + KASAN_SHADOW_SIZE)
+#define BPF_JIT_REGION_SIZE	(SZ_128M)
+#define BPF_JIT_REGION_END	(BPF_JIT_REGION_START + BPF_JIT_REGION_SIZE)
 #define MODULES_END		(MODULES_VADDR + MODULES_VSIZE)
-#define MODULES_VADDR		(VA_START + KASAN_SHADOW_SIZE)
+#define MODULES_VADDR		(BPF_JIT_REGION_END)
 #define MODULES_VSIZE		(SZ_128M)
 #define VMEMMAP_START		(PAGE_OFFSET - VMEMMAP_SIZE)
 #define PCI_IO_END		(VMEMMAP_START - SZ_2M)
diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index a6fdaea07c63..76c2ab40c02d 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -940,3 +940,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 					   tmp : orig_prog);
 	return prog;
 }
+
+void *bpf_jit_alloc_exec(unsigned long size)
+{
+	return __vmalloc_node_range(size, PAGE_SIZE, BPF_JIT_REGION_START,
+				    BPF_JIT_REGION_END, GFP_KERNEL,
+				    PAGE_KERNEL_EXEC, 0, NUMA_NO_NODE,
+				    __builtin_return_address(0));
+}
+
+void bpf_jit_free_exec(void *addr)
+{
+	return vfree(addr);
+}
-- 
2.19.1

