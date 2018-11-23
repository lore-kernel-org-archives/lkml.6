Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADB6C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F1F20685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 09:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Thb6DIKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00F1F20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502933AbeKWUZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 15:25:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55913 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405436AbeKWUZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 15:25:41 -0500
Received: by mail-wm1-f67.google.com with SMTP id y139so11207558wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 01:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v8u1be1RwPj+OIivYZiNyoEvuwKWhLSeAuAn+o4TaVM=;
        b=Thb6DIKWloK3VAeOMhRGVz7JUMNthBIe3jpvdlMgfpDF2WM7Yv2reFjk5VNxYFDevF
         NRAouSWeMHTKNfl8RW9mdnY2lDYEC64JhMi24oVca5KQTsrDG0pS82iG2Py6+5QvTSrh
         l8iLl3PyXCClu0kqpLSRn2/DU+KBkPmqZEpaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v8u1be1RwPj+OIivYZiNyoEvuwKWhLSeAuAn+o4TaVM=;
        b=O2pdhojtcXZZm4Wik2G61dvusepyTkrQE/ISuopwz/q8cXpOs8Oy8GlzxmTHmv/vim
         nLWd3uqq6TynzuJ1RahjBtdJ+jsp+vWySf1nNjQkTYyctY8VntXkF6d0iqkHl2Mh1pxs
         mDcDR5pR8DOjCigzTXl7Z/O5Q8ksSQja08KDDmZnxjgs14I/DenEPGHgNfuwQuCjsr4d
         yPQ8XFuMneVNkOZ80MF2meN6o9PRBe6Bnw//Xf5pGDknYDFsreVNypNS7UP/TgmXFWFb
         kWPy3L/0GyYsXJNNrNOgdlQ/m6Ng1Fqi3fToabO7latyhM5/3voVGu59L4q1afjfeXZL
         A4nA==
X-Gm-Message-State: AGRZ1gIvSegRh7mwxlZkmIWnbsK7JETDR/aHK96fUzPeTGbV8FFK1yCH
        G/IaujlnXcqkpPEAb8TYn3p4xWs9bZESUw==
X-Google-Smtp-Source: AFSGD/ULHYxKsh4ca0AgG7q5teT+z1FYH+qvRZhiE+0m/agWT4eumiZ49jaTBRZizhWWwTqwamKe+Q==
X-Received: by 2002:a1c:5f83:: with SMTP id t125-v6mr13176800wmb.53.1542966129100;
        Fri, 23 Nov 2018 01:42:09 -0800 (PST)
Received: from mba13.wifi.ns.nl (33.153.69.91.rev.sfr.net. [91.69.153.33])
        by smtp.gmail.com with ESMTPSA id k7sm35489897wrl.51.2018.11.23.01.42.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 01:42:08 -0800 (PST)
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
Subject: [PATCH v3 1/2] bpf: add __weak hook for allocating executable memory
Date:   Fri, 23 Nov 2018 10:41:51 +0100
Message-Id: <20181123094152.21368-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181123094152.21368-1-ard.biesheuvel@linaro.org>
References: <20181123094152.21368-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, BPF uses module_alloc() to allocate executable memory,
but this is not necessary on all arches and potentially undesirable
on some of them.

So break out the module_alloc() and module_memfree() calls into __weak
functions to allow them to be overridden in arch code.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 kernel/bpf/core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 1a796e0799ec..572dd74c26e3 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -609,6 +609,16 @@ static void bpf_jit_uncharge_modmem(u32 pages)
 	atomic_long_sub(pages, &bpf_jit_current);
 }
 
+void *__weak bpf_jit_alloc_exec(unsigned long size)
+{
+	return module_alloc(size);
+}
+
+void __weak bpf_jit_free_exec(const void *addr)
+{
+	module_memfree(addr);
+}
+
 struct bpf_binary_header *
 bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 		     unsigned int alignment,
@@ -626,7 +636,7 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 
 	if (bpf_jit_charge_modmem(pages))
 		return NULL;
-	hdr = module_alloc(size);
+	hdr = bpf_jit_alloc_exec(size);
 	if (!hdr) {
 		bpf_jit_uncharge_modmem(pages);
 		return NULL;
@@ -650,7 +660,7 @@ void bpf_jit_binary_free(struct bpf_binary_header *hdr)
 {
 	u32 pages = hdr->pages;
 
-	module_memfree(hdr);
+	bpf_jit_free_exec(hdr);
 	bpf_jit_uncharge_modmem(pages);
 }
 
-- 
2.17.1

