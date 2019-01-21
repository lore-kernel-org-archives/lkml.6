Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7714C2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBC12085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbfAUNYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:24:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728690AbfAUNYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:24:39 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EB29681F0D;
        Mon, 21 Jan 2019 13:24:38 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B40360CBA;
        Mon, 21 Jan 2019 13:24:37 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Corentin Chary <corentin.chary@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: asus-wmi: Allow loading on systems without the Asus Management GUID
Date:   Mon, 21 Jan 2019 14:24:36 +0100
Message-Id: <20190121132436.31825-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 21 Jan 2019 13:24:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hid-asus depends on asus-wmi through the asus_wmi_evaluate_method. Before
this commit asus-wmi and thus hid-asus could not be loaded on non Asus
systems. This breaks using Asus bluetooth keyboards such as the Asus
T100CHI keyboard with non Asus systems.

This commit fixes this by allowing asus-wmi to load on systems without the
Asus Management GUID.

This is save to do since all asus-wmi sub drivers use
asus_wmi_register_driver which also checks for the GUID.

This commit also improves the error messages in asus_wmi_register_driver
to include "ASUS" in their description tom make them more clear. This is
important since we now rely on those errors when loaded on systems without
the Asus Management GUID.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/asus-wmi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 37b5de541270..ee1fa93708ec 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -2265,12 +2265,12 @@ static int asus_wmi_probe(struct platform_device *pdev)
 	int ret;
 
 	if (!wmi_has_guid(ASUS_WMI_MGMT_GUID)) {
-		pr_warn("Management GUID not found\n");
+		pr_warn("ASUS Management GUID not found\n");
 		return -ENODEV;
 	}
 
 	if (wdrv->event_guid && !wmi_has_guid(wdrv->event_guid)) {
-		pr_warn("Event GUID not found\n");
+		pr_warn("ASUS Event GUID not found\n");
 		return -ENODEV;
 	}
 
@@ -2320,11 +2320,6 @@ EXPORT_SYMBOL_GPL(asus_wmi_unregister_driver);
 
 static int __init asus_wmi_init(void)
 {
-	if (!wmi_has_guid(ASUS_WMI_MGMT_GUID)) {
-		pr_info("Asus Management GUID not found\n");
-		return -ENODEV;
-	}
-
 	pr_info("ASUS WMI generic driver loaded\n");
 	return 0;
 }
-- 
2.20.1

