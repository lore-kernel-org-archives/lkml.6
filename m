Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EA5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 21:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC81218E2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 21:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNW2pxx1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbeLZVEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 16:04:39 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42116 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbeLZVEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 16:04:39 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so14696680lja.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 13:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EuxKM+L8goMIZAgnpg5Zp++orBI8BY79job/7famgVo=;
        b=FNW2pxx1bbJN8Bo+34FgP+oMR1Jzq/t3asfRVrPXCBHpIJr29AKQVC3tbgQy9YyHgZ
         5gX3x/xzhOMo1a2JhP/H+nnTEmpHO+CnCr+GNdbanLAppmwqfXj4RUqdlzT2vnYWh7y0
         ppcOFu7wUhmxcZv0A0AS8Vhi6mPAV8T+fNzoqMFG6oaTm51CdwP4xrMZ5HJAC1Tig01Y
         KXpceG8xeaF12C9PLIiLEn00me2xo1LgPKR7sNGDz2cwjCqAcaZQ7+B1hN6iiU8jY1of
         350SZaTh9J17BBDsQtXB7D6PMxW+AP3N+GI3Gl5y4zCpHdWXH4LTKBWEa+cfjsWaReeA
         9EDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=EuxKM+L8goMIZAgnpg5Zp++orBI8BY79job/7famgVo=;
        b=gB+toIBEnwarmd1xOQHKytjHAmg7s5QRmNXYt/hfXkrcauXJbtKb++dPtEsaLl+wTr
         nqSFPC8s/4mE3KbRVZjDsy5mNQkHaLIJKn1PzbWwiNSmxQQH7lYfdDds3Dw/m4+BllBA
         fDsAjhibAQoEz/WFXwFyt4R/263H1pUuvaxZWGBN8c2teDER0+xtNrCMA3kED/MZkA9Z
         X9O1m24jK7cEeLEhJcV59DVhL1mORVKxqVaK01Wg9ZYoWH3UxWmZeLvoyw54kaFcxn2Z
         wvSvwhS0Ml/FL0Bel/ClbvSIsDzFZhktEYdp9DfXG3pZJIY41maGHTXB+wC9regIw611
         fKYg==
X-Gm-Message-State: AJcUukc3jMlwDl6ip5Wk+jRQzWP6M5uUFr4cBpzuD36LdYY2n91JKGJ8
        rffaI++J3f3JkvSQctpzvKs=
X-Google-Smtp-Source: ALg8bN5U/nD1KODcHS70RxFtPxfi8p68K1oKZu6P6glo57RbTqYBkg3hY67OVbYARBWdX6iqAutT3w==
X-Received: by 2002:a2e:8546:: with SMTP id u6-v6mr11827020ljj.95.1545858277083;
        Wed, 26 Dec 2018 13:04:37 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id g70-v6sm7768124ljg.92.2018.12.26.13.04.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 13:04:36 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 2/7] drm: move DRM_SWITCH_POWER defines to drm_device.h
Date:   Wed, 26 Dec 2018 22:03:48 +0100
Message-Id: <20181226210353.13993-2-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20181226210215.GA27610@ravnborg.org>
References: <20181226210215.GA27610@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move DRM_SWITCH_POWER out of drmP.h to allow users
to get rid of the drmP include.

DRM_SWITCH_POWER defines are used in combination
with drm_device.switch_power_state.

Move the DRM_SWITCH_POWER defines to the file where
drm_device.switch_power_state is defined.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 include/drm/drmP.h       | 5 -----
 include/drm/drm_device.h | 9 +++++++++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/drm/drmP.h b/include/drm/drmP.h
index b6b8436b5123..2ba786820052 100644
--- a/include/drm/drmP.h
+++ b/include/drm/drmP.h
@@ -95,11 +95,6 @@ struct dma_buf_attachment;
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
index 42411b3ea0c8..c3da194d25f9 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -24,6 +24,13 @@ struct inode;
 struct pci_dev;
 struct pci_controller;
 
+
+/* Used by drm_device.switch_power_state */
+#define DRM_SWITCH_POWER_ON 0
+#define DRM_SWITCH_POWER_OFF 1
+#define DRM_SWITCH_POWER_CHANGING 2
+#define DRM_SWITCH_POWER_DYNAMIC_OFF 3
+
 /**
  * DRM device structure. This structure represent a complete card that
  * may contain multiple heads.
@@ -222,6 +229,8 @@ struct drm_device {
 	struct idr object_name_idr;
 	struct drm_vma_offset_manager *vma_offset_manager;
 	/*@} */
+
+	/* See DRM_SWITCH_POWER defines */
 	int switch_power_state;
 
 	/**
-- 
2.12.0

