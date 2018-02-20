Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751052AbeBTF0Q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 00:26:16 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42829 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbeBTFZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 00:25:05 -0500
X-Google-Smtp-Source: AH8x224PGA6S+g0OoQTUgYM/Ij6tfjZZt1d5dRvCx6yLEe0IgY9lYUoEa1NnhU8TA/8MY+gU5vCsIg==
From: =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To: Jonathan Woithe <jwoithe@just42.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] platform/x86: fujitsu-laptop: Simplify error paths
Date: Tue, 20 Feb 2018 06:24:50 +0100
Message-Id: <20180220052454.11134-4-kernel@kempniu.pl>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180220052454.11134-1-kernel@kempniu.pl>
References: <20180220052454.11134-1-kernel@kempniu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the last few lines of acpi_fujitsu_bl_add() with a simple return
in order to improve code readability without changing the logic.

As acpi_fujitsu_laptop_add() uses a managed memory allocation for
device-specific data, it is fine to just return immediately upon kfifo
allocation failure.  Do that instead of jumping to the end of the
function to improve code readability.  Running out of memory while
allocating the kfifo does not seem probable enough to warrant logging an
error message, so do not do it.

Signed-off-by: Michał Kępień <kernel@kempniu.pl>
---
 drivers/platform/x86/fujitsu-laptop.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
index 7f30a427a16c..94ff7f86fa8f 100644
--- a/drivers/platform/x86/fujitsu-laptop.c
+++ b/drivers/platform/x86/fujitsu-laptop.c
@@ -410,11 +410,7 @@ static int acpi_fujitsu_bl_add(struct acpi_device *device)
 	if (ret)
 		return ret;
 
-	ret = fujitsu_backlight_register(device);
-	if (ret)
-		return ret;
-
-	return 0;
+	return fujitsu_backlight_register(device);
 }
 
 /* Brightness notify */
@@ -790,10 +786,8 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 	spin_lock_init(&priv->fifo_lock);
 	ret = kfifo_alloc(&priv->fifo, RINGBUFFERSIZE * sizeof(int),
 			  GFP_KERNEL);
-	if (ret) {
-		pr_err("kfifo_alloc failed\n");
-		goto err_stop;
-	}
+	if (ret)
+		return ret;
 
 	pr_info("ACPI: %s [%s]\n",
 		acpi_device_name(device), acpi_device_bid(device));
@@ -845,7 +839,7 @@ static int acpi_fujitsu_laptop_add(struct acpi_device *device)
 
 err_free_fifo:
 	kfifo_free(&priv->fifo);
-err_stop:
+
 	return ret;
 }
 
-- 
2.16.1
