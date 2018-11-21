Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1CCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C3E2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ygh+2Lj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C3E2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730958AbeKUXwH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:52:07 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38512 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729128AbeKUXwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:52:05 -0500
Received: by mail-ed1-f66.google.com with SMTP id h50so4855046ede.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 05:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AeOSRD17eI7lqQdKuzheZHr/lUeJ/wz4KokMFARTc+Y=;
        b=Ygh+2Lj5cEMg6oVN64CQcyFRQTdy0Md0J7EJggMJPoZO82mhFGh7Ps9P8enMqjisOH
         RBOrTlLg9N1r6t8KCP4czn0GWxphAenXXmY7T9ObCj5awEAdy7kIpypzhq21TotWc9mp
         NRCRN8pCMcOTDd0FPPr7ptyG7iFNuY2NX9MZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AeOSRD17eI7lqQdKuzheZHr/lUeJ/wz4KokMFARTc+Y=;
        b=iw/1IacLxIPYT0YJWFdsQDBr92VHRzPS/ptah6kowbWJImS9ecm1xGLTGTNFSMraqR
         ccxl8by/zCMjmgDVDpxpQh7CZPgATW2LkqHcjjn41WRD3vHPxGr+Ma9w4vfKl1rFkg3p
         Bx9B+0WJOPxr0kbCFpJu4kLB/EclQyKzn5W35sGnvsbdRsy8vJ8EAsBbcVBNKE1t7JnZ
         rV5nbHLCYD4DrEck+PEYYuVWfW6Pq4HS2Tztm26B+BD6ZBCNf6B3Qi5KyVKXO7/2SSMI
         EzxpOqjtnLztVNz54YqgtuLEN9DIxTIV0kvvONqUm71MpzMqBs/UWqG7K9q7HRIZFe7o
         gduw==
X-Gm-Message-State: AGRZ1gJmzn2/kHPwEMpcYz0RW6dfxJYFIw/PG4zQ3W0PGw7MJ1Bcnqqi
        bQJF4F46IX2xFMQ81kS9rg1h8A==
X-Google-Smtp-Source: AJdET5dLo531+uVY2yq/X/fvsI2gFaOS6K1nlcXESrdtnBQE2ALtc/h/eyWl/cSfv4LK+hxTdCC4Aw==
X-Received: by 2002:a17:906:4684:: with SMTP id a4-v6mr5210489ejr.24.1542806263663;
        Wed, 21 Nov 2018 05:17:43 -0800 (PST)
Received: from mba13.wifi.ns.nl (dhcp-077-251-017-237.chello.nl. [77.251.17.237])
        by smtp.gmail.com with ESMTPSA id f4sm11501597edb.21.2018.11.21.05.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 05:17:42 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-arm-kernel@lists.infradead.org
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
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 1/2] bpf: add __weak hook for allocating executable memory
Date:   Wed, 21 Nov 2018 14:17:32 +0100
Message-Id: <20181121131733.14910-2-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181121131733.14910-1-ard.biesheuvel@linaro.org>
References: <20181121131733.14910-1-ard.biesheuvel@linaro.org>
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
index 1a796e0799ec..f28d8a5eb6b8 100644
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
+	return module_memfree(size);
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

