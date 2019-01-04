Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E170C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E0B20656
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 17:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfADRYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 12:24:36 -0500
Received: from gateway24.websitewelcome.com ([192.185.50.84]:27446 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727352AbfADRYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 12:24:35 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id EE50F10344
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jan 2019 11:17:55 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id fT6ZgUSGZ2qH7fT6ZgAAYw; Fri, 04 Jan 2019 11:17:55 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=34892 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gfT6Y-000GOH-7p; Fri, 04 Jan 2019 11:17:54 -0600
Date:   Fri, 4 Jan 2019 11:17:53 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH 1/2] ARM: integrator: impd1: fix NULL pointer dereference
Message-ID: <84a16ed64a29984b11c34b4f31cdef0758ffbfb2.1546621488.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1gfT6Y-000GOH-7p
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:34892
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a potential NULL pointer dereference in case devm_kzalloc()
fails and returns NULL.

Fix this by adding a NULL check on lookup.

This issue was detected with the help of Coccinelle.

Fixes: 684284b64aae ("ARM: integrator: add MMCI device to IM-PD1")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 arch/arm/mach-integrator/impd1.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-integrator/impd1.c b/arch/arm/mach-integrator/impd1.c
index a109f6482413..eb0149561be2 100644
--- a/arch/arm/mach-integrator/impd1.c
+++ b/arch/arm/mach-integrator/impd1.c
@@ -392,6 +392,9 @@ static int __ref impd1_probe(struct lm_device *dev)
 			lookup = devm_kzalloc(&dev->dev,
 					      sizeof(*lookup) + 3 * sizeof(struct gpiod_lookup),
 					      GFP_KERNEL);
+			if (!lookup)
+				return -ENOMEM;
+
 			chipname = devm_kstrdup(&dev->dev, devname, GFP_KERNEL);
 			mmciname = kasprintf(GFP_KERNEL, "lm%x:00700", dev->id);
 			lookup->dev_id = mmciname;
-- 
2.20.1

