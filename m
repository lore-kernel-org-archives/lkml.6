Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	TVD_SPACE_RATIO,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CAEF1C004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 19:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAEE20869
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 19:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BfJAIUoX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DAEE20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933503AbeFKTfw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 15:35:52 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45165 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933159AbeFKTfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 15:35:50 -0400
Received: by mail-pf0-f194.google.com with SMTP id a22-v6so10762775pfo.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 12:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=z82AsbSiTvOBPXaS1jqrM3cx1/5k3cw9Ov4Z74GZlt8=;
        b=BfJAIUoXAAkckAru1aHcNp43oEEeijV0PPqrr7smJyMNTMl+Sa7c1Ym7PNtVdhWX9b
         rs+jFvly7n3FGxbjTfqE1PDMJu+uO9UFSzR1OL26sig67DWZZPp10gfA0R4cGnNBgB+q
         cKNwcc6WrTkUMZeXPABhep6+sZauOpmHkq+uI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z82AsbSiTvOBPXaS1jqrM3cx1/5k3cw9Ov4Z74GZlt8=;
        b=Z/GlOYJNj1/OtOA+JCOOJIWRM5qiBE6RFsn9jawQtnjByYSM2Dac31wTdBxW6IPOQg
         oq2YgbLeIDTfRenbbR3d1GL0WXHxzLUCyyYMnEkMfTpiO2aniWos225ZfvFNzRGrxHDt
         t1a4NT1AAkWRztdDGXCxHEtA/DzF5mOPOn8n8baRsHalw75SQmJgx+DErcBLuNYcRWtF
         Kqn+JnjMdbenRo5/Cngft8skFWD5vZXpwB51e8aT+ldDUNYfnscl1wRBkfjFa0og8xUa
         BhdGyzq0c/qvZZLVhr7o0ArWQtWZ4rTxii/GeOb0U0LeJ8+eOAt9arm+3VEbJ5XV3Z6z
         m2eA==
X-Gm-Message-State: APt69E1kxCi0GbAh6UVxn7lla3lhZIaCyJbkHlTrhyMwDJXRb97FDtff
        34oYDo/QWypiYz4xRZD9nEKWfA==
X-Google-Smtp-Source: ADUXVKLWm1hd62nr5nF/HNxaGMuvipr7VcMS8FeZFOsaODQSsE+KVYS0wZWbkOezkQsEGJfw1t5lUQ==
X-Received: by 2002:a62:4e07:: with SMTP id c7-v6mr484169pfb.149.1528745750389;
        Mon, 11 Jun 2018 12:35:50 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:0:1000:1501:bc2f:3082:9938:5d41])
        by smtp.gmail.com with ESMTPSA id y2-v6sm26734221pfk.82.2018.06.11.12.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 12:35:48 -0700 (PDT)
From:   Brian Norris <briannorris@chromium.org>
To:     Kalle Valo <kvalo@qca.qualcomm.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>,
        <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH] ath10k: snoc: use module_platform_driver() macro
Date:   Mon, 11 Jun 2018 12:35:40 -0700
Message-Id: <20180611193540.190255-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ath10k_snoc_init()/ath10k_snoc_exit() don't add much value;
module_platform_driver() can remove the boilerplate.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/ath/ath10k/snoc.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index a3a7042fe13a..ee74e0060504 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -1388,25 +1388,7 @@ static struct platform_driver ath10k_snoc_driver = {
 			.of_match_table = ath10k_snoc_dt_match,
 		},
 };
-
-static int __init ath10k_snoc_init(void)
-{
-	int ret;
-
-	ret = platform_driver_register(&ath10k_snoc_driver);
-	if (ret)
-		pr_err("failed to register ath10k snoc driver: %d\n",
-		       ret);
-
-	return ret;
-}
-module_init(ath10k_snoc_init);
-
-static void __exit ath10k_snoc_exit(void)
-{
-	platform_driver_unregister(&ath10k_snoc_driver);
-}
-module_exit(ath10k_snoc_exit);
+module_platform_driver(ath10k_snoc_driver);
 
 MODULE_AUTHOR("Qualcomm");
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.18.0.rc1.242.g61856ae69a-goog

