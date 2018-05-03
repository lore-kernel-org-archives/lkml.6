Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751860AbeECTZ7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 15:25:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:8166 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751185AbeECTYg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 15:24:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,359,1520924400";
   d="scan'208";a="225573193"
From: Ross Zwisler <ross.zwisler@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        linux-nvdimm@lists.01.org
Subject: [PATCH 2/5] radix tree test suite: fix compilation issue
Date: Thu,  3 May 2018 13:24:27 -0600
Message-Id: <20180503192430.7582-3-ross.zwisler@linux.intel.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180503192430.7582-1-ross.zwisler@linux.intel.com>
References: <20180503192430.7582-1-ross.zwisler@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pulled from a patch from Matthew Wilcox entitled
"xarray: Add definition of struct xarray":

> From: Matthew Wilcox <mawilcox@microsoft.com>
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

https://patchwork.kernel.org/patch/10341249/

These defines fix this compilation error:

In file included from ./linux/radix-tree.h:6:0,
                 from ./linux/../../../../include/linux/idr.h:15,
                 from ./linux/idr.h:1,
                 from idr.c:4:
./linux/../../../../include/linux/idr.h: In function ‘idr_init_base’:
./linux/../../../../include/linux/radix-tree.h:129:2: warning: implicit declaration of function ‘spin_lock_init’; did you mean ‘spinlock_t’? [-Wimplicit-function-declaration]
  spin_lock_init(&(root)->xa_lock);    \
  ^
./linux/../../../../include/linux/idr.h:126:2: note: in expansion of macro ‘INIT_RADIX_TREE’
  INIT_RADIX_TREE(&idr->idr_rt, IDR_RT_MARKER);
  ^~~~~~~~~~~~~~~

by providing a spin_lock_init() wrapper for the v4.17-rc* version of the
radix tree test suite.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
---
 tools/include/linux/spinlock.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/include/linux/spinlock.h b/tools/include/linux/spinlock.h
index b21b586b9854..1738c0391da4 100644
--- a/tools/include/linux/spinlock.h
+++ b/tools/include/linux/spinlock.h
@@ -6,8 +6,9 @@
 #include <stdbool.h>
 
 #define spinlock_t		pthread_mutex_t
-#define DEFINE_SPINLOCK(x)	pthread_mutex_t x = PTHREAD_MUTEX_INITIALIZER;
+#define DEFINE_SPINLOCK(x)	pthread_mutex_t x = PTHREAD_MUTEX_INITIALIZER
 #define __SPIN_LOCK_UNLOCKED(x)	(pthread_mutex_t)PTHREAD_MUTEX_INITIALIZER
+#define spin_lock_init(x)      pthread_mutex_init(x, NULL)
 
 #define spin_lock_irqsave(x, f)		(void)f, pthread_mutex_lock(x)
 #define spin_unlock_irqrestore(x, f)	(void)f, pthread_mutex_unlock(x)
-- 
2.14.3
