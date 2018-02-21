Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938791AbeBURAM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 12:00:12 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36375 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933341AbeBURAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 12:00:09 -0500
X-Google-Smtp-Source: AH8x224zOY8jqO2cE4XKAn36Y3nARpeMQg/g+DBpuR4SFLMPMlNVRiM1LkcHxzDNk/JwheM3aFwmGA==
Date: Wed, 21 Feb 2018 18:00:06 +0100
From: Guillaume =?utf-8?Q?Dou=C3=A9zan-Grard?= <gdouezangrard@gmail.com>
To: Andy Shevchenko <andy@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/7] platform/x86: topstar-laptop: revert "convert to
 module_acpi_driver()"
Message-ID: <110548dc26a7792cd03a66b8e43bb6ea95a13064.1519231939.git.gdouezangrard@gmail.com>
References: <cover.1519231939.git.gdouezangrard@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1519231939.git.gdouezangrard@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Revert commit
  15165594da65 ("topstar-laptop: convert to module_acpi_driver()")
to later add a platform device.

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
