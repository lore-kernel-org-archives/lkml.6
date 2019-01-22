Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6BEC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB46321726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbfAVQ4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:56:40 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.196]:22154 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729454AbfAVQ4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:56:38 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id ACD8F3CD0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 10:56:37 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id lzLpgXjjq4FKplzLpgwZLE; Tue, 22 Jan 2019 10:56:37 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=57638 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1glzLp-0046Yi-2m; Tue, 22 Jan 2019 10:56:37 -0600
Date:   Tue, 22 Jan 2019 10:56:36 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 1/2] mfd: sm501: Fix potential NULL pointer dereference
Message-ID: <6376930a04650c2dafcbe306f6d402794c30d5b3.1548175934.git.gustavo@embeddedor.com>
References: <cover.1548175934.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548175934.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1glzLp-0046Yi-2m
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:57638
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a potential NULL pointer dereference in case devm_kzalloc()
fails and returns NULL.

Fix this by adding a NULL check on *lookup*

This bug was detected with the help of Coccinelle.

Fixes: b2e63555592f ("i2c: gpio: Convert to use descriptors")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mfd/sm501.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index a530972c5a7e..e0173bf4b0dc 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1145,6 +1145,9 @@ static int sm501_register_gpio_i2c_instance(struct sm501_devdata *sm,
 	lookup = devm_kzalloc(&pdev->dev,
 			      sizeof(*lookup) + 3 * sizeof(struct gpiod_lookup),
 			      GFP_KERNEL);
+	if (!lookup)
+		return -ENOMEM;
+
 	lookup->dev_id = "i2c-gpio";
 	if (iic->pin_sda < 32)
 		lookup->table[0].chip_label = "SM501-LOW";
-- 
2.20.1

