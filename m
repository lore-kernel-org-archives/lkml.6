Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1460C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE9A2064C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pV2kXpll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730537AbfAHT37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:29:59 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43033 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730503AbfAHT3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:29:55 -0500
Received: by mail-lj1-f193.google.com with SMTP id q2-v6so4395044lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 11:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1awO/MoKoVwOfNgJEovkQ5ae+K1bPPHX4RXZHhL2kVE=;
        b=pV2kXpllQYrDA4hF3IMi/IHnLg/GWyuF8rb4zqsGZT0lZl5MtSHjUOC9dTkdqnJpTW
         4Scn+Ojbs2oK6NxFKMkJ8OZPDv1s7tjVAAj0Qw6Wq7SdLBXg76t4hzFQYv3Qb+agPaqy
         lFGbIiRP2KZEEm7RkRgkA39sxXR+PQqJDz5lohbZ2uTEGVhiNMfIapf3OtQLpn/kGP7l
         e4Bc8jxdydNB+1AJW6aF79Pjye4jhG5Kouwoly2Xuzs701sDxeO0VD64ojZA2PnGV2J9
         giz7hPXkCTlKxgFtDThU7YSjeNJOi7SIM9Cgvj1JcLjFJ1tg9ZG2Io9TQPmSRcPQPyGx
         718g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=1awO/MoKoVwOfNgJEovkQ5ae+K1bPPHX4RXZHhL2kVE=;
        b=TCgPpE+0Glm2QoNP3hg0k31wyszaegllEEkD6WF15HyoWjEmSTMvbYMpiFScnH2PCX
         5M6Tp4fi5TKMpErdw3DXoEtPzWiiE3PVZH34D40renm/MTYQo1ooSVf6o16UF34g30uL
         IJJnfxSDcGELvdmdCf8Kzc7k3aGJRAaO1Fl2lYUP+wGDFJhadNemByvdSxLaZCjNsjvp
         h10jlG/0pma8CftxKFdogurDBwKiaYArkHli/5WayvdP0re+sf8/vsOO6OZwKH2nxDPL
         cqG/8DipTxLaVX/WHCJQ5Lj2wqrVschQ63dky3NeMJNr5loc+ulWZBbFbDd/ZQS8uQNz
         1Wxw==
X-Gm-Message-State: AJcUuke+Y6pJf4Yc6IGQYiDswlYFpydxBFa8E4S+5q3zrNS3XoWoOHJf
        5dOhQVzLglj46MEXGJtkx9o=
X-Google-Smtp-Source: ALg8bN7Sh6h+PveqxzyabyL3Odd/fBddfwjtuvwPxWGw6iRBuz5Gkz+Lip+hC4L7sT7+n5J6xEYqaw==
X-Received: by 2002:a2e:197:: with SMTP id f23-v6mr1795389lji.144.1546975792755;
        Tue, 08 Jan 2019 11:29:52 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id q128-v6sm9122246ljq.14.2019.01.08.11.29.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 11:29:52 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v3 02/12] drm: move DRM_SWITCH_POWER defines to drm_device.h
Date:   Tue,  8 Jan 2019 20:29:29 +0100
Message-Id: <20190108192939.15255-3-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190108192939.15255-1-sam@ravnborg.org>
References: <20190108192939.15255-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move DRM_SWITCH_POWER out of drmP.h to allow users
to get rid of the drmP include.
Moved to drm_device.h because drm_device.switch_power_state
is the only user.

Converted to enum and added sparse kerneldoc comments.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 include/drm/drmP.h       |  5 -----
 include/drm/drm_device.h | 29 ++++++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/include/drm/drmP.h b/include/drm/drmP.h
index db94ef00940e..9e47c8dc6b87 100644
--- a/include/drm/drmP.h
+++ b/include/drm/drmP.h
@@ -94,11 +94,6 @@ struct dma_buf_attachment;
 struct pci_dev;
 struct pci_controller;
 
-#define DRM_SWITCH_POWER_ON 0
-#define DRM_SWITCH_POWER_OFF 1
-#define DRM_SWITCH_POWER_CHANGING 2
-#define DRM_SWITCH_POWER_DYNAMIC_OFF 3
-
 /* returns true if currently okay to sleep */
 static inline bool drm_can_sleep(void)
 {
diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index 2b154ead9efc..d7cedbac66a3 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -24,6 +24,25 @@ struct inode;
 struct pci_dev;
 struct pci_controller;
 
+
+/**
+ * enum drm_switch_power - power state of drm device
+ */
+
+enum switch_power_state {
+	/** @DRM_SWITCH_POWER_ON: Power state is ON */
+	DRM_SWITCH_POWER_ON = 0,
+
+	/** @DRM_SWITCH_POWER_OFF: Power state is OFF */
+	DRM_SWITCH_POWER_OFF = 1,
+
+	/** @DRM_SWITCH_POWER_CHANGING: Power state is changing */
+	DRM_SWITCH_POWER_CHANGING = 2,
+
+	/** @DRM_SWITCH_POWER_DYNAMIC_OFF: Suspended */
+	DRM_SWITCH_POWER_DYNAMIC_OFF = 3,
+};
+
 /**
  * struct drm_device - DRM device structure
  *
@@ -291,7 +310,15 @@ struct drm_device {
 	/** @vma_offset_manager: GEM information */
 	struct drm_vma_offset_manager *vma_offset_manager;
 
-	int switch_power_state;
+	/**
+	 * @switch_power_state:
+	 *
+	 * Power state of the client.
+	 * Used by drivers supporting the switcheroo driver.
+	 * The state is maintained in the
+	 * &vga_switcheroo_client_ops.set_gpu_state callback
+	 */
+	enum switch_power_state switch_power_state;
 
 	/**
 	 * @fb_helper:
-- 
2.12.0

