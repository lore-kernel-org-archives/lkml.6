Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0500C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85B72087F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 10:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfA1KEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 05:04:31 -0500
Received: from smtp03.citrix.com ([162.221.156.55]:28658 "EHLO
        SMTP03.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfA1KEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 05:04:30 -0500
X-IronPort-AV: E=Sophos;i="5.56,533,1539648000"; 
   d="scan'208";a="76590243"
From:   Ross Lagerwall <ross.lagerwall@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-efi@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Huang Ying <ying.huang@intel.com>,
        Ross Lagerwall <ross.lagerwall@citrix.com>
Subject: [PATCH v2 2/2] efi/cper: Fix possible out-of-bounds access
Date:   Mon, 28 Jan 2019 10:04:24 +0000
Message-ID: <20190128100424.30278-3-ross.lagerwall@citrix.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190128100424.30278-1-ross.lagerwall@citrix.com>
References: <20190128100424.30278-1-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When checking a generic status block, we iterate over all the generic
data blocks. The loop condition only checks that the start of the
generic data block is valid (within estatus->data_length) but not the
whole block. Because the size of data blocks (excluding error data) may
vary depending on the revision and the revision is contained within the
data block, ensure that enough of the current data block is valid before
dereferencing any members otherwise an out-of-bounds access may occur if
estatus->data_length is invalid. This relies on the fact that struct
acpi_hest_generic_data_v300 is a superset of the earlier version.  Also
rework the other checks to avoid potential underflow.

Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
---
 drivers/firmware/efi/cper.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index a7902fccdcfa..6090d25dce85 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -546,19 +546,24 @@ EXPORT_SYMBOL_GPL(cper_estatus_check_header);
 int cper_estatus_check(const struct acpi_hest_generic_status *estatus)
 {
 	struct acpi_hest_generic_data *gdata;
-	unsigned int data_len, gedata_len;
+	unsigned int data_len, record_size;
 	int rc;
 
 	rc = cper_estatus_check_header(estatus);
 	if (rc)
 		return rc;
+
 	data_len = estatus->data_length;
 
 	apei_estatus_for_each_section(estatus, gdata) {
-		gedata_len = acpi_hest_get_error_length(gdata);
-		if (gedata_len > data_len - acpi_hest_get_size(gdata))
+		if (sizeof(struct acpi_hest_generic_data) > data_len)
+			return -EINVAL;
+
+		record_size = acpi_hest_get_record_size(gdata);
+		if (record_size > data_len)
 			return -EINVAL;
-		data_len -= acpi_hest_get_record_size(gdata);
+
+		data_len -= record_size;
 	}
 	if (data_len)
 		return -EINVAL;
-- 
2.17.2

