Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD85C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76AA8208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:57:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76AA8208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933268AbeGJJ45 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 05:56:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:6916 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751903AbeGJJ4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 05:56:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2018 02:56:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,334,1526367600"; 
   d="scan'208";a="73598568"
Received: from devel-ww.sh.intel.com ([10.239.48.110])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2018 02:56:30 -0700
From:   Wei Wang <wei.w.wang@intel.com>
To:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org,
        akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, pbonzini@redhat.com,
        wei.w.wang@intel.com, liliang.opensource@gmail.com,
        yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com,
        riel@redhat.com, peterx@redhat.com
Subject: [PATCH v35 2/5] virtio-balloon: remove BUG() in init_vqs
Date:   Tue, 10 Jul 2018 17:31:04 +0800
Message-Id: <1531215067-35472-3-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531215067-35472-1-git-send-email-wei.w.wang@intel.com>
References: <1531215067-35472-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a bit overkill to use BUG when failing to add an entry to the
stats_vq in init_vqs. So remove it and just return the error to the
caller to bail out nicely.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 6b237e3..9356a1a 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -455,9 +455,13 @@ static int init_vqs(struct virtio_balloon *vb)
 		num_stats = update_balloon_stats(vb);
 
 		sg_init_one(&sg, vb->stats, sizeof(vb->stats[0]) * num_stats);
-		if (virtqueue_add_outbuf(vb->stats_vq, &sg, 1, vb, GFP_KERNEL)
-		    < 0)
-			BUG();
+		err = virtqueue_add_outbuf(vb->stats_vq, &sg, 1, vb,
+					   GFP_KERNEL);
+		if (err) {
+			dev_warn(&vb->vdev->dev, "%s: add stat_vq failed\n",
+				 __func__);
+			return err;
+		}
 		virtqueue_kick(vb->stats_vq);
 	}
 	return 0;
-- 
2.7.4

