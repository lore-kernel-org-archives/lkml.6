Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5581AC46472
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A73821A5D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 02:57:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A73821A5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731293AbeHGFJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 01:09:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:25252 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727216AbeHGFJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 01:09:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2018 19:57:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,453,1526367600"; 
   d="scan'208";a="61159734"
Received: from chejianj-opti.sh.intel.com ([10.239.154.125])
  by fmsmga008.fm.intel.com with ESMTP; 06 Aug 2018 19:57:16 -0700
From:   Jian Jun Chen <jian.jun.chen@intel.com>
To:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     kraxel@redhat.com, mst@redhat.com, jasowang@redhat.com,
        yu1.wang@intel.com, shuo.a.liu@intel.com, jie.deng@intel.com,
        conghui.chen@intel.com, Jian Jun Chen <jian.jun.chen@intel.com>
Subject: [PATCH] virtio-input: reset device when going to sleep
Date:   Tue,  7 Aug 2018 11:02:10 +0800
Message-Id: <20180807030210.16543-1-jian.jun.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When going to sleep all virtqueues are deleted, memory used for
descriptor table entries are freed. Device reset is required in
this case to notify the backend driver.

Signed-off-by: Jian Jun Chen <jian.jun.chen@intel.com>
---
 drivers/virtio/virtio_input.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index 3a0468f2ceb0..20ea660bf1fc 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -332,12 +332,16 @@ static void virtinput_remove(struct virtio_device *vdev)
 static int virtinput_freeze(struct virtio_device *vdev)
 {
 	struct virtio_input *vi = vdev->priv;
+	void *buf;
 	unsigned long flags;
 
 	spin_lock_irqsave(&vi->lock, flags);
 	vi->ready = false;
 	spin_unlock_irqrestore(&vi->lock, flags);
 
+	vdev->config->reset(vdev);
+	while ((buf = virtqueue_detach_unused_buf(vi->sts)) != NULL)
+		kfree(buf);
 	vdev->config->del_vqs(vdev);
 	return 0;
 }
-- 
2.17.1

