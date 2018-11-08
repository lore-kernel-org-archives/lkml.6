Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6B1ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92ED20818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsIjedfl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92ED20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbeKIHhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:37:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:55158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729502AbeKIHhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:37:17 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FFF120818;
        Thu,  8 Nov 2018 21:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714389;
        bh=BKQ4Tof9t/8FcwW8nHMYzG1ZPxHUQeMFXstyFne9q8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MsIjedflV7AcjEGuRM1HYDpOUHl6wc51c7ZoApnpnkNWpk9YIKA78T/WmhClDoU6U
         ZyWRCDrE2c3+p2SgKdo59Op7dBmaqESEFzfhVwCia9YUQfZ6UUGdXpJrwl/3p2tpTG
         zCsNrAaLQbo54JwgFKLlwIjVHExAwQZU0PyvxFWw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Roskin <plroskin@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 052/114] drm/nouveau/fbcon: fix oops without fbdev emulation
Date:   Thu,  8 Nov 2018 13:51:07 -0800
Message-Id: <20181108215105.860896186@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4813766325374af6ed0b66879ba6a0bbb05c83b6 ]

This is similar to an earlier commit 52dfcc5ccfbb ("drm/nouveau: fix for
disabled fbdev emulation"), but protects all occurrences of helper.fbdev
in the source.

I see oops in nouveau_fbcon_accel_save_disable() called from
nouveau_fbcon_set_suspend_work() on Linux 3.13 when
CONFIG_DRM_FBDEV_EMULATION option is disabled.

Signed-off-by: Pavel Roskin <plroskin@gmail.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_fbcon.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_fbcon.c b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
index e40a1b07a014..343476d15726 100644
--- a/drivers/gpu/drm/nouveau/nouveau_fbcon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_fbcon.c
@@ -235,7 +235,7 @@ void
 nouveau_fbcon_accel_save_disable(struct drm_device *dev)
 {
 	struct nouveau_drm *drm = nouveau_drm(dev);
-	if (drm->fbcon) {
+	if (drm->fbcon && drm->fbcon->helper.fbdev) {
 		drm->fbcon->saved_flags = drm->fbcon->helper.fbdev->flags;
 		drm->fbcon->helper.fbdev->flags |= FBINFO_HWACCEL_DISABLED;
 	}
@@ -245,7 +245,7 @@ void
 nouveau_fbcon_accel_restore(struct drm_device *dev)
 {
 	struct nouveau_drm *drm = nouveau_drm(dev);
-	if (drm->fbcon) {
+	if (drm->fbcon && drm->fbcon->helper.fbdev) {
 		drm->fbcon->helper.fbdev->flags = drm->fbcon->saved_flags;
 	}
 }
@@ -257,7 +257,8 @@ nouveau_fbcon_accel_fini(struct drm_device *dev)
 	struct nouveau_fbdev *fbcon = drm->fbcon;
 	if (fbcon && drm->channel) {
 		console_lock();
-		fbcon->helper.fbdev->flags |= FBINFO_HWACCEL_DISABLED;
+		if (fbcon->helper.fbdev)
+			fbcon->helper.fbdev->flags |= FBINFO_HWACCEL_DISABLED;
 		console_unlock();
 		nouveau_channel_idle(drm->channel);
 		nvif_object_fini(&fbcon->twod);
-- 
2.17.1



