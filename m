Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07DCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81ED020832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81ED020832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeK1XB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:01:28 -0500
Received: from mga01.intel.com ([192.55.52.88]:3291 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbeK1XB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:01:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 04:00:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,290,1539673200"; 
   d="scan'208";a="116501302"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Nov 2018 04:00:00 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 3/3] of/property: Add of_fwnode_name()
Date:   Wed, 28 Nov 2018 14:59:52 +0300
Message-Id: <20181128115952.80890-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181128115952.80890-1-heikki.krogerus@linux.intel.com>
References: <20181128115952.80890-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements get_name fwnode op for DT.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/of/property.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index f46828e3b082..403bc9cbbaf4 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -823,6 +823,18 @@ static void of_fwnode_put(struct fwnode_handle *fwnode)
 	of_node_put(to_of_node(fwnode));
 }
 
+static int of_fwnode_get_name(const struct fwnode_handle *fwnode, char *buf,
+			      size_t len)
+{
+	const struct device_node *node = to_of_node(fwnode);
+
+	if (len < snprintf(NULL, 0, "%pOFn", node) + 1)
+		return -EOVERFLOW;
+
+	sprintf(buf, "%pOFn", node);
+	return 0;
+}
+
 static bool of_fwnode_device_is_available(const struct fwnode_handle *fwnode)
 {
 	return of_device_is_available(to_of_node(fwnode));
@@ -987,6 +999,7 @@ of_fwnode_device_get_match_data(const struct fwnode_handle *fwnode,
 const struct fwnode_operations of_fwnode_ops = {
 	.get = of_fwnode_get,
 	.put = of_fwnode_put,
+	.get_name = of_fwnode_get_name,
 	.device_is_available = of_fwnode_device_is_available,
 	.device_get_match_data = of_fwnode_device_get_match_data,
 	.property_present = of_fwnode_property_present,
-- 
2.19.2

