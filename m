Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD736C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7E520675
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 20:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfACUOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 15:14:30 -0500
Received: from gateway23.websitewelcome.com ([192.185.47.80]:47830 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726601AbfACUO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 15:14:29 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 15CF9ED16
        for <linux-kernel@vger.kernel.org>; Thu,  3 Jan 2019 14:14:29 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id f9Ntgwxgm4FKpf9NtgPPtH; Thu, 03 Jan 2019 14:14:29 -0600
X-Authority-Reason: nr=8
Received: from [189.250.78.104] (port=40340 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gf9Na-001jes-9n; Thu, 03 Jan 2019 14:14:28 -0600
Date:   Thu, 3 Jan 2019 14:14:08 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Ben Dooks <ben@simtec.co.uk>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ARM: mach-s3c24xx: Fix boolean expressions in
 osiris_dvs_notify
Message-ID: <20190103201408.GA27754@embeddedor>
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
X-Source-IP: 189.250.78.104
X-Source-L: No
X-Exim-ID: 1gf9Na-001jes-9n
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.78.104]:40340
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 17
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix boolean expressions by using logical AND operator '&&'
instead of bitwise operator '&'.

This issue was detected with the help of Coccinelle.

Fixes: 4fa084af28ca ("ARM: OSIRIS: DVS (Dynamic Voltage Scaling) supoort.")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
index 058ce73137e8..ccbd7b7965ca 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
@@ -65,16 +65,16 @@ static int osiris_dvs_notify(struct notifier_block *nb,
 
 	switch (val) {
 	case CPUFREQ_PRECHANGE:
-		if (old_dvs & !new_dvs ||
-		    cur_dvs & !new_dvs) {
+		if (old_dvs && !new_dvs ||
+		    cur_dvs && !new_dvs) {
 			pr_debug("%s: exiting dvs\n", __func__);
 			cur_dvs = false;
 			gpio_set_value(OSIRIS_GPIO_DVS, 1);
 		}
 		break;
 	case CPUFREQ_POSTCHANGE:
-		if (!old_dvs & new_dvs ||
-		    !cur_dvs & new_dvs) {
+		if (!old_dvs && new_dvs ||
+		    !cur_dvs && new_dvs) {
 			pr_debug("entering dvs\n");
 			cur_dvs = true;
 			gpio_set_value(OSIRIS_GPIO_DVS, 0);
-- 
2.20.1

