Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932510AbeCIRts (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 12:49:48 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46055 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932342AbeCIRtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 12:49:45 -0500
X-Google-Smtp-Source: AG47ELsqlUkGckamVrNhiPyZn+rCQA/vY4F6yfIvFg0cJyfHk5SZUOrZajNWX5LDRj61wUixxCOodQ==
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-media@vger.kernel.org
Cc: kernel@collabora.com, Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Shuah Khan <shuahkh@osg.samsung.com>, Pawel Osciak <pawel@osciak.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Brian Starkey <brian.starkey@arm.com>, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>
Subject: [PATCH v8 02/13] [media] hackrf: group device capabilities
Date: Fri,  9 Mar 2018 14:49:09 -0300
Message-Id: <20180309174920.22373-3-gustavo@padovan.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180309174920.22373-1-gustavo@padovan.org>
References: <20180309174920.22373-1-gustavo@padovan.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gustavo Padovan <gustavo.padovan@collabora.com>

Instead of putting V4L2_CAP_STREAMING and V4L2_CAP_READWRITE
everywhere, set device_caps earlier with these values.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
---
 drivers/media/usb/hackrf/hackrf.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/media/usb/hackrf/hackrf.c b/drivers/media/usb/hackrf/hackrf.c
index 7eb53517a82f..6d692fb3e8dd 100644
--- a/drivers/media/usb/hackrf/hackrf.c
+++ b/drivers/media/usb/hackrf/hackrf.c
@@ -909,18 +909,15 @@ static int hackrf_querycap(struct file *file, void *fh,
 
 	dev_dbg(&intf->dev, "\n");
 
+	cap->device_caps = V4L2_CAP_STREAMING | V4L2_CAP_READWRITE;
 	if (vdev->vfl_dir == VFL_DIR_RX)
-		cap->device_caps = V4L2_CAP_SDR_CAPTURE | V4L2_CAP_TUNER |
-				   V4L2_CAP_STREAMING | V4L2_CAP_READWRITE;
-
+		cap->device_caps |= V4L2_CAP_SDR_CAPTURE | V4L2_CAP_TUNER;
 	else
-		cap->device_caps = V4L2_CAP_SDR_OUTPUT | V4L2_CAP_MODULATOR |
-				   V4L2_CAP_STREAMING | V4L2_CAP_READWRITE;
+		cap->device_caps |= V4L2_CAP_SDR_OUTPUT | V4L2_CAP_MODULATOR;
 
 	cap->capabilities = V4L2_CAP_SDR_CAPTURE | V4L2_CAP_TUNER |
 			    V4L2_CAP_SDR_OUTPUT | V4L2_CAP_MODULATOR |
-			    V4L2_CAP_STREAMING | V4L2_CAP_READWRITE |
-			    V4L2_CAP_DEVICE_CAPS;
+			    V4L2_CAP_DEVICE_CAPS | cap->device_caps;
 	strlcpy(cap->driver, KBUILD_MODNAME, sizeof(cap->driver));
 	strlcpy(cap->card, dev->rx_vdev.name, sizeof(cap->card));
 	usb_make_path(dev->udev, cap->bus_info, sizeof(cap->bus_info));
-- 
2.14.3
