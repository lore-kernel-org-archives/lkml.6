Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9034EC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397662064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRJ9FWO6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397662064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbeKAF51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 01:57:27 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35920 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbeKAF50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 01:57:26 -0400
Received: by mail-qk1-f196.google.com with SMTP id o125so7772831qkf.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 13:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=P/+YaClhl463b55HNkEDJSmrYu6HJuE62UikqKKubfI=;
        b=BRJ9FWO6fUu0YJQeL50LI6vGFyl/xRz/WGPUv9rzD8YWGbevwthS8v6eWkiNQYyWaH
         R+bxH2SxYzO69xv56kyjPVVZPEyI5PR/o8aw3zdXJAK+1KaXFc9+02gMSgECXe6HMren
         QEW6ERccqbbjooglY0PLtMhEZtI1yMRARcflSFpRyR1WjWAwWx673SFH/wMxg3a2TRrZ
         apimM2jbB7MFJr6+0XEJhdu0A8ZHwRn10XTf7z307G1LcY55QIW0zzwCR4rPkqQ2kvOd
         EP3jIi33UqKut4hDCbfJmGDF6hzEcvzIGicK5kbL8yZzzDD/KqjWaBPKesz/kjKUQYk/
         kIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=P/+YaClhl463b55HNkEDJSmrYu6HJuE62UikqKKubfI=;
        b=pysSuR18+jpcQjVf8hm4yKAXSvj0KO83TC9A4AKw8IwJgwY/2bGZGRvnXGKFCR37B3
         DFoP/8KPa6/utjQwB1EHAPFTZ/zlk5VdnjcuIjLLEGHbhjpSuamXfMjCfyR9yf68PUMN
         gIiFdEMCTLNWobekikCLmOCOqs0HpPXVkZIsNm2W8zG2MHQRdJ8E9tCmE6sEqFil0F75
         jckuETy7Jx0vGpf9KL6t/XZXjz/Tj5ptNQsC+uTwYVd7rOFRvyQrttrJsR7DVAQ/8jv2
         vmilcFOeUcT1REdF+COIf7FsgVIY43XIMmW7Fv+Avonv0BOsaZjC/bIgTi+ebl7pzbsO
         taag==
X-Gm-Message-State: AGRZ1gIfqfYsJncWNGepDSsMKwyKsOnzlvFS3qk5GOYWwr9Hiv3beFeL
        EibAM/y4wXT52TrTrAt7eg/hcWQeTA8=
X-Google-Smtp-Source: AJdET5cq0rzeL2ZjGDhQ1TH4Xg61p1mqmPO1f7DNIeIAmlJY/1CgCAPMsWy/AvBgqWtjS2eGZEENuA==
X-Received: by 2002:a37:9e44:: with SMTP id h65mr4129485qke.300.1541019462076;
        Wed, 31 Oct 2018 13:57:42 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id o63-v6sm9119499qka.16.2018.10.31.13.57.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 13:57:41 -0700 (PDT)
Date:   Wed, 31 Oct 2018 17:57:37 -0300
From:   Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH] drm: Rename crtc_idr as object_idr to KMS cleanups
Message-ID: <20181031205737.cingeaqget7hkbs6@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename 'drm_mode_config.crtc_idr' as 'drm_mode_config.object_idr',
as proposed in the task description in TODO list for KMS cleanups.

Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
---
 drivers/gpu/drm/drm_lease.c       | 6 +++---
 drivers/gpu/drm/drm_mode_config.c | 4 ++--
 drivers/gpu/drm/drm_mode_object.c | 8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
index f4702f23c11d..4f8de2217049 100644
--- a/drivers/gpu/drm/drm_lease.c
+++ b/drivers/gpu/drm/drm_lease.c
@@ -222,7 +222,7 @@ static struct drm_master *drm_lease_create(struct drm_master *lessor, struct idr
 
 	idr_for_each_entry(leases, entry, object) {
 		error = 0;
-		if (!idr_find(&dev->mode_config.crtc_idr, object))
+		if (!idr_find(&dev->mode_config.object_idr, object))
 			error = -ENOENT;
 		else if (!_drm_lease_held_master(lessor, object))
 			error = -EACCES;
@@ -438,7 +438,7 @@ static int fill_object_idr(struct drm_device *dev,
 		/*
 		 * We're using an IDR to hold the set of leased
 		 * objects, but we don't need to point at the object's
-		 * data structure from the lease as the main crtc_idr
+		 * data structure from the lease as the main object_idr
 		 * will be used to actually find that. Instead, all we
 		 * really want is a 'leased/not-leased' result, for
 		 * which any non-NULL pointer will work fine.
@@ -679,7 +679,7 @@ int drm_mode_get_lease_ioctl(struct drm_device *dev,
 
 	if (lessee->lessor == NULL)
 		/* owner can use all objects */
-		object_idr = &lessee->dev->mode_config.crtc_idr;
+		object_idr = &lessee->dev->mode_config.object_idr;
 	else
 		/* lessee can only use allowed object */
 		object_idr = &lessee->leases;
diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index ee80788f2c40..ab553b6465e2 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -381,7 +381,7 @@ void drm_mode_config_init(struct drm_device *dev)
 	INIT_LIST_HEAD(&dev->mode_config.property_list);
 	INIT_LIST_HEAD(&dev->mode_config.property_blob_list);
 	INIT_LIST_HEAD(&dev->mode_config.plane_list);
-	idr_init(&dev->mode_config.crtc_idr);
+	idr_init(&dev->mode_config.object_idr);
 	idr_init(&dev->mode_config.tile_idr);
 	ida_init(&dev->mode_config.connector_ida);
 	spin_lock_init(&dev->mode_config.connector_list_lock);
@@ -484,7 +484,7 @@ void drm_mode_config_cleanup(struct drm_device *dev)
 
 	ida_destroy(&dev->mode_config.connector_ida);
 	idr_destroy(&dev->mode_config.tile_idr);
-	idr_destroy(&dev->mode_config.crtc_idr);
+	idr_destroy(&dev->mode_config.object_idr);
 	drm_modeset_lock_fini(&dev->mode_config.connection_mutex);
 }
 EXPORT_SYMBOL(drm_mode_config_cleanup);
diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
index cd9bc0ce9be0..bb1dd46496cd 100644
--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -38,7 +38,7 @@ int __drm_mode_object_add(struct drm_device *dev, struct drm_mode_object *obj,
 	int ret;
 
 	mutex_lock(&dev->mode_config.idr_mutex);
-	ret = idr_alloc(&dev->mode_config.crtc_idr, register_obj ? obj : NULL,
+	ret = idr_alloc(&dev->mode_config.object_idr, register_obj ? obj : NULL,
 			1, 0, GFP_KERNEL);
 	if (ret >= 0) {
 		/*
@@ -79,7 +79,7 @@ void drm_mode_object_register(struct drm_device *dev,
 			      struct drm_mode_object *obj)
 {
 	mutex_lock(&dev->mode_config.idr_mutex);
-	idr_replace(&dev->mode_config.crtc_idr, obj, obj->id);
+	idr_replace(&dev->mode_config.object_idr, obj, obj->id);
 	mutex_unlock(&dev->mode_config.idr_mutex);
 }
 
@@ -99,7 +99,7 @@ void drm_mode_object_unregister(struct drm_device *dev,
 {
 	mutex_lock(&dev->mode_config.idr_mutex);
 	if (object->id) {
-		idr_remove(&dev->mode_config.crtc_idr, object->id);
+		idr_remove(&dev->mode_config.object_idr, object->id);
 		object->id = 0;
 	}
 	mutex_unlock(&dev->mode_config.idr_mutex);
@@ -131,7 +131,7 @@ struct drm_mode_object *__drm_mode_object_find(struct drm_device *dev,
 	struct drm_mode_object *obj = NULL;
 
 	mutex_lock(&dev->mode_config.idr_mutex);
-	obj = idr_find(&dev->mode_config.crtc_idr, id);
+	obj = idr_find(&dev->mode_config.object_idr, id);
 	if (obj && type != DRM_MODE_OBJECT_ANY && obj->type != type)
 		obj = NULL;
 	if (obj && obj->id != id)
-- 
2.19.1

