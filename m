Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0488AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A3A214C6
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeLRIYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:24:06 -0500
Received: from foss.arm.com ([217.140.101.70]:40540 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbeLRIYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:24:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9BC880D;
        Tue, 18 Dec 2018 00:24:04 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (p8cg001049571a15.blr.arm.com [10.162.41.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6525A3F575;
        Tue, 18 Dec 2018 00:24:01 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, will.deacon@arm.com, Steven.Price@arm.com,
        steve.capper@arm.com, catalin.marinas@arm.com, mhocko@kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        n-horiguchi@ah.jp.nec.com
Subject: [RESEND PATCH V3 0/5] arm64/mm: Enable HugeTLB migration
Date:   Tue, 18 Dec 2018 13:54:05 +0530
Message-Id: <1545121450-1663-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enables HugeTLB migration support for all supported
huge page sizes at all levels including contiguous bit implementation.
Following HugeTLB migration support matrix has been enabled with this
patch series. All permutations have been tested except for the 16GB.

         CONT PTE    PMD    CONT PMD    PUD
         --------    ---    --------    ---
4K:         64K     2M         32M     1G
16K:         2M    32M          1G
64K:         2M   512M         16G

First the series adds migration support for PUD based huge pages. It
then adds a platform specific hook to query an architecture if a
given huge page size is supported for migration while also providing
a default fallback option preserving the existing semantics which just
checks for (PMD|PUD|PGDIR)_SHIFT macros. The last two patches enables
HugeTLB migration on arm64 and subscribe to this new platform specific
hook by defining an override.

The second patch differentiates between movability and migratability
aspects of huge pages and implements hugepage_movable_supported() which
can then be used during allocation to decide whether to place the huge
page in movable zone or not.

This is just a resend for the previous version (V3) after the rebase
on current mainline kernel. Also added all the tags previous version
had received.

Changes in V3:

- Re-ordered patches 1 and 2 per Michal
- s/Movability/Migratability/ in unmap_and_move_huge_page() per Naoya

Changes in V2: (https://lkml.org/lkml/2018/10/12/190)

- Added a new patch which differentiates migratability and movability
  of huge pages and implements hugepage_movable_supported() function
  as suggested by Michal Hocko.

Anshuman Khandual (5):
  mm/hugetlb: Distinguish between migratability and movability
  mm/hugetlb: Enable PUD level huge page migration
  mm/hugetlb: Enable arch specific huge page size support for migration
  arm64/mm: Enable HugeTLB migration
  arm64/mm: Enable HugeTLB migration for contiguous bit HugeTLB pages

 arch/arm64/Kconfig               |  4 ++++
 arch/arm64/include/asm/hugetlb.h |  5 +++++
 arch/arm64/mm/hugetlbpage.c      | 20 +++++++++++++++++
 include/linux/hugetlb.h          | 48 +++++++++++++++++++++++++++++++++++++---
 mm/hugetlb.c                     |  2 +-
 mm/migrate.c                     |  2 +-
 6 files changed, 76 insertions(+), 5 deletions(-)

-- 
2.7.4

