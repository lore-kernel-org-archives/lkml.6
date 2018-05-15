Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeEOVkp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 17:40:45 -0400
Received: from g2t2353.austin.hpe.com ([15.233.44.26]:37910 "EHLO
        g2t2353.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbeEOVko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 17:40:44 -0400
From: Toshi Kani <toshi.kani@hpe.com>
To: mhocko@suse.com, akpm@linux-foundation.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com
Cc: cpandya@codeaurora.org, linux-mm@kvack.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] fix free pmd/pte page handlings on x86
Date: Tue, 15 May 2018 15:39:28 -0600
Message-Id: <20180515213931.23885-1-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes two issues in the x86 ioremap free page handlings
for pud/pmd mappings.

Patch 01 fixes BUG_ON on x86-PAE reported by Joerg.  It disables
the free page handling on x86-PAE.

Patch 02-03 fixes a possible issue with speculation which can cause
stale page-directory cache.
 - Patch 02 is from Chintan's v9 01/04 patch [1], which adds a new arg
   'addr'.  This avoids merge conflicts with his series.
 - Patch 03 adds a TLB purge (INVLPG) to purge page-structure caches
   that may be cached by speculation.  See the patch descriptions for
   more detal.

[1] https://patchwork.kernel.org/patch/10371015/

v2:
 - Reordered patch-set, so that patch 01 can be applied independently.
 - Added a NULL pointer check for the page alloc in patch 03. 

---
Toshi Kani (2):
  1/3 x86/mm: disable ioremap free page handling on x86-PAE
  3/3 x86/mm: add TLB purge to free pmd/pte page interfaces

Chintan Pandya (1):
  2/3 ioremap: Update pgtable free interfaces with addr

---
 arch/arm64/mm/mmu.c           |  4 +--
 arch/x86/mm/pgtable.c         | 59 +++++++++++++++++++++++++++++++++++++------
 include/asm-generic/pgtable.h |  8 +++---
 lib/ioremap.c                 |  4 +--
 4 files changed, 59 insertions(+), 16 deletions(-)
