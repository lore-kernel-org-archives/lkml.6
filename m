Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCFEC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C9D21569
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m3tkLILb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C9D21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeI0HE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:04:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43435 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbeI0HE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:04:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id q19-v6so554084pgn.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 17:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5REZXXpcj+68mcIHPkGrgZEdADbEUsZWPA7Jej+JYQ4=;
        b=m3tkLILbDSqJuLyGHBXfp6FY4TS7WkokaTy+u9/+Usg4bEE1wAeZL1qVTeq6SsIWLx
         onj8Wltks21QW4nu/gaUB7r1qM72LxOCKYc5/wwYDUTbDBSDQUZoUTQBNUO3+V/WDIf4
         sHsKkTJaS+7Y/aBAbsIU4UUcgD7nsBUYHzn98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5REZXXpcj+68mcIHPkGrgZEdADbEUsZWPA7Jej+JYQ4=;
        b=h+IPioF03CkDDWVSWib7Wg54MzoVvwXBEzoNpdHdc9q5GQ6Y9amMJCVXiFroxysKto
         xWtRB4ge0t58nAmMHr42BURcoMupZxSFg+zHCK5qO38Zzox5W8ftbq8o4maGZShVFXT9
         gHvymw7eEPh+xcrwogXHuXbLeiI/K1yv+EN2kAks6cIZOFGzh3y5wdQIKJ3CF0xQfxOK
         0sArzpDcjFMt/TaylgHN6RhhEINkbYfP+Wxw2NGMEs1skhIY/lmvAOKu8q9auA+i1VK9
         Lf8CxJxSx9T+fi5jXWunEg35BzUte27PU19k0SuJcgfub5NdUw2oHTAcDal5+dxpHH+r
         d+kw==
X-Gm-Message-State: ABuFfoiYeDm2BOQwj+XH+uFff08++E1NrvQyc1ApKGvxtU2q+Q9AOXwT
        wyqsGS657xzJ8Od3t7HsyDKr7Q==
X-Google-Smtp-Source: ACcGV60bFenmjD/2KB8fYBuxqK57Dyr1xEgnOLxsTcarhiEV93BwpNTi6iZcPmEOUqYokQ38zv7WOg==
X-Received: by 2002:a63:fd06:: with SMTP id d6-v6mr7647309pgh.348.1538009331602;
        Wed, 26 Sep 2018 17:48:51 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id g3-v6sm404173pfi.9.2018.09.26.17.48.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 17:48:51 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v4 1/2] Bluetooth: Add device_get_bd_address()
Date:   Wed, 26 Sep 2018 17:48:09 -0700
Message-Id: <20180927004810.124185-2-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20180927004810.124185-1-mka@chromium.org>
References: <20180927004810.124185-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide an API for Bluetooth drivers to retrieve the Bluetooth Device
address (BD_ADDR) for a device. If the firmware node of the device
has a property 'local-bd-address' the BD address is read from this
property.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
Changes in v4:
- move code from driver/base/property.c to net/bluetooth/lib.c
- undo move of bdaddr_t declaration
- merge fwnode_get_bd_address() into device_get_bd_address(). as of now
  the function is not needed, it can be created later if necessary
- minor improvements suggested by Sakari
- updated commit message
- added 'Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>' tag

Changes in v3:
- move definition of bdaddr_t to types.h to avoid include of
  bluetooth.h from property.h
- add stubs for the new functions

Changes in v2:
- use bdaddr_t instead of byte pointer + len
- use EXPORT_SYMBOL_GPL for the new functions instead of EXPORT_SYMBOL
- put new functions inside #if IS_ENABLED(CONFIG_BT)
- some new line juggling in property.h
- added 'Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>' tag
---
 include/net/bluetooth/bluetooth.h |  2 ++
 net/bluetooth/lib.c               | 34 +++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index ec9d6bc65855..6c4cecfda816 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -413,4 +413,6 @@ void mgmt_exit(void);
 
 void bt_sock_reclassify_lock(struct sock *sk, int proto);
 
+int device_get_bd_address(struct device *dev, bdaddr_t *bd_addr);
+
 #endif /* __BLUETOOTH_H */
diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
index 63e65d9b4b24..78a58ea586c6 100644
--- a/net/bluetooth/lib.c
+++ b/net/bluetooth/lib.c
@@ -26,7 +26,10 @@
 
 #define pr_fmt(fmt) "Bluetooth: " fmt
 
+#include <linux/etherdevice.h>
 #include <linux/export.h>
+#include <linux/fwnode.h>
+#include <linux/property.h>
 
 #include <net/bluetooth/bluetooth.h>
 
@@ -198,3 +201,34 @@ void bt_err_ratelimited(const char *format, ...)
 	va_end(args);
 }
 EXPORT_SYMBOL(bt_err_ratelimited);
+
+/**
+ * device_get_bd_address - Get the Bluetooth Device Address (BD_ADDR) for a
+ *                         given device
+ * @dev:	Pointer to the device
+ * @bd_addr:	Pointer to struct to store the BD address in
+ *
+ * Search the firmware node of the device for 'local-bd-address'.
+ *
+ * All-zero BD addresses are rejected, because those could be properties
+ * that exist in the firmware tables, but were not updated by the firmware. For
+ * example, the DTS could define 'local-bd-address', with zero BD addresses.
+ */
+int device_get_bd_address(struct device *dev, bdaddr_t *bd_addr)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(dev);
+	bdaddr_t ba;
+	int ret;
+
+	ret = fwnode_property_read_u8_array(fwnode, "local-bd-address",
+					    (u8 *)&ba, sizeof(ba));
+	if (ret < 0)
+		return ret;
+	if (is_zero_ether_addr((u8 *)&ba))
+		return -ENODATA;
+
+	*bd_addr = ba;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(device_get_bd_address);
-- 
2.19.0.605.g01d371f741-goog

