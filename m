Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B4EC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796712088F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 10:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 796712088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbeILP3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 11:29:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56952 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbeILP3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 11:29:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6E0C7A9;
        Wed, 12 Sep 2018 03:26:01 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A7EAD3F614;
        Wed, 12 Sep 2018 03:26:01 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 7BA781AE3231; Wed, 12 Sep 2018 11:26:18 +0100 (BST)
From:   Will Deacon <will.deacon@arm.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     cpandya@codeaurora.org, toshi.kani@hpe.com, tglx@linutronix.de,
        mhocko@suse.com, akpm@linux-foundation.org,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH 0/5] Clean up huge vmap and ioremap code
Date:   Wed, 12 Sep 2018 11:26:09 +0100
Message-Id: <1536747974-25875-1-git-send-email-will.deacon@arm.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The recent introduction of break-before-make on the huge vmap path in
b6bdb7517c3d ("mm/vmalloc: add interfaces to free unmapped page table")
introduced a pair of arch functions for freeing a child level of page
table before putting down a huge mapping at the parent level.

Whilst this works well, the semantics of the pXd_free_pYd_table() function
are slightly confusing, and this led to an over-eager VM_WARN_ON in the
arm64 code that we fixed in -rc3 [1]. Linus suggested that the interface
could be tidied up so that the pXd_present() checks are moved into the
caller, so I've implemented that and generally cleaned up the ioremap code
so that it's easier to follow. I also extended the break-before-make code
to cover the huge p4d case, although this remains unused by any architectures.

Feedback welcome.

Cheers,

Will

[1] https://lkml.org/lkml/2018/9/7/898

--->8

Will Deacon (5):
  ioremap: Rework pXd_free_pYd_page() API
  arm64: mmu: Drop pXd_present() checks from pXd_free_pYd_table()
  x86: pgtable: Drop pXd_none() checks from pXd_free_pYd_table()
  lib/ioremap: Ensure phys_addr actually corresponds to a physical
    address
  lib/ioremap: Ensure break-before-make is used for huge p4d mappings

 arch/arm64/mm/mmu.c           |  13 +++---
 arch/x86/mm/pgtable.c         |  14 +++---
 include/asm-generic/pgtable.h |   5 ++
 lib/ioremap.c                 | 103 +++++++++++++++++++++++++++++-------------
 4 files changed, 91 insertions(+), 44 deletions(-)

-- 
2.1.4

