Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F71C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8071222A3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ga36iSdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbfBPPSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 10:18:44 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34951 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfBPPSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 10:18:44 -0500
Received: by mail-pf1-f195.google.com with SMTP id j5so1784147pfa.2;
        Sat, 16 Feb 2019 07:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Ciga3oq2Jepxu5Q88L5YWntx9r4J5pvBwDOGZvsxrQ=;
        b=Ga36iSdH1E1mfc1wO1UqCGBfyB6HtMbSgTOjjWJP8CyNILGMdj9htAwfn5tWnbV+VE
         9e6f9NnKf5foHVu50W9qpcVjInI/HNMgD1GMcc4IRv6vBn9DYo/8mY/HXQjxJhM6HogC
         v9bgxFcoKNkgzZA0Uz5gCsj/YBRbboMZW22zRaDVhH7lDeiHD642WdsD9TuBbdiiItAF
         66yoaeUWGARVri+Q6p0lg8y2iC88xEZa90A3WQYUjq7OGBJf2L6U02JQojSZqM6jeaqN
         uKGoeZs//OQiwbUA7eXfhodULfbvK0MTb1l2wR6mUxZvmhImlQ5tvqlhg/pnBdfGL3h7
         3JPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2Ciga3oq2Jepxu5Q88L5YWntx9r4J5pvBwDOGZvsxrQ=;
        b=XH5YCEf5rLPl7CBB5n4qS7lrgljUbRJcv+kb+pKAgMb49DKlwRiKhN6q/9AiHxm9Hr
         msvJHJsrslOzDPf0xS336hmDFdkybYqeil6X/CetmC900dM6xIGbCcIYn1MIOuHFDzky
         +yyNFHNEE4+7FClydSH7LzveEbYz7Gl4Ue/1DQbGQQsGgeLUZUskTvZKxClzBwQqU3ms
         5rjxic9AzFQPHQ6Malfc1YnhSD6B1fb4PStuKhhxfQ/E6eqBq+LuBQEncCBJ3JmLR0LC
         3uy1A3viLXr++JfgcXT2rbjOMLqxMl4iqgcGnF2kH8tAisGWhQJ/HkQJwNvuBViOZNZm
         5kXg==
X-Gm-Message-State: AHQUAuZFUs5/IRuUT4rhlsqdYxj4lymLkzvXCc4KvnspUo8ySUJwCFM/
        oIzmeLbRy1pT/Cdou6BbSN0=
X-Google-Smtp-Source: AHgI3Ia5HFmmkkpz+iQXTSUGjiboKoIFTbVtW3dxWixpu7wvRS/7SFDWTKZH/WvVgdURL1mvcLxzmg==
X-Received: by 2002:aa7:808a:: with SMTP id v10mr15471762pff.8.1550330323587;
        Sat, 16 Feb 2019 07:18:43 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id g7sm12810254pfm.10.2019.02.16.07.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 07:18:42 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, heiko@sntech.de,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 1/3] PM / devfreq: rk3399_dmc: remove unneeded semicolon
Date:   Sat, 16 Feb 2019 10:18:24 -0500
Message-Id: <20190216151826.11584-2-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190216151826.11584-1-tiny.windzz@gmail.com>
References: <20190216151826.11584-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The semicolon is unneeded, so remove it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/devfreq/rk3399_dmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index e795ad2b3f6b..a228dad2bee4 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -322,7 +322,7 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 
 		dev_err(dev, "Cannot get the clk dmc_clk\n");
 		return PTR_ERR(data->dmc_clk);
-	};
+	}
 
 	data->edev = devfreq_event_get_edev_by_phandle(dev, 0);
 	if (IS_ERR(data->edev))
-- 
2.17.0

