Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD04ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7FD21547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B7FD21547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389042AbeIUHcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:32:43 -0400
Received: from mail5.windriver.com ([192.103.53.11]:53980 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbeIUHcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:32:43 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w8L1j5QO030705
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 20 Sep 2018 18:45:15 -0700
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.408.0; Thu, 20 Sep 2018 18:44:54 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <platform-driver-x86@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Peter Feuerer <peter@piie.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [PATCH 2/6] platform/x86: acerhdf: Enable ability to list supported systems
Date:   Thu, 20 Sep 2018 21:44:17 -0400
Message-ID: <20180921014421.30804-3-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180921014421.30804-1-paul.gortmaker@windriver.com>
References: <20180921014421.30804-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver has two module parameters that allow an override of the
checks for matching model and BIOS version.  However, both parameters
expect you to choose an entry from the existing list of supported
systems, encoded within the driver itself.

Without the source, such as in a binary distribution, the end user
does not have access to this information, thus rendering the two
module parameters essentially useless.

Add a module parameter that allows the end user to dump the list
of make/model/versions so that they can then pick one that most
closely matches their own system.

Cc: Peter Feuerer <peter@piie.net>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/platform/x86/acerhdf.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 3d5c4e183111..2735815c73c5 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -86,6 +86,7 @@ static unsigned int interval = 10;
 static unsigned int fanon = 60000;
 static unsigned int fanoff = 53000;
 static unsigned int verbose;
+static unsigned int list_supported;
 static unsigned int fanstate = ACERHDF_FAN_AUTO;
 static char force_bios[16];
 static char force_product[16];
@@ -104,6 +105,8 @@ module_param(fanoff, uint, 0600);
 MODULE_PARM_DESC(fanoff, "Turn the fan off below this temperature");
 module_param(verbose, uint, 0600);
 MODULE_PARM_DESC(verbose, "Enable verbose dmesg output");
+module_param(list_supported, uint, 0600);
+MODULE_PARM_DESC(list_supported, "List supported models and BIOS versions");
 module_param_string(force_bios, force_bios, 16, 0);
 MODULE_PARM_DESC(force_bios, "Pretend system has this known supported BIOS version");
 module_param_string(force_product, force_product, 16, 0);
@@ -632,6 +635,17 @@ static int acerhdf_check_hardware(void)
 
 	pr_info("Acer Aspire One Fan driver, v.%s\n", DRV_VER);
 
+	if (list_supported) {
+		pr_info("List of supported Manufacturer/Model/BIOS:\n");
+		pr_info("---------------------------------------------------\n");
+		for (bt = bios_tbl; bt->vendor[0]; bt++) {
+			pr_info("%-13s | %-17s | %-10s\n", bt->vendor,
+				bt->product, bt->version);
+		}
+		pr_info("---------------------------------------------------\n");
+		return -ECANCELED;
+	}
+
 	if (force_bios[0]) {
 		version = force_bios;
 		pr_info("forcing BIOS version: %s\n", version);
-- 
2.15.0

