Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3230AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB811217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="T5POJxa4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfBZMlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:41:18 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46206 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfBZMlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:41:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id 196so6154887pgf.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 04:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=a7yD60MZnY7J1jK/WMO01A+GKZfG5ohExdyNciYvmKE=;
        b=T5POJxa49fPKk9Yx8Ku3k5i48UQqx8xdu6VTdx8cgyk3Iyie0R/s2LS3Uy3JeAGct8
         H+KCaZI2p7Zg7rfsEQhoUvLBg1KWuqgxaJryytCGFbbRMn0i5mYUxM1cpr0QEROR+Y6E
         qnN46K7sZX6l+z/5il3SZGgsfMoZEKvo2cUP93WeAsCrsDmDSQZ9KCcH7Q6LiBazbqLc
         6cWQatk9hEO8FU8qLi+g90+nMmNZpgvyBDHs60mDOhAuRlrLyDQCEYEtZPgP/ZejLZTS
         aFTWyjPREB+lp+8uokx7FTDONDCoB4mb5f7ImICo9Xcg2pflEt1F4nPG69LESboq6Ovm
         5vkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a7yD60MZnY7J1jK/WMO01A+GKZfG5ohExdyNciYvmKE=;
        b=INOvuU/wTjQ5/cFLIT6+elY/+Doc3iYAYZfrVmUf51OVLJ/WdJ/ZinyHif3kJDlGX3
         rKwoTaNZaIC9b+JJNbgsp2T3447o+RddCeQHcb3iO8Uhl7MrEVCH9IJt0jGv3/VVffxw
         uaUtmAvBikncBRqucksr7GvMshZ1WT+8c3VAfVMPURVT10WYMzI2htZFOGepWIGUI72A
         Ia4TI5i4oMASgx79Wx15LkfpwYi7z6FYkuKnaVwgK2f1D3csRsTmYan8Nu8mifsQNioP
         AIBKv5WQPfqlWr9+yPFJyrEuMNCYx74J7K5e3cysn4muIquLGQebVUfl81oyqR83xae+
         PXdw==
X-Gm-Message-State: AHQUAuYxtoPWQ0HCMnEH8o+dcQ0qQGN7wH0HZ42EA975JvsHglam+eZB
        n6N0879TdO+euhIlCxGHbzOs6g==
X-Google-Smtp-Source: AHgI3IbExOIFddgxA+evBbxRg8aCI2zbAGCDdu/PwgtFdojUFnNbv+BjXnPbbzi+EzikQJ57x7I8WA==
X-Received: by 2002:a62:449b:: with SMTP id m27mr26149839pfi.79.1551184876229;
        Tue, 26 Feb 2019 04:41:16 -0800 (PST)
Received: from localhost.localdomain (36-239-237-193.dynamic-ip.hinet.net. [36.239.237.193])
        by smtp.gmail.com with ESMTPSA id c13sm7669030pfd.121.2019.02.26.04.41.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 04:41:15 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Haojian Zhuang <haojian.zhuang@gmail.com>,
        Jett Zhou <jtzhou@marvell.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: 88pm8607: Simplify pm8607_list_voltage implementation
Date:   Tue, 26 Feb 2019 20:40:58 +0800
Message-Id: <20190226124059.26668-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set volt_table filed then we can use regulator_list_voltage_table.
Since we have volt_table setting, now we can remove vol_table from
struct pm8607_regulator_info.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/88pm8607.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/88pm8607.c b/drivers/regulator/88pm8607.c
index 28f55248eb90..597385d25201 100644
--- a/drivers/regulator/88pm8607.c
+++ b/drivers/regulator/88pm8607.c
@@ -27,7 +27,6 @@ struct pm8607_regulator_info {
 	struct i2c_client	*i2c;
 	struct i2c_client	*i2c_8606;
 
-	unsigned int	*vol_table;
 	unsigned int	*vol_suspend;
 
 	int	slope_double;
@@ -210,13 +209,15 @@ static const unsigned int LDO14_suspend_table[] = {
 static int pm8607_list_voltage(struct regulator_dev *rdev, unsigned index)
 {
 	struct pm8607_regulator_info *info = rdev_get_drvdata(rdev);
-	int ret = -EINVAL;
+	int ret;
+
+	ret = regulator_list_voltage_table(rdev, index);
+	if (ret < 0)
+		return ret;
+
+	if (info->slope_double)
+		ret <<= 1;
 
-	if (info->vol_table && (index < rdev->desc->n_voltages)) {
-		ret = info->vol_table[index];
-		if (info->slope_double)
-			ret <<= 1;
-	}
 	return ret;
 }
 
@@ -257,6 +258,7 @@ static const struct regulator_ops pm8606_preg_ops = {
 		.type	= REGULATOR_VOLTAGE,				\
 		.id	= PM8607_ID_##vreg,				\
 		.owner	= THIS_MODULE,					\
+		.volt_table = vreg##_table,				\
 		.n_voltages = ARRAY_SIZE(vreg##_table),			\
 		.vsel_reg = PM8607_##vreg,				\
 		.vsel_mask = ARRAY_SIZE(vreg##_table) - 1,		\
@@ -266,7 +268,6 @@ static const struct regulator_ops pm8606_preg_ops = {
 		.enable_mask = 1 << (ebit),				\
 	},								\
 	.slope_double	= (0),						\
-	.vol_table	= (unsigned int *)&vreg##_table,		\
 	.vol_suspend	= (unsigned int *)&vreg##_suspend_table,	\
 }
 
@@ -278,6 +279,7 @@ static const struct regulator_ops pm8606_preg_ops = {
 		.type	= REGULATOR_VOLTAGE,				\
 		.id	= PM8607_ID_LDO##_id,				\
 		.owner	= THIS_MODULE,					\
+		.volt_table = LDO##_id##_table,				\
 		.n_voltages = ARRAY_SIZE(LDO##_id##_table),		\
 		.vsel_reg = PM8607_##vreg,				\
 		.vsel_mask = (ARRAY_SIZE(LDO##_id##_table) - 1) << (shift), \
@@ -285,7 +287,6 @@ static const struct regulator_ops pm8606_preg_ops = {
 		.enable_mask = 1 << (ebit),				\
 	},								\
 	.slope_double	= (0),						\
-	.vol_table	= (unsigned int *)&LDO##_id##_table,		\
 	.vol_suspend	= (unsigned int *)&LDO##_id##_suspend_table,	\
 }
 
-- 
2.17.1

