Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0C5C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F066120700
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 01:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfBWBy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 20:54:59 -0500
Received: from gateway23.websitewelcome.com ([192.185.48.251]:20751 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725821AbfBWBy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 20:54:58 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id C7E9819E98
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 19:54:57 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id xMWngr1RXdnCexMWngoAdZ; Fri, 22 Feb 2019 19:54:57 -0600
X-Authority-Reason: nr=8
Received: from [189.250.127.169] (port=37098 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gxMWi-001UNS-7p; Fri, 22 Feb 2019 19:54:56 -0600
Date:   Fri, 22 Feb 2019 19:54:51 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] regulator: da9062: Use struct_size() in devm_kzalloc()
Message-ID: <20190223015451.GA24619@embeddedor>
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
X-Source-IP: 189.250.127.169
X-Source-L: No
X-Exim-ID: 1gxMWi-001UNS-7p
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.127.169]:37098
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
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
    struct boo entry[];
};

size = sizeof(struct foo) + count * sizeof(struct boo);
instance = alloc(size, GFP_KERNEL)

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = alloc(struct_size(instance, entry, count), GFP_KERNEL)

Notice that, in this case, variable size is not necessary, hence it is
removed.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/regulator/da9062-regulator.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/da9062-regulator.c b/drivers/regulator/da9062-regulator.c
index 4c5d6ad853f8..b064d8a19d4c 100644
--- a/drivers/regulator/da9062-regulator.c
+++ b/drivers/regulator/da9062-regulator.c
@@ -992,7 +992,6 @@ static int da9062_regulator_probe(struct platform_device *pdev)
 	struct regulator_config config = { };
 	const struct da9062_regulator_info *rinfo;
 	int irq, n, ret;
-	size_t size;
 	int max_regulators;
 
 	switch (chip->chip_type) {
@@ -1010,9 +1009,8 @@ static int da9062_regulator_probe(struct platform_device *pdev)
 	}
 
 	/* Allocate memory required by usable regulators */
-	size = sizeof(struct da9062_regulators) +
-		max_regulators * sizeof(struct da9062_regulator);
-	regulators = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
+	regulators = devm_kzalloc(&pdev->dev, struct_size(regulators, regulator,
+				  max_regulators), GFP_KERNEL);
 	if (!regulators)
 		return -ENOMEM;
 
-- 
2.20.1

