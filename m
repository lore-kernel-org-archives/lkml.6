Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A599EC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7683921726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfAVUDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:03:44 -0500
Received: from proxy01.fsdata.se ([89.221.252.211]:57437 "EHLO
        mail-gw01.fsdata.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726015AbfAVUDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:03:44 -0500
Received: from localhost (94.234.43.8) by DAG01.HMC.local (192.168.46.11) with
 Microsoft SMTP Server (TLS) id 15.0.1263.5; Tue, 22 Jan 2019 21:03:17 +0100
From:   Mattias Jacobsson <2pi@mok.nu>
To:     <dvhart@infradead.org>, <andy@infradead.org>
CC:     <2pi@mok.nu>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] platform/x86: wmi: fix potential null pointer dereferences
Date:   Tue, 22 Jan 2019 21:03:01 +0100
Message-ID: <20190122200302.19861-1-2pi@mok.nu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [94.234.43.8]
X-ClientProxiedBy: PROXY05.HMC.local (192.168.46.55) To DAG01.HMC.local
 (192.168.46.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the function wmi_dev_match() there are three variables that
potentially can result in a null pointer dereference. Namely:
dev/wblock, driver/wmi_driver, and wmi_driver->id_table.

Check for NULL and return that the driver can't handle the device if any
of these variables would result in a null pointer dereference.

The NULL checks are performed prior to running container_of() for the
variables dev/wblock and driver/wmi_driver.

Fixes: 844af950da94 ("platform/x86: wmi: Turn WMI into a bus driver")
Signed-off-by: Mattias Jacobsson <2pi@mok.nu>
---
 drivers/platform/x86/wmi.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index bea35be68706..c596479e8b13 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -763,10 +763,18 @@ static void wmi_dev_release(struct device *dev)
 
 static int wmi_dev_match(struct device *dev, struct device_driver *driver)
 {
-	struct wmi_driver *wmi_driver =
-		container_of(driver, struct wmi_driver, driver);
-	struct wmi_block *wblock = dev_to_wblock(dev);
-	const struct wmi_device_id *id = wmi_driver->id_table;
+	const struct wmi_device_id *id;
+	struct wmi_block *wblock;
+	struct wmi_driver *wmi_driver;
+
+	if (dev == NULL || driver == NULL)
+		return 0;
+	wblock = dev_to_wblock(dev);
+	wmi_driver = container_of(driver, struct wmi_driver, driver);
+
+	if (wmi_driver->id_table == NULL)
+		return 0;
+	id = wmi_driver->id_table;
 
 	while (id->guid_string) {
 		uuid_le driver_guid;
-- 
2.20.1

