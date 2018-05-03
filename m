Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbeECTYj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 15:24:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:8165 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751054AbeECTYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 15:24:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,359,1520924400";
   d="scan'208";a="225573182"
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        linux-nvdimm@lists.01.org
Subject: [PATCH 0/5] fix radix tree multi-order iteration race
Date: Thu,  3 May 2018 13:24:25 -0600
Message-Id: <20180503192430.7582-1-ross.zwisler@linux.intel.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series gets the radix tree test suite compiling again in
the current linux/master, adds a unit test which exposes a race in the
radix tree multi-order iteration code, and then fixes that race.

This race was initially hit on a v4.15 based kernel and results in a GP
fault.  I've described the race in detail in patches 4 and 5.

The fix is simple and necessary, and I think it should be merged for
v4.17.

This tree has gotten positive build confirmation from the 0-day bot,
passes the updated radix tree test suite, xfstests, and the original
test that was hitting the race with the v4.15 based kernel.

Ross Zwisler (5):
  radix tree test suite: fix mapshift build target
  radix tree test suite: fix compilation issue
  radix tree test suite: add item_delete_rcu()
  radix tree test suite: multi-order iteration race
  radix tree: fix multi-order iteration race

 lib/radix-tree.c                      |  6 ++--
 tools/include/linux/spinlock.h        |  3 +-
 tools/testing/radix-tree/Makefile     |  6 ++--
 tools/testing/radix-tree/multiorder.c | 63 +++++++++++++++++++++++++++++++++++
 tools/testing/radix-tree/test.c       | 19 +++++++++++
 tools/testing/radix-tree/test.h       |  3 ++
 6 files changed, 91 insertions(+), 9 deletions(-)

-- 
2.14.3
