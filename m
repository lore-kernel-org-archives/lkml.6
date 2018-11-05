Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585BEC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FCD20883
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 17:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="fuQqaG9F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1FCD20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387735AbeKFDTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 22:19:48 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33006 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387503AbeKFDTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 22:19:48 -0500
Received: by mail-lj1-f196.google.com with SMTP id v1-v6so2672657ljd.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 09:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DnarAaeQFJZA4V1lB/qKYr//Z7ZqqiS7Nxyyzf0joQ0=;
        b=fuQqaG9F25AE5HgbBDdvn3778P5jd2q9DXL27XBoZLf9vauamfkdk10w/f+ftiTZMO
         Qq03nUv6XzARhBaQAuSIWYVogLe7EQyHeW6OD11LYvuWvBKGycHbDKjKlToS5rL2GdF4
         AOWamxrzX7BAwI9qq90NNs4fLMb/znO6Rf850=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DnarAaeQFJZA4V1lB/qKYr//Z7ZqqiS7Nxyyzf0joQ0=;
        b=OH/Xu8qyOBRlpyifhWT4ATc2GLssAyyfMlk+yLjTJsRWB5mKHEmHLo6dKlMQD2nK9C
         yetYoJdVsAML667vDr2aQT1MVyifFPoLSU9D1CP1fLSkOChWApOYV5ksSCbP5cUHvb8M
         JXCkLtWx4hpszzfZc6hH6aguPLeG+ovSCECqs9Fvm1CO9MmbV9p/OPiS0n1RQcv4N5ah
         c6vhr0xpaAhsWF7hmKaVlgF547A/iH2DVjm6sfJc2cXBsYAwGG16F1SjvYJj4P2rEfpf
         24/umPSygZA0i6oybBf9bG8sWnu5gJtfBP1H8V9D2DBZpn9bJafaTsSG4xN/DpkN6YLP
         tbnw==
X-Gm-Message-State: AGRZ1gI6dqh7oo8CXd4315Jdz4WrQgaJbHplNoOAZbnOqhDn+7K7upHK
        qMxPgWwG55vvwMS0VRESJr9HoA==
X-Google-Smtp-Source: AJdET5c/P0KK9q6kspVwUbf3l92mLpnwq8TuqMT0KJ/82gcKNxgvJUSMPdkyr8cpVZu8VMVgo3PhcA==
X-Received: by 2002:a2e:96c6:: with SMTP id d6-v6mr1711715ljj.35.1541440349737;
        Mon, 05 Nov 2018 09:52:29 -0800 (PST)
Received: from prevas-ravi.prevas.se (77.241.135.197.mobile.3.dk. [77.241.135.197])
        by smtp.gmail.com with ESMTPSA id x24-v6sm718890ljc.54.2018.11.05.09.52.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Nov 2018 09:52:29 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Jay Cliburn <jcliburn@gmail.com>,
        Chris Snook <chris.snook@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: alx: make alx_drv_name static
Date:   Mon,  5 Nov 2018 18:52:21 +0100
Message-Id: <20181105175222.12337-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.19.1.6.gbde171bbf5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alx_drv_name is not used outside main.c, so there's no reason for it to
have external linkage.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/net/ethernet/atheros/alx/alx.h  | 1 -
 drivers/net/ethernet/atheros/alx/main.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/atheros/alx/alx.h b/drivers/net/ethernet/atheros/alx/alx.h
index 78c5de467426..9d0e74f6b089 100644
--- a/drivers/net/ethernet/atheros/alx/alx.h
+++ b/drivers/net/ethernet/atheros/alx/alx.h
@@ -140,6 +140,5 @@ struct alx_priv {
 };
 
 extern const struct ethtool_ops alx_ethtool_ops;
-extern const char alx_drv_name[];
 
 #endif
diff --git a/drivers/net/ethernet/atheros/alx/main.c b/drivers/net/ethernet/atheros/alx/main.c
index 7968c644ad86..c131cfc1b79d 100644
--- a/drivers/net/ethernet/atheros/alx/main.c
+++ b/drivers/net/ethernet/atheros/alx/main.c
@@ -49,7 +49,7 @@
 #include "hw.h"
 #include "reg.h"
 
-const char alx_drv_name[] = "alx";
+static const char alx_drv_name[] = "alx";
 
 static void alx_free_txbuf(struct alx_tx_queue *txq, int entry)
 {
-- 
2.19.1.6.gbde171bbf5

