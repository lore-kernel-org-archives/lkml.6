Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1919C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E3D2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMia6d8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E3D2084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbeJYWvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:51:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbeJYWu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:50:59 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C70FE20834;
        Thu, 25 Oct 2018 14:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477082;
        bh=Ijs0Jru06Rf3iGYcQ89V7n5pioWLhP3aW41sijQUZHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WMia6d8SRCzQjqyICR8i03YFRUgk3obH8i8Jw0BE241r9O8/0ydJJlf3ZzhZH9mk8
         kDBSARXmXAZpQyrrV+KWVkebRWc9HUJ7y2Y0eTfNmIaeYtQJx2BkxlyVVCHl7orw8w
         f5S7Hc48c54fusn7DmCqdvsIpMcV5OTQWvbkYCWE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pavel Roskin <plroskin@gmail.com>, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 34/65] drm/nouveau/fbcon: fix oops without fbdev emulation
Date:   Thu, 25 Oct 2018 10:16:34 -0400
Message-Id: <20181025141705.213937-34-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Roskin <plroskin@gmail.com>

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

