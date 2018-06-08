Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id NLEHMiD9GVtPOgAAmS7hNA
	; Fri, 08 Jun 2018 03:50:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B8CB6607E4; Fri,  8 Jun 2018 03:50:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 20DD860590;
	Fri,  8 Jun 2018 03:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 20DD860590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752758AbeFHDuu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 23:50:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752621AbeFHDus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 23:50:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4F4C6402315A;
        Fri,  8 Jun 2018 03:50:48 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-64.pek2.redhat.com [10.72.12.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D0EF2166BB2;
        Fri,  8 Jun 2018 03:50:44 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net] vhost_net: remove VHOST_NET_F_VIRTIO_NET_HDR support
Date: Fri,  8 Jun 2018 11:50:42 +0800
Message-Id: <1528429842-22835-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 08 Jun 2018 03:50:48 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Fri, 08 Jun 2018 03:50:48 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This feature bit is duplicated with VIRTIO_F_ANY_LAYOUT, this means if
a userpsace want to enable VRITIO_F_ANY_LAYOUT,
VHOST_NET_F_VIRTIO_NET_HDR will be implied too. This is wrong and will
break networking. Fixing this by safely removing
VHOST_NET_F_VIRTIO_NET_HDR support. There should be very few or even
no userspace can use this. Further cleanups could be done for
-net-next for safety.

In the future, we need a vhost dedicated feature set/get ioctl()
instead of reusing virtio ones.

Fixes: 4e9fa50c6ccbe ("vhost: move features to core")
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 986058a..83eef52 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -69,7 +69,6 @@ MODULE_PARM_DESC(experimental_zcopytx, "Enable Zero Copy TX;"
 
 enum {
 	VHOST_NET_FEATURES = VHOST_FEATURES |
-			 (1ULL << VHOST_NET_F_VIRTIO_NET_HDR) |
 			 (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
 			 (1ULL << VIRTIO_F_IOMMU_PLATFORM)
 };
@@ -1255,15 +1254,11 @@ static int vhost_net_set_features(struct vhost_net *n, u64 features)
 			       (1ULL << VIRTIO_F_VERSION_1))) ?
 			sizeof(struct virtio_net_hdr_mrg_rxbuf) :
 			sizeof(struct virtio_net_hdr);
-	if (features & (1 << VHOST_NET_F_VIRTIO_NET_HDR)) {
-		/* vhost provides vnet_hdr */
-		vhost_hlen = hdr_len;
-		sock_hlen = 0;
-	} else {
-		/* socket provides vnet_hdr */
-		vhost_hlen = 0;
-		sock_hlen = hdr_len;
-	}
+
+        /* socket provides vnet_hdr */
+	vhost_hlen = 0;
+	sock_hlen = hdr_len;
+
 	mutex_lock(&n->dev.mutex);
 	if ((features & (1 << VHOST_F_LOG_ALL)) &&
 	    !vhost_log_access_ok(&n->dev))
-- 
2.7.4
