Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A593ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB802075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 08:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB802075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbeGRIoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 04:44:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57515 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726067AbeGRIoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 04:44:03 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9B707D89625E3;
        Wed, 18 Jul 2018 16:07:18 +0800 (CST)
Received: from [10.177.253.249] (10.177.253.249) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.382.0; Wed, 18 Jul 2018
 16:07:16 +0800
To:     Dominique Martinet <asmadeus@codewreck.org>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Eric Van Hensbergen" <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        "Latchesar Ionkov" <lucho@ionkov.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>
From:   piaojun <piaojun@huawei.com>
Subject: [PATCH] net/9p/trans_virtio.c: replace mutex_lock with spin_lock to
 protect 'virtio_chan_list'
Message-ID: <5B4EF511.7090104@huawei.com>
Date:   Wed, 18 Jul 2018 16:06:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.253.249]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spin_lock is more effective for short time protection than mutex_lock, as
mutex lock may cause process sleep and wake up which consume much cpu
time.

Signed-off-by: Jun Piao <piaojun@huawei.com>
---
 net/9p/trans_virtio.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 86077f7..7ec0dbf 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -53,8 +53,8 @@

 #define VIRTQUEUE_NUM	128

-/* a single mutex to manage channel initialization and attachment */
-static DEFINE_MUTEX(virtio_9p_lock);
+/* a single spinlock to manage channel initialization and attachment */
+static DEFINE_SPINLOCK(virtio_9p_lock);
 static DECLARE_WAIT_QUEUE_HEAD(vp_wq);
 static atomic_t vp_pinned = ATOMIC_INIT(0);

@@ -120,10 +120,10 @@ static void p9_virtio_close(struct p9_client *client)
 {
 	struct virtio_chan *chan = client->trans;

-	mutex_lock(&virtio_9p_lock);
+	spin_lock(&virtio_9p_lock);
 	if (chan)
 		chan->inuse = false;
-	mutex_unlock(&virtio_9p_lock);
+	spin_unlock(&virtio_9p_lock);
 }

 /**
@@ -605,9 +605,9 @@ static int p9_virtio_probe(struct virtio_device *vdev)

 	virtio_device_ready(vdev);

-	mutex_lock(&virtio_9p_lock);
+	spin_lock(&virtio_9p_lock);
 	list_add_tail(&chan->chan_list, &virtio_chan_list);
-	mutex_unlock(&virtio_9p_lock);
+	spin_unlock(&virtio_9p_lock);

 	/* Let udev rules use the new mount_tag attribute. */
 	kobject_uevent(&(vdev->dev.kobj), KOBJ_CHANGE);
@@ -645,7 +645,7 @@ static int p9_virtio_probe(struct virtio_device *vdev)
 	int ret = -ENOENT;
 	int found = 0;

-	mutex_lock(&virtio_9p_lock);
+	spin_lock(&virtio_9p_lock);
 	list_for_each_entry(chan, &virtio_chan_list, chan_list) {
 		if (!strncmp(devname, chan->tag, chan->tag_len) &&
 		    strlen(devname) == chan->tag_len) {
@@ -657,7 +657,7 @@ static int p9_virtio_probe(struct virtio_device *vdev)
 			ret = -EBUSY;
 		}
 	}
-	mutex_unlock(&virtio_9p_lock);
+	spin_unlock(&virtio_9p_lock);

 	if (!found) {
 		pr_err("no channels available for device %s\n", devname);
@@ -682,7 +682,7 @@ static void p9_virtio_remove(struct virtio_device *vdev)
 	struct virtio_chan *chan = vdev->priv;
 	unsigned long warning_time;

-	mutex_lock(&virtio_9p_lock);
+	spin_lock(&virtio_9p_lock);

 	/* Remove self from list so we don't get new users. */
 	list_del(&chan->chan_list);
@@ -690,17 +690,17 @@ static void p9_virtio_remove(struct virtio_device *vdev)

 	/* Wait for existing users to close. */
 	while (chan->inuse) {
-		mutex_unlock(&virtio_9p_lock);
+		spin_unlock(&virtio_9p_lock);
 		msleep(250);
 		if (time_after(jiffies, warning_time + 10 * HZ)) {
 			dev_emerg(&vdev->dev,
 				  "p9_virtio_remove: waiting for device in use.\n");
 			warning_time = jiffies;
 		}
-		mutex_lock(&virtio_9p_lock);
+		spin_lock(&virtio_9p_lock);
 	}

-	mutex_unlock(&virtio_9p_lock);
+	spin_unlock(&virtio_9p_lock);

 	vdev->config->reset(vdev);
 	vdev->config->del_vqs(vdev);
-- 
