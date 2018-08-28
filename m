Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D7DC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0E520658
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:55:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA0E520658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbeH1Fo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:44:29 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:37815 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbeH1Fo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:44:29 -0400
Received: by mail-oi0-f68.google.com with SMTP id p84-v6so28278oic.4;
        Mon, 27 Aug 2018 18:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kt7BYDfHhex6sxeWyjXMbgP+JbjAApFplsDbqg9VKPM=;
        b=F7+3u8AdIU3wxf9OuYRKXzIlSB+XDr016lmLzFqoDRGwGhDRTRk8/NXIKNHgsXqj/f
         dHYf8fSnxi5EDghURgX23r697MUye8wuHBznOq8Ox9s2AsQX/RcBFsUKH09KJBil+3sw
         Y4YjD/gem1h4ZnMaJ/hSBhp2XqnZjRbCQxlYVesqt4+RqKip6Tp7Y3sDhGUcccg+nRzU
         T5wH3KpEtxKp+IOEnL3hao2r7oEY8VCO0tPe8fNJo4Z3e30+SlkttBv0A1rVYk81GqTx
         ACSdtqkpDW3JzpoO+baIL/qsnXfmO8XgEUZ5fkdKS11z8UXYIuTqqlysYdBLOXz0UOIm
         Tyrg==
X-Gm-Message-State: APzg51BPWoNkBizVz7qAod++0WkUt8WNYnPNCI2PIYnZd2KEyGYNC0sN
        GflemCTk565BZ0Jm6dK+79ncm0k=
X-Google-Smtp-Source: ANB0VdZMn1g5NvfqMXRggGgXOZKbi8/azHP0PgeUw5zIx+5kYneXHuk5uM2np16Ibc+fx8CIcaZp8A==
X-Received: by 2002:aca:d846:: with SMTP id p67-v6mr1181215oig.42.1535421312717;
        Mon, 27 Aug 2018 18:55:12 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.55.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:55:12 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH] staging: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:45 -0500
Message-Id: <20180828015252.28511-44-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Steve Longerbeam <slongerbeam@gmail.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-media@vger.kernel.org
Cc: devel@driverdev.osuosl.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/staging/media/imx/imx-media-dev.c | 11 ++++++-----
 drivers/staging/media/imx/imx-media-of.c  |  4 ++--
 drivers/staging/mt7621-eth/mdio.c         |  4 ++--
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-dev.c b/drivers/staging/media/imx/imx-media-dev.c
index b0be80f05767..818846f8c291 100644
--- a/drivers/staging/media/imx/imx-media-dev.c
+++ b/drivers/staging/media/imx/imx-media-dev.c
@@ -89,8 +89,8 @@ int imx_media_add_async_subdev(struct imx_media_dev *imxmd,
 
 	/* return -EEXIST if this asd already added */
 	if (find_async_subdev(imxmd, fwnode, devname)) {
-		dev_dbg(imxmd->md.dev, "%s: already added %s\n",
-			__func__, np ? np->name : devname);
+		dev_dbg(imxmd->md.dev, "%s: already added %pOFn\n",
+			__func__, np ? np : devname);
 		ret = -EEXIST;
 		goto out;
 	}
@@ -105,19 +105,20 @@ int imx_media_add_async_subdev(struct imx_media_dev *imxmd,
 	if (fwnode) {
 		asd->match_type = V4L2_ASYNC_MATCH_FWNODE;
 		asd->match.fwnode = fwnode;
+		dev_dbg(imxmd->md.dev, "%s: added %pOFn, match type FWNODE\n",
+			__func__, np);
 	} else {
 		asd->match_type = V4L2_ASYNC_MATCH_DEVNAME;
 		asd->match.device_name = devname;
 		imxasd->pdev = pdev;
+		dev_dbg(imxmd->md.dev, "%s: added %s, match type DEVNAME\n",
+			__func__, devname);
 	}
 
 	list_add_tail(&imxasd->list, &imxmd->asd_list);
 
 	imxmd->subdev_notifier.num_subdevs++;
 
-	dev_dbg(imxmd->md.dev, "%s: added %s, match type %s\n",
-		__func__, np ? np->name : devname, np ? "FWNODE" : "DEVNAME");
-
 out:
 	mutex_unlock(&imxmd->mutex);
 	return ret;
diff --git a/drivers/staging/media/imx/imx-media-of.c b/drivers/staging/media/imx/imx-media-of.c
index acde372c6795..cb74df356576 100644
--- a/drivers/staging/media/imx/imx-media-of.c
+++ b/drivers/staging/media/imx/imx-media-of.c
@@ -79,8 +79,8 @@ of_parse_subdev(struct imx_media_dev *imxmd, struct device_node *sd_np,
 	int i, num_ports, ret;
 
 	if (!of_device_is_available(sd_np)) {
-		dev_dbg(imxmd->md.dev, "%s: %s not enabled\n", __func__,
-			sd_np->name);
+		dev_dbg(imxmd->md.dev, "%pOFn: %s not enabled\n", __func__,
+			sd_np);
 		/* unavailable is not an error */
 		return 0;
 	}
diff --git a/drivers/staging/mt7621-eth/mdio.c b/drivers/staging/mt7621-eth/mdio.c
index 7ad0c4141205..9ffa8f771235 100644
--- a/drivers/staging/mt7621-eth/mdio.c
+++ b/drivers/staging/mt7621-eth/mdio.c
@@ -70,7 +70,7 @@ int mtk_connect_phy_node(struct mtk_eth *eth, struct mtk_mac *mac,
 	_port = of_get_property(phy_node, "reg", NULL);
 
 	if (!_port || (be32_to_cpu(*_port) >= 0x20)) {
-		pr_err("%s: invalid port id\n", phy_node->name);
+		pr_err("%pOFn: invalid port id\n", phy_node);
 		return -EINVAL;
 	}
 	port = be32_to_cpu(*_port);
@@ -249,7 +249,7 @@ int mtk_mdio_init(struct mtk_eth *eth)
 	eth->mii_bus->priv = eth;
 	eth->mii_bus->parent = eth->dev;
 
-	snprintf(eth->mii_bus->id, MII_BUS_ID_SIZE, "%s", mii_np->name);
+	snprintf(eth->mii_bus->id, MII_BUS_ID_SIZE, "%pOFn", mii_np);
 	err = of_mdiobus_register(eth->mii_bus, mii_np);
 	if (err)
 		goto err_free_bus;
-- 
2.17.1

