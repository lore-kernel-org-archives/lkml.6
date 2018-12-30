Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA6AC43444
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD3020866
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 17:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OgrBTG3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbeL3RtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 12:49:15 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39084 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbeL3RtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 12:49:13 -0500
Received: by mail-lj1-f194.google.com with SMTP id t9-v6so22357909ljh.6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 09:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=mx+2cToZAbWgb7Sp+NmdMQzw1NNIlpQ3WHFBDn62o0E=;
        b=OgrBTG3n0PwLA8sLJzhh/CSP6loZMlBfxKa2ijQ2qiwzauy1X5o51npVHWpXMVpRRY
         ogchDWuBaJGznKIRhxlxM75xeQnMXVUEjNxLyvivvvZULbGayjGz64IiExRdCkVLrNA1
         SERbvDBJlDufG+IRkqIoCSFlp9pQKzps19SHMc9A4OvSVutZYTjilzeoeWPtQ07+SBtD
         edTrNv23XoRwBPessqwX7CM4E5c/xD0FTXmO9S5zNKSGMNNdVS6D0iasUOsSuGzxbfDw
         3sOYesn9FyenvB8Sc4+aIEB9WI7sZU/K8knM3nTujDXrA1lDQtsiE1A9mOU//EGHi9vd
         PPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=mx+2cToZAbWgb7Sp+NmdMQzw1NNIlpQ3WHFBDn62o0E=;
        b=tsclBZRn4gHlJomdcpCRDLQI4Slu58C1dHHqu2iGn+kzi3jA4ESLG5hejJzpBSFgne
         nEuGu2CT7zjvjRAEqkYdYiROxiGuwrt2iTKAr1KBhm4WElAptbC0NE/vWEfqlcLfmwWN
         ynyClSXfECBVz3guc/0GgR0O/cVP/FRxmClpvgQF1Qar3e2abfAcZ07lyrw2sIK/LBku
         tNovolTpGZwqe+t6cFRW2wZYIAyF/pvz0nzFLUq5xBYVjWCqHZOkxc/iKacGMedkMNVd
         kwNtf4KpEQ8Mah/CEcB9gKZod48GpmwnL6W1j1Wb+wQ+NKnevHf6+rAVGTr2cO5LY2Qw
         d+JA==
X-Gm-Message-State: AJcUukfLuQuyc9UIPH2Z7jU763Hp1Dvr79nx0OdNChjRBnccAkUXcehX
        5AzTUk7INPZTT101wrIZE3M=
X-Google-Smtp-Source: ALg8bN5gmRGKe6W1sGYDhls0+Olomo4ME4BYQrUyyA1i0eptmOqUgLt0nUkgYUq2Y7Tzn201mHQJDQ==
X-Received: by 2002:a2e:5054:: with SMTP id v20-v6mr19939949ljd.45.1546192151486;
        Sun, 30 Dec 2018 09:49:11 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id q11sm8853170lfc.92.2018.12.30.09.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Dec 2018 09:49:11 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v2 14/14] drm: remove drmP.h from drm_gem_cma_helper.h
Date:   Sun, 30 Dec 2018 18:48:38 +0100
Message-Id: <20181230174838.32330-15-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With all dependencies fixed we can now remove
drmP.h from drm_gem_cma_helper.h.
It is replaced by the include files required,
or forward declarations as appropritate.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Sean Paul <sean@poorly.run>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 include/drm/drm_gem_cma_helper.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/drm/drm_gem_cma_helper.h b/include/drm/drm_gem_cma_helper.h
index 07c504940ba1..947ac95eb24a 100644
--- a/include/drm/drm_gem_cma_helper.h
+++ b/include/drm/drm_gem_cma_helper.h
@@ -2,9 +2,12 @@
 #ifndef __DRM_GEM_CMA_HELPER_H__
 #define __DRM_GEM_CMA_HELPER_H__
 
-#include <drm/drmP.h>
+#include <drm/drm_file.h>
+#include <drm/drm_ioctl.h>
 #include <drm/drm_gem.h>
 
+struct drm_mode_create_dumb;
+
 /**
  * struct drm_gem_cma_object - GEM object backed by CMA memory allocations
  * @base: base GEM object
-- 
2.12.0

