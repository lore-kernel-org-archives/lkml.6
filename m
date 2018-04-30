Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754084AbeD3SAX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 14:00:23 -0400
Received: from g9t5008.houston.hpe.com ([15.241.48.72]:57168 "EHLO
        g9t5008.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752255AbeD3SAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 14:00:22 -0400
From: Toshi Kani <toshi.kani@hpe.com>
To: mhocko@suse.com, akpm@linux-foundation.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com
Cc: cpandya@codeaurora.org, linux-mm@kvack.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] fix free pmd/pte page handlings on x86
Date: Mon, 30 Apr 2018 11:59:22 -0600
Message-Id: <20180430175925.2657-1-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes x86 ioremap free page handlings when setting up
pud/pmd maps.

Patch 01 is from Chintan's v9 01/04 patch [1], which adds a new arg 'addr'.
This avoids merge conflicts with his series.

Patch 02 adds a TLB purge (INVLPG) to purge page-structure caches that
may be cached by speculation.  See patch 2/2 for the detals.

Patch 03 disables free page handling on x86-PAE to address BUG_ON reported
by Joerg.

[1] https://patchwork.kernel.org/patch/10371015/

---
Chintan Pandya (1):
  1/3 ioremap: Update pgtable free interfaces with addr

Toshi Kani (2):
  2/3 x86/mm: add TLB purge to free pmd/pte page interfaces
  3/3 x86/mm: disable ioremap free page handling on x86-PAE

---
 arch/arm64/mm/mmu.c           |  4 +--
 arch/x86/mm/pgtable.c         | 57 +++++++++++++++++++++++++++++++++++++------
 include/asm-generic/pgtable.h |  8 +++---
 lib/ioremap.c                 |  4 +--
 4 files changed, 57 insertions(+), 16 deletions(-)
