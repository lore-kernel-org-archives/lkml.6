Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E331C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22EE120827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcRa1JFQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22EE120827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387406AbeKEX5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:57:39 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37370 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729017AbeKEX5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 18:57:39 -0500
Received: by mail-pl1-f195.google.com with SMTP id p6-v6so4551371pll.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 06:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=z1zzkMTBEehskq2DPI3ZOQHaUdaoniARDpLAtPnVMgI=;
        b=bcRa1JFQfrDvxrCBswxmSbgeYFdHnqGGnLHq2506hoD518rVvfi+ArtX1yOrjsbBOr
         cKS4HHPs61TUaDKK7hcxEbfjeW/bO0GYRZtTTL7CEE2ZT48mdh81NSlaXTehVuVKrH2A
         aUC+SXnaJ5EQzeuG1htRreOwDDxM34/VaDgYrdpDhyXx/UAS9W2mUgvbPXrY/qlwRSXe
         Jf8QX+yZM3Iif5ZajdGd4heLQI/thOmMxfwWQ6U/BOTuLA9foA4fLBbBN6UOsGQ4lvfM
         HDmZf40WMracLCha0dmE/WtRdwKj8E7JkPiYKf3c6xT4jBbfIjUw/GXYFCYFa44UhT5G
         F9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z1zzkMTBEehskq2DPI3ZOQHaUdaoniARDpLAtPnVMgI=;
        b=WQFU0Zb3EvZOZwUBBGzX/ecSWCeKSkylz3vX9GK2ybuoG9ZLAPtehw+3H83n9J5goZ
         0QUYhKSgZxq9MLQ1pJGbbJ0T7+KrJPfcumgAi8HUFjVa2d8DeKe9X4eBrT2e0FYxR5mA
         /I0FtXQEyNQ/wnkqWrYSrWZhx1epw9J74UQVD8IAI0zFaTq77Hfpj1qUHAPGlZIeFk+d
         3KtzmMqW+b+GvjkA7e8XRCJeopFJ5ObvDkpNBX7qS+6gYqJ0l+chP89D2ixkcljanIqD
         kht35lp7/JNuDDtfiSxIuKrp1ZCLdybD9i56XiaBqp2FWtAZYKAKLcmoAb7b2XclnP8N
         hXQA==
X-Gm-Message-State: AGRZ1gKckHJ7yWdpsth2X/2E3QveFzwVgPhOdyS1jlHmoZVaLpvu+82V
        FbSaN2aOHeQq0y9/d0q80Y4=
X-Google-Smtp-Source: AJdET5eTxjVAXMLDVPHzELPZyCSMhaRrkGRajUG1ti+DRfkoiQVOCYE9rTqsYzy/8E/MQUnwlQ24GA==
X-Received: by 2002:a17:902:b183:: with SMTP id s3-v6mr21194163plr.70.1541428658045;
        Mon, 05 Nov 2018 06:37:38 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id o27-v6sm57166297pfk.85.2018.11.05.06.37.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 06:37:37 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        fabio.estevam@nxp.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] ASoC: fsl_ssi: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Mon,  5 Nov 2018 09:37:30 -0500
Message-Id: <20181105143730.6071-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 sound/soc/fsl/fsl_ssi_dbg.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi_dbg.c b/sound/soc/fsl/fsl_ssi_dbg.c
index 1255dfe19eef..6f6294149476 100644
--- a/sound/soc/fsl/fsl_ssi_dbg.c
+++ b/sound/soc/fsl/fsl_ssi_dbg.c
@@ -124,17 +124,7 @@ static int fsl_ssi_stats_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
-static int fsl_ssi_stats_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, fsl_ssi_stats_show, inode->i_private);
-}
-
-static const struct file_operations fsl_ssi_stats_ops = {
-	.open = fsl_ssi_stats_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(fsl_ssi_stats);
 
 int fsl_ssi_debugfs_create(struct fsl_ssi_dbg *ssi_dbg, struct device *dev)
 {
@@ -144,7 +134,7 @@ int fsl_ssi_debugfs_create(struct fsl_ssi_dbg *ssi_dbg, struct device *dev)
 
 	ssi_dbg->dbg_stats = debugfs_create_file("stats", 0444,
 						 ssi_dbg->dbg_dir, ssi_dbg,
-						 &fsl_ssi_stats_ops);
+						 &fsl_ssi_stats_fops);
 	if (!ssi_dbg->dbg_stats) {
 		debugfs_remove(ssi_dbg->dbg_dir);
 		return -ENOMEM;
-- 
2.17.0

