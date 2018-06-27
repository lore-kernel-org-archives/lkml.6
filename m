Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D8EC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DA72614B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 14:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08DA72614B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965375AbeF0OPv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 10:15:51 -0400
Received: from g4t3425.houston.hpe.com ([15.241.140.78]:29437 "EHLO
        g4t3425.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934614AbeF0OPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 10:15:47 -0400
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 155018D;
        Wed, 27 Jun 2018 14:15:46 +0000 (UTC)
Received: from misato.americas.hpqcorp.net (unknown [10.34.81.122])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 2A0814A;
        Wed, 27 Jun 2018 14:15:45 +0000 (UTC)
From:   Toshi Kani <toshi.kani@hpe.com>
To:     mhocko@suse.com, akpm@linux-foundation.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com
Cc:     cpandya@codeaurora.org, linux-mm@kvack.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] fix free pmd/pte page handlings on x86
Date:   Wed, 27 Jun 2018 08:13:45 -0600
Message-Id: <20180627141348.21777-1-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes two issues in the x86 ioremap free page handlings
for pud/pmd mappings.

Patch 01 fixes BUG_ON on x86-PAE reported by Joerg.  It disables
the free page handling on x86-PAE.

Patch 02-03 fixes a possible issue with speculation which can cause
stale page-directory cache.
 - Patch 02 is from Chintan's v9 01/04 patch [1], which adds a new arg
   'addr', with my merge change to patch 01.
 - Patch 03 adds a TLB purge (INVLPG) to purge page-structure caches
   that may be cached by speculation.  See the patch descriptions for
   more detal.

The patches are based off from the tip tree.

[1] https://patchwork.kernel.org/patch/10371015/

v4:
 - Re-wrote patch 2/3 description. (v3-UPDATE)
 - Added NOTE to pud_free_pmd_page().

v3:
 - Fixed a build error in v2.

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
 arch/x86/mm/pgtable.c         | 61 +++++++++++++++++++++++++++++++++++++------
 include/asm-generic/pgtable.h |  8 +++---
 lib/ioremap.c                 |  4 +--
 4 files changed, 61 insertions(+), 16 deletions(-)
