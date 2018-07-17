Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC8BECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444DF206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 22:09:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444DF206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbeGQWoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 18:44:24 -0400
Received: from gateway36.websitewelcome.com ([50.116.125.2]:43878 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730652AbeGQWoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 18:44:24 -0400
X-Greylist: delayed 1322 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Jul 2018 18:44:23 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id E6E26400C8BC7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 15:49:18 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id fXotfc86URPojfXotfACCh; Tue, 17 Jul 2018 16:47:43 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=59156 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1ffXot-001Syl-5k; Tue, 17 Jul 2018 16:47:43 -0500
Date:   Tue, 17 Jul 2018 16:47:39 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] power: supply: max77693_charger: fix unintentional
 fall-through
Message-ID: <20180717214739.GA19410@embeddedor.com>
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
X-Source-IP: 189.250.65.56
X-Source-L: No
X-Exim-ID: 1ffXot-001Syl-5k
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:59156
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that a *break* is missing in order to avoid a fall-through.
Otherwise, the calculation of *data* makes no sense.

Addresses-Coverity-ID: 1271172 ("Missing break in switch")
Fixes: 87c2d9067893 ("power: max77693: Add charger driver for Maxim 77693")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/power/supply/max77693_charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
index 6c78884..749c792 100644
--- a/drivers/power/supply/max77693_charger.c
+++ b/drivers/power/supply/max77693_charger.c
@@ -567,6 +567,7 @@ static int max77693_set_charge_input_threshold_volt(struct max77693_charger *chg
 	case 4800000:
 	case 4900000:
 		data = (uvolt - 4700000) / 100000;
+		break;
 	default:
 		dev_err(chg->dev, "Wrong value for charge input voltage regulation threshold\n");
 		return -EINVAL;
-- 
2.7.4

