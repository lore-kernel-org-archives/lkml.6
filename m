Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999E3C4646D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5110E215FA
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 13:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5110E215FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbeHOQfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 12:35:41 -0400
Received: from gateway20.websitewelcome.com ([192.185.69.18]:45580 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729222AbeHOQfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 12:35:41 -0400
X-Greylist: delayed 1425 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Aug 2018 12:35:40 EDT
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id A5CE040CEDE07
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 08:15:12 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id pvdIfcSbpbXuJpvdZf0CFg; Wed, 15 Aug 2018 08:15:11 -0500
X-Authority-Reason: nr=8
Received: from [189.250.37.72] (port=56832 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1fpvdH-001imY-55; Wed, 15 Aug 2018 08:14:39 -0500
Date:   Wed, 15 Aug 2018 08:14:37 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] hwmon: (nct6775) Fix potential Spectre v1
Message-ID: <20180815131437.GA25639@embeddedor.com>
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
X-Source-IP: 189.250.37.72
X-Source-L: No
X-Exim-ID: 1fpvdH-001imY-55
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.37.72]:56832
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

val can be indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

vers/hwmon/nct6775.c:2698 store_pwm_weight_temp_sel() warn: potential
spectre issue 'data->temp_src' [r]

Fix this by sanitizing val before using it to index data->temp_src

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/hwmon/nct6775.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index c6bd61e..944f5b6 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -63,6 +63,7 @@
 #include <linux/bitops.h>
 #include <linux/dmi.h>
 #include <linux/io.h>
+#include <linux/nospec.h>
 #include "lm75.h"
 
 #define USE_ALTERNATE
@@ -2689,6 +2690,7 @@ store_pwm_weight_temp_sel(struct device *dev, struct device_attribute *attr,
 		return err;
 	if (val > NUM_TEMP)
 		return -EINVAL;
+	val = array_index_nospec(val, NUM_TEMP + 1);
 	if (val && (!(data->have_temp & BIT(val - 1)) ||
 		    !data->temp_src[val - 1]))
 		return -EINVAL;
-- 
2.7.4

