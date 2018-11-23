Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8C3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 22:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F208220861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 22:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bKsKXBXS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F208220861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbeKXJE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 04:04:29 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55214 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeKXJE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 04:04:28 -0500
Received: by mail-wm1-f67.google.com with SMTP id r63-v6so13110328wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 14:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fYPVSXXSxRlZtaS4pECe7oPYKLBl6FSIygjQnihZy4Q=;
        b=bKsKXBXSoVcz1eSzGI2lS7TvEUTCxlKboZJ1AbNuvllKsJTTVp6Ezjjjgy8YWAOwvM
         Zm8xRm7+iNYaq/iwRNeCyf1CNr0M08cbE+rKk4qXrB7XuVuvrMo0Q+tHWsJcVb9YOG6f
         wVAwcSWW+MmCGyiA/w3DStkFqWPIgcu9IcRHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fYPVSXXSxRlZtaS4pECe7oPYKLBl6FSIygjQnihZy4Q=;
        b=bJOp7CWguo4jl6Fv6LiCegZjQMAJjCWfzZr9Gmzkk/8fEE4NcjmkkbcF43TB4MVI/p
         FbRj1zrvKJqoy9/B2qA12hnjv3cXFwC8CfChXZ82by4JWVlC/oykXERjpkbaeEq8tg6H
         0QRWFw1dO+HWPLjT5TPERCmkTZ5Va7K+Uk08u2NIWXTprbG2HOc8rBRSMyJrr5MrrI6a
         +iRwleJnqTECifEE0EvJ7TR4O5uC9YwGlfbsNPufpsMNZP74UW14twmoiFBaFFIMt3DK
         Hn2COGKNy5ETXes1dw6KTZZdmic+vSKhVjh4DJZRkABBUMbdLG16QjKkZ4RT1xXBVimY
         Bp3g==
X-Gm-Message-State: AGRZ1gKJxlfiMZBKYiv32my7r4q9H3VpRnXhqVCfaXdjTwYZwlfPRT6I
        phehFuK1R+deT+cJjdRqGz3cG0NhllE=
X-Google-Smtp-Source: AJdET5ebqjOyY42Y7dbOnTyyndvwEOuHwMcKEtiUstUKnE/LOoX2+2tn+Fy0Dq3+LA/z5KRTd2cDzA==
X-Received: by 2002:a7b:c003:: with SMTP id c3-v6mr14097308wmb.133.1543011502879;
        Fri, 23 Nov 2018 14:18:22 -0800 (PST)
Received: from harold.home ([2a01:cb1d:112:6f00:6913:f64b:5e59:5ba5])
        by smtp.gmail.com with ESMTPSA id y13sm12578267wrw.85.2018.11.23.14.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 14:18:21 -0800 (PST)
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
Subject: [PATCH v4 0/2] bpf: permit JIT allocations to be served outside the module region
Date:   Fri, 23 Nov 2018 23:18:02 +0100
Message-Id: <20181123221804.440-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm64, modules are allocated from a 128 MB window which is close to
the core kernel, so that relative direct branches are guaranteed to be
in range (except in some KASLR configurations). Also, module_alloc()
is in charge of allocating KASAN shadow memory when running with KASAN
enabled.

This means that the way BPF reuses module_alloc()/module_memfree() is
undesirable on arm64 (and potentially other architectures as well),
and so this series refactors BPF's use of those functions to permit
architectures to change this behavior.

Patch #1 breaks out the module_alloc() and module_memfree() calls into
__weak functions so they can be overridden.

Patch #2 implements the new alloc/free overrides for arm64

Changes since v3:
- drop 'const' modifier for free() hook void* argument
- move the dedicated BPF region to before the module region, putting it
  within 4GB of the module and kernel regions on non-KASLR kernels

Changes since v2:
- properly build time and runtime tested this time (log after the diffstat)
- create a dedicated 128 MB region at the top of the vmalloc space for BPF
  programs, ensuring that the programs will be in branching range of each
  other (which we currently rely upon) but at an arbitrary distance from
  the kernel and modules (which we don't care about)

Changes since v1:
- Drop misguided attempt to 'fix' and refactor the free path. Instead,
  just add another __weak wrapper for the invocation of module_memfree()

Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Eric Dumazet <eric.dumazet@gmail.com>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>

Cc: Jessica Yu <jeyu@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org

Ard Biesheuvel (2):
  bpf: add __weak hook for allocating executable memory
  arm64/bpf: don't allocate BPF JIT programs in module memory

 arch/arm64/include/asm/memory.h |  5 ++++-
 arch/arm64/net/bpf_jit_comp.c   | 13 +++++++++++++
 kernel/bpf/core.c               | 14 ++++++++++++--
 3 files changed, 29 insertions(+), 3 deletions(-)

-- 
2.19.1

