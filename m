Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BECC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8A7218CD
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbfADRkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:40:04 -0500
Received: from gateway30.websitewelcome.com ([192.185.147.85]:19926 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725958AbfADRkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:40:04 -0500
X-Greylist: delayed 1269 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Jan 2019 12:40:04 EST
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id C8C6B36CE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jan 2019 11:18:54 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id fT7WgdT3ciQerfT7Wgfr7E; Fri, 04 Jan 2019 11:18:54 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=34900 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gfT7V-000GyY-Se; Fri, 04 Jan 2019 11:18:54 -0600
Date:   Fri, 4 Jan 2019 11:18:51 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 2/2] ARM: integrator: impd1: use struct_size() in
 devm_kzalloc()
Message-ID: <9005dbee894cfbada5e57d6ddda9fdf4d711b0a4.1546621488.git.gustavo@embeddedor.com>
References: <cover.1546621488.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1546621488.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gfT7V-000GyY-Se
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:34900
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 12
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
 arch/arm/mach-integrator/impd1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index eb0149561be2..8ccf01af3817 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -389,8 +389,8 @@ static int __ref impd1_probe(struct lm_device *dev)
 			char *chipname;
 			char *mmciname;
 
-			lookup = devm_kzalloc(&dev->dev,
-					      sizeof(*lookup) + 3 * sizeof(struct gpiod_lookup),
+			lookup = devm_kzalloc(&dev->deva,
+					      struct_size(lookup, table, 3),
 					      GFP_KERNEL);
 			if (!lookup)
 				return -ENOMEM;
-- 
2.20.1

