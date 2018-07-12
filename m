Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D415BC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ADFA213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ADFA213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732588AbeGLPGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:06:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:52770 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732507AbeGLPGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:06:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jul 2018 07:56:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,343,1526367600"; 
   d="scan'208";a="57147299"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 12 Jul 2018 07:56:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id A3A8D18D; Thu, 12 Jul 2018 17:56:27 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 0/2] Fix crash due to vma_is_anonymous() false-positives
Date:   Thu, 12 Jul 2018 17:56:24 +0300
Message-Id: <20180712145626.41665-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fix crash found by syzkaller.

The fix allows to remove ->vm_ops checks.

v2:
 - Catch few more cases where we need to initialize ->vm_ops:
   + nommu;
   + ia64;
 - Make sure that we initialize ->vm_ops even if ->mmap failed.
   We need ->vm_ops in error path too.

Kirill A. Shutemov (2):
  mm: Fix vma_is_anonymous() false-positives
  mm: Drop unneeded ->vm_ops checks

 arch/ia64/kernel/perfmon.c |  1 +
 arch/ia64/mm/init.c        |  2 ++
 drivers/char/mem.c         |  1 +
 fs/binfmt_elf.c            |  2 +-
 fs/exec.c                  |  1 +
 fs/hugetlbfs/inode.c       |  1 +
 fs/kernfs/file.c           | 20 +-------------------
 fs/proc/task_mmu.c         |  2 +-
 include/linux/mm.h         |  5 ++++-
 kernel/events/core.c       |  2 +-
 kernel/fork.c              |  2 +-
 mm/gup.c                   |  2 +-
 mm/hugetlb.c               |  2 +-
 mm/khugepaged.c            |  4 ++--
 mm/memory.c                | 12 ++++++------
 mm/mempolicy.c             | 10 +++++-----
 mm/mmap.c                  | 25 ++++++++++++++++++-------
 mm/mremap.c                |  2 +-
 mm/nommu.c                 | 13 ++++++++++---
 mm/shmem.c                 |  1 +
 mm/util.c                  | 12 ++++++++++++
 21 files changed, 72 insertions(+), 50 deletions(-)

-- 
2.18.0

