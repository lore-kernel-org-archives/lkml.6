Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16681C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA61C20866
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWKjMVIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbeL3RtA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 12:49:00 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32994 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeL3RtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 12:49:00 -0500
Received: by mail-lj1-f194.google.com with SMTP id v1-v6so22372127ljd.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 09:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=1EW5bqcaQm1NMvxmOz0PFniZvfEVPaRGaH3Xynt21bo=;
        b=JWKjMVIhHOwoVTF1Y6gW2kaegIxqQP7gD8Cv0J15FyX26ysC8qGIzg7dk84HRCYwKG
         EKKaoAwC66+gyzqZ7VbBYNeHkP/yNtsev2T+pHEfbu0dWcU/b6Lb7+PI3/idDkPFLF2B
         ri1Uh0jEy56uTT9oumZTUwcrDOFa6vinhHPpSyse9Rtl1RCsXe0Fpj3GTlUypHta10Mc
         bADcZhxtZfjaogl/RmwbhfHaPh0SckDRtxC+nzELno6WyvZYPQYb/ioqc0+/epWJCBSC
         KP1NftOlEYQ84dcDR73Gm379R2DGu/eziQJ0xC5PFvpEjZf4lgacCNvSPVPKvulCePHS
         YJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=1EW5bqcaQm1NMvxmOz0PFniZvfEVPaRGaH3Xynt21bo=;
        b=uVzRg2IzrpA8LM6d7LwnTih/ekCrFBoYkSDmINbZqLIw+T4Q+X2a+FsP+c1sFjWToM
         LRZHUyydFxkAf0gcBNK2jkr9Jt2enHAesWgMQ7hd1bdFtrS2hEAX3ONLI0D+a7sPlScD
         bzAstwC63Y/3cOVr44vH9l+dT6j05AaLjvTnLiS3d2XkeyyQUxFTPCwZwqs54XJSNJeF
         jXjlhk3LZSYqNOYuCI6YNS/19EMQdlkvlpK89RECDfsM/HfBLiXTsQuV8yLC/YdHKqXR
         iuZsSoC3Oed4qJIqbP5F6Va0gVQwTZUESfcDNUADfCBwdDnk6X3qpTNJkfDeDInK6qvV
         LiLA==
X-Gm-Message-State: AJcUukdqAbvOowrTafaiiAY9xx5zrnp5JtgCJ9Bni4KFuUNB5oSKqNa0
        lLQgt1kZisMCzQGM+xVbfBc=
X-Google-Smtp-Source: ALg8bN4m5t8Vq+AewAUVSqCuQ80HdMYKfMnGKFyLtc0hC2JSOSq2q+23lrFVrhayO7W+44WUvfvlhA==
X-Received: by 2002:a2e:3e04:: with SMTP id l4-v6mr19100068lja.148.1546192137849;
        Sun, 30 Dec 2018 09:48:57 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id q11sm8853170lfc.92.2018.12.30.09.48.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 09:48:57 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH v2 01/14] drm: move DRM_IF_VERSION to drm_internal.h
Date:   Sun, 30 Dec 2018 18:48:25 +0100
Message-Id: <20181230174838.32330-2-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move DRM_IF_VERSION out of drmP.h to allow users
to get rid of the drmP include.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20181226210353.13993-1-sam@ravnborg.org
---
 drivers/gpu/drm/drm_internal.h | 2 ++
 include/drm/drmP.h             | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
index c7a7d7ce5d1c..331112b2ae88 100644
--- a/drivers/gpu/drm/drm_internal.h
+++ b/drivers/gpu/drm/drm_internal.h
@@ -26,6 +26,8 @@
 #define DRM_IF_MAJOR 1
 #define DRM_IF_MINOR 4
 
+#define DRM_IF_VERSION(maj, min) (maj << 16 | min)
+
 struct drm_prime_file_private;
 struct dma_buf;
 
diff --git a/include/drm/drmP.h b/include/drm/drmP.h
index bdb0d5548f39..db94ef00940e 100644
--- a/include/drm/drmP.h
+++ b/include/drm/drmP.h
@@ -94,8 +94,6 @@ struct dma_buf_attachment;
 struct pci_dev;
 struct pci_controller;
 
-#define DRM_IF_VERSION(maj, min) (maj << 16 | min)
-
 #define DRM_SWITCH_POWER_ON 0
 #define DRM_SWITCH_POWER_OFF 1
 #define DRM_SWITCH_POWER_CHANGING 2
-- 
2.12.0

