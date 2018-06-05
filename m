Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753843AbeFERHQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:07:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:36468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753409AbeFERHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:07:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fengguang Wu <fengguang.wu@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 4.9 52/61] stm class: Use vmalloc for the master map
Date: Tue,  5 Jun 2018 19:02:13 +0200
Message-Id: <20180605170121.004287720@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180605170117.643936916@linuxfoundation.org>
References: <20180605170117.643936916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit b5e2ced9bf81393034072dd4d372f6b430bc1f0a upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/stm/core.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -682,7 +682,7 @@ static void stm_device_release(struct de
 {
 	struct stm_device *stm = to_stm_device(dev);
 
-	kfree(stm);
+	vfree(stm);
 }
 
 int stm_register_device(struct device *parent, struct stm_data *stm_data,
@@ -699,7 +699,7 @@ int stm_register_device(struct device *p
 		return -EINVAL;
 
 	nmasters = stm_data->sw_end - stm_data->sw_start + 1;
-	stm = kzalloc(sizeof(*stm) + nmasters * sizeof(void *), GFP_KERNEL);
+	stm = vzalloc(sizeof(*stm) + nmasters * sizeof(void *));
 	if (!stm)
 		return -ENOMEM;
 
@@ -752,7 +752,7 @@ err_device:
 	/* matches device_initialize() above */
 	put_device(&stm->dev);
 err_free:
-	kfree(stm);
+	vfree(stm);
 
 	return err;
 }
