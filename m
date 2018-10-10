Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40D1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3562214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:13:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3562214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbeJJWg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:36:29 -0400
Received: from gateway31.websitewelcome.com ([192.185.143.43]:42169 "EHLO
        gateway31.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726699AbeJJWg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:36:28 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway31.websitewelcome.com (Postfix) with ESMTP id 283BE8BCF
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 10:13:51 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id AGAmgEiCs8YaUAGB6ggJSD; Wed, 10 Oct 2018 10:13:50 -0500
X-Authority-Reason: nr=8
Received: from 57.154.24.109.rev.sfr.net ([109.24.154.57]:48128 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gAGAl-004KJk-HY; Wed, 10 Oct 2018 10:13:16 -0500
Date:   Wed, 10 Oct 2018 17:13:13 +0200
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2] pinctrl: madera: Fix uninitialized variable bug in
 madera_mux_set_mux
Message-ID: <20181010151313.GA16854@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 109.24.154.57
X-Source-L: No
X-Exim-ID: 1gAGAl-004KJk-HY
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 57.154.24.109.rev.sfr.net (embeddedor) [109.24.154.57]:48128
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a potential execution path in which variable *ret* is checked
in an IF statement, and then its value is used to report an error at
line 659 without being properly initialized previously:

659 if (ret)
660	dev_err(priv->dev, "Failed to write to 0x%x (%d)\n", reg, ret);

Fix this by initializing variable *ret* to 0 in order to
avoid unpredictable or unintended results.

Addresses-Coverity-ID: 1471969 ("Uninitialized scalar variable")
Fixes: 218d72a77b0b ("pinctrl: madera: Add driver for Cirrus Logic Madera codecs")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Initialize variable ret to 0 instead of -1. Thanks to Charles Keepax
   for pointing this out.
 - Update subject and commit log.

 drivers/pinctrl/cirrus/pinctrl-madera-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/cirrus/pinctrl-madera-core.c b/drivers/pinctrl/cirrus/pinctrl-madera-core.c
index 0266302..a5dda83 100644
--- a/drivers/pinctrl/cirrus/pinctrl-madera-core.c
+++ b/drivers/pinctrl/cirrus/pinctrl-madera-core.c
@@ -608,7 +608,7 @@ static int madera_mux_set_mux(struct pinctrl_dev *pctldev,
 	unsigned int n_chip_groups = priv->chip->n_pin_groups;
 	const char *func_name = madera_mux_funcs[selector].name;
 	unsigned int reg;
-	int i, ret;
+	int i, ret = 0;
 
 	dev_dbg(priv->dev, "%s selecting %u (%s) for group %u (%s)\n",
 		__func__, selector, func_name, group,
-- 
2.7.4

