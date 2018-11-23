Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBB2C43610
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 22:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514CE20861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 22:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fEXGYNj/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 514CE20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbeKXJEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 04:04:30 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42210 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbeKXJE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 04:04:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so13558311wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 14:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2t2DKZwLo4uiuBiBMlCY8fawnGcKKtVedWhh8SZ5pW8=;
        b=fEXGYNj/zjrne2auIEZkw4UbItpB9cnQsXYQXrVwYhXuatn1twG7bEQKehvRb5hzEk
         4PhZp3v8/zDBoWML41sVaMoIFQ8v9OJnM91SQ/zPdClh1RwbG4tD5YtqYIFIww1mxqbo
         ks7GhN+jEpgtuDsOAY/q5P/1DWS5iDHK5ja/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2t2DKZwLo4uiuBiBMlCY8fawnGcKKtVedWhh8SZ5pW8=;
        b=g6jmNSIEkJfviULK4ieBSE7tzjq28hKeYOpv6wZ5bXMRF5CxQNrad/2/2g98Jf8+EG
         xm7EPtmhyBRdSmfMU16zmdMgTMShHtOhMxreVOHsz0g3zqpi1vqjvBhEk+xKC2SVViop
         ohhnj1BcgXNozS2CWk/QtQKQfXCyDAHT+xBRx4V9cZO85SpguUQ/lreSSBbriGxzo6sL
         Gcijbk1/azjHVTHojEcJUpp96f9nAegrBTYePRi+C1h92X6Q6R1STVK+itZwZT8DMojr
         1qGS5/fv2Fqsir4Q+Op9mgdNhSf1e6GWIiu2pFFuhQk09TVmhQzuzuUSQypBp73ZLYTx
         yNBw==
X-Gm-Message-State: AA+aEWYkt8XuyJNctcKuY6qFDaiEvYjY7ecovb3XfxCKXaIEW+Iiycoa
        MoleTDBGThbH8cbu5W5fach5IDNc32w=
X-Google-Smtp-Source: AFSGD/WaITxS2oVrfLwpvaBcX+Dpe4YjoEvZDiwaqeCxs6qQa7QVB8qOYG1+cV4j08vLLfuBGd2hlQ==
X-Received: by 2002:adf:a452:: with SMTP id e18mr3846291wra.190.1543011504211;
        Fri, 23 Nov 2018 14:18:24 -0800 (PST)
Received: from harold.home ([2a01:cb1d:112:6f00:6913:f64b:5e59:5ba5])
        by smtp.gmail.com with ESMTPSA id y13sm12578267wrw.85.2018.11.23.14.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 14:18:23 -0800 (PST)
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
Subject: [PATCH v4 1/2] bpf: add __weak hook for allocating executable memory
Date:   Fri, 23 Nov 2018 23:18:03 +0100
Message-Id: <20181123221804.440-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181123221804.440-1-ard.biesheuvel@linaro.org>
References: <20181123221804.440-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 1a796e0799ec..78e9b76201b3 100644
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
+void __weak bpf_jit_free_exec(void *addr)
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
2.19.1

