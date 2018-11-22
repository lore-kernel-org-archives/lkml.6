Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B385C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5294F206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnVxuYLq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5294F206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436920AbeKWAKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 19:10:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36130 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436898AbeKWAKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 19:10:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id b85so1976235pfc.3;
        Thu, 22 Nov 2018 05:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+mmzSs3DXc8UJQkZ7e34l7kPjkN1Cc3Q+b2IuQI1Quw=;
        b=hnVxuYLqzjlhrgRAlATsKc4CsxOXynPLec64OpeJ+y1bunzePpSRBOkep8YZHVCch2
         +5yiK57KGf+LuB/F1ge/Whp5H4d7mu9KbnTvmeHfQiJLOieD0k3mFTg2eghEGIf6rJVn
         VUeIWIh/9tYhv0FcDE3IPnmJqGvQL+N6Sfj6K0taSUZuU+cb8l91n+1sbfIHOE/BzwE0
         EZiYUDmPX6IOezee7QkgNEAFkoWiYHGkUVdMKdl+jd82v2UtvsxqhZWDS2+ihgfoU2SC
         dmEGwnv/z3lO5plBsgyZo4kzdQTDAwUBRoIYTQGVs0gNnEU+uJgsGo85dpXJRNw+Azxn
         MdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+mmzSs3DXc8UJQkZ7e34l7kPjkN1Cc3Q+b2IuQI1Quw=;
        b=MPpPmtie1DvoVWSeN1bgV9DD1K6oZqtAmYDc1oDJe+CFTqtQ3bixsU+uHDfSiZlGsz
         nhz1R8AOlzeVr0ecl762ORwWMbYx4m7f7WCNjep3PhLdRF0hsBWnIq7TlTu1InI3RwW+
         8peLQaHdOEocu0rPJT7T5tYR7r45qwBQKp1/UDstfnJbNVSbERR9OG4PH4VE89yL7Fsl
         lVzUDbsnXLS32DQdnh+Z+LThkNGN9S/1JTAUkkB3QGZqvxTbIBZL6trHLtaZDQKCpXoF
         vyWvg7GJHnWxJCLOjs8WEaj1sitJl3tdl5J5IqT4OfdWEov/XOjVRhFzX3/EtidtgcyR
         x34A==
X-Gm-Message-State: AA+aEWZ/FudvrJI1fLw+2VDlvg8ngzm293zryO4qQ/pXfvL6h9Mnr3MN
        c6g85LStKY40i598bMO+IWY=
X-Google-Smtp-Source: AFSGD/Wbi+ro9PcM//9NeybdVgUuYNYEP2QW/OU4uasofnusmzfiNXvLHvmsl6INds+OLiX5d/e76g==
X-Received: by 2002:a63:5153:: with SMTP id r19mr10076118pgl.281.1542893450543;
        Thu, 22 Nov 2018 05:30:50 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id i63-v6sm18313074pfi.66.2018.11.22.05.30.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 05:30:49 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     thierry.reding@gmail.com, joro@8bytes.org, jonathanh@nvidia.com
Cc:     linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] iommu/tegra: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Thu, 22 Nov 2018 08:30:47 -0500
Message-Id: <20181122133047.24902-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/iommu/tegra-smmu.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 0d03341317c4..97b3c0461831 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -926,17 +926,7 @@ static int tegra_smmu_swgroups_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int tegra_smmu_swgroups_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, tegra_smmu_swgroups_show, inode->i_private);
-}
-
-static const struct file_operations tegra_smmu_swgroups_fops = {
-	.open = tegra_smmu_swgroups_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(tegra_smmu_swgroups);
 
 static int tegra_smmu_clients_show(struct seq_file *s, void *data)
 {
@@ -964,17 +954,7 @@ static int tegra_smmu_clients_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int tegra_smmu_clients_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, tegra_smmu_clients_show, inode->i_private);
-}
-
-static const struct file_operations tegra_smmu_clients_fops = {
-	.open = tegra_smmu_clients_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(tegra_smmu_clients);
 
 static void tegra_smmu_debugfs_init(struct tegra_smmu *smmu)
 {
-- 
2.17.0

