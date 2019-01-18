Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B0AC5AC81
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C910520823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISDp5SI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbfARRaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:30:03 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40606 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbfARRaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:30:02 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so16018076wrt.7;
        Fri, 18 Jan 2019 09:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PyVbBL0mW/TEEmZTs3dNnnVQ8377kJ8dXSHGfjBfTsw=;
        b=ISDp5SI1SSCrWv+tDcrCIzP+rHmaCzMDquTSb0GXJv3wst91aagvvh8cI6S/TbeQCF
         lYusuqIoFpZoUaOjcQCa/hKqkkrPpcv0iSLX1wCCE2HE8vY7csgsyMc+OymLbkMuqG1r
         M31sarRASwFmcQDHjgZugWWGaFf9Jnxm9rS1240Tz9hRZLEEav29Laj9zeWKHnEHINXO
         ByOjEu9LDNmqaZH74IXZhiM7LpAvUUaNWdGXr0sUJt0oON142yNM6Fk4JYwp9EJ09/DV
         qMDVsWTXfQi7/256WumO8gxsuAhTUGUQfv9DtRQO0cyp4C0OC0GDqVWJOhggiX/v5vfV
         kLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PyVbBL0mW/TEEmZTs3dNnnVQ8377kJ8dXSHGfjBfTsw=;
        b=eA06WFVqHv1RfHfPxGjwQ/ksbF3zPHyIjAdMRI7a7wqiddD8yUk54lzX05Z1Y8ddnB
         kLYprUuvUNWwXEhG2gYfxp1u43ElctZ8c6lvuGAq50Nh3wfsBJ041axErTOpwUbODvdG
         1j10yKqOOMMzjSOzOqIIUiEiV7Fx1N/R+5V+hw+D2C4bMrSzTBVk48lwo6k/jXLEiUnZ
         SFV2+8E0nWNdVnzwhqWM6u30LqD7p9dwfHCxsblhP9UpPhMmOvKM1u7Q+Aqnmup3+B+B
         29CKYSHhwk8nVTHprjFw8MfizfO4yOcuHzXAyS9vSxPqm/KPwqqpSmkFBrrPSXZBQFut
         Chxg==
X-Gm-Message-State: AJcUukcbqTqQ1CMeqKBAuLWZ5vP4TT9bKW9mMxrj6qQLrFNJ1OlB+cNu
        qJ9QVCTKkJ1TyBDktN4+1ntrGyCw1Z0=
X-Google-Smtp-Source: ALg8bN5/hHDTMAhOglw/OFlDM/U8DvA9/GZLtA+kCKmkaN0XVS4YvvZyho26EfzpmjA+a4UtHmBy5g==
X-Received: by 2002:a5d:558a:: with SMTP id i10mr16849438wrv.287.1547832099666;
        Fri, 18 Jan 2019 09:21:39 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id c13sm94318861wrb.38.2019.01.18.09.21.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 09:21:38 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm: rcar-du: Fix build error
Date:   Fri, 18 Jan 2019 10:21:25 -0700
Message-Id: <20190118172125.32504-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On arm{32,64} allyesconfig builds:

drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c:40:1: error: incomplete result type 'enum drm_mode_status' in function definition
drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c:47:10: error: incomplete definition of type 'struct drm_display_mode'
drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c:48:10: error: use of undeclared identifier 'MODE_CLOCK_HIGH'
drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c:50:9: error: use of undeclared identifier 'MODE_OK'

After the removal of drmP.h from this file and its removal from
bridge/dw_hdmi.h, these types are not defined anymore, as they
were implicitly coming into that file through drm_crtc.h.

Fixes: 428747ae5cca ("drm: remove include of drmP.h from bridge/dw_hdmi.h")
Fixes: 9a47db8e7a9d ("drm: rcar-du: Remove inclusion of drmP.h")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c b/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c
index 0fb25113f19c..452461dc96f2 100644
--- a/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c
+++ b/drivers/gpu/drm/rcar-du/rcar_dw_hdmi.c
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 
 #include <drm/bridge/dw_hdmi.h>
+#include <drm/drm_modes.h>
 
 #define RCAR_HDMI_PHY_OPMODE_PLLCFG	0x06	/* Mode of operation and PLL dividers */
 #define RCAR_HDMI_PHY_PLLCURRGMPCTRL	0x10	/* PLL current and Gmp (conductance) */
-- 
2.20.1

