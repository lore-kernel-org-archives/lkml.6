Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717A5C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9C620836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 17:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728600AbfBUR5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:57:18 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.253]:25816 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725932AbfBUR5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 12:57:18 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 31BCD22672
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 11:57:17 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id wsazgQ3mKdnCewsazgNSoI; Thu, 21 Feb 2019 11:57:17 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=39374 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gwsax-001s23-OH; Thu, 21 Feb 2019 11:57:16 -0600
Date:   Thu, 21 Feb 2019 11:57:14 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] regulator: da9063: Use struct_size() in devm_kzalloc()
Message-ID: <20190221175714.GA3104@embeddedor>
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
X-Source-IP: 189.250.119.20
X-Source-L: No
X-Exim-ID: 1gwsax-001s23-OH
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.20]:39374
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
 drivers/regulator/da9063-regulator.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index a83bbd3dbc37..2b0c7a85306a 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -739,7 +739,6 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 	struct regulator_config config;
 	bool bcores_merged, bmem_bio_merged;
 	int id, irq, n, n_regulators, ret, val;
-	size_t size;
 
 	regl_pdata = da9063_pdata ? da9063_pdata->regulators_pdata : NULL;
 
@@ -784,9 +783,8 @@ static int da9063_regulator_probe(struct platform_device *pdev)
 		n_regulators--;    /* remove BMEM_BIO_MERGED */
 
 	/* Allocate memory required by usable regulators */
-	size = sizeof(struct da9063_regulators) +
-		n_regulators * sizeof(struct da9063_regulator);
-	regulators = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
+	regulators = devm_kzalloc(&pdev->dev, struct_size(regulators,
+				  regulator, n_regulators), GFP_KERNEL);
 	if (!regulators)
 		return -ENOMEM;
 
-- 
2.20.1

