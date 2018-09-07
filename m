Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D42FC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6922077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F32WMMMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6922077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbeIGWEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:04:08 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40048 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeIGWEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:04:08 -0400
Received: by mail-lf1-f66.google.com with SMTP id x26-v6so12636671lfi.7;
        Fri, 07 Sep 2018 10:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iqWj8t//jjvTywXSU6UCipICH2il3mzAgAeuRXBjRyE=;
        b=F32WMMMRqw212dzEVRMarWZxpBOgtFNDOFNNfWxY3vVJscV296V99r06eqF1EGVzn/
         j+U3PFV+v77R+YcvPUIZl6VmBjMDt14ARcOCr1d5NUScx0HM2DFBm6XAOwVJdk1Ppf/k
         vPL59zyAK7z0cRUEzBv2UFlit6oSaoWUKuYIGoWTvfZBnMNU8q8a5CEVBR7YwiFD7AD8
         /CB+/Bme1IlC3mX11Gho5ps8+da8H4vRfNgnFdZGhh+cgNOV37Pb2gZidBfO1lJUQkEL
         al0lMEYfdsEF9TnFfiCa71rbvgbSxGylollWOpq0NHpEQ2gPBQ3nBqsdlEqO4gJwWYoE
         6WmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iqWj8t//jjvTywXSU6UCipICH2il3mzAgAeuRXBjRyE=;
        b=RBgYEia5jcN6EJEWJcZr6YY8dLFoVhvuKQLlt5Ez2+1dBMsJ3HwTjB5Y3sqptSbdrY
         wvMumyIF39GkX4G76E66m3kIHOOShw/NNUxH1ecrKKyI0A9gcRZ5mOn36XavXEI4SWvD
         LFNjGAJIT1qEQYS253v3cZCIU9ipmNxjmiHtqD9HQvAEgdpq+rCMBhBxuo4Wy1xSeds7
         6/9+W1/BIcjabkBduMIc/sSTqs6O/2CPk0XZrmpYmbRi8C4cKXV7f5ug9aq7BbztjOkp
         PHqjB7P+GvHudPtzTm3ErG7Vrt/nLNiIqgmTVr7Vgb6L1nzoIZylvIFUaouYJh/3rx5V
         3MDw==
X-Gm-Message-State: APzg51Cv9jvn1rweMYFaoTRCqFSoA/akdweWCnn1SQRsUd1OqCLCXqLl
        GdRnWZS+dKKtK6/TdIJCnEVvwzNxs8Q=
X-Google-Smtp-Source: ANB0VdY5OGEwIazfTx+CW/70XLmETpgY39g8sd/o94iy+PRW/5YFv6VFGK+ObPfrX8UdYuESLIM1bA==
X-Received: by 2002:a19:c646:: with SMTP id w67-v6mr6027365lff.108.1536340932122;
        Fri, 07 Sep 2018 10:22:12 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-156-179-220.elisa-laajakaista.fi. [91.156.179.220])
        by smtp.gmail.com with ESMTPSA id g11-v6sm1358286ljk.45.2018.09.07.10.22.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 10:22:11 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        linux-wimax@intel.com, "David S. Miller" <davem@davemloft.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] wimax: i2400m: remove unnecessary unlikely()
Date:   Fri,  7 Sep 2018 20:22:03 +0300
Message-Id: <20180907172203.28668-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to
wrap it into another.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Cc: linux-wimax@intel.com
Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/wimax/i2400m/tx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wimax/i2400m/tx.c b/drivers/net/wimax/i2400m/tx.c
index f20886ade1cc..59c70d928249 100644
--- a/drivers/net/wimax/i2400m/tx.c
+++ b/drivers/net/wimax/i2400m/tx.c
@@ -655,8 +655,7 @@ void i2400m_tx_close(struct i2400m *i2400m)
 	padding = aligned_size - tx_msg_moved->size;
 	if (padding > 0) {
 		pad_buf = i2400m_tx_fifo_push(i2400m, padding, 0, 0);
-		if (unlikely(WARN_ON(pad_buf == NULL
-				     || pad_buf == TAIL_FULL))) {
+		if (WARN_ON(!pad_buf || pad_buf == TAIL_FULL)) {
 			/* This should not happen -- append should verify
 			 * there is always space left at least to append
 			 * tx_block_size */
-- 
2.17.1

