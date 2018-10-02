Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB2CC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F35206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F35206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbeJBULF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:11:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60478 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbeJBULE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:11:04 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DB304B2F;
        Tue,  2 Oct 2018 13:27:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 071/228] media: ov772x: add checks for register read errors
Date:   Tue,  2 Oct 2018 06:22:48 -0700
Message-Id: <20181002132504.114038206@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Akinobu Mita <akinobu.mita@gmail.com>

[ Upstream commit 30f3b17eaf4913e9e56be15915ce57aae69db701 ]

This change adds checks for register read errors and returns correct
error code.

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans Verkuil <hans.verkuil@cisco.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/ov772x.c |   20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

--- a/drivers/media/i2c/ov772x.c
+++ b/drivers/media/i2c/ov772x.c
@@ -1136,7 +1136,7 @@ static int ov772x_set_fmt(struct v4l2_su
 static int ov772x_video_probe(struct ov772x_priv *priv)
 {
 	struct i2c_client  *client = v4l2_get_subdevdata(&priv->subdev);
-	u8                  pid, ver;
+	int		    pid, ver, midh, midl;
 	const char         *devname;
 	int		    ret;
 
@@ -1146,7 +1146,11 @@ static int ov772x_video_probe(struct ov7
 
 	/* Check and show product ID and manufacturer ID. */
 	pid = ov772x_read(client, PID);
+	if (pid < 0)
+		return pid;
 	ver = ov772x_read(client, VER);
+	if (ver < 0)
+		return ver;
 
 	switch (VERSION(pid, ver)) {
 	case OV7720:
@@ -1162,13 +1166,17 @@ static int ov772x_video_probe(struct ov7
 		goto done;
 	}
 
+	midh = ov772x_read(client, MIDH);
+	if (midh < 0)
+		return midh;
+	midl = ov772x_read(client, MIDL);
+	if (midl < 0)
+		return midl;
+
 	dev_info(&client->dev,
 		 "%s Product ID %0x:%0x Manufacturer ID %x:%x\n",
-		 devname,
-		 pid,
-		 ver,
-		 ov772x_read(client, MIDH),
-		 ov772x_read(client, MIDL));
+		 devname, pid, ver, midh, midl);
+
 	ret = v4l2_ctrl_handler_setup(&priv->hdl);
 
 done:


