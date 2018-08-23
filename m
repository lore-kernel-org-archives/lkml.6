Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E54C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0056520847
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0056520847
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387877AbeHWM2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:28:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53110 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727293AbeHWM2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:28:03 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C297BC83;
        Thu, 23 Aug 2018 08:59:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 213/324] drm/sun4i: link in front-end code if needed
Date:   Thu, 23 Aug 2018 09:54:39 +0200
Message-Id: <20180823075006.802938974@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 3156b53c2e2fadafa1a16412a8791b38f94b5bdc ]

When the base sun4i DRM driver is built-in but the back-end is
a loadable module, we run into a link error:

drivers/gpu/drm/sun4i/sun4i_drv.o: In function `sun4i_drv_probe':
sun4i_drv.c:(.text+0x60c): undefined reference to `sun4i_frontend_of_table'

The dependency is a bit tricky, the best workaround I have come up
with is to use a Makefile hack to to interpret both
CONFIG_DRM_SUN4I_BACKEND=m and CONFIG_DRM_SUN4I_BACKEND=y
as a directive to build the front-end the same way as the main module.

Fixes: dd0421f47505 ("drm/sun4i: Add a driver for the display frontend")
Link: https://lore.kernel.org/lkml/20180301091908.zcptz3ezqr2c6ly5@flea/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180706142847.2032381-1-arnd@arndb.de
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/sun4i/Makefile |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/sun4i/Makefile
+++ b/drivers/gpu/drm/sun4i/Makefile
@@ -29,7 +29,10 @@ obj-$(CONFIG_DRM_SUN4I)		+= sun4i-tcon.o
 obj-$(CONFIG_DRM_SUN4I)		+= sun4i_tv.o
 obj-$(CONFIG_DRM_SUN4I)		+= sun6i_drc.o
 
-obj-$(CONFIG_DRM_SUN4I_BACKEND)	+= sun4i-backend.o sun4i-frontend.o
+obj-$(CONFIG_DRM_SUN4I_BACKEND)	+= sun4i-backend.o
+ifdef CONFIG_DRM_SUN4I_BACKEND
+obj-$(CONFIG_DRM_SUN4I)		+= sun4i-frontend.o
+endif
 obj-$(CONFIG_DRM_SUN4I_HDMI)	+= sun4i-drm-hdmi.o
 obj-$(CONFIG_DRM_SUN8I_DW_HDMI)	+= sun8i-drm-hdmi.o
 obj-$(CONFIG_DRM_SUN8I_MIXER)	+= sun8i-mixer.o


