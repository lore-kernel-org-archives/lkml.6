Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A44C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6452133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA6452133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeK1B1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:27:09 -0500
Received: from mga03.intel.com ([134.134.136.65]:5443 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726590AbeK1B1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 20:27:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 06:29:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,286,1539673200"; 
   d="scan'208";a="114457851"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Nov 2018 06:29:00 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 2/4] ACPI: property: Add acpi_fwnode_name()
Date:   Tue, 27 Nov 2018 17:28:53 +0300
Message-Id: <20181127142855.73899-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181127142855.73899-1-heikki.krogerus@linux.intel.com>
References: <20181127142855.73899-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements the get_name fwnode op for ACPI.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/property.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 8c7c4583b52d..c24cf02e9214 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1219,6 +1219,33 @@ acpi_graph_get_remote_endpoint(const struct fwnode_handle *__fwnode)
 	return acpi_graph_get_child_prop_value(fwnode, "endpoint", endpoint_nr);
 }
 
+static int
+acpi_fwnode_get_name(const struct fwnode_handle *fwnode, char *buf, size_t len)
+{
+	struct acpi_buffer buffer;
+	acpi_status status;
+
+	if (is_acpi_data_node(fwnode)) {
+		if (len < strlen(to_acpi_data_node(fwnode)->name) + 1)
+			return -EOVERFLOW;
+		sprintf(buf, "%s", to_acpi_data_node(fwnode)->name);
+		return 0;
+	}
+
+	if (len < ACPI_NAME_SIZE + 1)
+		return -EOVERFLOW;
+
+	buffer.length = ACPI_NAME_SIZE + 1;
+	buffer.pointer = buf;
+
+	status = acpi_get_name(to_acpi_device_node(fwnode)->handle,
+			       ACPI_SINGLE_NAME, &buffer);
+	if (ACPI_FAILURE(status))
+		return -ENXIO;
+
+	return 0;
+}
+
 static bool acpi_fwnode_device_is_available(const struct fwnode_handle *fwnode)
 {
 	if (!is_acpi_device_node(fwnode))
@@ -1310,6 +1337,7 @@ acpi_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
 
 #define DECLARE_ACPI_FWNODE_OPS(ops) \
 	const struct fwnode_operations ops = {				\
+		.get_name = acpi_fwnode_get_name,			\
 		.device_is_available = acpi_fwnode_device_is_available, \
 		.device_get_match_data = acpi_fwnode_device_get_match_data, \
 		.property_present = acpi_fwnode_property_present,	\
-- 
2.19.2

