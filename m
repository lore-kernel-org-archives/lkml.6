Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C111CC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854B523F44
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 854B523F44
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932984AbeGFO3Q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:29:16 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:36026 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932352AbeGFO3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:29:15 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue003 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MDCnY-1fKsnO38oO-00GcH9; Fri, 06 Jul 2018 16:28:50 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonathan Liu <net147@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] drm/sun4i: link in front-end code if needed
Date:   Fri,  6 Jul 2018 16:28:28 +0200
Message-Id: <20180706142847.2032381-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:fCaH8MbrLFLFzY6/9NThH6GI7c9wvj1lmRUnFVz5arfs/O0ZERD
 0CnelIfcFumZX9Qh8D9k8AflLdgtG3CZxZf/nNBWJMWqqMsx2mNdtEM6Pe04RS/I5cT45PZ
 4585G7Uz292oK49AEHFOGwp1zEnC4Z4kNwSF6CUVTxvxpuxkgj0wLZ/sjHkH2Dz0LE93InJ
 oMPaVKE89OGgQKOu9E9Kg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UvFfUBKP+Fc=:fLa48AGu0FlVChJ/1G97mk
 jd80hOB54JVw7Hde6kjlGYNjCUNreeqXvZ5KEIHFWUNuAQhiOF8L9l4C832J3m0ZGtbwE2Fst
 ZzEWiRF1KGBOnKA0xiwPjSPX5HUL7Er2y2AXrZsByi/6sVLp6rJioCIpdXcb1KEQj+LBFKIgR
 RzXmzjdNlTD2YzIRU4GimMjgwy3ewUk6B3xGIHZysJ9GbmHtsFSd0CGDJnxKWmoC5oTMQ/Qwz
 JUBhIBKRzvQjQD5hFgsR5OgIuzuAm2br5JXgGiQv0pjMcPgRs8lJ+kaGFeT+8gwLwcBEc/2U4
 EbaWK7oYtB9B7Z6B0M1eA1TuLFvcr3o/f3KwFdwPrN9yhOyq8IRIm7wWn0rvqFK1vTRuo1PS9
 kZcNAn5G7nh5AVkAz5caYa+m7TI6+Z1TIShoqg941ce911l8fbspZRznnyu4Fd4GLIZU/F3zJ
 hOApEj0U/Mvw2iWvTmEWqDfO8HU4Fsj118UjEwsWq05UfzSqJ2DEr56VCIzP80mvttuMHhw9l
 QjfmWQDmRNu+Y32YuheKTUjkB5OjjSYo1LtwLupKqx/g0bcU4H0A+rBdypE5gTNy/xmx2m1wD
 6e8kHwY4kjYncSmlN1cxXJvEUDto3k+URkiIRPcP2HQu6U9MMT5lEANK+2NP2YxKk6PEI+wgJ
 Qnrn39dGq+0jNCwYVvKU3+Y8i63lCC4zPm07ecQXewtwpeQBv+EchlwP3vu2U7/QTyrQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
I stumbled over this one again when I sent a related patch.
---
 drivers/gpu/drm/sun4i/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
index 3daed14941ca..11de3cd52dae 100644
--- a/drivers/gpu/drm/sun4i/Makefile
+++ b/drivers/gpu/drm/sun4i/Makefile
@@ -32,7 +32,10 @@ obj-$(CONFIG_DRM_SUN4I)		+= sun4i-tcon.o
 obj-$(CONFIG_DRM_SUN4I)		+= sun4i_tv.o
 obj-$(CONFIG_DRM_SUN4I)		+= sun6i_drc.o
 
-obj-$(CONFIG_DRM_SUN4I_BACKEND)	+= sun4i-backend.o sun4i-frontend.o
+obj-$(CONFIG_DRM_SUN4I_BACKEND)	+= sun4i-backend.o
+ifdef CONFIG_DRM_SUN4I_BACKEND
+obj-$(CONFIG_DRM_SUN4I)		+= sun4i-frontend.o
+endif
 obj-$(CONFIG_DRM_SUN4I_HDMI)	+= sun4i-drm-hdmi.o
 obj-$(CONFIG_DRM_SUN6I_DSI)	+= sun6i-dsi.o
 obj-$(CONFIG_DRM_SUN8I_DW_HDMI)	+= sun8i-drm-hdmi.o
-- 
2.9.0

