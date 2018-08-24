Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1810DC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 01:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20BC21557
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 01:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B20BC21557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbeHXEjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 00:39:53 -0400
Received: from gateway21.websitewelcome.com ([192.185.45.31]:17641 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726143AbeHXEjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 00:39:52 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 80D26400E9FC0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 20:07:38 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id t0Z9f2bO1PvAdt0ZRf0zDg; Thu, 23 Aug 2018 20:07:38 -0500
X-Authority-Reason: nr=8
Received: from [189.250.73.28] (port=44084 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ft0Z9-003RE1-6O; Thu, 23 Aug 2018 20:07:07 -0500
Date:   Thu, 23 Aug 2018 20:07:06 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] memory: atmel-ebi: Use struct_size() in devm_kzalloc()
Message-ID: <20180824010706.GA25522@embeddedor.com>
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
X-Source-IP: 189.250.73.28
X-Source-L: No
X-Exim-ID: 1ft0Z9-003RE1-6O
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.73.28]:44084
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
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

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/memory/atmel-ebi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index b907865..c3748b4 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -327,8 +327,7 @@ static int atmel_ebi_dev_setup(struct atmel_ebi *ebi, struct device_node *np,
 		return -EINVAL;
 	}
 
-	ebid = devm_kzalloc(ebi->dev,
-			    sizeof(*ebid) + (numcs * sizeof(*ebid->configs)),
+	ebid = devm_kzalloc(ebi->dev, struct_size(ebid, configs, numcs),
 			    GFP_KERNEL);
 	if (!ebid)
 		return -ENOMEM;
-- 
2.7.4

