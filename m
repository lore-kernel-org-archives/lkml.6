Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AF0C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A0D20868
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 10:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GT10QXQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A0D20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbeLAVnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 16:43:08 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42402 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbeLAVnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 16:43:08 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so3609233pga.9;
        Sat, 01 Dec 2018 02:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wKiwvWaLK3NEaJ8gIfz2hFtx79PMWaMjuWZE4x0nq/I=;
        b=GT10QXQS4IjyMcSIbr8H5en919rq7ptb+r16+TxSVCggnbvmzkxOWR+cObA7RU2/RJ
         GTQitQ/ImAfcErLrQhmdxgZCtOpKn2DDxEY/rfzRiylB9R4T7e7o21sg1+fahatLBZCh
         P4vztiXEidw9PKTPbZC0gb5S1RkkhxmrStfAlIuItzH1SXEv6YVPGR2BcvOWZmbkYVbh
         zM2GhL6AYxKpy3fzAVnYCLOuirrcAKGscwmbrp/9Blxn2v9wmi46818WovBaWnlH/Am7
         GLOilVpzDXByPnaB3PsXGazElE3F++YYhvFlxZeaTV7OXsGce9Wyttwn5HjNOPkQFyEX
         JwIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wKiwvWaLK3NEaJ8gIfz2hFtx79PMWaMjuWZE4x0nq/I=;
        b=O1eCWDmYsRd9skI3/jG6D3IR1u0oiFc8c84EDoBdCrQstEDOHNjYearsC71WH9GBNR
         HFQfrql+TH//POKr6anRFPki0UxuAk/bDqqHLvET3UYcMdGY867nnUXKsNcK8jkc467u
         Vr3GVZqHu4zcsiQrE7Qz1iJ1fEqv9dvRZfW59r6LMx7JKdbYkV7qwXBkNN4y/74qfl1s
         UP3VEkSOFkt+USR9Cl/tHVkmwSnOpgmqnfx0ZewoxYiR1OYcsxQvdGrl59IQpaKm1KZ2
         FfDMOWx2wIs5DF815n7xnUjSoMB48ttS1qJD6f0jy/rgElcloUtKYwF9esSfkUtDxAMm
         4yjA==
X-Gm-Message-State: AA+aEWbShFKv5udvUyqTyX/MadrWX94V8qdhaAmZ+xPYSg69RKQETF6R
        tt3UTbNKGh0dluXfrX+s39o=
X-Google-Smtp-Source: AFSGD/UImOb485/K3flM4bIYtlj8iONmdZm8Oi4+DprWx/sJX+g/fgJMEMQ10+f6cCuMyNmeDcrnqA==
X-Received: by 2002:a63:a91a:: with SMTP id u26mr7390496pge.349.1543660255386;
        Sat, 01 Dec 2018 02:30:55 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id q195sm7747676pgq.7.2018.12.01.02.30.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 02:30:54 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] memory: tegra: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Sat,  1 Dec 2018 05:30:52 -0500
Message-Id: <20181201103052.6653-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/memory/tegra/tegra124-emc.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index eedb7d48e2ea..10e36ae2d573 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -1027,7 +1027,7 @@ static int emc_debug_rate_set(void *data, u64 rate)
 DEFINE_SIMPLE_ATTRIBUTE(emc_debug_rate_fops, emc_debug_rate_get,
 			emc_debug_rate_set, "%lld\n");
 
-static int emc_debug_supported_rates_show(struct seq_file *s, void *data)
+static int emc_supported_rates_show(struct seq_file *s, void *data)
 {
 	struct tegra_emc *emc = s->private;
 	const char *prefix = "";
@@ -1046,19 +1046,7 @@ static int emc_debug_supported_rates_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int emc_debug_supported_rates_open(struct inode *inode,
-					  struct file *file)
-{
-	return single_open(file, emc_debug_supported_rates_show,
-			   inode->i_private);
-}
-
-static const struct file_operations emc_debug_supported_rates_fops = {
-	.open = emc_debug_supported_rates_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(emc_supported_rates);
 
 static void emc_debugfs_init(struct device *dev, struct tegra_emc *emc)
 {
@@ -1083,7 +1071,7 @@ static void emc_debugfs_init(struct device *dev, struct tegra_emc *emc)
 		dev_err(dev, "failed to create debugfs entry\n");
 
 	file = debugfs_create_file("supported_rates", S_IRUGO, root, emc,
-				   &emc_debug_supported_rates_fops);
+				   &emc_supported_rates_fops);
 	if (!file)
 		dev_err(dev, "failed to create debugfs entry\n");
 }
-- 
2.17.0

