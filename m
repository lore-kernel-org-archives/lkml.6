Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8819C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 07:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82155205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 07:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbeL1Hzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 02:55:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52994 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729300AbeL1Hzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 02:55:48 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3F6C0C07998E;
        Fri, 28 Dec 2018 07:55:48 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-196.pek2.redhat.com [10.72.12.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E60C05D9C9;
        Fri, 28 Dec 2018 07:55:45 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH V2 1/3] vhost: generalize adding used elem
Date:   Fri, 28 Dec 2018 15:55:35 +0800
Message-Id: <20181228075537.21402-2-jasowang@redhat.com>
In-Reply-To: <20181228075537.21402-1-jasowang@redhat.com>
References: <20181228075537.21402-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 28 Dec 2018 07:55:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use one generic vhost_copy_to_user() instead of two dedicated
accessor. This will simplify the conversion to fine grain
accessors. About 2% improvement of PPS were seen during vitio-user
txonly test.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vhost/vhost.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 55e5aa662ad5..f179b5ee14c4 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2174,16 +2174,7 @@ static int __vhost_add_used_n(struct vhost_virtqueue *vq,
 
 	start = vq->last_used_idx & (vq->num - 1);
 	used = vq->used->ring + start;
-	if (count == 1) {
-		if (vhost_put_user(vq, heads[0].id, &used->id)) {
-			vq_err(vq, "Failed to write used id");
-			return -EFAULT;
-		}
-		if (vhost_put_user(vq, heads[0].len, &used->len)) {
-			vq_err(vq, "Failed to write used len");
-			return -EFAULT;
-		}
-	} else if (vhost_copy_to_user(vq, used, heads, count * sizeof *used)) {
+	if (vhost_copy_to_user(vq, used, heads, count * sizeof *used)) {
 		vq_err(vq, "Failed to write used");
 		return -EFAULT;
 	}
-- 
2.17.1

