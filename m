Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AD9C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D54221480
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 09:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlbCFJVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D54221480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbeHVNSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 09:18:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35121 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbeHVNSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 09:18:54 -0400
Received: by mail-pg1-f195.google.com with SMTP id z4-v6so704309pgv.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 02:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Pu6kSVUsOmoXq5Sx6cBotLUTLntQR3P5sBRANpjnOOA=;
        b=LlbCFJVDGatuPiuszKGg6iC0IGGlsIRtBwtE/9N0zKQyAcqlcQnpXPIMYaNo5fNTk0
         hvmAPZ0EcnG2u/ca1rpQn+6WamaUI4NLYzGgjCT4r7V4uS1r9cMETpeJf80EYv9kg/Jx
         Wh2DFf6ENUXc7PQ6Sxm0LFppPqfNILKdcXtcHPu9bZMKuc9fxL2bIdYm9RnfdegKmTb5
         08IfzG0882OYfwR7SGMvIQ/dcrb+ky1Q1d+GJTL/PiqCNBLCmS1jbyvIapKIGuVCpISX
         jcjJf9nUtd9AzSwtkT+enqjqfWXELjZ44gllhPA7QJI01QxhvwU4LC9vJLrUP3nN2D2v
         VvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Pu6kSVUsOmoXq5Sx6cBotLUTLntQR3P5sBRANpjnOOA=;
        b=DDCPRpiafcFsSIRWfJvYwncueKCUNjcirhU9pG+YuaTxCEmiWsXq2TW8Mqs6vF/wIv
         uRcERz8WO4RcVFsViDDesV9L7iJtKhFi0YiYFnMl4G1Usno+OzP/riFOlWEbDxA/yWQD
         1Fnh8e6RaZhjL61xDfw1s/iTY1U2ToFChjbQoChuh6ZdTSZ69amtQ/lQnVzhA9o5lBcK
         nmIucDfKQGOywnMSCNOHeuZ5UbnmazNSQC/oEcia4JHBKjQ7T4Fs8+dAcSeb0L9/6Jzc
         pHv0aCgTPTrAhsYCeh51MyDoGQsVzyPPHXaFEGWYpbsZWlndcxvCp9FPR0LQP6Oo+57p
         FGPw==
X-Gm-Message-State: AOUpUlF2Q0IUO1niNwMq1Oc5hy4BnWdG8K/ENR3X5lCownKCEgKyJPOm
        v8U0Atr88Sp2fiFo5uVx0gg=
X-Google-Smtp-Source: AA+uWPzlYrIENVQCwdqIRgvcGTVVpclgdHy+zWZgptraQpaJELXWfh6RHdY1n0/qtMU7IdNDYk8RqQ==
X-Received: by 2002:a63:1a61:: with SMTP id a33-v6mr10372803pgm.9.1534931682890;
        Wed, 22 Aug 2018 02:54:42 -0700 (PDT)
Received: from toy.corp.qihoo.net ([104.192.108.9])
        by smtp.gmail.com with ESMTPSA id z20-v6sm3126105pfd.99.2018.08.22.02.54.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 02:54:42 -0700 (PDT)
From:   Jun Yao <yaojun8558363@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v4 0/6] arm64/mm: Move swapper_pg_dir to rodata
Date:   Wed, 22 Aug 2018 17:54:26 +0800
Message-Id: <20180822095432.12125-1-yaojun8558363@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The set_init_mm_pgd() is reimplemented using assembly in order to
avoid being instrumented by kasan.

Test following configs with CONFIG_RANDOMIZE_BASE/UNMAP_KERNEL_AT_EL0/
CONFIG_ARM64_SW_TTBR0_PAN/CONFIG_KASAN_OUTLINE enabled on qemu:

	1. CONFIG_ARM64_4K_PAGES/CONFIG_ARM64_VA_BITS_48
	2. CONFIG_ARM64_4K_PAGES/CONFIG_ARM64_VA_BITS_39
	3. CONFIG_ARM64_64K_PAGES/CONFIG_ARM64_VA_BITS_48
	4. CONFIG_ARM64_64K_PAGES/CONFIG_ARM64_VA_BITS_42

Jun Yao (6):
  arm64/mm: Introduce the init_pg_dir.
  arm64/mm: Pass ttbr1 as a parameter to __enable_mmu().
  arm64/mm: Create the initial page table in the init_pg_dir.
  arm64/mm: Create the final page table directly in swapper_pg_dir.
  arm64/mm: Populate the swapper_pg_dir by fixmap.
  arm64/mm: Move {idmap_pg_dir .. swapper_pg_dir} to rodata section.

 arch/arm64/include/asm/assembler.h | 29 +++++++++++++
 arch/arm64/include/asm/pgtable.h   | 66 ++++++++++++++++++++++++++----
 arch/arm64/kernel/head.S           | 48 ++++++++++++++--------
 arch/arm64/kernel/sleep.S          |  1 +
 arch/arm64/kernel/vmlinux.lds.S    | 47 ++++++++++++++-------
 arch/arm64/mm/mmu.c                | 45 ++++++++------------
 6 files changed, 168 insertions(+), 68 deletions(-)

-- 
2.17.1

