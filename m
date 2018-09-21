Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF91ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9369021547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9369021547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389057AbeIUHcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:32:43 -0400
Received: from mail5.windriver.com ([192.103.53.11]:53982 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388893AbeIUHcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:32:43 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id w8L1j5QR030705
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 20 Sep 2018 18:45:41 -0700
Received: from yow-pgortmak-d1.corp.ad.wrs.com (128.224.56.57) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.408.0; Thu, 20 Sep 2018 18:45:25 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <platform-driver-x86@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Peter Feuerer <peter@piie.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: [PATCH 3/6] platform/x86: acerhdf: Remove cut-and-paste trap from instructions
Date:   Thu, 20 Sep 2018 21:44:18 -0400
Message-ID: <20180921014421.30804-4-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20180921014421.30804-1-paul.gortmaker@windriver.com>
References: <20180921014421.30804-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like we avoid specifying actual block devices like sda for fdisk
and dd examples, we should not specify specific thermal zones here.

On the platform I was testing on, zone0 was acpitz, and zone1 was for
this acerhdf driver.  Make the printk such that it won't work with a
blind cut-and-paste, and force the user to determine which zone is
correct for this driver.

Cc: Peter Feuerer <peter@piie.net>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Andy Shevchenko <andy@infradead.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/platform/x86/Kconfig   | 5 ++++-
 drivers/platform/x86/acerhdf.c | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 0c1aa6c314f5..1fca33c97e8a 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -60,7 +60,10 @@ config ACERHDF
 
 	  After loading this driver the BIOS is still in control of the fan.
 	  To let the kernel handle the fan, do:
-	  echo -n enabled > /sys/class/thermal/thermal_zone0/mode
+	  echo -n enabled > /sys/class/thermal/thermal_zoneN/mode
+	  where N=0,1,2... depending on the number of thermal nodes and the
+	  detection order of your particular system.  The "type" parameter
+	  in the same node directory will tell you if it is "acerhdf".
 
 	  For more information about this driver see
 	  <http://piie.net/files/acerhdf_README.txt>
diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
index 2735815c73c5..fef3b727bc24 100644
--- a/drivers/platform/x86/acerhdf.c
+++ b/drivers/platform/x86/acerhdf.c
@@ -688,7 +688,7 @@ static int acerhdf_check_hardware(void)
 	 */
 	if (!kernelmode) {
 		pr_notice("Fan control off, to enable do:\n");
-		pr_notice("echo -n \"enabled\" > /sys/class/thermal/thermal_zone0/mode\n");
+		pr_notice("echo -n \"enabled\" > /sys/class/thermal/thermal_zoneN/mode # N=0,1,2...\n");
 	}
 
 	return 0;
-- 
2.15.0

