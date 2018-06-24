Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C843C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1902500B
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1K8qELH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1902500B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755400AbeFXPgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:36:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54947 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755381AbeFXPgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:36:09 -0400
Received: by mail-wm0-f67.google.com with SMTP id o13-v6so6595189wmf.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 08:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uU0frDl58uzTtA+itjr8MZmO22yUCjWP957h1Al5ZK8=;
        b=O1K8qELHy3ttG/2fFU02oqwHGX16T+dYD1aiglgXntKH0ZzE2IFVaghzigJ8x0nlD8
         2im4nPXFAtjvvqFnl7HBLznVcpWzcW9pR/M7KT7G5OZvK/B0mtpSwllySdZ0EZfh6vgc
         g7YaVvWM929SrrXmH6OKA9DpAdWq3wehEmF53Ka9bWcXbXJWO+DIBez1VCVoO8ujTBQp
         8FNiijZX2d7IcolUgTIgf8ouvPrZoyN2TaxHBBX2/p6V7ahNdSCtFOAAicJdoePmjjqv
         Sz9RlPu6TcnRk4knghC0sBbOMXZPsk/o5mlbj4bjVcw4lyaV/uCVhPSvLTBSlYbbw3O8
         jCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uU0frDl58uzTtA+itjr8MZmO22yUCjWP957h1Al5ZK8=;
        b=b/Gl2idHkGF2ugXred+Cr54OeAOLZbIJhQQ+fF3KQB1By5d5vc//mlZbKdbOhsctGo
         T4IbJoM2A7D5CfISFYg4IaJySL5TFOEEYh7x9EiH5LJLwwlreB/Epf6Pwg3BuDzuPyQW
         czh+CZ0BS2yUhxuJoTQ4Kkg0E3o5ZqZiXLxodbbqhgUJe8jyvmyYzwijojEpC67bj5Tc
         4fQRCN1etVyZRL9aVwRR7UODjaW2HNT2sGoms2kiirjg5uyrDGl4Dr+Bh0EsIPBvrAkq
         qGkfYCLhDOc0bF3FomNcr9lHEMpCRd2cXJA2MrNFh48Fi4DAzRv22uMTQJyYUdbxGYfd
         qzaA==
X-Gm-Message-State: APt69E3qUUkoZRIlWzViVtx3rD1rup3QNWRo4yU4doMquwalgUs2tgdn
        sXwQ7BZOL1GC1GvRGd1EklYLS1PT
X-Google-Smtp-Source: ADUXVKLHBauT8GFgUlKfyHMzu4GodpLHmrTNQUWsxgbhQuh5MgJvtiKESYTCyp53fMDQDNXCerUa2g==
X-Received: by 2002:a1c:d11:: with SMTP id 17-v6mr6731210wmn.81.1529854567986;
        Sun, 24 Jun 2018 08:36:07 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id j10-v6sm1505813wro.53.2018.06.24.08.36.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 08:36:07 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v3 7/8] staging: rtl8192u: Correct if statement - Coding Style
Date:   Sun, 24 Jun 2018 16:34:53 +0100
Message-Id: <20180624153454.27356-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180624153454.27356-1-johnfwhitmore@gmail.com>
References: <20180624153454.27356-1-johnfwhitmore@gmail.com>
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

