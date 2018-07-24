Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8378C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FD020856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 12:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52FD020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388381AbeGXNRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 09:17:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:7043 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388256AbeGXNRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 09:17:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2018 05:11:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,397,1526367600"; 
   d="scan'208";a="218637833"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 24 Jul 2018 05:11:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id C4941161; Tue, 24 Jul 2018 15:11:47 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv3 0/3] Fix crash due to vma_is_anonymous() false-positives
Date:   Tue, 24 Jul 2018 15:11:36 +0300
Message-Id: <20180724121139.62570-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix crash found by syzkaller.

Build on top of Linus' changes in 4.18-rc6.

Andrew, could you please drop mm-drop-unneeded-vm_ops-checks-v2.patch for
now. Infiniband drivers have to be fixed first.

Kirill A. Shutemov (3):
  mm: Introduce vma_init()
  mm: Use vma_init() to initialize VMAs on stack and data segments
  mm: Fix vma_is_anonymous() false-positives

 arch/arm/kernel/process.c    |  1 +
 arch/arm/mach-rpc/ecard.c    |  2 +-
 arch/arm64/include/asm/tlb.h |  4 +++-
 arch/arm64/mm/hugetlbpage.c  |  7 +++++--
 arch/ia64/include/asm/tlb.h  |  2 +-
 arch/ia64/mm/init.c          |  2 +-
 arch/x86/um/mem_32.c         |  2 +-
 drivers/char/mem.c           |  1 +
 fs/exec.c                    |  1 +
 fs/hugetlbfs/inode.c         |  2 ++
 include/linux/mm.h           | 14 ++++++++++++++
 kernel/fork.c                |  6 ++----
 mm/mempolicy.c               |  1 +
 mm/mmap.c                    |  3 +++
 mm/nommu.c                   |  2 ++
 mm/shmem.c                   |  1 +
 16 files changed, 40 insertions(+), 11 deletions(-)

-- 
2.18.0

