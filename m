Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0447C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82702147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 13:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BaxVc/Eh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B82702147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbeKUXwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:52:04 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46357 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729128AbeKUXwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:52:04 -0500
Received: by mail-ed1-f65.google.com with SMTP id o10so4818490edt.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 05:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ua5Rr10lwHQvZaAtuEira9MgKRm7EfMgP/0yT234Uxw=;
        b=BaxVc/Eh5J9Ay0ueMrqcTiPg+8RlZM80+ExLfcaPieTzUwa3hPsZBvJnzhpmMw9ZO8
         8q2ScdC7WhN88IA9dnY1FHIbPbZKD0WLa0ctSbbWqc14rzGIxA7jotkWM8nGOwckye7Q
         H4Zq6NalCr/TE43QKQbjjUrUZ6yRLTlytbE14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ua5Rr10lwHQvZaAtuEira9MgKRm7EfMgP/0yT234Uxw=;
        b=JeBWnj+cgYbtxqCnijVDnLr/dYEp+oIXsz7qUb3miaJHGXsJWCajeesTmFQVEVPq79
         O4bbOSJjLV9qjWfVNHW3LjzfRZ/FaNhQw8BP8UMyvirSmyfo8SIScrZ6lS77XgeDouZ0
         Nr3mzZUhTT3bgL+gE/YOg/pb3zxJK68rlC0+CUx7t/j2ix52PUMdepw7x8XhGDssS4yb
         LpMG3umztQazE0Il9eGE5lRoScAPETmxAqCn0QT/p7c4zAevnt2r6ampayE5Zbt8YGTP
         jhfD/A4CVoEAJe01SLJjtpu3AHNgdU6ZWDFp7XSWrNqhwhtfTmDgsAC+AM374QgzH1lW
         k/kw==
X-Gm-Message-State: AA+aEWbgu2W6ofVTQhuocA7yEkzDKjjVRmxPuWFJHYDBXpNfSlsVRZFW
        hLJSdba1DuBseO8zVecD33BOmQ==
X-Google-Smtp-Source: AFSGD/VNzqBxHyRSU0uZ48ax5D7DVW++khtRregEvcM7u8CfZYYfSol/GBuyXwoHe4pG80+iPnA3oQ==
X-Received: by 2002:a50:b8e5:: with SMTP id l92mr5627576ede.294.1542806262119;
        Wed, 21 Nov 2018 05:17:42 -0800 (PST)
Received: from mba13.wifi.ns.nl (dhcp-077-251-017-237.chello.nl. [77.251.17.237])
        by smtp.gmail.com with ESMTPSA id f4sm11501597edb.21.2018.11.21.05.17.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 05:17:41 -0800 (PST)
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
Subject: [PATCH v2 0/2] bpf: permit JIT allocations to be served outside the module region
Date:   Wed, 21 Nov 2018 14:17:31 +0100
Message-Id: <20181121131733.14910-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
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

Patch #4 implements the new alloc/free overrides for arm64

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

 arch/arm64/net/bpf_jit_comp.c | 10 ++++++++++
 kernel/bpf/core.c             | 14 ++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.17.1

