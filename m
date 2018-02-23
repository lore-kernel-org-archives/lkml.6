Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751667AbeBWNOL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 08:14:11 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:53451 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751357AbeBWNOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 08:14:09 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>
Cc: Tim Harvey <tharvey@gateworks.com>, Arnd Bergmann <arnd@arndb.de>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: i2c: TDA1997x: add CONFIG_SND dependency
Date: Fri, 23 Feb 2018 14:13:26 +0100
Message-Id: <20180223131356.979530-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:zrvHbK2sTFGTkAIvKrsDUYleDPa99PJXx5BBP3wYpIgl38aaFfa
 2hCS417tNHCVuUhqj/BNtLJrzUG8zZQ9Enfo4e0bT7sf5Qc7N2KabSJt9Hyn8oCyRCNwIQo
 hG0RnTAvZ3rxEQr0Iapgtw+nJ0QIykLMcqK7B/mE9WLh/mAqvdSipLCnImx76I7g0sMdc59
 /WAqUmhGuuOSPrHAbfG2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZSfGUc4PiM4=:H2TLDD97a8ucQRjkY/a4ql
 zpXGFE7wTS42/1kGAtYUSPIsLU9TIv3U1ycQQUUDtfJVuRbmvpJiDa8yubOUiAYnDT5OzsVhk
 KHL+ITljY/92oMKBPqCJd0VHyvbdWGMg9Iz3ZoDxM5LVQbtvQdwtutnoMfHpYiVng3SzvqeUy
 4wCrCvRh4vSmPvBdwcuhrcBeQAb65mp20ULi3EVGFc31mZIHDYbVhPNf+N/aQgyPL+l7StEx7
 olk7PZ7jhYUjtrQLm+sEESGG5CXYARFVsfmpqDb8EjYhezDnVZXAlg6WU309QEOaRZhb5aUph
 dXd1qt0ROpKFWgTO4zTjq1S1zP1PKb3MNbUbv6RV5/RyFIOZvJou7DxeIuM5vlFdCdxu/VeBP
 iDEn+BEgUE30few1Ui3YEGBXliT2gDU4+OHDGwxIfsn3RSxfwYTFIKMKd2In0MGDFqenxE7C8
 pD0rdjQk+GLOjaTfTinEu80ze5P3uCcFjAY34vXK4C62c3nXSuOId/11qza+vV2ujPa3uej1i
 O9pASggF/Funrc/zy6CMV8N9zkb1twsR+tD2xSgK2jcATRbzW6Ea7mCteVOTrmWEnNkG6Zemi
 ycv2ZDG01ohq6sjwZi9Ggpgr+bqNvEFGM81j1WNVMDhzA4MZ8tOlrW4QzsistdiLP1gfxJYlg
 TeOBMfI1u8TcqzNqPLxLPOcRAGjNSX+/1sKkJqUsXO1hRGhFWRreWQ1ut5+AzP1lYfYoIyCJo
 zlCFgmXfwX2rvupC8Z0//ucqm45y36+khpkDIw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without CONFIG_SND, we get a link error:

ERROR: "snd_soc_register_codec" [drivers/media/i2c/tda1997x.ko] undefined!
ERROR: "snd_soc_unregister_codec" [drivers/media/i2c/tda1997x.ko] undefined!
ERROR: "snd_pcm_hw_constraint_minmax" [drivers/media/i2c/tda1997x.ko] undefined!

This adds the same Kconfig dependency that we have in other
media drivers, using 'select SND_PCM' to ensure that we have
can call snd_pcm_hw_constraint_minmax, while depending on
CONFIG_SND_SOC for registering the codec.

Fixes: 9ac0038db9a7 ("media: i2c: Add TDA1997x HDMI receiver driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/media/i2c/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/i2c/Kconfig b/drivers/media/i2c/Kconfig
index 94e32d75d632..a44e8c36f13c 100644
--- a/drivers/media/i2c/Kconfig
+++ b/drivers/media/i2c/Kconfig
@@ -59,6 +59,8 @@ config VIDEO_TDA9840
 config VIDEO_TDA1997X
 	tristate "NXP TDA1997x HDMI receiver"
 	depends on VIDEO_V4L2 && I2C && VIDEO_V4L2_SUBDEV_API
+	depends on SND_SOC
+	select SND_PCM
 	---help---
 	  V4L2 subdevice driver for the NXP TDA1997x HDMI receivers.
 
-- 
2.9.0
