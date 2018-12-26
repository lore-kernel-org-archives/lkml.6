Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_RHS_DOB,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524B4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 21:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D306218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 21:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hScjKh9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbeLZVE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 16:04:29 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34437 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbeLZVE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 16:04:28 -0500
Received: by mail-lj1-f194.google.com with SMTP id u89-v6so14747459lje.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 13:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fsBXqBJslNWkzB2GNJjcUo4JaMGhgeRfhXO3VU4naB8=;
        b=hScjKh9uAjRfup0H0D0mEHn71lu0ZoxXWCZda8MFKdIP8j69b8PHz4W/DCQQZaawmV
         299fL+0Fqzrtwwt5SeNv2OG2EKpFMT3stGWzzkYNNl26M54JUgvdAOJC66NqPryMGOog
         mCBbc3Yj0WKJ1SoA+2GhB2nJSvRCwGHVohg+QPEo3e5XsOEObQyw1u4CkqI69l3WwwLU
         KJGGUmzXN0JD0GLOhqjPrzdLNJD3bR3V1z9tVBqF5mrCK386xTX8y6ykhqvo7xObOfs5
         fWrJ/YfapJ8xPrp6oejFuyPvAroPtgSMPtY1ZtA1z7tnpa+3DFn3x0FiFqnQCwLhQ534
         ssbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=fsBXqBJslNWkzB2GNJjcUo4JaMGhgeRfhXO3VU4naB8=;
        b=N8fcrofjC3DHIDrs0WKSlJy98f5ciagKNBwamxP52j1UPlCXUQ8T+fSfEIpbgdrpwx
         E67gv9pDCR9otMT2SOL8IL4irY01JdrzOZHIXUB8eEKcP+p7ZvETit2BfiPqfXuERvuI
         h2xOzrcncjqTb/BiWxEZ+PQ8L5VAbSvcjDQ7bhBscNXgJlfZd8dDg4s4FoyNAgpYkWRS
         oP3Gai/Yo2TyOZ+tvwUBidoOnq+05BY658xRiz9EWhz+IXFi+S79ICz+23G55U9ybrtL
         aw1/Tk6S0ZKs87fBEOj90qipi2QtMP1rJ4GP3VZpI75g5i/xk88Qjw1XWYLLT1XLndHt
         DRDg==
X-Gm-Message-State: AA+aEWbqsY7b2lw2UVSYafrRDN2eCoh+41mCjMJzPyvjAcxnojvLzJw3
        G9W+Yt7dYJ6QKemL9PFckgo=
X-Google-Smtp-Source: ALg8bN4yml4ed1qAq/TfUTPtm9zNNvW3xbitMYSNuZVMYVsiPAlLPzzmCWJsiLo36aegdBDfnNTdmg==
X-Received: by 2002:a2e:92:: with SMTP id e18-v6mr13328539lji.130.1545858266294;
        Wed, 26 Dec 2018 13:04:26 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id g70-v6sm7768124ljg.92.2018.12.26.13.04.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 13:04:25 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 1/7] drm: move DRM_IF_VERSION to drm_internal.h
Date:   Wed, 26 Dec 2018 22:03:47 +0100
Message-Id: <20181226210353.13993-1-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20181226210215.GA27610@ravnborg.org>
References: <20181226210215.GA27610@ravnborg.org>
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
---
 drivers/gpu/drm/drm_internal.h | 2 ++
 include/drm/drmP.h             | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
index 51e06defc8d8..e9374cd43610 100644
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
index 05350424a4d3..b6b8436b5123 100644
--- a/include/drm/drmP.h
+++ b/include/drm/drmP.h
@@ -95,8 +95,6 @@ struct dma_buf_attachment;
 struct pci_dev;
 struct pci_controller;
 
-#define DRM_IF_VERSION(maj, min) (maj << 16 | min)
-
 #define DRM_SWITCH_POWER_ON 0
 #define DRM_SWITCH_POWER_OFF 1
 #define DRM_SWITCH_POWER_CHANGING 2
-- 
2.12.0

