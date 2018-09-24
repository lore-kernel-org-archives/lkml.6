Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65571C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7A920883
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7A920883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbeIXV6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:58:11 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:14711 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731043AbeIXV6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:58:09 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 42Jpgp0l7Wz9ttS5;
        Mon, 24 Sep 2018 17:55:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id C6pD0fhvaDNm; Mon, 24 Sep 2018 17:55:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 42Jpgp07czz9ttRt;
        Mon, 24 Sep 2018 17:55:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EC38E8B7B7;
        Mon, 24 Sep 2018 17:55:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 1zuCRUvfC32J; Mon, 24 Sep 2018 17:55:16 +0200 (CEST)
Received: from PO15451.localdomain (po15451.idsi0.si.c-s.fr [172.25.231.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A45538B7B8;
        Mon, 24 Sep 2018 17:55:15 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A1CEF70AD3; Mon, 24 Sep 2018 15:52:19 +0000 (UTC)
Message-Id: <cover.1537802981.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 0/9] powerpc: Switch to CONFIG_THREAD_INFO_IN_TASK
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 24 Sep 2018 15:52:19 +0000 (UTC)
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

Christophe Leroy (9):
  timer: fix circular header dependency
  book3s/64: avoid circular header inclusion in mmu-hash.h
  powerpc: change name THREAD_INFO to TASK_STACK
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
 arch/powerpc/include/asm/irq.h                 | 14 +++---
 arch/powerpc/include/asm/livepatch.h           |  2 +-
 arch/powerpc/include/asm/processor.h           | 39 ++-------------
 arch/powerpc/include/asm/ptrace.h              |  2 +-
 arch/powerpc/include/asm/reg.h                 |  2 +-
 arch/powerpc/include/asm/smp.h                 |  3 +-
 arch/powerpc/include/asm/task_size.h           | 42 ++++++++++++++++
 arch/powerpc/include/asm/thread_info.h         | 17 +------
 arch/powerpc/kernel/asm-offsets.c              |  8 ++--
 arch/powerpc/kernel/entry_32.S                 | 66 +++++++++-----------------
 arch/powerpc/kernel/entry_64.S                 | 12 ++---
 arch/powerpc/kernel/epapr_hcalls.S             |  5 +-
 arch/powerpc/kernel/exceptions-64e.S           | 13 +----
 arch/powerpc/kernel/exceptions-64s.S           |  2 +-
 arch/powerpc/kernel/head_32.S                  | 14 +++---
 arch/powerpc/kernel/head_40x.S                 |  4 +-
 arch/powerpc/kernel/head_44x.S                 |  8 ++--
 arch/powerpc/kernel/head_64.S                  |  1 +
 arch/powerpc/kernel/head_8xx.S                 |  2 +-
 arch/powerpc/kernel/head_booke.h               | 12 ++---
 arch/powerpc/kernel/head_fsl_booke.S           | 16 +++----
 arch/powerpc/kernel/idle_6xx.S                 |  8 ++--
 arch/powerpc/kernel/idle_book3e.S              |  2 +-
 arch/powerpc/kernel/idle_e500.S                |  8 ++--
 arch/powerpc/kernel/idle_power4.S              |  2 +-
 arch/powerpc/kernel/irq.c                      | 66 ++++----------------------
 arch/powerpc/kernel/kgdb.c                     | 28 -----------
 arch/powerpc/kernel/machine_kexec_64.c         |  6 +--
 arch/powerpc/kernel/misc_32.S                  | 17 +++----
 arch/powerpc/kernel/process.c                  | 15 +++---
 arch/powerpc/kernel/setup-common.c             |  2 +-
 arch/powerpc/kernel/setup_32.c                 | 15 ++----
 arch/powerpc/kernel/setup_64.c                 | 29 ++---------
 arch/powerpc/kernel/smp.c                      | 16 +++----
 arch/powerpc/kernel/trace/ftrace_64_mprofile.S |  6 +--
 arch/powerpc/kvm/book3s_hv_hmi.c               |  1 +
 arch/powerpc/mm/hash_low_32.S                  | 14 ++----
 arch/powerpc/sysdev/6xx-suspend.S              |  5 +-
 arch/powerpc/xmon/xmon.c                       |  2 +-
 fs/timerfd.c                                   |  2 +-
 kernel/time/alarmtimer.c                       |  2 +-
 45 files changed, 194 insertions(+), 347 deletions(-)
 create mode 100644 arch/powerpc/include/asm/task_size.h

-- 
2.13.3

