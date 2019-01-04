Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9EAC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078B821872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727642AbfADRs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:48:26 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.154]:44971 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726309AbfADRsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:48:25 -0500
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 9DA18400DA0E8
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jan 2019 11:48:24 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id fTa4gTHmB90onfTa4gyEqN; Fri, 04 Jan 2019 11:48:24 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=35476 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gfTa3-000YoP-Ji; Fri, 04 Jan 2019 11:48:24 -0600
Date:   Fri, 4 Jan 2019 11:48:19 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] sc16is7xx: Use struct_size() in devm_kzalloc()
Message-ID: <20190104174819.GA32645@embeddedor>
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
X-Exim-ID: 1gfTa3-000YoP-Ji
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:35476
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 41
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
 drivers/tty/serial/sc16is7xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 268098681856..635178cf3eed 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1187,9 +1187,7 @@ static int sc16is7xx_probe(struct device *dev,
 		return PTR_ERR(regmap);
 
 	/* Alloc port structure */
-	s = devm_kzalloc(dev, sizeof(*s) +
-			 sizeof(struct sc16is7xx_one) * devtype->nr_uart,
-			 GFP_KERNEL);
+	s = devm_kzalloc(dev, struct_size(s, p, devtype->nr_uart), GFP_KERNEL);
 	if (!s) {
 		dev_err(dev, "Error allocating port structure\n");
 		return -ENOMEM;
-- 
2.20.1

