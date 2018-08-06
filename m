Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77A5C46472
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABDA21A35
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ABDA21A35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733230AbeHFUHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 16:07:39 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:44385 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbeHFUHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 16:07:39 -0400
X-Originating-IP: 79.86.19.127
Received: from alex.numericable.fr (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 99611C0003;
        Mon,  6 Aug 2018 17:57:16 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     linux-mm@kvack.org, mike.kravetz@oracle.com, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will.deacon@arm.com, tony.luck@intel.com,
        fenghua.yu@intel.com, ralf@linux-mips.org, paul.burton@mips.com,
        jhogan@kernel.org, jejb@parisc-linux.org, deller@gmx.de,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        ysato@users.sourceforge.jp, dalias@libc.org, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v6 00/11] hugetlb: Factorize hugetlb architecture primitives 
Date:   Mon,  6 Aug 2018 17:57:00 +0000
Message-Id: <20180806175711.24438-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CC linux-mm for inclusion in -mm tree]                                          
                                                                                 
In order to reduce copy/paste of functions across architectures and then         
make riscv hugetlb port (and future ports) simpler and smaller, this             
patchset intends to factorize the numerous hugetlb primitives that are           
defined across all the architectures.                                            
                                                                                 
Except for prepare_hugepage_range, this patchset moves the versions that         
are just pass-through to standard pte primitives into                            
asm-generic/hugetlb.h by using the same #ifdef semantic that can be              
found in asm-generic/pgtable.h, i.e. __HAVE_ARCH_***.                            
                                                                                 
s390 architecture has not been tackled in this serie since it does not           
use asm-generic/hugetlb.h at all.                                                
                                                                                 
This patchset has been compiled on all addressed architectures with              
success (except for parisc, but the problem does not come from this              
series).                                                                         
                                                                                 
v6:                                                                              
  - Remove nohash/32 and book3s/32 powerpc specific implementations in
    order to use the generic ones.                                                        
  - Add all the Reviewed-by, Acked-by and Tested-by in the commits,              
    thanks to everyone.                                                          
                                                                                 
v5:                                                                              
  As suggested by Mike Kravetz, no need to move the #include                     
  <asm-generic/hugetlb.h> for arm and x86 architectures, let it live at          
  the top of the file.                                                           
                                                                                 
v4:                                                                              
  Fix powerpc build error due to misplacing of #include                          
  <asm-generic/hugetlb.h> outside of #ifdef CONFIG_HUGETLB_PAGE, as              
  pointed by Christophe Leroy.                                                   
                                                                                 
v1, v2, v3:                                                                      
  Same version, just problems with email provider and misuse of                  
  --batch-size option of git send-email

Alexandre Ghiti (11):
  hugetlb: Harmonize hugetlb.h arch specific defines with pgtable.h
  hugetlb: Introduce generic version of hugetlb_free_pgd_range
  hugetlb: Introduce generic version of set_huge_pte_at
  hugetlb: Introduce generic version of huge_ptep_get_and_clear
  hugetlb: Introduce generic version of huge_ptep_clear_flush
  hugetlb: Introduce generic version of huge_pte_none
  hugetlb: Introduce generic version of huge_pte_wrprotect
  hugetlb: Introduce generic version of prepare_hugepage_range
  hugetlb: Introduce generic version of huge_ptep_set_wrprotect
  hugetlb: Introduce generic version of huge_ptep_set_access_flags
  hugetlb: Introduce generic version of huge_ptep_get

 arch/arm/include/asm/hugetlb-3level.h        | 32 +---------
 arch/arm/include/asm/hugetlb.h               | 30 ----------
 arch/arm64/include/asm/hugetlb.h             | 39 +++---------
 arch/ia64/include/asm/hugetlb.h              | 47 ++-------------
 arch/mips/include/asm/hugetlb.h              | 40 +++----------
 arch/parisc/include/asm/hugetlb.h            | 33 +++--------
 arch/powerpc/include/asm/book3s/32/pgtable.h |  6 --
 arch/powerpc/include/asm/book3s/64/pgtable.h |  1 +
 arch/powerpc/include/asm/hugetlb.h           | 43 ++------------
 arch/powerpc/include/asm/nohash/32/pgtable.h |  6 --
 arch/powerpc/include/asm/nohash/64/pgtable.h |  1 +
 arch/sh/include/asm/hugetlb.h                | 54 ++---------------
 arch/sparc/include/asm/hugetlb.h             | 40 +++----------
 arch/x86/include/asm/hugetlb.h               | 69 ----------------------
 include/asm-generic/hugetlb.h                | 88 +++++++++++++++++++++++++++-
 15 files changed, 135 insertions(+), 394 deletions(-)

-- 
2.16.2

