Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415E2C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C58821872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbfADTaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 14:30:20 -0500
Received: from mga17.intel.com ([192.55.52.151]:41136 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfADTaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 14:30:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 11:30:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,439,1539673200"; 
   d="scan'208";a="103982203"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 04 Jan 2019 11:30:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D0E3E161; Fri,  4 Jan 2019 21:30:12 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/4] ARM: bcm2835: Switch to use %ptT
Date:   Fri,  4 Jan 2019 21:30:07 +0200
Message-Id: <20190104193009.30907-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190104193009.30907-1-andriy.shevchenko@linux.intel.com>
References: <20190104193009.30907-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use %ptT instead of open coded variant to print content of
time64_t type in human readable format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/firmware/raspberrypi.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index a13558154ac3..ac5aeab1eb04 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -181,16 +181,10 @@ rpi_firmware_print_firmware_revision(struct rpi_firmware *fw)
 					RPI_FIRMWARE_GET_FIRMWARE_REVISION,
 					&packet, sizeof(packet));
 
-	if (ret == 0) {
-		struct tm tm;
-
-		time64_to_tm(packet, 0, &tm);
+	if (ret)
+		return;
 
-		dev_info(fw->cl.dev,
-			 "Attached to firmware from %04ld-%02d-%02d %02d:%02d\n",
-			 tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
-			 tm.tm_hour, tm.tm_min);
-	}
+	dev_info(fw->cl.dev, "Attached to firmware from %ptT\n", &packet);
 }
 
 static void
-- 
2.19.2

