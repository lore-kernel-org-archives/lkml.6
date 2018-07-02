Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687FAC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B2A25A24
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13B2A25A24
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753630AbeGBVvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:51:44 -0400
Received: from gateway34.websitewelcome.com ([192.185.150.107]:19295 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753068AbeGBVvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:51:43 -0400
X-Greylist: delayed 1283 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Jul 2018 17:51:43 EDT
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 89360C806
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jul 2018 16:30:19 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id a6Oofn1apkBj6a6OpfBgAb; Mon, 02 Jul 2018 16:30:19 -0500
X-Authority-Reason: nr=8
Received: from [189.250.65.56] (port=38150 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fa6Oo-0045zE-E0; Mon, 02 Jul 2018 16:30:18 -0500
Date:   Mon, 2 Jul 2018 16:30:17 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] hwmon: Mark expected switch fall-throughs
Message-ID: <20180702213017.GA27242@embeddedor.com>
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
X-Exim-ID: 1fa6Oo-0045zE-E0
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.65.56]:38150
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/hwmon/emc1403.c | 2 ++
 drivers/hwmon/nct6775.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
index 1ea7ca5..aaebeb7 100644
--- a/drivers/hwmon/emc1403.c
+++ b/drivers/hwmon/emc1403.c
@@ -443,8 +443,10 @@ static int emc1403_probe(struct i2c_client *client,
 	switch (id->driver_data) {
 	case emc1404:
 		data->groups[2] = &emc1404_group;
+		/* fall through */
 	case emc1403:
 		data->groups[1] = &emc1403_group;
+		/* fall through */
 	case emc1402:
 		data->groups[0] = &emc1402_group;
 	}
diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 3714990..c6bd61e 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -2541,7 +2541,7 @@ static void pwm_update_registers(struct nct6775_data *data, int nr)
 	case thermal_cruise:
 		nct6775_write_value(data, data->REG_TARGET[nr],
 				    data->target_temp[nr]);
-		/* intentional */
+		/* fall through  */
 	default:
 		reg = nct6775_read_value(data, data->REG_FAN_MODE[nr]);
 		reg = (reg & ~data->tolerance_mask) |
-- 
2.7.4

