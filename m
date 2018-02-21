Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966010AbeBUPNA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 10:13:00 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46258 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938116AbeBUPM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 10:12:57 -0500
X-Google-Smtp-Source: AH8x227iHwiwTJQDOpvJloTcal+2IFTNi4RL+yCjCiVgoKm9weoljuVmkgnpfgerWipN96e0K4mNnw==
Date: Wed, 21 Feb 2018 16:12:54 +0100
From: Guillaume =?utf-8?Q?Dou=C3=A9zan-Grard?= <gdouezangrard@gmail.com>
To: Andy Shevchenko <andy@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/6] revert "topstar-laptop: convert to
 module_acpi_driver()"
Message-ID: <b40361cf40e8a73310d48ac775f7b324c08c7f95.1519225570.git.gdouezangrard@gmail.com>
References: <cover.1519225570.git.gdouezangrard@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1519225570.git.gdouezangrard@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revert commit 15165594da65 ("topstar-laptop: convert to
module_acpi_driver()") to later add a platform device.

Signed-off-by: Guillaume Douézan-Grard <gdouezangrard@gmail.com>
---
 drivers/platform/x86/topstar-laptop.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/topstar-laptop.c b/drivers/platform/x86/topstar-laptop.c
index 1032c00b907b..b4807b868a69 100644
--- a/drivers/platform/x86/topstar-laptop.c
+++ b/drivers/platform/x86/topstar-laptop.c
@@ -178,7 +178,27 @@ static struct acpi_driver acpi_topstar_driver = {
 		.notify = acpi_topstar_notify,
 	},
 };
-module_acpi_driver(acpi_topstar_driver);
+
+static int __init topstar_laptop_init(void)
+{
+	int ret;
+
+	ret = acpi_bus_register_driver(&acpi_topstar_driver);
+	if (ret < 0)
+		return ret;
+
+	pr_info("ACPI extras driver loaded\n");
+
+	return 0;
+}
+
+static void __exit topstar_laptop_exit(void)
+{
+	acpi_bus_unregister_driver(&acpi_topstar_driver);
+}
+
+module_init(topstar_laptop_init);
+module_exit(topstar_laptop_exit);
 
 MODULE_AUTHOR("Herton Ronaldo Krzesinski");
 MODULE_DESCRIPTION("Topstar Laptop ACPI Extras driver");
-- 
2.16.1
