Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB679C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CDB208CC
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ElbL84SG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7CDB208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753885AbeFTIby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:31:54 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50453 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752595AbeFTIbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:31:49 -0400
Received: by mail-wm0-f66.google.com with SMTP id e16-v6so4557413wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 01:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=vMyB2IQKZanP4u9MqlYTIvUXmn5PjPp1LYr/SfaYsNA=;
        b=ElbL84SGMWemJJAFpFPG6wdKdLQWGQUZw9A1EoKH+BpKIWvuvMtfJxJIk1BGp2XwXn
         cQmt7J6H9uqINYGeJkAo77vcMe2VquN+k/ndUpQys9zuEpkDx9NbAUp4GwHAFcW4yszK
         M3Es/E+vvX4cCetRh28myJMW4OEzkEU6RYrnMJbtqktrNqDxmsIXqPbkjvVwp1ub1OYS
         iMf5R4zYU88nV8rlAXYQ6OApuijaM6zwvvLWkfpfsxbG/efDpW90XQSfvReyGh7TNevN
         8WoMLhs0OeAYCO733pgMdO7XC9A10/I2NreWzbhWkzPctQrnZCFHzMCT0PEPL54eF+me
         xXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vMyB2IQKZanP4u9MqlYTIvUXmn5PjPp1LYr/SfaYsNA=;
        b=azQaMrDy+ios128RVXHzk1BfesvwfXYsieSLjC25vjwKwvi+lZEkeLh2SM9rTGoMqW
         Wy5bBdHLOPhc/KDB80+xnxPjhDrFXVfrZ9hqVn+SrvCWdaHyrQtSGmMRtxrq+XcsINM3
         WIy/lgTRoDwvEUW24MA591NwQTtLq2WnQL/XACkPVIu2ZoXijFeq4pxeFY5oPSxYL0Gv
         xbWEgGE8Y6m5H8kuz7fXDTsQbrW2y4FdARVS3PYPQjB+NkUai2jyWxlSVh4yTBRJ8q6a
         YLnUKXO2pWivczIC6TJi5dvdV2Aow4pAYcq/8rptuM0IF7Zii6SyYiRsmDl0BG6Y3Ol9
         nP2Q==
X-Gm-Message-State: APt69E2wTqIlb1+NliRzWP8Js6PL3zcpDD9K0xgbrFUPjzaIfYrWA7C6
        hCO1jNrceveSZ8GuPLSwrwl2sw==
X-Google-Smtp-Source: ADUXVKJbLe3dmLqFTVW8hkNYyECTdo1HWty74I+us/UolRxg3hc+ONXH1D9pKMmjY6ghPyNGdPs2XQ==
X-Received: by 2002:a1c:8b52:: with SMTP id n79-v6mr821346wmd.148.1529481842291;
        Wed, 20 Jun 2018 01:04:02 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-13-249.w90-86.abo.wanadoo.fr. [90.86.134.249])
        by smtp.gmail.com with ESMTPSA id t14-v6sm2131704wrm.79.2018.06.20.01.04.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 01:04:01 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Rob Herring <robh@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>, Andrew Lunn <andrew@lunn.ch>
Cc:     linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 0/2] net: davinci_emac: fix suspend/resume (both a regression and a common clk problem)
Date:   Wed, 20 Jun 2018 10:03:54 +0200
Message-Id: <20180620080356.11900-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Earlier I sent the first patch as a solution to a regression introduced
during the v4.16 merge window, but after testing David's common clock
series on top of 4.18-rc1 + this patch it turned out that the problem
persisted.

This is a follow-up containing the regression fix and an additional
patche that makes suspend/resume work with David's changes.

v1 -> v2:
- dropped patch 2/3
- in patch 2/2: check the device's parent's compatible

Bartosz Golaszewski (2):
  net: ethernet: fix suspend/resume in davinci_emac
  net: davinci_emac: match the mdio device against its compatible if
    possible

 drivers/net/ethernet/ti/davinci_emac.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

-- 
2.17.1

