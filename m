Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78823C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520A8222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389950AbfBMHqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:46:09 -0500
Received: from mga09.intel.com ([134.134.136.24]:39706 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389915AbfBMHqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:46:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 23:46:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,365,1544515200"; 
   d="scan'208";a="146426056"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2019 23:46:04 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/9] platform/x86: intel_cht_int33fe: Remove old style mux connections
Date:   Wed, 13 Feb 2019 10:45:51 +0300
Message-Id: <20190213074557.66028-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213074557.66028-1-heikki.krogerus@linux.intel.com>
References: <20190213074557.66028-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new mux connection naming scheme is now in use, so
dropping the connections still using the old names. From now
on the same connection description named "mode-switch" is
used with both the port and the alternate modes, so on CHT
the DP alt mode will use the same connection as the port to
get a handle to the mux device.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/platform/x86/intel_cht_int33fe.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
index 295fe19ad4c2..6fa3cced6f8e 100644
--- a/drivers/platform/x86/intel_cht_int33fe.c
+++ b/drivers/platform/x86/intel_cht_int33fe.c
@@ -32,7 +32,7 @@ struct cht_int33fe_data {
 	struct i2c_client *fusb302;
 	struct i2c_client *pi3usb30532;
 	/* Contain a list-head must be per device */
-	struct device_connection connections[7];
+	struct device_connection connections[4];
 };
 
 /*
@@ -174,22 +174,13 @@ static int cht_int33fe_probe(struct platform_device *pdev)
 
 	data->connections[0].endpoint[0] = "port0";
 	data->connections[0].endpoint[1] = "i2c-pi3usb30532";
-	data->connections[0].id = "typec-switch";
+	data->connections[0].id = "orientation-switch";
 	data->connections[1].endpoint[0] = "port0";
 	data->connections[1].endpoint[1] = "i2c-pi3usb30532";
-	data->connections[1].id = "typec-mux";
-	data->connections[2].endpoint[0] = "port0";
-	data->connections[2].endpoint[1] = "i2c-pi3usb30532";
-	data->connections[2].id = "idff01m01";
-	data->connections[3].endpoint[0] = "i2c-fusb302";
-	data->connections[3].endpoint[1] = "intel_xhci_usb_sw-role-switch";
-	data->connections[3].id = "usb-role-switch";
-	data->connections[4].endpoint[0] = "port0";
-	data->connections[4].endpoint[1] = "i2c-pi3usb30532";
-	data->connections[4].id = "orientation-switch";
-	data->connections[5].endpoint[0] = "port0";
-	data->connections[5].endpoint[1] = "i2c-pi3usb30532";
-	data->connections[5].id = "mode-switch";
+	data->connections[1].id = "mode-switch";
+	data->connections[2].endpoint[0] = "i2c-fusb302";
+	data->connections[2].endpoint[1] = "intel_xhci_usb_sw-role-switch";
+	data->connections[2].id = "usb-role-switch";
 
 	device_connections_add(data->connections);
 
-- 
2.20.1

