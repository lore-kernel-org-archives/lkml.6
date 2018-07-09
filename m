Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA29C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3603820873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3603820873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933563AbeGIPWF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:22:05 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:49825 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932898AbeGIPWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:22:03 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MINPb-1ff0gN1lQF-004B2s; Mon, 09 Jul 2018 17:21:08 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        David Airlie <airlied@linux.ie>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        David Lechner <david@lechnology.com>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/tinydrm: add backlight dependency for ili9341
Date:   Mon,  9 Jul 2018 17:20:29 +0200
Message-Id: <20180709152106.990066-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:SilJmrmec6oMCnQqxN6VDBWQrXHvtUlaR/uBsAR4yW6WuOSR8r/
 fJlrI8+SqRkZAlxI0nM+TcE1RKrUXbQe8DjZkockQCN/es3KkKE+F3hP/KADR/eg9MoKFr3
 3tC1wHU86kIupDnpzGztwC6X0nK+XBF0FlarBUDeLS1nrVIK+A4U6qV9UFUmYCl3RifMQx/
 XjUtuhHX6ihh490h4yA/w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:guVQ+d7IzCg=:Li4ELKm+Sm/R+Bgew7SXyV
 2VBES4RdPILscbfPFLefqFWO19f+XDPhzi/UiddzGED97hWLbWhVvu3HxjYjPBjwtjVauAdfZ
 S94tqIsMmKLW1Gc4rUCpyizbNI2D8HlN6coo74iYBmlRrLfO3UFrN+rVsMvunQMmu6WmT7dkH
 xoCClzEF+MM+i/pgEgcZuV/1D8VLmizA3ZOjxZpdJpG/P732Vtcw0S7XjlXapf+KsFd1KG6sp
 ORgh9UStm9hPlU4MfcMTJL+k+0aUOSdBetLgp+vJmgZeoH0HW3N+LDvd/buSVrc2ThN/+PUbN
 vxh8ggVsy3YJEghspZ1F87wxbPOGnXcijovXHihES3x/9+d8bhAy8cEw2B6dZ3ezG2Z86N/C/
 WlIqVWflBrKrb9EmYZqTHEfzK2ELmO9Br3cQ6k869vfCsPKzTLybLpdBhWOYH/WB0TjXFYuKP
 BAkuXV+scvc1h9t7cMP7MX+zV60B+5zI/xd9zMIzMLxgtJFYQ/gdvIkfc3tuxMLJXPvlBgCzF
 oIB00158B8LFD+aA48O4K5in5WX33FQYhE9iwfKtyAM4eDpF9wySIH0wxFDJh6pWxyGFwPMVI
 f94ZvaredE4npJ8WDZFZvWFU6B+SyjvifQmQeKHctdPtZgcgpW+f1B1a/T8AsZkIfSDrAI7qR
 LU377nzsoE8glAXTUYLBKlNiIQyq0wQ/N3Js0Y3/E1uERDvSeLmiaxxiHZMtpsQoct0s=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This tinydrm driver fails to link without the backlight support:

drivers/gpu/drm/tinydrm/ili9341.o: In function `ili9341_probe':
ili9341.c:(.text+0x578): undefined reference to `devm_of_find_backlight'

Fixes: 3fa0e8f6f960 ("drm/tinydrm: new driver for ILI9341 display panels")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/tinydrm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tinydrm/Kconfig b/drivers/gpu/drm/tinydrm/Kconfig
index 7a8008b0783f..16f4b5c91f1b 100644
--- a/drivers/gpu/drm/tinydrm/Kconfig
+++ b/drivers/gpu/drm/tinydrm/Kconfig
@@ -23,6 +23,7 @@ config TINYDRM_ILI9225
 config TINYDRM_ILI9341
 	tristate "DRM support for ILI9341 display panels"
 	depends on DRM_TINYDRM && SPI
+	depends on BACKLIGHT_CLASS_DEVICE
 	select TINYDRM_MIPI_DBI
 	help
 	  DRM driver for the following Ilitek ILI9341 panels:
-- 
2.9.0

