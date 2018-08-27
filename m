Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154B7C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E06C208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B9H/00l/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E06C208B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbeH0OtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 10:49:12 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40329 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbeH0OtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 10:49:12 -0400
Received: by mail-ed1-f68.google.com with SMTP id e19-v6so10146524edq.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 04:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KZpXutJD8TJDNiGk/rbW/vWe21LI0Ft8rx8Dmxx88Jw=;
        b=B9H/00l/A38AZ0GnJJ6RMEqfOIDUf6edSpUR80T1y7vw45Pd8sA18wSG5Pu+5f4z9n
         V7OQKazV/yxfFJREddZrMDdWu6NoMIFHGn/fnbBSbEBO5V+Q3TcNS8p6uJQcRl8HXrkc
         8kkZ+CKQe4s/x4sQptQhsxxNAAZDg6CWNB2No=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KZpXutJD8TJDNiGk/rbW/vWe21LI0Ft8rx8Dmxx88Jw=;
        b=ILl4AxD2e91ky2DxZ1bJ2hveQ5Sbt1nGED3UwV40fgKroUQGY6oKrvrK4KMaNrCsG9
         MyfiXWLrFvbWiUXxB3EMxf1VTzY4Lqhgvb9H3ztGfC7vi0lZagBTatxZJar+EKoVX7iZ
         s9aBc1n29UlkolnGqWnrPJjNwl8w/h3CiDkHoCCAWwDTWKXOs4XBMvAeiG45I6Ekr7IE
         CBdT4CPmI1j/jzP39t02N+2gH8XJ2NprWxPydrfjqzs9acFSzCxuRzeyAiIpPimzwLuy
         a6caPfIE516o7JpNXGx6jNyo5viypHJvTf99qy8AWxy2JopbId2JH0S1E+t6v9ETTNln
         kn5g==
X-Gm-Message-State: APzg51Ck4yNNey0MRUHurmsdikOqs0pW1h0k8sI907c3ffs5gZH5udjC
        8kSM6KIrMnhvCx9HQBgvg6Tkcw==
X-Google-Smtp-Source: ANB0VdZ15BArf225FMwUl6lV/s5gWxygzNw8Vk/gEodEtfkTLgjcWuHbP9Silo4/bUKSYv9Fz42phA==
X-Received: by 2002:a50:b003:: with SMTP id i3-v6mr16010146edd.120.1535367779989;
        Mon, 27 Aug 2018 04:02:59 -0700 (PDT)
Received: from rev02.home ([2a02:a212:9283:9800:24b9:e2d6:9acc:50dd])
        by smtp.gmail.com with ESMTPSA id r2-v6sm3114344eda.89.2018.08.27.04.02.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 04:02:59 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org
Cc:     will.deacon@arm.com, catalin.marinas@arm.com,
        herbert@gondor.apana.org.au, ebiggers@google.com,
        suzuki.poulose@arm.com, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 0/4] arm64: wire CRC32 instructions into core crc32 routines
Date:   Mon, 27 Aug 2018 13:02:41 +0200
Message-Id: <20180827110245.14812-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are many crc32 users in the kernel that call the library routine
rather than the crypto API wrapper, and so none of these callers use the
accelerated arm64 instructions when available.

While this is not known to cause performance issues, calling a table based
time variant implementation with a non-negligible D-cache footprint (8 KB)
is wasteful in any case, and now that the crc32 instructions have been made
mandatory in the architecture, let's wire them up into the core crc routines.

This also means that they will be exposed to the crypto API via the generic
CRC32 driver, and so we can remove the scalar routines from the crypto API
driver. This leaves the PMULL code, which will only be useful on systems
that implement 64x64 PMULL but not the CRC32 instructions. Given that no
such systems are known to exist, this driver is removed entirely in patch #4.

Ard Biesheuvel (4):
  lib/crc32: make core crc32() routines weak so they can be overridden
  arm64: cpufeature: add feature for CRC32 instructions
  arm64/lib: add accelerated crc32 routines
  crypto: arm64/crc32 - remove PMULL based CRC32 driver

 arch/arm64/Kconfig                |   1 +
 arch/arm64/configs/defconfig      |   1 -
 arch/arm64/crypto/Kconfig         |   5 -
 arch/arm64/crypto/Makefile        |   3 -
 arch/arm64/crypto/crc32-ce-core.S | 287 --------------------
 arch/arm64/crypto/crc32-ce-glue.c | 244 -----------------
 arch/arm64/include/asm/cpucaps.h  |   3 +-
 arch/arm64/kernel/cpufeature.c    |   9 +
 arch/arm64/lib/Makefile           |   2 +
 arch/arm64/lib/crc32.S            |  60 ++++
 lib/crc32.c                       |  11 +-
 11 files changed, 81 insertions(+), 545 deletions(-)
 delete mode 100644 arch/arm64/crypto/crc32-ce-core.S
 delete mode 100644 arch/arm64/crypto/crc32-ce-glue.c
 create mode 100644 arch/arm64/lib/crc32.S

-- 
2.18.0

