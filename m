Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E54CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64CD22145D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 06:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CD22145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeKUQy1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 11:54:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeKUQy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 11:54:27 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 467DF356D3;
        Wed, 21 Nov 2018 06:21:19 +0000 (UTC)
Received: from xz-x1.nay.redhat.com (dhcp-14-128.nay.redhat.com [10.66.14.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7980D600C5;
        Wed, 21 Nov 2018 06:21:05 +0000 (UTC)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Keith Busch <keith.busch@intel.com>,
        Jerome Glisse <jglisse@redhat.com>, peterx@redhat.com,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH RFC v3 0/4] mm: some enhancements to the page fault mechanism
Date:   Wed, 21 Nov 2018 14:20:59 +0800
Message-Id: <20181121062103.18835-1-peterx@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Wed, 21 Nov 2018 06:21:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
- fix up issues that krobot reported, rebase

This is an RFC series as cleanup and enhancements to current page
fault logic.  The whole idea comes from the discussion between Andrea
and Linus on the bug reported by syzbot here:

  https://lkml.org/lkml/2017/11/2/833

Basically it does two things:

  (a) Allows the page fault logic to be more interactive on not only
      SIGKILL, but also the rest of userspace signals, and,

  (b) Allows the page fault retry (VM_FAULT_RETRY) to happen for more
      than once.

For (a): with the changes we should be able to react faster when page
faults are working in parallel with userspace signals like SIGSTOP and
SIGCONT (and more), and with that we can remove the buggy part in
userfaultfd and benefit the whole page fault mechanism on faster
signal processing to reach the userspace.

For (b), we should be able to allow the page fault handler to loop for
even more than twice.  Some context: for now since we have
FAULT_FLAG_ALLOW_RETRY we can allow to retry the page fault once with
the same interrupt context, however never more than twice.  This can
be not only a potential cleanup to remove this assumption since AFAIU
the code itself doesn't really have this twice-only limitation (though
that should be a protective approach in the past), at the same time
it'll greatly simplify future works like userfaultfd write-protect
where it's possible to retry for more than twice (please have a look
at [1] below for a possible user that might require the page fault to
be handled for a third time; if we can remove the retry limitation we
can simply drop that patch and those complexity).

Some more details on each of the patch (even more in commit messages):

Patch 1: A cleanup of existing GUP code to rename the confusing
         "nonblocking" parameter to "locked" which seems suite more.

Patch 2: Complete the page fault faster for non-sigkill signals

Patch 3: Remove the limitation to only allow to retry page fault for
         twice (page fault part)

Patch 4: Similar work of patch 3, but for GUP.

The series is only lightly tested.  Before running more tests, I'd be
really glad to see whether there's any feedback first.

Looking forward to your comments.  Thanks,

[1] https://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git/commit/?h=userfault&id=b245ecf6cf59156966f3da6e6b674f6695a5ffa5

Peter Xu (4):
  mm: gup: rename "nonblocking" to "locked" where proper
  mm: userfault: return VM_FAULT_RETRY on signals
  mm: allow VM_FAULT_RETRY for multiple times
  mm: gup: allow VM_FAULT_RETRY for multiple times

 arch/alpha/mm/fault.c      |  4 +--
 arch/arc/mm/fault.c        | 12 ++++----
 arch/arm/mm/fault.c        | 17 ++++++-----
 arch/arm64/mm/fault.c      | 11 ++-----
 arch/hexagon/mm/vm_fault.c |  3 +-
 arch/ia64/mm/fault.c       |  3 +-
 arch/m68k/mm/fault.c       |  5 +---
 arch/microblaze/mm/fault.c |  3 +-
 arch/mips/mm/fault.c       |  3 +-
 arch/nds32/mm/fault.c      |  7 ++---
 arch/nios2/mm/fault.c      |  5 +---
 arch/openrisc/mm/fault.c   |  3 +-
 arch/parisc/mm/fault.c     |  4 +--
 arch/powerpc/mm/fault.c    |  9 ++----
 arch/riscv/mm/fault.c      |  9 ++----
 arch/s390/mm/fault.c       | 14 ++++-----
 arch/sh/mm/fault.c         |  5 +++-
 arch/sparc/mm/fault_32.c   |  4 ++-
 arch/sparc/mm/fault_64.c   |  4 ++-
 arch/um/kernel/trap.c      |  6 ++--
 arch/unicore32/mm/fault.c  | 10 ++-----
 arch/x86/mm/fault.c        | 13 ++++++--
 arch/xtensa/mm/fault.c     |  4 ++-
 fs/userfaultfd.c           | 24 ---------------
 mm/gup.c                   | 61 +++++++++++++++++++++-----------------
 mm/hugetlb.c               |  8 ++---
 26 files changed, 114 insertions(+), 137 deletions(-)

-- 
2.17.1

