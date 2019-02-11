Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FF96C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0214320838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895219;
	bh=Q12YCwGIfeS5gemNCB97bulDWB7sfDaZY0zamEHVeAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1oyMCYskZ670+nUPniG1aBOSxv/rcoSabURB6FVqwZNpaL5NflDO+nqgnRU2UREHV
	 XDz2TQyNC4vFkupCJ7j4eV1yZnpNrt83VCgmRyRS56ICiV9l1m/Pld5SB+jauKy9/X
	 SD4xiSHV+9Ns7TeEGQRFpUFiFA2yNccYaaONPnSI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729641AbfBKO04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:26:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:60844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbfBKO0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:26:55 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED49D20821;
        Mon, 11 Feb 2019 14:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895214;
        bh=Q12YCwGIfeS5gemNCB97bulDWB7sfDaZY0zamEHVeAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0zIA8D2JqVunKTyKoG8EcncPL11L3z0po9wRkceFYqXLun/ebgf0vOwHsm/B5TCdW
         30dykSdOFUSp5Dx2hAR2rpRSZTXSOZHCzCe4Ohb/nCXELB+RJTePnWMnxOfEqIUSAq
         GPnZ3iVYu0yZ+5fnE3FYH6lGOcihCMtEgHcOQ7cY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 131/352] media: v4l2-device: Link subdevices to their parent devices if available
Date:   Mon, 11 Feb 2019 15:15:58 +0100
Message-Id: <20190211141854.809725511@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ee494cf377e142f65f202fadf0d859f8e12119fb ]

Currently v4l2_device_register_subdev_nodes() does not initialize the
dev_parent field of the video_device structs it creates for subdevices
being registered. This leads to __video_register_device() falling back
to the parent device of associated v4l2_device struct, which often does
not match the physical device the subdevice is registered for.

Due to the problem above, the links between real devices and v4l-subdev
nodes cannot be obtained from sysfs, which might be confusing for the
userspace trying to identify the hardware.

Fix this by initializing the dev_parent field of the video_device struct
with the value of dev field of the v4l2_subdev struct. In case of
subdevices without a parent struct device, the field will be NULL and the
old behavior will be preserved by the semantics of
__video_register_device().

Signed-off-by: Tomasz Figa <tfiga@chromium.org>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/v4l2-core/v4l2-device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/v4l2-core/v4l2-device.c b/drivers/media/v4l2-core/v4l2-device.c
index df0ac38c4050..e0ddb9a52bd1 100644
--- a/drivers/media/v4l2-core/v4l2-device.c
+++ b/drivers/media/v4l2-core/v4l2-device.c
@@ -247,6 +247,7 @@ int v4l2_device_register_subdev_nodes(struct v4l2_device *v4l2_dev)
 
 		video_set_drvdata(vdev, sd);
 		strscpy(vdev->name, sd->name, sizeof(vdev->name));
+		vdev->dev_parent = sd->dev;
 		vdev->v4l2_dev = v4l2_dev;
 		vdev->fops = &v4l2_subdev_fops;
 		vdev->release = v4l2_device_release_subdev_node;
-- 
2.19.1



