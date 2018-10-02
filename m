Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632B6C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E35B205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E35B205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeJBS6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:58:43 -0400
Received: from foss.arm.com ([217.140.101.70]:35902 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbeJBS6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:58:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D9FE7A9;
        Tue,  2 Oct 2018 05:15:41 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BF5823F5B7;
        Tue,  2 Oct 2018 05:15:37 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     suzuki.poulose@arm.com, punit.agrawal@arm.com, will.deacon@arm.com,
        Steven.Price@arm.com, catalin.marinas@arm.com, mhocko@kernel.org,
        mike.kravetz@oracle.com, n-horiguchi@ah.jp.nec.com
Subject: [PATCH 0/4] arm64/mm: Enable HugeTLB migration
Date:   Tue,  2 Oct 2018 17:45:27 +0530
Message-Id: <1538482531-26883-1-git-send-email-anshuman.khandual@arm.com>
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

Anshuman Khandual (4):
  mm/hugetlb: Enable PUD level huge page migration
  mm/hugetlb: Enable arch specific huge page size support for migration
  arm64/mm: Enable HugeTLB migration
  arm64/mm: Enable HugeTLB migration for contiguous bit HugeTLB pages

 arch/arm64/Kconfig               |  4 ++++
 arch/arm64/include/asm/hugetlb.h |  5 +++++
 arch/arm64/mm/hugetlbpage.c      | 20 ++++++++++++++++++++
 include/linux/hugetlb.h          | 18 +++++++++++++++---
 4 files changed, 44 insertions(+), 3 deletions(-)

-- 
2.7.4

