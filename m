Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D42C6786C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19CD820851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:53:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19CD820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeLMCxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 21:53:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726787AbeLMCxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 21:53:49 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 371463DE04;
        Thu, 13 Dec 2018 02:53:49 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-167.pek2.redhat.com [10.72.12.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B33175D70A;
        Thu, 13 Dec 2018 02:53:46 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net V3 1/3] vhost: make sure used idx is seen before log in vhost_add_used_n()
Date:   Thu, 13 Dec 2018 10:53:37 +0800
Message-Id: <20181213025339.14023-2-jasowang@redhat.com>
In-Reply-To: <20181213025339.14023-1-jasowang@redhat.com>
References: <20181213025339.14023-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 13 Dec 2018 02:53:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We miss a write barrier that guarantees used idx is updated and seen
before log. This will let userspace sync and copy used ring before
used idx is update. Fix this by adding a barrier before log_write().

Fixes: 8dd014adfea6f ("vhost-net: mergeable buffers support")
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 6b98d8e3a5bf..5915f240275a 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2220,6 +2220,8 @@ int vhost_add_used_n(struct vhost_virtqueue *vq, struct vring_used_elem *heads,
 		return -EFAULT;
 	}
 	if (unlikely(vq->log_used)) {
+		/* Make sure used idx is seen before log. */
+		smp_wmb();
 		/* Log used index update. */
 		log_write(vq->log_base,
 			  vq->log_addr + offsetof(struct vring_used, idx),
-- 
2.17.1

