Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D85C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB2B20676
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB2B20676
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbeIYSRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:17:52 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:28311 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbeIYSRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:17:52 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42KKf45Kdhz9ttS8;
        Tue, 25 Sep 2018 14:10:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id mU6sqjy9lsa9; Tue, 25 Sep 2018 14:10:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42KKf44MGtz9ttS2;
        Tue, 25 Sep 2018 14:10:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 40F3B8B7DC;
        Tue, 25 Sep 2018 14:10:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 3wbDTh8Oi9OG; Tue, 25 Sep 2018 14:10:36 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E37278B7DB;
        Tue, 25 Sep 2018 14:10:35 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 9E7D070AF2; Tue, 25 Sep 2018 12:10:35 +0000 (UTC)
Message-Id: <cover.1537877134.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v2 0/9] powerpc: Switch to CONFIG_THREAD_INFO_IN_TASK
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 25 Sep 2018 12:10:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this serie is to activate CONFIG_THREAD_INFO_IN_TASK which
moves the thread_info into task_struct.

Moving thread_info into task_struct has the following advantages:
- It protects thread_info from corruption in the case of stack
overflows.
- Its address is harder to determine if stack addresses are
leaked, making a number of attacks more difficult.

Changes since v1:
 - Removed the first patch which was modifying header inclusion order in timer
 - Modified some names in asm-offsets to avoid conflicts when including asm-offsets in C files
 - Modified asm/smp.h to avoid having to include linux/sched.h (using asm-offsets instead)
 - Moved some changes from the activation patch to the preparation patch.

Christophe Leroy (9):
  book3s/64: avoid circular header inclusion in mmu-hash.h
  powerpc: change name THREAD_INFO to TASK_STACK
  powerpc: clear redundancies in asm-offset.c
  powerpc: Prepare for moving thread_info into task_struct
  powerpc: Activate CONFIG_THREAD_INFO_IN_TASK
  powerpc: regain entire stack space
  powerpc: 'current_set' is now a table of task_struct pointers
  powerpc/32: Remove CURRENT_THREAD_INFO and rename TI_CPU
  powerpc/64: Modify CURRENT_THREAD_INFO()

 arch/powerpc/Kconfig                           |  1 +
 arch/powerpc/include/asm/asm-prototypes.h      |  4 +-
 arch/powerpc/include/asm/book3s/64/mmu-hash.h  |  2 +-
 arch/powerpc/include/asm/exception-64s.h       |  4 +-
 arch/powerpc/include/asm/irq.h                 | 14 ++--
 arch/powerpc/include/asm/livepatch.h           |  2 +-
 arch/powerpc/include/asm/mmu-44x.h             |  8 +--
 arch/powerpc/include/asm/processor.h           | 39 +-----------
 arch/powerpc/include/asm/ptrace.h              |  2 +-
 arch/powerpc/include/asm/reg.h                 |  2 +-
 arch/powerpc/include/asm/smp.h                 | 14 +++-
 arch/powerpc/include/asm/task_size.h           | 42 ++++++++++++
 arch/powerpc/include/asm/thread_info.h         | 17 +----
 arch/powerpc/kernel/asm-offsets.c              | 37 ++++++-----
 arch/powerpc/kernel/entry_32.S                 | 88 ++++++++++----------------
 arch/powerpc/kernel/entry_64.S                 | 12 ++--
 arch/powerpc/kernel/epapr_hcalls.S             |  5 +-
 arch/powerpc/kernel/exceptions-64e.S           | 13 +---
 arch/powerpc/kernel/exceptions-64s.S           |  2 +-
 arch/powerpc/kernel/head_32.S                  | 16 ++---
 arch/powerpc/kernel/head_40x.S                 |  6 +-
 arch/powerpc/kernel/head_44x.S                 | 10 +--
 arch/powerpc/kernel/head_64.S                  |  3 +-
 arch/powerpc/kernel/head_8xx.S                 |  4 +-
 arch/powerpc/kernel/head_booke.h               | 12 +---
 arch/powerpc/kernel/head_fsl_booke.S           | 18 +++---
 arch/powerpc/kernel/idle_6xx.S                 |  8 +--
 arch/powerpc/kernel/idle_book3e.S              |  2 +-
 arch/powerpc/kernel/idle_e500.S                |  8 +--
 arch/powerpc/kernel/idle_power4.S              |  2 +-
 arch/powerpc/kernel/irq.c                      | 66 +++----------------
 arch/powerpc/kernel/kgdb.c                     | 28 --------
 arch/powerpc/kernel/machine_kexec_64.c         |  6 +-
 arch/powerpc/kernel/misc_32.S                  | 17 ++---
 arch/powerpc/kernel/process.c                  | 15 ++---
 arch/powerpc/kernel/setup-common.c             |  2 +-
 arch/powerpc/kernel/setup_32.c                 | 15 ++---
 arch/powerpc/kernel/setup_64.c                 | 29 ++-------
 arch/powerpc/kernel/smp.c                      | 16 ++---
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S |  6 +-
 arch/powerpc/kernel/vdso32/gettimeofday.S      |  4 +-
 arch/powerpc/kvm/book3s_hv_hmi.c               |  1 +
 arch/powerpc/mm/hash_low_32.S                  | 14 ++--
 arch/powerpc/sysdev/6xx-suspend.S              |  5 +-
 arch/powerpc/xmon/xmon.c                       |  2 +-
 45 files changed, 243 insertions(+), 380 deletions(-)
 create mode 100644 arch/powerpc/include/asm/task_size.h

-- 
2.13.3

