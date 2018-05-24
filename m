Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965382AbeEXI1t (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:27:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:21923 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965350AbeEXI1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:27:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,436,1520924400";
   d="scan'208";a="43824544"
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        stable@vger.kernel.org
Subject: [GIT PULL 1/2] stm class: Use vmalloc for the master map
Date: Thu, 24 May 2018 11:27:26 +0300
Message-Id: <20180524082727.28990-2-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524082727.28990-1-alexander.shishkin@linux.intel.com>
References: <20180524082727.28990-1-alexander.shishkin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fengguang is running into a warning from the buddy allocator:

> swapper/0: page allocation failure: order:9, mode:0x14040c0(GFP_KERNEL|__GFP_COMP), nodemask=(null)
> CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.17.0-rc1 #262
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> Call Trace:
...
>  __kmalloc+0x14b/0x180: ____cache_alloc at mm/slab.c:3127
>  stm_register_device+0xf3/0x5c0: stm_register_device at drivers/hwtracing/stm/core.c:695
...

Which is basically a result of the stm class trying to allocate ~512kB
for the dummy_stm with its default parameters. There's no reason, however,
for it not to be vmalloc()ed instead, which is what this patch does.

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC: stable@vger.kernel.org # v4.4+
---
 drivers/hwtracing/stm/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 05386b76465e..657badb479a5 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -674,7 +674,7 @@ static void stm_device_release(struct device *dev)
 {
 	struct stm_device *stm = to_stm_device(dev);
 
-	kfree(stm);
+	vfree(stm);
 }
 
 int stm_register_device(struct device *parent, struct stm_data *stm_data,
@@ -691,7 +691,7 @@ int stm_register_device(struct device *parent, struct stm_data *stm_data,
 		return -EINVAL;
 
 	nmasters = stm_data->sw_end - stm_data->sw_start + 1;
-	stm = kzalloc(sizeof(*stm) + nmasters * sizeof(void *), GFP_KERNEL);
+	stm = vzalloc(sizeof(*stm) + nmasters * sizeof(void *));
 	if (!stm)
 		return -ENOMEM;
 
@@ -744,7 +744,7 @@ int stm_register_device(struct device *parent, struct stm_data *stm_data,
 	/* matches device_initialize() above */
 	put_device(&stm->dev);
 err_free:
-	kfree(stm);
+	vfree(stm);
 
 	return err;
 }
-- 
2.17.0
