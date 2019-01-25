Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3850EC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01798218DE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="OyfaNmHM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfAYMeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:34:02 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:7432 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbfAYMeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:34:01 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43mJNl2jNsz9tyxs;
        Fri, 25 Jan 2019 13:33:59 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=OyfaNmHM; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Zp3WXi0wPSwA; Fri, 25 Jan 2019 13:33:59 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43mJNl1fw9z9tyxr;
        Fri, 25 Jan 2019 13:33:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1548419639; bh=EEesvil3Sf8LrJX4h7oxINSRVTIM0hkNP7uU9WeNfzM=;
        h=From:Subject:To:Cc:Date:From;
        b=OyfaNmHM+KIm+EtA111ZF1r+JodHf33y6EtCCSArC0c+OhER4+oQS5dJXF0LcgqzT
         WkxKad2865oNlNGX8p02lVt7wBLfEXh4XRBRKdA/rN/FXSLPWTuGv1WPi955joNRYQ
         xy0tunJIKmdjNdFzuftHIe9umIP9PRTM5hRXoSW0=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7EE868B87A;
        Fri, 25 Jan 2019 13:34:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PzZ8LnlJoYmM; Fri, 25 Jan 2019 13:34:00 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 59D468B761;
        Fri, 25 Jan 2019 13:34:00 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 4A59272DA9; Fri, 25 Jan 2019 12:34:00 +0000 (UTC)
Message-Id: <cover.1548419273.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 00/10] Optimise TLB miss handlers on 603/e300
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        joakim.tjernlund@infinera.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 25 Jan 2019 12:34:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this serie is to optimise the handling of
TLB misses on the 603/e300.

Today the TLB miss handlers are implemented by more or less
copying the actions performed by the hash page handlers used
on processors having HASH pagetable.

This serie brings some simplification.

Christophe Leroy (10):
  powerpc: simplify BDI switch
  powerpc/603: Store PGDIR physical address in a SPRG
  powerpc/603: use physical address directly in TLB miss handlers.
  powerpc/hash32: use physical address directly in hash handlers.
  powerpc/603: Don't handle kernel page TLB misses when not need
  powerpc/603: Don't handle _PAGE_RW and _PAGE_DIRTY on ITLB misses
  powerpc/603: let's handle PAGE_DIRTY directly
  powerpc/603: Don't worry about _PAGE_USER in TLB miss handlers
  powerpc/603: don't handle PAGE_ACCESSED in TLB miss handlers.
  powerpc/book3s32: Reorder _PAGE_XXX flags to simplify TLB handling

 arch/powerpc/include/asm/book3s/32/hash.h |  8 +--
 arch/powerpc/include/asm/mmu.h            |  2 +
 arch/powerpc/include/asm/reg.h            |  1 +
 arch/powerpc/kernel/cpu_setup_6xx.S       |  4 ++
 arch/powerpc/kernel/head_32.S             | 97 ++++++++++++++-----------------
 arch/powerpc/kernel/head_40x.S            |  5 +-
 arch/powerpc/kernel/head_8xx.S            |  1 +
 arch/powerpc/mm/8xx_mmu.c                 |  7 +--
 arch/powerpc/mm/hash_low_32.S             | 68 +++++++++-------------
 arch/powerpc/mm/ppc_mmu_32.c              |  6 +-
 10 files changed, 93 insertions(+), 106 deletions(-)

-- 
2.13.3

