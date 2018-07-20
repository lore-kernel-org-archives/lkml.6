Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C099FECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765C020673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:15:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 765C020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbeGTBBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 21:01:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48138 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727615AbeGTBBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 21:01:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 496424076068;
        Fri, 20 Jul 2018 00:15:36 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-42.pek2.redhat.com [10.72.12.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 327EB2026D6B;
        Fri, 20 Jul 2018 00:15:31 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, netdev@vger.kernel.org
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/9] vhost_net: introduce helper to initialize tx iov iter
Date:   Fri, 20 Jul 2018 08:15:14 +0800
Message-Id: <1532045721-4958-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
References: <1532045721-4958-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 20 Jul 2018 00:15:36 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 20 Jul 2018 00:15:36 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce init_iov_iter() in order to be reused by future patch.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/net.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 1a8175a..cac28fd 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -466,6 +466,18 @@ static bool vhost_exceeds_maxpend(struct vhost_net *net)
 	       min_t(unsigned int, VHOST_MAX_PEND, vq->num >> 2);
 }
 
+static size_t init_iov_iter(struct vhost_virtqueue *vq, struct iov_iter *iter,
+			    size_t hdr_size, int out)
+{
+	/* Skip header. TODO: support TSO. */
+	size_t len = iov_length(vq->iov, out);
+
+	iov_iter_init(iter, WRITE, vq->iov, out, len);
+	iov_iter_advance(iter, hdr_size);
+
+	return iov_iter_count(iter);
+}
+
 /* Expects to be always run from workqueue - which acts as
  * read-size critical section for our kind of RCU. */
 static void handle_tx(struct vhost_net *net)
@@ -531,18 +543,14 @@ static void handle_tx(struct vhost_net *net)
 			       "out %d, int %d\n", out, in);
 			break;
 		}
-		/* Skip header. TODO: support TSO. */
-		len = iov_length(vq->iov, out);
-		iov_iter_init(&msg.msg_iter, WRITE, vq->iov, out, len);
-		iov_iter_advance(&msg.msg_iter, hdr_size);
+
 		/* Sanity check */
-		if (!msg_data_left(&msg)) {
-			vq_err(vq, "Unexpected header len for TX: "
-			       "%zd expected %zd\n",
-			       len, hdr_size);
+		len = init_iov_iter(vq, &msg.msg_iter, hdr_size, out);
+		if (!len) {
+			vq_err(vq, "Unexpected header len for TX: %zd expected %zd\n",
+			len, hdr_size);
 			break;
 		}
-		len = msg_data_left(&msg);
 
 		zcopy_used = zcopy && len >= VHOST_GOODCOPY_LEN
 				   && !vhost_exceeds_maxpend(net)
-- 
2.7.4

