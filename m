Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1219C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACDB121907
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 23:28:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MpaFc4XH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfBGX2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 18:28:22 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36010 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfBGX2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 18:28:10 -0500
Received: by mail-ed1-f67.google.com with SMTP id d12so1339650edy.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 15:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+HG60zShCoHZ92dPA33wq6HlorvfHtvDV7Yrof+DOvQ=;
        b=MpaFc4XH9XKIvDbSQ9PpthHVHvRsJcnYhOATGV1soMyGOb2tw/IIqx+x36AP/8gNKr
         BwszuYke4LPrnL4Ip+6m4MRrCRbwlRs4SDH7MYD1zw3HAlg31y3tndX0xcRjsq62w9Vl
         tnVXsPJIqNou8LjKvEjWnV2kv0gBpVZx7KLq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+HG60zShCoHZ92dPA33wq6HlorvfHtvDV7Yrof+DOvQ=;
        b=ZsdtHqzWmpeOT2aBhXGsEZjLt3nrI5dVCT1wnw4AE1cKS3dErMGbtVSCu41lPVMEUn
         fQwhn1MsnL7aieJQaZVK4EEedrPh6w8lYC+L7kkK4/7427qat5zgOFpCIPWGRJXzItGK
         pHo642+gH13v8GCW4FF2r/QcSwbeYAr0lhxYLXG+z2K41F3VPNt6isHDsB2O5V3YOAKX
         vIkMPzh97vbKLL8HBHhbkGs7fG+cEklA/b+HhZHbIn4HM1twee2V2vY20YEzvVasOllk
         +d31G5cz7i3rTKdtAncv9hdAa12V39xXodRXUBXAqkill2fimdtqj7CereAHv2e8crox
         DPkw==
X-Gm-Message-State: AHQUAua5rGKBr6SN12niDmF62WkmnIFW86ni/f4td8sCmADYQss7PJdm
        nIdXvceqcPSuqR4if7baYyG2OA==
X-Google-Smtp-Source: AHgI3IbQg91HVTfrfcmk1g5/bgahAC4gX1OBQwNIMfwDIyJ1nC59zIqCtBQkXNAxyJoaVBDLiErNBQ==
X-Received: by 2002:a17:906:4344:: with SMTP id z4mr13366580ejm.27.1549582088484;
        Thu, 07 Feb 2019 15:28:08 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id p7sm145079ejb.15.2019.02.07.15.28.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 15:28:07 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 3/4] drm/doc: document recommended component helper usage
Date:   Fri,  8 Feb 2019 00:27:58 +0100
Message-Id: <20190207232759.14553-3-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207232759.14553-1-daniel.vetter@ffwll.ch>
References: <20190207232759.14553-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that component has docs it's worth spending a few words and
hyperlinks on recommended best practices in drm.

Cc: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 Documentation/driver-api/component.rst |  2 ++
 Documentation/gpu/drm-internals.rst    |  5 +++++
 drivers/gpu/drm/drm_drv.c              | 14 ++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/Documentation/driver-api/component.rst b/Documentation/driver-api/component.rst
index 2da4a8f20607..57e37590733f 100644
--- a/Documentation/driver-api/component.rst
+++ b/Documentation/driver-api/component.rst
@@ -1,3 +1,5 @@
+.. _component:
+
 ======================================
 Component Helper for Aggregate Drivers
 ======================================
diff --git a/Documentation/gpu/drm-internals.rst b/Documentation/gpu/drm-internals.rst
index 3ae23a5454ac..966bd2d9f0cc 100644
--- a/Documentation/gpu/drm-internals.rst
+++ b/Documentation/gpu/drm-internals.rst
@@ -93,6 +93,11 @@ Device Instance and Driver Handling
 Driver Load
 -----------
 
+Component Helper Usage
+~~~~~~~~~~~~~~~~~~~~~~
+
+.. kernel-doc:: drivers/gpu/drm/drm_drv.c
+   :doc: component helper usage recommendations
 
 IRQ Helper Library
 ~~~~~~~~~~~~~~~~~~
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 381581b01d48..aae413003705 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -456,6 +456,20 @@ static void drm_fs_inode_free(struct inode *inode)
 	}
 }
 
+/**
+ * DOC: component helper usage recommendations
+ *
+ * DRM drivers that drive hardware where a logical device consists of a pile of
+ * independent hardware blocks are recommended to use the :ref:`component helper
+ * library<component>`. The entire device initialization procedure should be run
+ * from the &component_master_ops.master_bind callback, starting with
+ * drm_dev_init(), then binding all components with component_bind_all() and
+ * finishing with drm_dev_register(). For consistency and easier sharing of
+ * components across drivers the opaque pointer passed to all components through
+ * component_bind_all() should point at &struct drm_device of the device
+ * instance, not some driver specific private structure.
+ */
+
 /**
  * drm_dev_init - Initialise new DRM device
  * @dev: DRM device
-- 
2.20.1

