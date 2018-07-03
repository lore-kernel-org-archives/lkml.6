Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEDCC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E81421ADE
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E81421ADE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932767AbeGCFiu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 01:38:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754424AbeGCFip (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 01:38:45 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4B3DD401CDA7;
        Tue,  3 Jul 2018 05:38:44 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-60.pek2.redhat.com [10.72.12.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F6361117624;
        Tue,  3 Jul 2018 05:38:39 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wexu@redhat.com, tiwei.bie@intel.com, maxime.coquelin@redhat.com,
        jfreimann@redhat.com
Subject: [PATCH net-next 4/8] vhost_net: do not explicitly manipulate vhost_used_elem
Date:   Tue,  3 Jul 2018 13:38:00 +0800
Message-Id: <1530596284-4101-5-git-send-email-jasowang@redhat.com>
In-Reply-To: <1530596284-4101-1-git-send-email-jasowang@redhat.com>
References: <1530596284-4101-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 03 Jul 2018 05:38:44 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Tue, 03 Jul 2018 05:38:44 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two helpers of setting/getting used len were introduced to avoid
explicitly manipulating vhost_used_elem in zerocopy code. This will be
used to hide used_elem internals and simplify packed ring
implementation.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c   | 11 +++++------
 drivers/vhost/vhost.c | 12 ++++++++++--
 drivers/vhost/vhost.h |  5 +++++
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index d109649..eada5a6 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -348,9 +348,10 @@ static void vhost_zerocopy_signal_used(struct vhost_net *net,
 	int j = 0;
 
 	for (i = nvq->done_idx; i != nvq->upend_idx; i = (i + 1) % UIO_MAXIOV) {
-		if (vq->heads[i].elem.len == VHOST_DMA_FAILED_LEN)
+		if (vhost_get_used_len(vq, &vq->heads[i]) ==
+		    VHOST_DMA_FAILED_LEN)
 			vhost_net_tx_err(net);
-		if (VHOST_DMA_IS_DONE(vq->heads[i].elem.len)) {
+		if (VHOST_DMA_IS_DONE(vhost_get_used_len(vq, &vq->heads[i]))) {
 			vq->heads[i].elem.len = VHOST_DMA_CLEAR_LEN;
 			++j;
 		} else
@@ -549,10 +550,8 @@ static void handle_tx(struct vhost_net *net)
 			struct ubuf_info *ubuf;
 			ubuf = nvq->ubuf_info + nvq->upend_idx;
 
-			vq->heads[nvq->upend_idx].elem.id =
-				cpu_to_vhost32(vq, used.elem.id);
-			vq->heads[nvq->upend_idx].elem.len =
-				VHOST_DMA_IN_PROGRESS;
+			vhost_set_used_len(vq, &used, VHOST_DMA_IN_PROGRESS);
+			vq->heads[nvq->upend_idx] = used;
 			ubuf->callback = vhost_zerocopy_callback;
 			ubuf->ctx = nvq->ubufs;
 			ubuf->desc = nvq->upend_idx;
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 641f4c6..af15bec 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2071,11 +2071,19 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
 }
 EXPORT_SYMBOL_GPL(vhost_get_vq_desc);
 
-static void vhost_set_used_len(struct vhost_virtqueue *vq,
-			       struct vhost_used_elem *used, int len)
+void vhost_set_used_len(struct vhost_virtqueue *vq,
+			struct vhost_used_elem *used, int len)
 {
 	used->elem.len = cpu_to_vhost32(vq, len);
 }
+EXPORT_SYMBOL_GPL(vhost_set_used_len);
+
+int vhost_get_used_len(struct vhost_virtqueue *vq,
+		       struct vhost_used_elem *used)
+{
+	return vhost32_to_cpu(vq, used->elem.len);
+}
+EXPORT_SYMBOL_GPL(vhost_get_used_len);
 
 /* This is a multi-buffer version of vhost_get_desc, that works if
  *	vq has read descriptors only.
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 8dea44b..604821b 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -198,6 +198,11 @@ int vhost_get_bufs(struct vhost_virtqueue *vq,
 		   unsigned *log_num,
 		   unsigned int quota,
 		   s16 *count);
+void vhost_set_used_len(struct vhost_virtqueue *vq,
+			struct vhost_used_elem *used,
+			int len);
+int vhost_get_used_len(struct vhost_virtqueue *vq,
+		       struct vhost_used_elem *used);
 void vhost_discard_vq_desc(struct vhost_virtqueue *, int n);
 
 int vhost_vq_init_access(struct vhost_virtqueue *);
-- 
2.7.4

