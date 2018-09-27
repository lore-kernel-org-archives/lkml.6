Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DE7C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 689D72152F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689D72152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbeI0PdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:33:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55664 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbeI0PdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:33:04 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2BDDC1120;
        Thu, 27 Sep 2018 09:15:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 4.18 66/88] drm/nouveau/drm/nouveau: Dont forget to cancel hpd_work on suspend/unload
Date:   Thu, 27 Sep 2018 11:03:47 +0200
Message-Id: <20180927090308.724680870@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090300.631426620@linuxfoundation.org>
References: <20180927090300.631426620@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lyude Paul <lyude@redhat.com>

commit 2f7ca781fd382cf8dde73ed36dfdd93fd05b3332 upstream.

Currently, there's nothing in nouveau that actually cancels this work
struct. So, cancel it on suspend/unload. Otherwise, if we're unlucky
enough hpd_work might try to keep running up until the system is
suspended.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/nouveau/nouveau_display.c |    9 ++++++---
 drivers/gpu/drm/nouveau/nouveau_display.h |    2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c     |    2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -425,7 +425,7 @@ nouveau_display_init(struct drm_device *
 }
 
 void
-nouveau_display_fini(struct drm_device *dev, bool suspend)
+nouveau_display_fini(struct drm_device *dev, bool suspend, bool runtime)
 {
 	struct nouveau_display *disp = nouveau_display(dev);
 	struct nouveau_drm *drm = nouveau_drm(dev);
@@ -450,6 +450,9 @@ nouveau_display_fini(struct drm_device *
 	}
 	drm_connector_list_iter_end(&conn_iter);
 
+	if (!runtime)
+		cancel_work_sync(&drm->hpd_work);
+
 	drm_kms_helper_poll_disable(dev);
 	disp->fini(dev);
 }
@@ -618,11 +621,11 @@ nouveau_display_suspend(struct drm_devic
 			}
 		}
 
-		nouveau_display_fini(dev, true);
+		nouveau_display_fini(dev, true, runtime);
 		return 0;
 	}
 
-	nouveau_display_fini(dev, true);
+	nouveau_display_fini(dev, true, runtime);
 
 	list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
 		struct nouveau_framebuffer *nouveau_fb;
--- a/drivers/gpu/drm/nouveau/nouveau_display.h
+++ b/drivers/gpu/drm/nouveau/nouveau_display.h
@@ -62,7 +62,7 @@ nouveau_display(struct drm_device *dev)
 int  nouveau_display_create(struct drm_device *dev);
 void nouveau_display_destroy(struct drm_device *dev);
 int  nouveau_display_init(struct drm_device *dev);
-void nouveau_display_fini(struct drm_device *dev, bool suspend);
+void nouveau_display_fini(struct drm_device *dev, bool suspend, bool runtime);
 int  nouveau_display_suspend(struct drm_device *dev, bool runtime);
 void nouveau_display_resume(struct drm_device *dev, bool runtime);
 int  nouveau_display_vblank_enable(struct drm_device *, unsigned int);
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -629,7 +629,7 @@ nouveau_drm_unload(struct drm_device *de
 	nouveau_debugfs_fini(drm);
 
 	if (dev->mode_config.num_crtc)
-		nouveau_display_fini(dev, false);
+		nouveau_display_fini(dev, false, false);
 	nouveau_display_destroy(dev);
 
 	nouveau_bios_takedown(dev);


