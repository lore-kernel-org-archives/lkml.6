Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA56C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFB720823
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbfAVQJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:09:39 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:62981 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729394AbfAVQJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:09:37 -0500
X-IronPort-AV: E=Sophos;i="5.56,507,1539648000"; 
   d="scan'208";a="76149987"
From:   Ross Lagerwall <ross.lagerwall@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-efi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Huang Ying <ying.huang@intel.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>
Subject: [PATCH 1/2] acpi/apei: Avoid possible OOB when accessing BERT region
Date:   Tue, 22 Jan 2019 16:09:11 +0000
Message-ID: <20190122160912.27312-2-ross.lagerwall@citrix.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190122160912.27312-1-ross.lagerwall@citrix.com>
References: <20190122160912.27312-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check that the length recorded in the generic error status block is
within the region before checking the contents of the region itself.
Otherwise it may result in an OOB access if the system firmware has
generated a status block with an invalid length (larger than the mapped
region). Also move the block_status check so that it only happens after
the block has been verified to be within the mapped region.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---
 drivers/acpi/apei/bert.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/apei/bert.c b/drivers/acpi/apei/bert.c
index 12771fcf0417..0d948d0a41af 100644
--- a/drivers/acpi/apei/bert.c
+++ b/drivers/acpi/apei/bert.c
@@ -42,15 +42,7 @@ static void __init bert_print_all(struct acpi_bert_region *region,
 	int remain = region_len;
 	u32 estatus_len;
 
-	if (!estatus->block_status)
-		return;
-
-	while (remain > sizeof(struct acpi_bert_region)) {
-		if (cper_estatus_check(estatus)) {
-			pr_err(FW_BUG "Invalid error record.\n");
-			return;
-		}
-
+	while (remain >= sizeof(struct acpi_bert_region)) {
 		estatus_len = cper_estatus_len(estatus);
 		if (remain < estatus_len) {
 			pr_err(FW_BUG "Truncated status block (length: %u).\n",
@@ -58,6 +50,15 @@ static void __init bert_print_all(struct acpi_bert_region *region,
 			return;
 		}
 
+		/* No more error records. */
+		if (!estatus->block_status)
+			return;
+
+		if (cper_estatus_check(estatus)) {
+			pr_err(FW_BUG "Invalid error record.\n");
+			return;
+		}
+
 		pr_info_once("Error records from previous boot:\n");
 
 		cper_estatus_print(KERN_INFO HW_ERR, estatus);
@@ -70,10 +71,6 @@ static void __init bert_print_all(struct acpi_bert_region *region,
 		estatus->block_status = 0;
 
 		estatus = (void *)estatus + estatus_len;
-		/* No more error records. */
-		if (!estatus->block_status)
-			return;
-
 		remain -= estatus_len;
 	}
 }
-- 
2.17.2

