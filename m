Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F433C43610
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD19920815
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XYLhyO5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD19920815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbeKRFO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 00:14:59 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36520 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbeKRFO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 00:14:58 -0500
Received: by mail-pf1-f196.google.com with SMTP id b85so6107599pfc.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 10:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=26kHMy6e9ZHNMFq26DfYcP5qT10rPVni7XnqYDLJuPI=;
        b=XYLhyO5mN3FVA4ReKitsYfMKGuHNDNlOhuo5CX3m1WdOPZeKdKBplc4oZZ6V6yFg5A
         hQ83SmcdvQq6M0spjr5rwWJUh9QdiW39oPX0Z2kNZVWF+j0XU6sZnr/m82angEa1AG65
         GQ2t7WMlRjYOWyc5If1zGyUDez/kBmIctb+b4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=26kHMy6e9ZHNMFq26DfYcP5qT10rPVni7XnqYDLJuPI=;
        b=tPWg68MXt/9Md4RUxKgqgXn0DH646P3GCjKcjMl+Bd8gEnc5YgOgLZgeb3KMtc54YD
         7NmXUkOyOdwGNwjE3LP/qlP20SKrsN3HaIkcSUWzx2nOaJ14KWqhvmR4BLNuxPHSOxq8
         gTj6zm9hZntO1izmhx+ZkzKRmOPMIaAS8/WmShPqaOXXSDKU2ZCQeKbXjADRd630wdBr
         xh5R6HQxw4bFavwbc9j8ZFEkpCl3tBSnOr/aLV2DjTTFSB15e8YsyynjrRZOkTCu5tpD
         k6h33v9bhpzetuyTUX6n5aEVyLXsZsJnZLmv9/5cDtlzG6zQMVzwrQ1fJIs2KEN9z4Cw
         nJpg==
X-Gm-Message-State: AGRZ1gIMqkinDUCR3MH31Vv7/z5pE1YGSqNJMtjw26573DlHiCBrPnCD
        Xkm4WaBEwWYqum+53T3eoi2Af6PVPvzjTg==
X-Google-Smtp-Source: AJdET5dbJskaau0oeh2D+j2r5+z2XCOLI6qC1Gpj92MrCzlhVrhcUg2kk12XFX1xpT0h9FiUT1nBcw==
X-Received: by 2002:a63:f241:: with SMTP id d1mr14569834pgk.2.1542481043353;
        Sat, 17 Nov 2018 10:57:23 -0800 (PST)
Received: from mba13.psav.com ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id u76-v6sm49550745pfa.176.2018.11.17.10.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 10:57:22 -0800 (PST)
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
Subject: [PATCH 3/4] bpf: add __weak hook for allocating executable memory
Date:   Sat, 17 Nov 2018 10:57:14 -0800
Message-Id: <20181117185715.25198-4-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
References: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, BPF uses module_alloc() to allocate executable memory,
but this is not necessary on all arches and potentially undesirable
on some of them.

So break out the module_alloc() call into a __weak function to allow
it to be overridden in arch code.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 kernel/bpf/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 29f766dac203..156d6b96ac6c 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -609,6 +609,11 @@ static void bpf_jit_uncharge_modmem(u32 pages)
 	atomic_long_sub(pages, &bpf_jit_current);
 }
 
+void *__weak bpf_jit_alloc_exec(unsigned long size)
+{
+	return module_alloc(size);
+}
+
 struct bpf_binary_header *
 bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 		     unsigned int alignment,
@@ -626,7 +631,7 @@ bpf_jit_binary_alloc(unsigned int proglen, u8 **image_ptr,
 
 	if (bpf_jit_charge_modmem(pages))
 		return NULL;
-	hdr = module_alloc(size);
+	hdr = bpf_jit_alloc_exec(size);
 	if (!hdr) {
 		bpf_jit_uncharge_modmem(pages);
 		return NULL;
-- 
2.17.1

