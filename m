Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01247C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84122087B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84122087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeH1Tg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:36:58 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39252 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbeH1Tg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:36:57 -0400
Received: by mail-oi0-f68.google.com with SMTP id c190-v6so3665816oig.6;
        Tue, 28 Aug 2018 08:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to;
        bh=wo7xqdq/4BpmCLGZCJhWKkDumVdRWLrZhbJLgJHCFFM=;
        b=rSo7sEZ/GfPYG6x2zoVprfx8iiDtQaNQ9mIIvqIbkloHh5fqP0e1ZaYhuPkXYxQpTY
         cdixO+AgtxoBmpgKFDfUm1rme9R87SSvk9UtrUcrSFLflJJdweYxLUFdkR2rl3krE3vJ
         3akmkozV8XGr2Y3+/U2KZnauU0G2vnFETsubm8cPY4CFbuJsXPFu3tpSIhDedSdDlbOj
         i0L74H/i9XQHg4eb5/qrt4F7STEm1ZERg4fwdCMwsjCqgZj2DbQT/5CFFthz8Imk68Si
         1ZVAfmVicV50dyzs7mOKzN5kEG+0ksbmfFHHrfW/F87knnv1YirQrWOLXPZC+1uOYebK
         6I4A==
X-Gm-Message-State: APzg51B75Nsk5rBxtXFG8hrVXUVXrJeWt8IbocwPbLkDKydyq6j8CTQt
        cCngNbWGuy0SRENVKO4JBKBKtPs=
X-Google-Smtp-Source: ANB0VdZehfX2hoB/KuvlCdxUXaU+V9BfxNMYCLL1jrLbpIdHkI/LXK8mfmB6PPRI5ttytCE8VmbY5g==
X-Received: by 2002:aca:91a:: with SMTP id 26-v6mr1573713oij.33.1535471082515;
        Tue, 28 Aug 2018 08:44:42 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id f4-v6sm1808331oic.52.2018.08.28.08.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 08:44:41 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ian Arkver <ian.arkver.dev@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH v2] staging: Convert to using %pOFn instead of device_node.name
Date:   Tue, 28 Aug 2018 10:44:33 -0500
Message-Id: <20180828154433.5693-7-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828154433.5693-1-robh@kernel.org>
References: <20180828154433.5693-1-robh@kernel.org>
In-Reply-To: <20180828015252.28511-44-robh@kernel.org>
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
v2:
- fix conditional use of node name vs devname for imx

 drivers/staging/media/imx/imx-media-dev.c | 15 ++++++++++-----
 drivers/staging/media/imx/imx-media-of.c  |  4 ++--
 drivers/staging/mt7621-eth/mdio.c         |  4 ++--
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/media/imx/imx-media-dev.c b/drivers/staging/media/imx/imx-media-dev.c
index b0be80f05767..3f48f5ceb6ea 100644
--- a/drivers/staging/media/imx/imx-media-dev.c
+++ b/drivers/staging/media/imx/imx-media-dev.c
@@ -89,8 +89,12 @@ int imx_media_add_async_subdev(struct imx_media_dev *imxmd,

 	/* return -EEXIST if this asd already added */
 	if (find_async_subdev(imxmd, fwnode, devname)) {
-		dev_dbg(imxmd->md.dev, "%s: already added %s\n",
-			__func__, np ? np->name : devname);
+		if (np)
+			dev_dbg(imxmd->md.dev, "%s: already added %pOFn\n",
+			__func__, np);
+		else
+			dev_dbg(imxmd->md.dev, "%s: already added %s\n",
+			__func__, devname);
 		ret = -EEXIST;
 		goto out;
 	}
@@ -105,19 +109,20 @@ int imx_media_add_async_subdev(struct imx_media_dev *imxmd,
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
index acde372c6795..163437e421c5 100644
--- a/drivers/staging/media/imx/imx-media-of.c
+++ b/drivers/staging/media/imx/imx-media-of.c
@@ -79,8 +79,8 @@ of_parse_subdev(struct imx_media_dev *imxmd, struct device_node *sd_np,
 	int i, num_ports, ret;

 	if (!of_device_is_available(sd_np)) {
-		dev_dbg(imxmd->md.dev, "%s: %s not enabled\n", __func__,
-			sd_np->name);
+		dev_dbg(imxmd->md.dev, "%s: %pOFn not enabled\n", __func__,
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
