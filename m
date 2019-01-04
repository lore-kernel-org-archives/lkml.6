Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E44AC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4938D218FE
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfADRhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:37:39 -0500
Received: from gateway23.websitewelcome.com ([192.185.50.185]:49091 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725958AbfADRhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:37:39 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id F21351AF6C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jan 2019 11:37:38 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id fTPeglqhFdnCefTPegschB; Fri, 04 Jan 2019 11:37:38 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=35296 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gfTPe-000SB1-7D; Fri, 04 Jan 2019 11:37:38 -0600
Date:   Fri, 4 Jan 2019 11:37:33 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] pinctrl: mcp23s08: use struct_size() in devm_kzalloc()
Message-ID: <20190104173733.GA29979@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gfTPe-000SB1-7D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:35296
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 33
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    void *entry[];
};

instance = devm_kzalloc(dev, sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = devm_kzalloc(dev, struct_size(instance, entry, count), GFP_KERNEL);

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/pinctrl/pinctrl-mcp23s08.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-mcp23s08.c b/drivers/pinctrl/pinctrl-mcp23s08.c
index b03481ef99a1..6b4def13df8f 100644
--- a/drivers/pinctrl/pinctrl-mcp23s08.c
+++ b/drivers/pinctrl/pinctrl-mcp23s08.c
@@ -1139,8 +1139,7 @@ static int mcp23s08_probe(struct spi_device *spi)
 		return -ENODEV;
 
 	data = devm_kzalloc(&spi->dev,
-			    sizeof(*data) + chips * sizeof(struct mcp23s08),
-			    GFP_KERNEL);
+			    struct_size(data, chip, chips), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-- 
2.20.1

