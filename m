Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbeDEVDv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 17:03:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41288 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750726AbeDEVDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 17:03:50 -0400
Date: Fri, 6 Apr 2018 00:03:48 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: [PATCH v2 0/3] mm/get_user_pages_fast fixes, cleanups
Message-ID: <1522962072-182137-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out get_user_pages_fast and __get_user_pages_fast return different
values on error when given a single page: __get_user_pages_fast returns
0.  get_user_pages_fast returns either 0 or an error.

Callers of get_user_pages_fast expect an error so fix it up to return an
error consistently.

Stress the difference between get_user_pages_fast and __get_user_pages_fast
to make sure callers aren't confused.

Changes from v1:
	limit code changes to get_user_pages_fast.
	document __get_user_pages_fast
	fix a bug in caller

Michael S. Tsirkin (3):
  mm/gup_benchmark: handle gup failures
  gup: return -EFAULT on access_ok failure
  mm/gup: document return value

 arch/mips/mm/gup.c  | 2 ++
 arch/s390/mm/gup.c  | 2 ++
 arch/sh/mm/gup.c    | 2 ++
 arch/sparc/mm/gup.c | 4 ++++
 mm/gup.c            | 9 +++++++--
 mm/gup_benchmark.c  | 5 +++--
 mm/util.c           | 6 ++++--
 7 files changed, 24 insertions(+), 6 deletions(-)

-- 
MST
