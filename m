Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753979AbeCGMr2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 07:47:28 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34208 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751067AbeCGMr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 07:47:27 -0500
X-Google-Smtp-Source: AG47ELtY7T3SwJ9SwtNCqALvgLVDRyqqHJtpHDeX3jbmSej3yDlzT/DLnih2ihZDokq66OSCTtQCiw==
From: Tvrtko Ursulin <tursulin@ursulin.net>
X-Google-Original-From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 0/6] lib/scatterlist: Small SGL tidy
Date: Wed,  7 Mar 2018 12:47:06 +0000
Message-Id: <20180307124712.14963-1-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

I spotted a few small issues in the recent added SGL code so am sending some
patches to tidy this.

My motivation was looking at sgl_alloc_order to potentially use from the i915
driver, with a small addition to support fall-back to smaller order allocation
if so was requested.

But then I realized scatterlist table allocated with sgl_alloc_order is not
compatible with being put into the sg_table container due different allocator
being used.

If it had used the standard chained scatterlist allocation, it would benefit
from less memory pressure for small-order large length allocations (in other
words large nent - as it stands it can request really large kmalloc allocations
for those cases), but to convert it to use that looks to would require some
refactoring of the SGL API users. So I wasn't sure how feasible would that be.

There were some other unclear bits to me in the SGL API, like why so much API
some of which is unused, so I tried to trim that as well.

So don't know - comments are welcome.

Tvrtko Ursulin (6):
  lib/scatterlist: Tidy types and fix overflow checking in
    sgl_alloc_order
  lib/scatterlist: Skip requesting zeroed allocations in sgl_alloc_order
  lib/scatterlist: Do not leak pages when high-order allocation fails
  lib/scatterlist: Unexport some trivial wrappers
  lib/scatterlist: Drop unused sgl_free_order
  lib/scatterlist: Drop order argument from sgl_free_n_order

 drivers/target/target_core_transport.c |  2 +-
 include/linux/scatterlist.h            | 36 +++++++++++---
 lib/scatterlist.c                      | 91 +++++++++++-----------------------
 3 files changed, 57 insertions(+), 72 deletions(-)

---
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>

-- 
2.14.1
