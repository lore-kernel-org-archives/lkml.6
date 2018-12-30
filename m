Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD303C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942EB20861
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxVPHtsT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbeL3RuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 12:50:00 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41705 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeL3RtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 12:49:02 -0500
Received: by mail-lj1-f195.google.com with SMTP id k15-v6so22332149ljc.8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 09:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=1awO/MoKoVwOfNgJEovkQ5ae+K1bPPHX4RXZHhL2kVE=;
        b=TxVPHtsT3jC9tQ9wMJSJNH/z9LAfcRUVAwPyD2SA4IXOQinLkXj9CuE2abQWAx0pvD
         g9O8d0QMANFKRfRN4UBJ+8meywbRPdwFvRRRaganA/qDnRByDtYA2QOkKh16DogDHiPx
         +Ikn8mZf0GVkIQdc+cSXBii2Peb8yDgXOzvB+rzSeDJay0OOEewTwj5k7m3a96eUF+fX
         T5R14c265ZRwDYyVEt/DsyfnNsDVAg22rGthc+9cIuBuchVCrmUQoymFE9AaATWDcQuh
         O3FW+DiFJKmyjTMlJewapB4LgFSlIIdb3ncreD+nh/9gD1jg6I3o17PBSJVBc/Em3ZlG
         jNKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=1awO/MoKoVwOfNgJEovkQ5ae+K1bPPHX4RXZHhL2kVE=;
        b=H8RWI3gAmMuMB9JtUS44x51wp1vYcwSXVe9JZizNtLm3F4rpcQuVo79oZSAP0evd9a
         Bo3YmCAaWkLulwKJ6gSvJiYX49AnnnuhesNKA4T3LriIohPTPTqY480S/P2XsZ0IZFOS
         0VcmS/pay3PrvqwDUn52GOfmNglKgUa6AIWGBRGuUPS8q4k1f3Oehegp3EYhZy/QgJbU
         rZA+6es9FHzMAv9zm9cIp19iCRvinYeITPAGVUJ/BxqpzmW6MAXmDMhLDuRGJ/lRMLC8
         tnURho7cs1QankbSjwq7zr8KVfjJfth/b8I0w5c4uH4528k6Je6VaYD3n11f7QLDIDlL
         dFxg==
X-Gm-Message-State: AJcUukepjuB0LTXdIhqqb5z/7loJYZXU8Xu1lczouuLSz8/35iSZ+YZ4
        kf5aFYitz5nKrUzZJ4/j7QY=
X-Google-Smtp-Source: ALg8bN49pxaqWPQHzlAEBw2HU126+64sYUV11t8VaB+YgtfEGBdCAxOcjtw7mfZBhDTdZVPz8a2TFg==
X-Received: by 2002:a2e:2246:: with SMTP id i67-v6mr17082181lji.154.1546192140001;
        Sun, 30 Dec 2018 09:49:00 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id q11sm8853170lfc.92.2018.12.30.09.48.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 09:48:59 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v2 03/14] drm: move DRM_SWITCH_POWER defines to drm_device.h
Date:   Sun, 30 Dec 2018 18:48:27 +0100
Message-Id: <20181230174838.32330-4-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
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

