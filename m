Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C698FC10F0B
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 01:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95FB42085B
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 01:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="Kz3q0pDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbfBXB1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 20:27:11 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39572 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfBXB1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 20:27:11 -0500
Received: by mail-pf1-f196.google.com with SMTP id i20so2828201pfo.6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 17:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=zIV7TVWO7+GrDj86Uqz8LYGGWr4D+sOMdBOa5c0YC7E=;
        b=Kz3q0pDIOXb4brhgA04l56ZBFSoa0VzelgllGAhoqabEg6IASUTJKgevxNpOMSiEpF
         MKANfQwfVilOHEafGMA2ed12gSKhEY+vPqAeuxD+B4PTXimJwFhXl65/zhcXeYqksmeK
         u7Odf3uLZc5cR0QjGUm7HW34hTkbMt0FI2jfuRLcvLINJFkSxEw4WO+1ksubpFhHZVet
         +2+ot7S6eCe/qwnB+QcnN8yGpw01REx6ojXMdPlYmD+QoxiE0nHEww7DpSsMAGygqw37
         bOvNjfBwVOrMcHN9/IqFH/KCFdLkUqV0tWD7wzpt83t/jvmF/aksLSMkjXtT/RSp8hcH
         coTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zIV7TVWO7+GrDj86Uqz8LYGGWr4D+sOMdBOa5c0YC7E=;
        b=dZQqKxIBrqEbis2S9gBovTZMsWB0Eh3vcJffWRJnNvkFEPuI6IC66CQsUIeoPX6PEq
         H5iiZYkeU8dr9RhuIcmwxk9dGCO3stJMdSiJKtu5ba6SEzydX7SSl2hUDGv9A2PJvmqU
         KOVrxb0bcEfc4kZuKyDDXoMmXIOOpHIM95J1KOxwN5wKnXDzYsUjSy+XgNyH8j8AM9gr
         jkvaCI6C1pn0kj6rm5xRv/GJ750KCLVkwhakuTmjAE4zwdKZugWPzkzsrI331vVosdEz
         MXshao4sISJI5pguYxBv0wKss/+sol93tjn/DkhgZs5hYvpoG1y04ukfrV8Z18ebG0KU
         uVcg==
X-Gm-Message-State: AHQUAuYtImnoB+MantWwB3HQUFjhJV/exAYtXIVesCe0DmAH7V6CiGp5
        hZVihXRPSbGApFKQeg9KOiDrZw==
X-Google-Smtp-Source: AHgI3IbSRoZ+MsaOTUuaLdFMsP5/24oWyOoE3xJFJwbmjSjuVZ6iLhi0+hvLMk+J0RDO6B+IHTQR4g==
X-Received: by 2002:a63:1625:: with SMTP id w37mr10963063pgl.13.1550971630477;
        Sat, 23 Feb 2019 17:27:10 -0800 (PST)
Received: from localhost.localdomain (118-171-128-111.dynamic-ip.hinet.net. [118.171.128.111])
        by smtp.gmail.com with ESMTPSA id q7sm14075077pfa.119.2019.02.23.17.27.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 17:27:09 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mark Zhang <markz@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: max77620: Fix regulator info setting for max20024
Date:   Sun, 24 Feb 2019 09:26:54 +0800
Message-Id: <20190224012654.17217-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code always set pmic->rinfo[id] = &max77620_regs_info[id];
It should set to either max77620_regs_info or max20024_regs_info
depends on the chip_id.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/max77620-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/max77620-regulator.c b/drivers/regulator/max77620-regulator.c
index 1607ac673e44..0ad91a7f9cb9 100644
--- a/drivers/regulator/max77620-regulator.c
+++ b/drivers/regulator/max77620-regulator.c
@@ -803,7 +803,7 @@ static int max77620_regulator_probe(struct platform_device *pdev)
 			continue;
 
 		rdesc = &rinfo[id].desc;
-		pmic->rinfo[id] = &max77620_regs_info[id];
+		pmic->rinfo[id] = &rinfo[id];
 		pmic->enable_power_mode[id] = MAX77620_POWER_MODE_NORMAL;
 		pmic->reg_pdata[id].active_fps_src = -1;
 		pmic->reg_pdata[id].active_fps_pd_slot = -1;
-- 
2.17.1

