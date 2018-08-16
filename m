Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5891C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 770B5208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770B5208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389905AbeHPLQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 07:16:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:27823 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbeHPLQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 07:16:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2018 01:19:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,246,1531810800"; 
   d="scan'208";a="83781743"
Received: from devel-ww.sh.intel.com ([10.239.48.110])
  by orsmga002.jf.intel.com with ESMTP; 16 Aug 2018 01:19:15 -0700
From:   Wei Wang <wei.w.wang@intel.com>
To:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org,
        penguin-kernel@I-love.SAKURA.ne.jp
Cc:     wei.w.wang@intel.com
Subject: [PATCH v4 2/3] virtio-balloon: kzalloc the vb struct
Date:   Thu, 16 Aug 2018 15:50:57 +0800
Message-Id: <1534405858-27085-3-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534405858-27085-1-git-send-email-wei.w.wang@intel.com>
References: <1534405858-27085-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero all the vb fields at alloaction, so that we don't need to
zero-initialize each field one by one later.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/virtio/virtio_balloon.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 8100e77..d97d73c 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -561,7 +561,7 @@ static int virtballoon_probe(struct virtio_device *vdev)
 		return -EINVAL;
 	}
 
-	vdev->priv = vb = kmalloc(sizeof(*vb), GFP_KERNEL);
+	vdev->priv = vb = kzalloc(sizeof(*vb), GFP_KERNEL);
 	if (!vb) {
 		err = -ENOMEM;
 		goto out;
@@ -570,8 +570,6 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	INIT_WORK(&vb->update_balloon_stats_work, update_balloon_stats_func);
 	INIT_WORK(&vb->update_balloon_size_work, update_balloon_size_func);
 	spin_lock_init(&vb->stop_update_lock);
-	vb->stop_update = false;
-	vb->num_pages = 0;
 	mutex_init(&vb->balloon_lock);
 	init_waitqueue_head(&vb->acked);
 	vb->vdev = vdev;
@@ -602,7 +600,6 @@ static int virtballoon_probe(struct virtio_device *vdev)
 		err = PTR_ERR(vb->vb_dev_info.inode);
 		kern_unmount(balloon_mnt);
 		unregister_oom_notifier(&vb->nb);
-		vb->vb_dev_info.inode = NULL;
 		goto out_del_vqs;
 	}
 	vb->vb_dev_info.inode->i_mapping->a_ops = &balloon_aops;
-- 
2.7.4

