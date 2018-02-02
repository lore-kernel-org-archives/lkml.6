Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752520AbeBBPDl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:03:41 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:58834 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbeBBPDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:03:35 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block: skd: fix incorrect linux/slab_def.h inclusion
Date: Fri,  2 Feb 2018 16:03:04 +0100
Message-Id: <20180202150326.344024-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:CBmzEcnJgOJzt/3VcgSac2xikg7/MLuWnpaaMjBlMjMUZqJM71L
 CiQkV6QMLH2AGtvyf2jT23vnZSSpU4dOYE39/T7fMz8A2jdEH8/NjYGA7ITMxYb0RhJogdX
 88+nOKYEVe+MxDVVH2dJ+ARZx6rY0mItZ/1PK/lQg+Ws/WRI4AHusidb3RgO+4a/HHBYGhN
 ORruZGhHqYQqFi4M+xLGw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TMlIM3hUjFM=:57Te1JM7+G4Gq72boFGRuF
 uKj26yAVZBSdBekkZAJW5VWwZFevJ4lWHGo5um6WiXvNrs6LAEkf6fCHCrXnh6tgRN4kjzOli
 NtQkg7k4UAZzLgGI6ks/JVxUB+LNj4926cfCPAGna+O3ha1NJHSjJkVqjxSWfR7J8SsxwAr1O
 Hucs/GsZ8WoIp58Z9whcNteFHUdPH1PlufkwiP+2kY4PrNutPKkvofcDIGqdG0hONNpOEMpte
 7G4IK26q8bFR542eAQFlrocwPn9eg9KWHiYw3NFCpIAhHOMHTi3pzxeY5IeCaKfceDxbcC94b
 9YDj+pFf2vgNqWHg2mRcseYcuiarPlcirHCNAWd0FcCvxk6maiDHBgQNVzyzUQuM2nFfUvdpD
 iVrMxAy352dqGD/QP/DflztcjOK+aEcAL+j4sq+Ty9KriV4ioXS+BQ2lu39lkg4ANaNDU6H1k
 kZ9QW0ig32eKmvttm7zRuxRZOmkNe2sDku/OsyBSEoRIDO8RobCZQqKcVpg0JwqdE2zDWx843
 zPywvMV3U2fQ8/y8IScR3BWvaof6C4/xpfT/m6scu0R5HCjZUlcYiq5QwRWks/ceeaKsGJw5h
 ChZpTrT83liBGQ89pTUiCMHyD1X7RR5+HIK8gDgUyk3gFWgetfbsD6/VejzJLrS6DmoTQONv1
 /uDMiuqhlTBpO8oxQLlwd9wTp/THjFiIV2exD22fPtnAuIrhZSOJZcBhowwN9OkyZVGnCDKlN
 4AwXQPlVKIy07MTpodgtQpC3oTa329jDkfzw4w==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

skd includes slab_def.h to get access to the slab cache object size.
However, including this header breaks when we use SLUB or SLOB instead of
the SLAB allocator, since the structure layout is completely different,
as shown by this warning when we build this driver in one of the invalid
configurations with link-time optimizations enabled:

include/linux/slab.h:715:0: error: type of 'kmem_cache_size' does not match original declaration [-Werror=lto-type-mismatch]
 unsigned int kmem_cache_size(struct kmem_cache *s);

mm/slab_common.c:77:14: note: 'kmem_cache_size' was previously declared here
 unsigned int kmem_cache_size(struct kmem_cache *s)
              ^
mm/slab_common.c:77:14: note: code may be misoptimized unless -fno-strict-aliasing is used
include/linux/slab.h:147:0: error: type of 'kmem_cache_destroy' does not match original declaration [-Werror=lto-type-mismatch]
 void kmem_cache_destroy(struct kmem_cache *);

mm/slab_common.c:858:6: note: 'kmem_cache_destroy' was previously declared here
 void kmem_cache_destroy(struct kmem_cache *s)
      ^
mm/slab_common.c:858:6: note: code may be misoptimized unless -fno-strict-aliasing is used
include/linux/slab.h:140:0: error: type of 'kmem_cache_create' does not match original declaration [-Werror=lto-type-mismatch]
 struct kmem_cache *kmem_cache_create(const char *name, size_t size,

mm/slab_common.c:534:1: note: 'kmem_cache_create' was previously declared here
 kmem_cache_create(const char *name, size_t size, size_t align,
 ^

This removes the header inclusion and instead uses the kmem_cache_size()
interface to get the size in a reliable way.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/skd_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index de0d08133c7e..e41935ab41ef 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -32,7 +32,6 @@
 #include <linux/aer.h>
 #include <linux/wait.h>
 #include <linux/stringify.h>
-#include <linux/slab_def.h>
 #include <scsi/scsi.h>
 #include <scsi/sg.h>
 #include <linux/io.h>
@@ -2603,7 +2602,8 @@ static void *skd_alloc_dma(struct skd_device *skdev, struct kmem_cache *s,
 	buf = kmem_cache_alloc(s, gfp);
 	if (!buf)
 		return NULL;
-	*dma_handle = dma_map_single(dev, buf, s->size, dir);
+	*dma_handle = dma_map_single(dev, buf,
+				     kmem_cache_size(s), dir);
 	if (dma_mapping_error(dev, *dma_handle)) {
 		kmem_cache_free(s, buf);
 		buf = NULL;
@@ -2618,7 +2618,8 @@ static void skd_free_dma(struct skd_device *skdev, struct kmem_cache *s,
 	if (!vaddr)
 		return;
 
-	dma_unmap_single(&skdev->pdev->dev, dma_handle, s->size, dir);
+	dma_unmap_single(&skdev->pdev->dev, dma_handle,
+			 kmem_cache_size(s), dir);
 	kmem_cache_free(s, vaddr);
 }
 
-- 
2.9.0
