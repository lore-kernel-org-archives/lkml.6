Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3F7C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84C2220881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 13:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84C2220881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933356AbeGJNsW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 09:48:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:60828 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933258AbeGJNsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 09:48:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2018 06:48:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,334,1526367600"; 
   d="scan'208";a="53309362"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 10 Jul 2018 06:48:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 46EBC29B; Tue, 10 Jul 2018 16:48:22 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 0/2] Fix crash due to vma_is_anonymous() false-positives
Date:   Tue, 10 Jul 2018 16:48:19 +0300
Message-Id: <20180710134821.84709-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix crash found by syzkaller.

The fix allows to remove ->vm_ops checks.

Kirill A. Shutemov (2):
  mm: Fix vma_is_anonymous() false-positives
  mm: Drop unneeded ->vm_ops checks

 drivers/char/mem.c   |  1 +
 fs/binfmt_elf.c      |  2 +-
 fs/exec.c            |  1 +
 fs/hugetlbfs/inode.c |  1 +
 fs/kernfs/file.c     | 20 +-------------------
 fs/proc/task_mmu.c   |  2 +-
 include/linux/mm.h   |  5 ++++-
 kernel/events/core.c |  2 +-
 kernel/fork.c        |  2 +-
 mm/hugetlb.c         |  2 +-
 mm/khugepaged.c      |  4 ++--
 mm/memory.c          | 12 ++++++------
 mm/mempolicy.c       | 10 +++++-----
 mm/mmap.c            | 27 ++++++++++++++++++++-------
 mm/mremap.c          |  2 +-
 mm/nommu.c           |  4 ++--
 mm/shmem.c           |  1 +
 17 files changed, 50 insertions(+), 48 deletions(-)

-- 
2.18.0

