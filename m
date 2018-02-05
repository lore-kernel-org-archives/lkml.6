Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752521AbeBEB34 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:29:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:43385 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752370AbeBEB2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:28:02 -0500
From: Davidlohr Bueso <dbueso@suse.de>
To: akpm@linux-foundation.org, mingo@kernel.org
Cc: peterz@infradead.org, ldufour@linux.vnet.ibm.com, jack@suse.cz,
        mhocko@kernel.org, kirill.shutemov@linux.intel.com,
        mawilcox@microsoft.com, mgorman@techsingularity.net, dave@stgolabs.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 01/64] interval-tree: build unconditionally
Date: Mon,  5 Feb 2018 02:26:51 +0100
Message-Id: <20180205012754.23615-2-dbueso@wotan.suse.de>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180205012754.23615-1-dbueso@wotan.suse.de>
References: <20180205012754.23615-1-dbueso@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

In preparation for range locking, this patch gets rid of
CONFIG_INTERVAL_TREE option as we will unconditionally
build it.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/gpu/drm/Kconfig      |  2 --
 drivers/gpu/drm/i915/Kconfig |  1 -
 lib/Kconfig                  | 14 --------------
 lib/Kconfig.debug            |  1 -
 lib/Makefile                 |  3 +--
 5 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index deeefa7a1773..eac89dc17199 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -168,7 +168,6 @@ config DRM_RADEON
 	select HWMON
 	select BACKLIGHT_CLASS_DEVICE
 	select BACKLIGHT_LCD_SUPPORT
-	select INTERVAL_TREE
 	help
 	  Choose this option if you have an ATI Radeon graphics card.  There
 	  are both PCI and AGP versions.  You don't need to choose this to
@@ -189,7 +188,6 @@ config DRM_AMDGPU
 	select HWMON
 	select BACKLIGHT_CLASS_DEVICE
 	select BACKLIGHT_LCD_SUPPORT
-	select INTERVAL_TREE
 	select CHASH
 	help
 	  Choose this option if you have a recent AMD Radeon graphics card.
diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index dfd95889f4b7..520a613ec69f 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -3,7 +3,6 @@ config DRM_I915
 	depends on DRM
 	depends on X86 && PCI
 	select INTEL_GTT
-	select INTERVAL_TREE
 	# we need shmfs for the swappable backing store, and in particular
 	# the shmem_readpage() which depends upon tmpfs
 	select SHMEM
diff --git a/lib/Kconfig b/lib/Kconfig
index e96089499371..18b56ed167c4 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -362,20 +362,6 @@ config TEXTSEARCH_FSM
 config BTREE
 	bool
 
-config INTERVAL_TREE
-	bool
-	help
-	  Simple, embeddable, interval-tree. Can find the start of an
-	  overlapping range in log(n) time and then iterate over all
-	  overlapping nodes. The algorithm is implemented as an
-	  augmented rbtree.
-
-	  See:
-
-		Documentation/rbtree.txt
-
-	  for more information.
-
 config RADIX_TREE_MULTIORDER
 	bool
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 6088408ef26c..c888f03569e7 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1716,7 +1716,6 @@ config RBTREE_TEST
 config INTERVAL_TREE_TEST
 	tristate "Interval tree test"
 	depends on DEBUG_KERNEL
-	select INTERVAL_TREE
 	help
 	  A benchmark measuring the performance of the interval tree library
 
diff --git a/lib/Makefile b/lib/Makefile
index a90d4fcd748f..1c1f8e3ccaa8 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -39,7 +39,7 @@ obj-y += bcd.o div64.o sort.o parser.o debug_locks.o random32.o \
 	 gcd.o lcm.o list_sort.o uuid.o flex_array.o iov_iter.o clz_ctz.o \
 	 bsearch.o find_bit.o llist.o memweight.o kfifo.o \
 	 percpu-refcount.o percpu_ida.o rhashtable.o reciprocal_div.o \
-	 once.o refcount.o usercopy.o errseq.o bucket_locks.o
+	 once.o refcount.o usercopy.o errseq.o bucket_locks.o interval_tree.o
 obj-$(CONFIG_STRING_SELFTEST) += test_string.o
 obj-y += string_helpers.o
 obj-$(CONFIG_TEST_STRING_HELPERS) += test-string_helpers.o
@@ -84,7 +84,6 @@ obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o
 obj-$(CONFIG_GENERIC_HWEIGHT) += hweight.o
 
 obj-$(CONFIG_BTREE) += btree.o
-obj-$(CONFIG_INTERVAL_TREE) += interval_tree.o
 obj-$(CONFIG_ASSOCIATIVE_ARRAY) += assoc_array.o
 obj-$(CONFIG_DEBUG_PREEMPT) += smp_processor_id.o
 obj-$(CONFIG_DEBUG_LIST) += list_debug.o
-- 
2.13.6
