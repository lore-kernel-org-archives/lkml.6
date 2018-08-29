Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701DBC43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286362086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZiPY7gA7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286362086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbeH2Lxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:53:44 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46143 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbeH2Lxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:53:43 -0400
Received: by mail-lf1-f67.google.com with SMTP id e23-v6so3499830lfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n5N7rzo2Yz6ToBgcoJnkbL1OiPAx5DE6sy5tATHXNvo=;
        b=ZiPY7gA7J17PKABvvERsIGACUT9ycbQk2koUQRQauwaRddCew4S4x2tgVFCDLveVQV
         v2Ch4TRSQRXa/LbP1LDqpYFCPtmyRpx+27sAp02/nC2WtpJED7y5JAzd7s6poancIZf6
         owWVvwdR8w15N7PTsFemdubA4Vd5eQGaUwke4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n5N7rzo2Yz6ToBgcoJnkbL1OiPAx5DE6sy5tATHXNvo=;
        b=LxT8HtxqsZu0oImAikVkuQc9SBEPJUqN6MqI9FtIhm+sjuHfcWQI6FU/iy7rBd66Dq
         wmVfDaA70X0+5iIgiSZTEl9rx2hPKAprmCrINX7Qn1kmL0QdTdjPK8GWeHtqDgRhXaSK
         jkJnhjL53lh7NUdAebnQ7bD/12rQZfDlYUdFOc85TtIm5wDThbDGymtWUnkfX1XWrc4k
         DbPSG3wH7bbOWAKFWkJF39IMp7BqRv8Ek1SiBMsnhTRv4pdtq89bDTdVolnAf063GKMR
         ilmRRG5WV/kCvgDxpqjeQuvkfxtx4LrKCva7qykUNqRIVj1RXHacDS6/Xu+Uh1U5l1Pq
         lo3g==
X-Gm-Message-State: APzg51CyWeYWCWZG/dEZs650SbapbMqlOx0/Qkh7m5ufZUDcOBCtxRQQ
        lhwEAwfxWrDNMkSYB3NgGvu16w==
X-Google-Smtp-Source: ANB0VdbK9tycsTbfyUwaPfZv1moWKY93ozWFXTSx9CpQQLzn8fe5WbNKOytMFCEtx+6WYBxhFqvKOw==
X-Received: by 2002:a19:9355:: with SMTP id v82-v6mr3418687lfd.134.1535529485106;
        Wed, 29 Aug 2018 00:58:05 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id j9-v6sm592303ljh.40.2018.08.29.00.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 00:58:04 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 7/9] soc: qcom: wcnss_ctrl: Avoid string overflow
Date:   Wed, 29 Aug 2018 09:57:21 +0200
Message-Id: <20180829075724.9095-8-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829075724.9095-1-niklas.cassel@linaro.org>
References: <20180829075724.9095-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'chinfo.name' is used as a NUL-terminated string, but using strncpy() with
the length equal to the buffer size may result in lack of the termination:

drivers//soc/qcom/wcnss_ctrl.c: In function 'qcom_wcnss_open_channel':
drivers//soc/qcom/wcnss_ctrl.c:284:2: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
  strncpy(chinfo.name, name, sizeof(chinfo.name));
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This changes it to use the safer strscpy() instead.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/soc/qcom/wcnss_ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/wcnss_ctrl.c b/drivers/soc/qcom/wcnss_ctrl.c
index df3ccb30bc2d..373400dd816d 100644
--- a/drivers/soc/qcom/wcnss_ctrl.c
+++ b/drivers/soc/qcom/wcnss_ctrl.c
@@ -281,7 +281,7 @@ struct rpmsg_endpoint *qcom_wcnss_open_channel(void *wcnss, const char *name, rp
 	struct rpmsg_channel_info chinfo;
 	struct wcnss_ctrl *_wcnss = wcnss;
 
-	strncpy(chinfo.name, name, sizeof(chinfo.name));
+	strscpy(chinfo.name, name, sizeof(chinfo.name));
 	chinfo.src = RPMSG_ADDR_ANY;
 	chinfo.dst = RPMSG_ADDR_ANY;
 
-- 
2.17.1

