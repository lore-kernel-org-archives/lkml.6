Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7E8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C86C206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Q/WiWTsq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbfBTPNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:13:54 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14034 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfBTPNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:13:53 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c6d6eb00000>; Wed, 20 Feb 2019 07:13:52 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 20 Feb 2019 07:13:53 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 20 Feb 2019 07:13:53 -0800
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 20 Feb
 2019 15:13:52 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 20 Feb 2019 15:13:52 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c6d6ead0000>; Wed, 20 Feb 2019 07:13:52 -0800
From:   Sameer Pujar <spujar@nvidia.com>
To:     <tiwai@suse.com>, <perex@perex.cz>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 3/3] ALSA: hda/tegra: sound card name from device tree
Date:   Wed, 20 Feb 2019 20:43:24 +0530
Message-ID: <1550675604-14788-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550675604-14788-1-git-send-email-spujar@nvidia.com>
References: <1550675604-14788-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1550675632; bh=SlujExwvqb6zD30DcbI7Xl2geLJdDE5cmLu4OM78xSA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=Q/WiWTsqlPEOuAnnJgPX6ZyxrLp9dBJByT2OVPbqxQjLXjjjF9QwWaNb96vmf78i8
         JWlvYDy2jZIgKvrjMSuLEjaAhu9rLK2mcj2sn3RdVq6MSY3p/qWimMrxO6OYFGoHi1
         sPCCSSqsToz2n2+x29b1OO+0o8kTR6nKDMOqu1DM7+3Eceol6NDCckK2Bxego5Lty5
         EK1suATwPr0cS6GslZlSw4K8RRolEo7rGvf7sVNF1M7qPC9xU4JM2A7iLHv9wKwtVn
         9+XJAEL2lKi4LYdvlnGAVvakxYI7z1y5bMRS784RbXwFArnlw8zgFXoVwSA5nf3CQW
         4wHhYQKScIXmw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A platform can have multiple sound cards for different audio paths.
Following is the print seen duirng device boot for jetson-xavier,
  ALSA device list:
    #0: nvidia,p2972-0000 at 0x3518000 irq 17
By looking at above, it is not very clear if the sound card is for
HDA. It becomes confusing when platform has registered multiple cards,
and platform model name is used for card.

This patch uses "nvidia,model" property mentioned in hda device tree
to get the card name. Since property is optional, legacy boards will
continue to use "tegra-hda". Custom name can be passed wherever needed.
This naming convention is conistent with the way sound cards are named
in general.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
Reviewed-by: Jonathan Hunter <jonathanh@nvidia.com>
---
 sound/pci/hda/hda_tegra.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index c8d18dc..dbd8da5 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -380,8 +380,8 @@ static int hda_tegra_first_init(struct azx *chip, struct platform_device *pdev)
 	int err;
 	unsigned short gcap;
 	int irq_id = platform_get_irq(pdev, 0);
-	const char *sname;
-	struct device_node *root;
+	const char *sname, *drv_name = "tegra-hda";
+	struct device_node *np = pdev->dev.of_node;
 
 	err = hda_tegra_init_chip(chip, pdev);
 	if (err)
@@ -440,17 +440,11 @@ static int hda_tegra_first_init(struct azx *chip, struct platform_device *pdev)
 	}
 
 	/* driver name */
-	strcpy(card->driver, "tegra-hda");
-
-	root = of_find_node_by_path("/");
-	sname = of_get_property(root, "compatible", NULL);
-	of_node_put(root);
-	if (!sname) {
-		dev_err(card->dev,
-			"failed to get compatible property from root node\n");
-		return -ENODEV;
-	}
+	strncpy(card->driver, drv_name, sizeof(card->driver));
 	/* shortname for card */
+	sname = of_get_property(np, "nvidia,model", NULL);
+	if (!sname)
+		sname = drv_name;
 	if (strlen(sname) > sizeof(card->shortname))
 		dev_info(card->dev, "truncating shortname for card\n");
 	strncpy(card->shortname, sname, sizeof(card->shortname));
-- 
2.7.4

