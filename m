Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AF6C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F21208AE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 19:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ha/G46Bs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F21208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbeI3CYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 22:24:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41876 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbeI3CYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 22:24:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id m77-v6so6495726pfi.8;
        Sat, 29 Sep 2018 12:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gaWEwfdxCeE5LcfSqhDthv1uikrxw4vxlpf1btQOKr0=;
        b=Ha/G46BsYW1kebfdiOqa28uu7diyuojYfXPAF0TDMp1tmfQfKnln1pOkBeJ5eV+yoX
         LXtMWH/lbBcHpEcuKzuaIMiutsnJbynyxnL6q9YvSnJLNwPi0TWdapdYjRIZyw5b0c79
         9Poek9DUa/NPdoaQ5aFTQRPplEtLcltX7CS8xWQielB3l4toYvrUdY+CMaqjDapppj9K
         gx/ds26A4V7grHl1ikg6/KDxcYWYsygBq/A5fheOyJXdUe9rR392D35E+kWseHwIOqXy
         pU0N6Y1nJViGis/c6c3xzYw0S+ef6jnTD3bLQXjFjWiLNKalrMhjlEw8s2JtfN+9iYTO
         8+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gaWEwfdxCeE5LcfSqhDthv1uikrxw4vxlpf1btQOKr0=;
        b=XvSwrgaj3vmKYVswjhGnQbC5oOnOYV+Sp54nHhWHFwJEG2q72EtY35BV3U750SCOVN
         GOOKAbtBHDydPwpolFDw498dsyoyO+XpmPHSYyCnh867uNjASkpFYY4BbxNTl63yGUDI
         OmJSQZqRJ5zva+cnLI/dokg5rgsEWnDd1N/N14E1A8NC7o7t0hGxcA5MajTBxYMeUv3F
         GiW6A1Gnc7jprHuyufGdZitrpmIzGbs3HmtTn1nPdCH6E/XskOxV+/hnRyP0FKbB3Zt0
         xNFHXIacrGek2a48/Lm7aMQLuBxwDMX1ucJ+WWnmbD4bJ+6rsKRNskGcyHlcHopZ0xtL
         PX2A==
X-Gm-Message-State: ABuFfohO9/v4gIXy7yTJTIvYPnVTmYqDnNgjuHVHLkbtP4BhohfytjOF
        W3qibCJ1SnsjQNULysPJc9/pOFBM
X-Google-Smtp-Source: ACcGV62qfkERD9fSfHJbF95y/XABo14tdgbEPsPE1dHCk9ra3bO7dmBh6FSKCCCPoYKfqhQVQ3YJ5Q==
X-Received: by 2002:aa7:8594:: with SMTP id w20-v6mr4319242pfn.77.1538250894800;
        Sat, 29 Sep 2018 12:54:54 -0700 (PDT)
Received: from mappy.world.mentorg.com (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.gmail.com with ESMTPSA id b126-v6sm18371946pga.49.2018.09.29.12.54.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 12:54:53 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [RESEND PATCH v7 07/17] media: platform: video-mux: Register a subdev notifier
Date:   Sat, 29 Sep 2018 12:54:10 -0700
Message-Id: <20180929195420.28579-8-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180929195420.28579-1-slongerbeam@gmail.com>
References: <20180929195420.28579-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse neighbor remote devices on the video muxes input ports, add them to a
subdev notifier, and register the subdev notifier for the video mux, by
calling v4l2_async_register_fwnode_subdev().

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
Changes since v6:
- none
Changes since v5:
- add missing select V4L2_FWNODE to Kconfig for VIDEO_MUX
Changes since v4:
- none
Changes since v3:
- pass num_pads - 1 (num_input_pads) to video_mux_async_register().
Changes since v2:
- none
Changes since v1:
- add #include <linux/slab.h> for kcalloc() declaration.
---
 drivers/media/platform/Kconfig     |  1 +
 drivers/media/platform/video-mux.c | 36 +++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
index f6275874ec9e..0edacfb01f3a 100644
--- a/drivers/media/platform/Kconfig
+++ b/drivers/media/platform/Kconfig
@@ -58,6 +58,7 @@ config VIDEO_MUX
 	select MULTIPLEXER
 	depends on VIDEO_V4L2 && OF && VIDEO_V4L2_SUBDEV_API && MEDIA_CONTROLLER
 	select REGMAP
+	select V4L2_FWNODE
 	help
 	  This driver provides support for N:1 video bus multiplexers.
 
diff --git a/drivers/media/platform/video-mux.c b/drivers/media/platform/video-mux.c
index 61a9bf716a05..c33900e3c23e 100644
--- a/drivers/media/platform/video-mux.c
+++ b/drivers/media/platform/video-mux.c
@@ -21,8 +21,10 @@
 #include <linux/of.h>
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 #include <media/v4l2-async.h>
 #include <media/v4l2-device.h>
+#include <media/v4l2-fwnode.h>
 #include <media/v4l2-subdev.h>
 
 struct video_mux {
@@ -316,6 +318,38 @@ static const struct v4l2_subdev_ops video_mux_subdev_ops = {
 	.video = &video_mux_subdev_video_ops,
 };
 
+static int video_mux_parse_endpoint(struct device *dev,
+				    struct v4l2_fwnode_endpoint *vep,
+				    struct v4l2_async_subdev *asd)
+{
+	/*
+	 * it's not an error if remote is missing on a video-mux
+	 * input port, return -ENOTCONN to skip this endpoint with
+	 * no error.
+	 */
+	return fwnode_device_is_available(asd->match.fwnode) ? 0 : -ENOTCONN;
+}
+
+static int video_mux_async_register(struct video_mux *vmux,
+				    unsigned int num_input_pads)
+{
+	unsigned int i, *ports;
+	int ret;
+
+	ports = kcalloc(num_input_pads, sizeof(*ports), GFP_KERNEL);
+	if (!ports)
+		return -ENOMEM;
+	for (i = 0; i < num_input_pads; i++)
+		ports[i] = i;
+
+	ret = v4l2_async_register_fwnode_subdev(
+		&vmux->subdev, sizeof(struct v4l2_async_subdev),
+		ports, num_input_pads, video_mux_parse_endpoint);
+
+	kfree(ports);
+	return ret;
+}
+
 static int video_mux_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -383,7 +417,7 @@ static int video_mux_probe(struct platform_device *pdev)
 
 	vmux->subdev.entity.ops = &video_mux_ops;
 
-	return v4l2_async_register_subdev(&vmux->subdev);
+	return video_mux_async_register(vmux, num_pads - 1);
 }
 
 static int video_mux_remove(struct platform_device *pdev)
-- 
2.17.1

