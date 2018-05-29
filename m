Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934640AbeE2NK7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:10:59 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:51732 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934083AbeE2NKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:10:49 -0400
X-Google-Smtp-Source: ADUXVKLmakJxkI0zxx12fpUmP0lYUCjiguPshI/DAeCpX6U1TISny+6IsHaeYy1qOU4YmBun2Vb2lA==
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>
Subject: [PATCH 10/19] file2alias: Support for serdev devices
Date: Tue, 29 May 2018 15:10:05 +0200
Message-Id: <20180529131014.18641-11-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows file2alias to generate the proper module headers to
support serdev modalias drivers.

Eg:

root@qt5022:~# modinfo serdev:ttydev | grep alias
alias:          serdev:ttydev_serdev
alias:          serdev:ttydev

root@qt5022:~#
	cat /lib/modules/4.16.0-qtec-standard/modules.alias | grep serdev
alias serdev:ttydev_serdev serdev_ttydev
alias serdev:ttydev serdev_ttydev

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 scripts/mod/devicetable-offsets.c |  3 +++
 scripts/mod/file2alias.c          | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/scripts/mod/devicetable-offsets.c b/scripts/mod/devicetable-offsets.c
index 9fad6afe4c41..6082c41b7ad7 100644
--- a/scripts/mod/devicetable-offsets.c
+++ b/scripts/mod/devicetable-offsets.c
@@ -142,6 +142,9 @@ int main(void)
 	DEVID(i2c_device_id);
 	DEVID_FIELD(i2c_device_id, name);
 
+	DEVID(serdev_device_id);
+	DEVID_FIELD(serdev_device_id, name);
+
 	DEVID(spi_device_id);
 	DEVID_FIELD(spi_device_id, name);
 
diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index b9beeaa4695b..dce6df3a159a 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -955,6 +955,17 @@ static int do_i2c_entry(const char *filename, void *symval,
 }
 ADD_TO_DEVTABLE("i2c", i2c_device_id, do_i2c_entry);
 
+/* Looks like: serdev:S */
+static int do_serdev_entry(const char *filename, void *symval,
+			   char *alias)
+{
+	DEF_FIELD_ADDR(symval, serdev_device_id, name);
+	sprintf(alias, SERDEV_MODULE_PREFIX "%s", *name);
+
+	return 1;
+}
+ADD_TO_DEVTABLE("serdev", serdev_device_id, do_serdev_entry);
+
 /* Looks like: spi:S */
 static int do_spi_entry(const char *filename, void *symval,
 			char *alias)
-- 
2.17.0
