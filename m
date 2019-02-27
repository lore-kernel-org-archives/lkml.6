Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC9EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A35217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbfB0Oos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:44:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:11866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729798AbfB0Ooq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:44:46 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8F37CA3414;
        Wed, 27 Feb 2019 14:44:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-248.ams2.redhat.com [10.36.117.248])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C89C25D70E;
        Wed, 27 Feb 2019 14:44:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id EAFA91747B; Wed, 27 Feb 2019 15:44:41 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO GPU DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] drm/virtio: implement prime mmap
Date:   Wed, 27 Feb 2019 15:44:39 +0100
Message-Id: <20190227144441.6755-2-kraxel@redhat.com>
In-Reply-To: <20190227144441.6755-1-kraxel@redhat.com>
References: <20190227144441.6755-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 27 Feb 2019 14:44:46 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sync gem vm_node.start with ttm vm_node.start,
then we can just call drm_gem_prime_mmap().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_prime.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
index c59ec34c80a5..b4c9199349e7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_prime.c
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -56,7 +56,10 @@ void virtgpu_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
 }
 
 int virtgpu_gem_prime_mmap(struct drm_gem_object *obj,
-		       struct vm_area_struct *area)
+			   struct vm_area_struct *vma)
 {
-	return -ENODEV;
+	struct virtio_gpu_object *bo = gem_to_virtio_gpu_obj(obj);
+
+	bo->gem_base.vma_node.vm_node.start = bo->tbo.vma_node.vm_node.start;
+	return drm_gem_prime_mmap(obj, vma);
 }
-- 
2.9.3

