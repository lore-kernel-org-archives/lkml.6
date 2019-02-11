Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B42C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC49222AA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895024;
	bh=NG7VQH08ORMYZQx1yWvxtBsYHT8Vwhk/o9b8LexgkYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cwCo8/Z6VHnM+XrxJUwZ8mebaJsoy4YGaJyX8KIUnJcbdmpx863xKlMn8C/TD6O94
	 PUnCaKOk0xka4qZTNwx+OJUiZU4HZQgdhhcx+ciQXiH7Y9WN6XwE2yxTnTp4psERhL
	 OdyfTwcUpIiKOxRJWWDdCJPYxsrCYIwbANYuLTDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbfBKOXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:23:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:56772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729034AbfBKOXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:23:41 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B41C222A1;
        Mon, 11 Feb 2019 14:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895020;
        bh=NG7VQH08ORMYZQx1yWvxtBsYHT8Vwhk/o9b8LexgkYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aDrueQYsGhTRlhX7J51k4Q7frjURap1QXvpdzP2p6lkOZksSLZjsP20eeomV0C3XN
         mq3c83vhlirHGW1WUVJNznAjP8AgPq2LqOBMODmuKmXsv3JxOsW5A9efVDh7Cl4pbk
         d6oxODp/8Dm5DRS7EBFfoZeADfD9Qc79CloNP4RM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 064/352] RDMA/core: Sync unregistration with netlink commands
Date:   Mon, 11 Feb 2019 15:14:51 +0100
Message-Id: <20190211141850.203209018@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 01b671170d7f82b959dad6d5dbb44d7a915e647d ]

When the rdma device is getting removed, get resource info can race with
device removal, as below:

      CPU-0                                  CPU-1
    --------                               --------
    rdma_nl_rcv_msg()
       nldev_res_get_cq_dumpit()
          mutex_lock(device_lock);
          get device reference
          mutex_unlock(device_lock);        [..]
                                            ib_unregister_device()
                                            /* Valid reference to
                                             * device->dev exists.
                                             */
                                             ib_dealloc_device()

          [..]
          provider->fill_res_entry();

Even though device object is not freed, fill_res_entry() can get called on
device which doesn't have a driver anymore. Kernel core device reference
count is not sufficient, as this only keeps the structure valid, and
doesn't guarantee the driver is still loaded.

Similar race can occur with device renaming and device removal, where
device_rename() tries to rename a unregistered device. While this is fine
for devices of a class which are not net namespace aware, but it is
incorrect for net namespace aware class coming in subsequent series.  If a
class is net namespace aware, then the below [1] call trace is observed in
above situation.

Therefore, to avoid the race, keep a reference count and let device
unregistration wait until all netlink users drop the reference.

[1] Call trace:
kernfs: ns required in 'infiniband' for 'mlx5_0'
WARNING: CPU: 18 PID: 44270 at fs/kernfs/dir.c:842 kernfs_find_ns+0x104/0x120
libahci i2c_core mlxfw libata dca [last unloaded: devlink]
RIP: 0010:kernfs_find_ns+0x104/0x120
Call Trace:
kernfs_find_and_get_ns+0x2e/0x50
sysfs_rename_link_ns+0x40/0xb0
device_rename+0xb2/0xf0
ib_device_rename+0xb3/0x100 [ib_core]
nldev_set_doit+0x165/0x190 [ib_core]
rdma_nl_rcv_msg+0x249/0x250 [ib_core]
? netlink_deliver_tap+0x8f/0x3e0
rdma_nl_rcv+0xd6/0x120 [ib_core]
netlink_unicast+0x17c/0x230
netlink_sendmsg+0x2f0/0x3e0
sock_sendmsg+0x30/0x40
__sys_sendto+0xdc/0x160

Fixes: da5c85078215 ("RDMA/nldev: add driver-specific resource tracking")
Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/core_priv.h |  1 +
 drivers/infiniband/core/device.c    | 26 ++++++++++++++++++++++----
 drivers/infiniband/core/nldev.c     | 20 ++++++++++----------
 include/rdma/ib_verbs.h             |  8 +++++++-
 4 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/core/core_priv.h b/drivers/infiniband/core/core_priv.h
index bb9007a0cca7..d97d39a7537c 100644
--- a/drivers/infiniband/core/core_priv.h
+++ b/drivers/infiniband/core/core_priv.h
@@ -296,6 +296,7 @@ static inline int ib_mad_enforce_security(struct ib_mad_agent_private *map,
 #endif
 
 struct ib_device *ib_device_get_by_index(u32 ifindex);
+void ib_device_put(struct ib_device *device);
 /* RDMA device netlink */
 void nldev_init(void);
 void nldev_exit(void);
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 87eb4f2cdd7d..0027b0d79b09 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -145,7 +145,8 @@ static struct ib_device *__ib_device_get_by_index(u32 index)
 }
 
 /*
- * Caller is responsible to return refrerence count by calling put_device()
+ * Caller must perform ib_device_put() to return the device reference count
+ * when ib_device_get_by_index() returns valid device pointer.
  */
 struct ib_device *ib_device_get_by_index(u32 index)
 {
@@ -153,13 +154,21 @@ struct ib_device *ib_device_get_by_index(u32 index)
 
 	down_read(&lists_rwsem);
 	device = __ib_device_get_by_index(index);
-	if (device)
-		get_device(&device->dev);
-
+	if (device) {
+		/* Do not return a device if unregistration has started. */
+		if (!refcount_inc_not_zero(&device->refcount))
+			device = NULL;
+	}
 	up_read(&lists_rwsem);
 	return device;
 }
 
+void ib_device_put(struct ib_device *device)
+{
+	if (refcount_dec_and_test(&device->refcount))
+		complete(&device->unreg_completion);
+}
+
 static struct ib_device *__ib_device_get_by_name(const char *name)
 {
 	struct ib_device *device;
@@ -293,6 +302,8 @@ struct ib_device *ib_alloc_device(size_t size)
 	rwlock_init(&device->client_data_lock);
 	INIT_LIST_HEAD(&device->client_data_list);
 	INIT_LIST_HEAD(&device->port_list);
+	refcount_set(&device->refcount, 1);
+	init_completion(&device->unreg_completion);
 
 	return device;
 }
@@ -641,6 +652,13 @@ void ib_unregister_device(struct ib_device *device)
 	struct ib_client_data *context, *tmp;
 	unsigned long flags;
 
+	/*
+	 * Wait for all netlink command callers to finish working on the
+	 * device.
+	 */
+	ib_device_put(device);
+	wait_for_completion(&device->unreg_completion);
+
 	mutex_lock(&device_mutex);
 
 	down_write(&lists_rwsem);
diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index ff6468e7fe79..77a0f1e1576f 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -632,13 +632,13 @@ static int nldev_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	nlmsg_end(msg, nlh);
 
-	put_device(&device->dev);
+	ib_device_put(device);
 	return rdma_nl_unicast(msg, NETLINK_CB(skb).portid);
 
 err_free:
 	nlmsg_free(msg);
 err:
-	put_device(&device->dev);
+	ib_device_put(device);
 	return err;
 }
 
@@ -668,7 +668,7 @@ static int nldev_set_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		err = ib_device_rename(device, name);
 	}
 
-	put_device(&device->dev);
+	ib_device_put(device);
 	return err;
 }
 
@@ -752,14 +752,14 @@ static int nldev_port_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto err_free;
 
 	nlmsg_end(msg, nlh);
-	put_device(&device->dev);
+	ib_device_put(device);
 
 	return rdma_nl_unicast(msg, NETLINK_CB(skb).portid);
 
 err_free:
 	nlmsg_free(msg);
 err:
-	put_device(&device->dev);
+	ib_device_put(device);
 	return err;
 }
 
@@ -816,7 +816,7 @@ static int nldev_port_get_dumpit(struct sk_buff *skb,
 	}
 
 out:
-	put_device(&device->dev);
+	ib_device_put(device);
 	cb->args[0] = idx;
 	return skb->len;
 }
@@ -855,13 +855,13 @@ static int nldev_res_get_doit(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto err_free;
 
 	nlmsg_end(msg, nlh);
-	put_device(&device->dev);
+	ib_device_put(device);
 	return rdma_nl_unicast(msg, NETLINK_CB(skb).portid);
 
 err_free:
 	nlmsg_free(msg);
 err:
-	put_device(&device->dev);
+	ib_device_put(device);
 	return ret;
 }
 
@@ -1054,7 +1054,7 @@ next:		idx++;
 	if (!filled)
 		goto err;
 
-	put_device(&device->dev);
+	ib_device_put(device);
 	return skb->len;
 
 res_err:
@@ -1065,7 +1065,7 @@ err:
 	nlmsg_cancel(skb, nlh);
 
 err_index:
-	put_device(&device->dev);
+	ib_device_put(device);
 	return ret;
 }
 
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9c0c2132a2d6..64626b32107b 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -56,7 +56,7 @@
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/netdevice.h>
-
+#include <linux/refcount.h>
 #include <linux/if_link.h>
 #include <linux/atomic.h>
 #include <linux/mmu_notifier.h>
@@ -2605,6 +2605,12 @@ struct ib_device {
 
 	const struct uverbs_object_tree_def *const *driver_specs;
 	enum rdma_driver_id		driver_id;
+	/*
+	 * Provides synchronization between device unregistration and netlink
+	 * commands on a device. To be used only by core.
+	 */
+	refcount_t refcount;
+	struct completion unreg_completion;
 };
 
 struct ib_client {
-- 
2.19.1



