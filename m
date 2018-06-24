Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4566EC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 16:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014E3251B0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 16:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTJ9Aiz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 014E3251B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754985AbeFXQET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 12:04:19 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36904 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755910AbeFXPlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:41:04 -0400
Received: by mail-wr0-f195.google.com with SMTP id k6-v6so11134406wrp.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 08:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uU0frDl58uzTtA+itjr8MZmO22yUCjWP957h1Al5ZK8=;
        b=JTJ9Aiz56jcQw7Z0RwFk4AlZRUkzapdVuqGsKyQA/OFOr1hvFotycmR9TtUA9u+PdM
         UQOsN8x4loGBpr6nVno/PxIQTGtzShwY8H4ZJcu5yiAlJ4noo+TeQitwNQ2vJcV6k6BY
         wPIaCSyiOQs4UezlCDULN1Vv0KggzSpL2lqfwCJMk34UAnmEQneJzKDsIzAhsuzW5yvW
         b9YK1+r2Tnoj9sja8wIC4kWbdWqlyt0qU5wiX0yr9DYaD6ya5vqqPmWgacsamE6JPQKh
         o6XivxTMAGduJi5dTwCDwIznpXMuhibplhKT7Nr1FQtxnGw+lz8uhuwPTX6GKNCCfu8S
         z8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uU0frDl58uzTtA+itjr8MZmO22yUCjWP957h1Al5ZK8=;
        b=BPWf2EwWcqnYWPIUZEmy6AzLrxrUHNsHPIC38xtkKdjDEX0PCHEsvRrrfhFTRL8e8Z
         eMnhRILgvFmybFQMnjeAxrXlrbJvUJhgb1sF89bCX2nuOr4tue0+TvzaTqiI/0JOkvxw
         iqytEg/UGKIhVZKKjMBswEQ3TgWGx4EFoLUWOW1VmMCc07CZbk+hA1d1azbTqFE9kQ8+
         wmeYgcBSU/TVQmzKw0l77Cc12XSotW3vJTNvrPdmmigSHcNyRW1ECWpiiJ7qfi0LPr/1
         p8kHUcDfhsXxMSTQtUhggUtbJ+aAu6RVSFX595uY10WvugsaJrXORiErLYcOW9S5SzGY
         tpkA==
X-Gm-Message-State: APt69E2UoGGP8jt6VpF8N1xBPvU1Tus1gPpYByNS9KZgjpwCYFg+heMe
        0yOtV6E6XGEMP3DauereHSNJoJl/
X-Google-Smtp-Source: AAOMgpedFxkEnPA/pzxk10Hc7nLzo6mb3mZITgG06TwPYPQvqNQHIOf6oHcP+ZZMQ/HY05F5NDVQ4g==
X-Received: by 2002:a5d:4c4c:: with SMTP id n12-v6mr7213533wrt.71.1529854863096;
        Sun, 24 Jun 2018 08:41:03 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id w12-v6sm2782920wrp.69.2018.06.24.08.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 08:41:02 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v3 7/8] staging: rtl8192u: Correct if statement - Coding Style
Date:   Sun, 24 Jun 2018 16:40:26 +0100
Message-Id: <20180624154027.27654-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180624154027.27654-1-johnfwhitmore@gmail.com>
References: <20180624154027.27654-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Corrected the coding style of if statement.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 227710419123..07259f108ee5 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -732,7 +732,7 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
 	   section of code.
 	if(IS_UNDER_11N_AES_MODE(Adapter))
 	{
-		posRT2RTAgg->Octet[5] |=RT_HT_CAP_USE_AMPDU;
+		posRT2RTAgg->Octet[5] |= RT_HT_CAP_USE_AMPDU;
 	}else
 	{
 		posRT2RTAgg->Octet[5] &= 0xfb;
-- 
2.17.1

