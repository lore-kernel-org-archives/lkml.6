Return-Path: <fthain@telegraphics.com.au>
X-Google-Smtp-Source: AB8JxZpMEUO3qTFIRNa5Q8aBWfVk0uVswAsTXr4jUbSLe5JAf+LIMQQqw2dGmUiCDU00XwelHrVO
ARC-Seal: i=1; a=rsa-sha256; t=1525827882; cv=none;
        d=google.com; s=arc-20160816;
        b=xloE9YD1ryn8P/ZTiBEjM4urjtcDPK+h8oP/0OJAuA/73+ooq8DPkcmoWI5cl9MwM+
         /0pQufkXxnO455rSTaDLq8RN6G4Bszmee9wUF+TvuLs5SvnXaOcg1j1JK5liyx/wC/5F
         MARGsekyz2ZYUNjKQpFgdASYDP95c1lfD2kRaoZraXIj2xga0z6GESlNUMsAaCESAVqr
         LLFHjcbTsdBmHnv//xSaRZB/fATskOxKZw01PX4cUMYRkBbTa3AU/C7Fem0UX7SM2itf
         yuWeMgzGt+NaVE5rMYp+B/AqJwipNxiMrPxPaP7NBm4foJEE/tk4t129EUpKFCUIKUtH
         n2WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=resent-message-id:resent-subject:resent-to:resent-from:resent-date
         :subject:from:cc:to:date:message-id:arc-authentication-results;
        bh=+bhYWF+FFP3sMU+CQzvSBLxS7Xtjn8k42FrCIZOQ3dc=;
        b=HBT8GT+zVkTyK+ukLddhfxp3zVyzl62ABS9MqwgBXsOZLUkQFuYLX3bKVgx/0kfJjs
         koToL0+eSTEviIc7n4B4gblFgmFgWD7C1tgNZq0cugbW5K4d31eeLe/eQtk8Uu7wWx2x
         neBYZHvCCizur75oM6mNx/7t9ULbJXBe93dXYm/6A7eixTkf+Lr02cyRQS5cVyDU3iWS
         zfunC8KvTevE0bCuRe8pY8XqZySfIGjb8MpqKrqwMZGRv2k5qPoPK83WvGY4hTjSWAHT
         oMMBKVqG45+ApcclsfzK6uY/46Xv6MVdO56gldJHO3r9UXBBmC3bI11njyOEujg//0WG
         LbMA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of fthain@telegraphics.com.au designates 98.124.60.144 as permitted sender) smtp.mailfrom=fthain@telegraphics.com.au
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of fthain@telegraphics.com.au designates 98.124.60.144 as permitted sender) smtp.mailfrom=fthain@telegraphics.com.au
Message-Id: <5af2492a.1c69fb81.4c7ec.4cbaSMTPIN_ADDED_MISSING@mx.google.com>
Date: Wed, 09 May 2018 11:04:48 +1000
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2] nubus: Call bus_register unconditionally
ReSent-Date: Wed, 9 May 2018 11:04:40 +1000 (AEST)
ReSent-From: fthain@telegraphics.com.au
ReSent-To: geert@linux-m68k.org, gregkh@linuxfoundation.org,
    linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
ReSent-Subject: [PATCH v2] nubus: Call bus_register unconditionally
ReSent-Message-ID: <alpine.LNX.2.21.1805091104400.8@nippy.intranet>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599946498073404911?=
X-GMAIL-MSGID: =?utf-8?q?1599946498073404911?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Loading a NuBus driver module on a non-NuBus machine triggers the
BUG_ON(!drv->bus->p) in driver_register(), because bus_register() was
not called, because it is conditional on MACH_IS_MAC.

Fix the crash by calling bus_register() unconditionally. Call it from
a postcore_initcall(), like other busses do.

Hence, the bus type is available for device_register(), which happens
in a subsys initcall, and for driver_register(), which happens in a
device or module initcall.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reported-by: Michael Schmitz <schmitzmic@gmail.com>
Tested-by: Stan Johnson <userm57@yahoo.com>
Fixes: 7f86c765a6a2 ("nubus: Add support for the driver model")
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Changed since v1:
- Improved commit log entry.
- The device_register(&nubus_parent) stays in the subsys initcall.
---
 drivers/nubus/bus.c   | 19 +++++++------------
 drivers/nubus/nubus.c |  2 +-
 include/linux/nubus.h |  2 +-
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/nubus/bus.c b/drivers/nubus/bus.c
index d306c348c857..a59b6c4bb5b8 100644
--- a/drivers/nubus/bus.c
+++ b/drivers/nubus/bus.c
@@ -63,20 +63,15 @@ static struct device nubus_parent = {
 	.init_name	= "nubus",
 };
 
-int __init nubus_bus_register(void)
+static int __init nubus_bus_register(void)
 {
-	int err;
-
-	err = device_register(&nubus_parent);
-	if (err)
-		return err;
-
-	err = bus_register(&nubus_bus_type);
-	if (!err)
-		return 0;
+	return bus_register(&nubus_bus_type);
+}
+postcore_initcall(nubus_bus_register);
 
-	device_unregister(&nubus_parent);
-	return err;
+int __init nubus_parent_device_register(void)
+{
+	return device_register(&nubus_parent);
 }
 
 static void nubus_device_release(struct device *dev)
diff --git a/drivers/nubus/nubus.c b/drivers/nubus/nubus.c
index 4621ff98138c..bb0d63a44f41 100644
--- a/drivers/nubus/nubus.c
+++ b/drivers/nubus/nubus.c
@@ -875,7 +875,7 @@ static int __init nubus_init(void)
 		return 0;
 
 	nubus_proc_init();
-	err = nubus_bus_register();
+	err = nubus_parent_device_register();
 	if (err)
 		return err;
 	nubus_scan_bus();
diff --git a/include/linux/nubus.h b/include/linux/nubus.h
index 6e8200215321..eba50b057f6f 100644
--- a/include/linux/nubus.h
+++ b/include/linux/nubus.h
@@ -163,7 +163,7 @@ void nubus_seq_write_rsrc_mem(struct seq_file *m,
 unsigned char *nubus_dirptr(const struct nubus_dirent *nd);
 
 /* Declarations relating to driver model objects */
-int nubus_bus_register(void);
+int nubus_parent_device_register(void);
 int nubus_device_register(struct nubus_board *board);
 int nubus_driver_register(struct nubus_driver *ndrv);
 void nubus_driver_unregister(struct nubus_driver *ndrv);
-- 
2.16.1
