Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752302AbeCPTOS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 15:14:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35140 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750877AbeCPTOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 15:14:17 -0400
From: jglisse@redhat.com
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Evgeny Baskakov <ebaskakov@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/4] hmm: fixes and documentations v2
Date: Fri, 16 Mar 2018 15:14:05 -0400
Message-Id: <20180316191414.3223-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

Removed pointless VM_BUG_ON() cced stable when appropriate and splitted
the last patch into _many_ smaller patches to make it easier to review.
The end result is same modulo comments i received so far and the extra
documentation i added while splitting thing up. Below is previous cover
letter (everything in it is still true):

----------------------------------------------------------------------

All patches only impact HMM user, there is no implication outside HMM.

First patch improve documentation to better reflect what HMM is. Second
patch fix #if/#else placement in hmm.h. The third patch add a call on
mm release which helps device driver who use HMM to clean up early when
a process quit. Finaly last patch modify the CPU snapshot and page fault
helper to simplify device driver. The nouveau patchset i posted last
week already depends on all of those patches.

You can find them in a hmm-for-4.17 branch:

git://people.freedesktop.org/~glisse/linux
https://cgit.freedesktop.org/~glisse/linux/log/?h=hmm-for-4.17

Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
Cc: Mark Hairgrove <mhairgrove@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>

Jérôme Glisse (12):
  mm/hmm: fix header file if/else/endif maze
  mm/hmm: hmm_pfns_bad() was accessing wrong struct
  mm/hmm: use struct for hmm_vma_fault(), hmm_vma_get_pfns() parameters
  mm/hmm: remove HMM_PFN_READ flag and ignore peculiar architecture
  mm/hmm: use uint64_t for HMM pfn instead of defining hmm_pfn_t to
    ulong
  mm/hmm: cleanup special vma handling (VM_SPECIAL)
  mm/hmm: do not differentiate between empty entry or missing directory
  mm/hmm: rename HMM_PFN_DEVICE_UNADDRESSABLE to HMM_PFN_DEVICE_PRIVATE
  mm/hmm: move hmm_pfns_clear() closer to where it is use
  mm/hmm: factor out pte and pmd handling to simplify hmm_vma_walk_pmd()
  mm/hmm: change hmm_vma_fault() to allow write fault on page basis
  mm/hmm: use device driver encoding for HMM pfn

Ralph Campbell (2):
  mm/hmm: documentation editorial update to HMM documentation
  mm/hmm: HMM should have a callback before MM is destroyed v2

 Documentation/vm/hmm.txt | 360 +++++++++++++++++-----------------
 MAINTAINERS              |   1 +
 include/linux/hmm.h      | 156 ++++++++-------
 mm/hmm.c                 | 495 +++++++++++++++++++++++++++++------------------
 4 files changed, 582 insertions(+), 430 deletions(-)

-- 
2.14.3
