Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156D0C04AB9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB57F2086D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 01:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB57F2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbeHWFHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 01:07:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39590 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726191AbeHWFHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 01:07:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6D0B240241C6;
        Thu, 23 Aug 2018 01:40:19 +0000 (UTC)
Received: from whitewolf.lyude.net.com (ovpn-124-163.rdu2.redhat.com [10.10.124.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0874110DCF6A;
        Thu, 23 Aug 2018 01:40:18 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     Karol Herbst <kherbst@redhat.com>, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm/nouveau: Fix potential memory leak in nouveau_drm_load()
Date:   Wed, 22 Aug 2018 21:40:06 -0400
Message-Id: <20180823014009.21532-2-lyude@redhat.com>
In-Reply-To: <20180823014009.21532-1-lyude@redhat.com>
References: <20180823014009.21532-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 23 Aug 2018 01:40:19 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 23 Aug 2018 01:40:19 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We forget to free drm in all instances of failure, and additionally also
forget to destroy the master client if the other client fails
initialization.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Karol Herbst <kherbst@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 5fdc1fbe2ee5..6c88ff776ff6 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -538,11 +538,11 @@ nouveau_drm_load(struct drm_device *dev, unsigned long flags)
 
 	ret = nouveau_cli_init(drm, "DRM-master", &drm->master);
 	if (ret)
-		return ret;
+		goto fail_alloc;
 
 	ret = nouveau_cli_init(drm, "DRM", &drm->client);
 	if (ret)
-		return ret;
+		goto fail_master;
 
 	dev->irq_enabled = true;
 
@@ -607,7 +607,9 @@ nouveau_drm_load(struct drm_device *dev, unsigned long flags)
 fail_ttm:
 	nouveau_vga_fini(drm);
 	nouveau_cli_fini(&drm->client);
+fail_master:
 	nouveau_cli_fini(&drm->master);
+fail_alloc:
 	kfree(drm);
 	return ret;
 }
-- 
2.17.1

