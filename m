Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E83C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7652084A
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 18:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UORXOUKY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE7652084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbeKRFOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 00:14:55 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38696 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725734AbeKRFOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 00:14:55 -0500
Received: by mail-pg1-f195.google.com with SMTP id g189so317567pgc.5
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 10:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KK24Xtf0yZxdzxm9LC+famSI28x00YC11YF96N0BM3E=;
        b=UORXOUKYewxZBY9q60veahrHkEtPpR9GSai6HV7K7LIRYSUmveL4hgphwWKykjezr5
         5aJslRjRd5lwcVzGm/diuVIZt/WHst6O5IT8qVuNmMEHGGC3uCNjKCW4U/6UPunf//Ri
         Yog90RJJIsfBEnEswOgbukRNoDii/RYXBxk8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KK24Xtf0yZxdzxm9LC+famSI28x00YC11YF96N0BM3E=;
        b=A4gBl1fSAuWFJxIvSARauhMYlOKiKCZW5WEPHTYSw+0qA+H4xZo+rCaSjEKTF9vOpl
         1r9t8dvJaQod2BR53Ek+hknPKyHM98OEr5ZBN6iAqOu0So7EkDo5kOZOKB6wbLGBukiO
         lGgv2DFHaqC+27s++j1AdccmZr3p1pLJaO/nPO0x17r1Yth9S0LE+bvKHFBeeqOHkIAu
         +k1XMcq22NM3sCv6FoC51yKGuWam8AUZaTWhk2YG3Vjq3erA6uQP8KU+eQFrZB2Dxvu3
         oQg02zYAZKwipUVYpLJca/CaNFTV89Tce3SnZKHQKFJQcdyFSbOkL5Tu5FLWZ+WqVqrA
         BdJg==
X-Gm-Message-State: AGRZ1gIbz2Q5/nFKpI01Top23IUTZiHTlITUenXj+lv/dJr3ofjJ3Pno
        i8fB6EJA+PhF6Jvsnd6xka6MLvhgHN9Usg==
X-Google-Smtp-Source: AJdET5dcu85Awa0hWemuaG/qBca5+pUPD7vYP+djiZMTtvFzptSWkQPdpArsamMNJVlWr5986121ww==
X-Received: by 2002:a63:3c44:: with SMTP id i4mr14292473pgn.286.1542481039552;
        Sat, 17 Nov 2018 10:57:19 -0800 (PST)
Received: from mba13.psav.com ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id u76-v6sm49550745pfa.176.2018.11.17.10.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 10:57:18 -0800 (PST)
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
Subject: [PATCH 0/4] bpf: permit JIT allocations to be served outside the module region
Date:   Sat, 17 Nov 2018 10:57:11 -0800
Message-Id: <20181117185715.25198-1-ard.biesheuvel@linaro.org>
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

Patch #1 fixes a bug introduced during the merge window, where the new
alloc/free tracking does not account for memory that is freed by some
arch code.

Patch #2 refactors the freeing path so that architectures can switch to
something other than module_memfree().

Patch #3 does the same for module_alloc().

Patch #4 implements the new alloc/free overrides for arm64

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
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: James Hogan <jhogan@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: sparclinux@vger.kernel.org
Cc: netdev@vger.kernel.org

Ard Biesheuvel (4):
  bpf: account for freed JIT allocations in arch code
  net/bpf: refactor freeing of executable allocations
  bpf: add __weak hook for allocating executable memory
  arm64/bpf: don't allocate BPF JIT programs in module memory

 arch/arm64/net/bpf_jit_comp.c     | 11 ++++++++++
 arch/mips/net/bpf_jit.c           |  7 ++-----
 arch/powerpc/net/bpf_jit_comp.c   |  7 ++-----
 arch/powerpc/net/bpf_jit_comp64.c | 12 +++--------
 arch/sparc/net/bpf_jit_comp_32.c  |  7 ++-----
 kernel/bpf/core.c                 | 22 ++++++++++----------
 6 files changed, 31 insertions(+), 35 deletions(-)

-- 
2.17.1

