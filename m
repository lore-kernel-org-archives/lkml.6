Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C4BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13DB7206A3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=4sigma.it header.i=@4sigma.it header.b="QUQr1CTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfBUXNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 18:13:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35209 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfBUXNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 18:13:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id t18so345969wrx.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 15:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=4sigma.it; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qtJLFBXgkYdI/h6OpEbdGjMWc1iqyJYezad5IMGHUs0=;
        b=QUQr1CTiQz/wn4QX2q46U63jvxZvqc0ODSsIMrQRU0QW7sSKm+pDVhlBX5100VIo5/
         iwF9A0CdUTPLsOogGJlmojT2ebuBqKJT6y91llkn4fp9qcpXo4/zRItsO8cnfUb+2nwg
         iVU/f9qD28DneH7TbUYV/+3c1rOhH1Hy4RXes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qtJLFBXgkYdI/h6OpEbdGjMWc1iqyJYezad5IMGHUs0=;
        b=NnJuRDtKDbvAIHm5HuBVfFp9T06GSBf91ZgcdZnHpR2awKXwO2VF5MpQHi4YiIgpMR
         rOSy/RUbIIGM1e2XvAgItVHnrPm6gDqSzkBOkbxREAImWmq3nvhEAv1KFilssNf5t/qa
         jo2YJkizSffGcr+1P5RtcbYCLr/Z7GhqQGKQEF+93wH9FvGphg5Ofluv2SAQQ6zXrkej
         br7lwUBXphkneAExXiGzicF886UKDUdrOYx5CHhquBfotFB8P9oJpuoD+pFg7sp9Y7kH
         gaO4xv4GAkmY3LuWfZAbGHlrmHCXe00DZHC+vrysn63aOko/MGCIfb3lEe3M0kICfqx1
         dCew==
X-Gm-Message-State: AHQUAubliXMX6a9kHlWrKWGgl1v/gFDTgXq+PlU10aenZyVVlIuuBGlm
        JAIwLTOZ9aHBMT9xHIuNLjdmBA==
X-Google-Smtp-Source: AHgI3IY7mT0sBYWrazgq7Q+AUwdUjpvxDh/i2fHqI+OleshXAnRa3sMPgNShvQu0hT+qOrF2GgAJQQ==
X-Received: by 2002:a5d:5504:: with SMTP id b4mr571750wrv.291.1550790795261;
        Thu, 21 Feb 2019 15:13:15 -0800 (PST)
Received: from localhost.localdomain (host121-71-dynamic.24-79-r.retail.telecomitalia.it. [79.24.71.121])
        by smtp.googlemail.com with ESMTPSA id i13sm144959wrm.86.2019.02.21.15.13.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 15:13:14 -0800 (PST)
From:   Andrea Greco <a.greco@4sigma.it>
X-Google-Original-From: Andrea Greco <andrea.greco.gapmilano@gmail.com>
To:     johannes.berg@intel.com
Cc:     Andrea Greco <a.greco@4sigma.it>,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ath9K: debugfs: Fix SPUR-DOWN field
Date:   Fri, 22 Feb 2019 00:12:57 +0100
Message-Id: <20190221231257.6221-1-andrea.greco.gapmilano@gmail.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Greco <a.greco@4sigma.it>

SPUR DOWN field return spurup inside of spurdown

Signed-off-by: Andrea Greco <a.greco@4sigma.it>
---
 drivers/net/wireless/ath/ath9k/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath9k/debug.c b/drivers/net/wireless/ath/ath9k/debug.c
index 4399e9ad058f..d4a2cdf9212c 100644
--- a/drivers/net/wireless/ath/ath9k/debug.c
+++ b/drivers/net/wireless/ath/ath9k/debug.c
@@ -148,7 +148,7 @@ static ssize_t read_file_ani(struct file *file, char __user *user_buf,
 		{ "OFDM LEVEL", ah->ani.ofdmNoiseImmunityLevel },
 		{ "CCK LEVEL", ah->ani.cckNoiseImmunityLevel },
 		{ "SPUR UP", ah->stats.ast_ani_spurup },
-		{ "SPUR DOWN", ah->stats.ast_ani_spurup },
+		{ "SPUR DOWN", ah->stats.ast_ani_spurdown },
 		{ "OFDM WS-DET ON", ah->stats.ast_ani_ofdmon },
 		{ "OFDM WS-DET OFF", ah->stats.ast_ani_ofdmoff },
 		{ "MRC-CCK ON", ah->stats.ast_ani_ccklow },
-- 
2.17.2

