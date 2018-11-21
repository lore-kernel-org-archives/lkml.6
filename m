Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C789C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E902147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kr8MbQ/F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E902147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbeKUXwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:52:09 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42977 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730934AbeKUXwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:52:07 -0500
Received: by mail-ed1-f66.google.com with SMTP id j6so4843348edp.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 05:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MYs0Qup+kKVUQb/IfUObkJlJ+Fjala9xEnkQB4UC89I=;
        b=Kr8MbQ/F6Y/x9T5DEV283Q4otL3mpHVSySGp6QGGdlFneYPQCIcZ81V3nFFm5gbfvk
         /h4YrvBiNU8HxM5HNsH9vWbygI7GLzDiHMGg/3nM/a2a5sGZ1ewObuZ2xAGLvURd0qA0
         Rap+LMykouLcOMjSe+5TJ43OAV43KpYfLl9gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MYs0Qup+kKVUQb/IfUObkJlJ+Fjala9xEnkQB4UC89I=;
        b=HWoRv2gfLWbDINoIAfNo534ayxup4tBAWsXIdFnxvWl9K+VjMWWVgXrmEDOs0QEr1s
         jIGT9OVi2AoTQyoohLRgzBuZM8A3+5wW29YTd7q9DGNpg042M5GmD325Fl7O9I9ckP82
         X+pmnEezcobILIjvEfhrXX4M2wtJPYzL+/Sem9c+EI4Z0ga1vwFyimDL9YXYZRHVIymv
         qLVlT6B2niq3q94K1zXFrhRMW6ccrFz8d1ajyBQ3w8TlKq9I6WYtQ5eI8LK2PyLU24MZ
         3M1e03DllM7+LzNMaEPYXVcCJXcOMlo9G1EeWuR4cN7SGSg1g2JVtpUvaiCFb9oV/kyd
         v27w==
X-Gm-Message-State: AA+aEWaylZu4QqdgUJArYl/+POASGGsVOHaM8bInqdqJUiKRyhrMKka4
        P3xxRQyqQek9s1ozs2O8U7AHmw==
X-Google-Smtp-Source: AFSGD/WWDGuchPCyFI94CqjAkUwCqEvsmhw4mSF+CH6Ce6mcvQNI3NFdTRT1pcMojh80eeKYugaZsg==
X-Received: by 2002:a50:8c21:: with SMTP id p30-v6mr5754586edp.34.1542806265016;
        Wed, 21 Nov 2018 05:17:45 -0800 (PST)
Received: from mba13.wifi.ns.nl (dhcp-077-251-017-237.chello.nl. [77.251.17.237])
        by smtp.gmail.com with ESMTPSA id f4sm11501597edb.21.2018.11.21.05.17.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 05:17:44 -0800 (PST)
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
Subject: [PATCH v2 2/2] arm64/bpf: don't allocate BPF JIT programs in module memory
Date:   Wed, 21 Nov 2018 14:17:33 +0100
Message-Id: <20181121131733.14910-3-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181121131733.14910-1-ard.biesheuvel@linaro.org>
References: <20181121131733.14910-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm64 module region is a 128 MB region that is kept close to
the core kernel, in order to ensure that relative branches are
always in range. So using the same region for programs that do
not have this restriction is wasteful, and preferably avoided.

Now that the core BPF JIT code permits the alloc/free routines to
be overridden, implement them by simple vmalloc_exec()/vfree()
calls, which can be served from anywere. This also solves an
issue under KASAN, where shadow memory is needlessly allocated for
all BPF programs (which don't require KASAN shadow pages since
they are not KASAN instrumented)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/net/bpf_jit_comp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index a6fdaea07c63..f91b7c157841 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -940,3 +940,13 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 					   tmp : orig_prog);
 	return prog;
 }
+
+void *bpf_jit_alloc_exec(unsigned long size)
+{
+	return vmalloc_exec(size);
+}
+
+void bpf_jit_free_exec(const void *addr)
+{
+	return vfree(size);
+}
-- 
2.17.1

