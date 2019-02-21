Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7095BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1C42084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="cYND5pZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfBUNRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:17:55 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39272 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfBUNRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:17:54 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so14178029pld.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 05:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z4WPpNvqATEqflSPwYUzMl3muuVuJNYbX37LQ5kTos0=;
        b=cYND5pZ1RjYAKsI8X/nSYC3vb41LMgF5K5SHWRAh2eHO9dQaxpif98SFORXP16GJ3f
         oreBrm0HGi2/rRsBGpwlrfWa6MWPH8lWwOS87FDkmKb04KeZpSvsjC8g3HLt3Ev59dRw
         CNFUhmAsyemXhnjW+o85wItMkF3ewjnRhdxHg35DRIMjexdafyhytyw3SYkn5NuvYaon
         2p45Lcd4HyLbQFmdpvHLJCnA7+nNM5y5Sep2yrZzk4BntP4qifwi99WEydkAygJPqzxE
         B6RF1Ff1f7nfZ18R11k+khnGdJrU1P+EhVFF4KzIU1nMUQ5Bh6JBJT9Wiu+5uPewUf8j
         p+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z4WPpNvqATEqflSPwYUzMl3muuVuJNYbX37LQ5kTos0=;
        b=FFtjI2axDuypRyMWHUNvE33k0rcYaDsHg8oGrFpNHsUrrLH687JxnZBkC4vx9x65/Q
         Pdt+LfRwYNQsw3/PkUrux3br0UQ3gjgZlAMMz7k9OdQm8HtIML34MyWqZQgqqKemWjS+
         K5RBPTQ0Cx5/mnOlwIzkK6sbDDqaS9vomDntvNWzn/tJ7ItsJsb0ccVb/CpWFpJV4VcM
         K0AinUiSUIgPI84E0zrsE4qtrscfthjxCs16eivUnBqHyCZNHvxCKMEBbqwZmbM+Rx+Q
         4dMn88fZfQowxz0z0Fftyjd2fFN4Dm3W1jH1T81YBijtKSFYxtsPMDQrQSnxMfBkxEua
         xvng==
X-Gm-Message-State: AHQUAubZEUwzh/Y9m6xXmZ5Y9+DPf0H/bUIIItBa1ZcfddBtIR4kJNpu
        /r3MP21C6znXlKJ2VYkwQYUhn0+s7tgyPg==
X-Google-Smtp-Source: AHgI3IZgMgxx2VnsBPn3yEVzdeb9/YCv0OhSrmuAl2Q3gfov6iMisnXsXI4QFahe7Rka4xcVrXtNCg==
X-Received: by 2002:a17:902:1101:: with SMTP id d1mr9323067pla.19.1550755073905;
        Thu, 21 Feb 2019 05:17:53 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id e21sm79046676pfh.45.2019.02.21.05.17.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 05:17:53 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Sangbeom Kim <sbkim73@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] regulator: s5m8767: Simplify s5m8767_set_voltage_time_sel implementation
Date:   Thu, 21 Feb 2019 21:17:22 +0800
Message-Id: <20190221131722.12278-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190221131722.12278-1-axel.lin@ingics.com>
References: <20190221131722.12278-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/s5m8767.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/regulator/s5m8767.c b/drivers/regulator/s5m8767.c
index 5b0e1fe6723f..bb9d1a083299 100644
--- a/drivers/regulator/s5m8767.c
+++ b/drivers/regulator/s5m8767.c
@@ -339,13 +339,9 @@ static int s5m8767_set_voltage_time_sel(struct regulator_dev *rdev,
 					     unsigned int new_sel)
 {
 	struct s5m8767_info *s5m8767 = rdev_get_drvdata(rdev);
-	const struct sec_voltage_desc *desc;
-	int reg_id = rdev_get_id(rdev);
-
-	desc = reg_voltage_map[reg_id];
 
 	if ((old_sel < new_sel) && s5m8767->ramp_delay)
-		return DIV_ROUND_UP(desc->step * (new_sel - old_sel),
+		return DIV_ROUND_UP(rdev->desc->uV_step * (new_sel - old_sel),
 					s5m8767->ramp_delay * 1000);
 	return 0;
 }
-- 
2.17.1

