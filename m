Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D1AC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6963C21569
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6963C21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbeHGWzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 18:55:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56812 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727055AbeHGWzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 18:55:42 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA04087916;
        Tue,  7 Aug 2018 20:39:30 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88C4C1C664;
        Tue,  7 Aug 2018 20:39:30 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Karol Herbst <karolherbst@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/13] drm/nouveau: Add missing unroll functions in nouveau_do_suspend()
Date:   Tue,  7 Aug 2018 16:39:04 -0400
Message-Id: <20180807203914.2192-8-lyude@redhat.com>
In-Reply-To: <20180807203914.2192-1-lyude@redhat.com>
References: <20180807203914.2192-1-lyude@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 07 Aug 2018 20:39:30 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Tue, 07 Aug 2018 20:39:30 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'lyude@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, it appears that nouveau_do_suspend() forgets to roll back
suspending fbcon and suspending the device LEDs. We also currently skip
the entire rollback process if nouveau_display_suspend() fails. So, fix
that.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Karol Herbst <karolherbst@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 5ea8fe992484..db56e9b6b6af 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -674,10 +674,11 @@ nouveau_do_suspend(struct drm_device *dev, bool runtime)
 	if (dev->mode_config.num_crtc) {
 		NV_DEBUG(drm, "suspending console...\n");
 		nouveau_fbcon_set_suspend(dev, 1);
+
 		NV_DEBUG(drm, "suspending display...\n");
 		ret = nouveau_display_suspend(dev, runtime);
 		if (ret)
-			return ret;
+			goto fail_fbcon;
 	}
 
 	NV_DEBUG(drm, "evicting buffers...\n");
@@ -719,7 +720,14 @@ nouveau_do_suspend(struct drm_device *dev, bool runtime)
 	if (dev->mode_config.num_crtc) {
 		NV_DEBUG(drm, "resuming display...\n");
 		nouveau_display_resume(dev, runtime);
+
+fail_fbcon:
+		NV_DEBUG(drm, "resuming console...\n");
+		nouveau_fbcon_set_suspend(dev, 0);
 	}
+
+	nouveau_led_resume(dev);
+
 	return ret;
 }
 
-- 
2.17.1

