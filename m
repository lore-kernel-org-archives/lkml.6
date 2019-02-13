Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3469C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC233222D0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389984AbfBMHqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:46:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:39706 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388878AbfBMHqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:46:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 23:46:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,365,1544515200"; 
   d="scan'208";a="146426071"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2019 23:46:06 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/9] device connection: Add fwnode member to struct device_connection
Date:   Wed, 13 Feb 2019 10:45:52 +0300
Message-Id: <20190213074557.66028-5-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213074557.66028-1-heikki.krogerus@linux.intel.com>
References: <20190213074557.66028-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will prepare the device connection API for connections
described in firmware.

Acked-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Jun Li <jun.li@nxp.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 include/linux/device.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index d4e74fa42f9c..333db8c06152 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -758,11 +758,17 @@ struct device_dma_parameters {
 
 /**
  * struct device_connection - Device Connection Descriptor
+ * @fwnode: The device node of the connected device
  * @endpoint: The names of the two devices connected together
  * @id: Unique identifier for the connection
  * @list: List head, private, for internal use only
+ *
+ * NOTE: @fwnode is not used together with @endpoint. @fwnode is used when
+ * platform firmware defines the connection. When the connection is registered
+ * with device_connection_add() @endpoint is used instead.
  */
 struct device_connection {
+	struct fwnode_handle	*fwnode;
 	const char		*endpoint[2];
 	const char		*id;
 	struct list_head	list;
-- 
2.20.1

