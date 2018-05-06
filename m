Return-Path: <fthain@telegraphics.com.au>
X-Google-Smtp-Source: AB8JxZqFVgj+S08VlzRvgepFDQo6VGOrcLXNeaDCISQTT9AtGHERBS9jnFDeim1+YLk9pQ5SJDRN
ARC-Seal: i=1; a=rsa-sha256; t=1525571283; cv=none;
        d=google.com; s=arc-20160816;
        b=RbfSBSaQFHi+Z7/h054BouG/mELiw5itHp9wfzX8taWhZQICfJ38+P+8X9K9V1w/4J
         vSm2K/IuPKa2Sbj2g+IYLYE8+RToX/Bzga6FRowbcbhT4JthVq3Wdn2SnZlsPucQ1SZa
         4630QkaClykPsL5mrq1drYoeoUyYavjydavQ5QWX7pbhTmQD2cW3HMSp73aljAKv1i0e
         v2xJjaPNvwgU+2pkAOtEFmOejfIpUTafsFznIGYvvh9ykBvnwJMFIH8+aKRhTWYVsXwT
         0AbDm4ONTlT1q3LFLnLSOiSPP5yo0uLHVRCw7UFwqstpu/EsN37Y4XfhqFZwxUm1oK9n
         bLeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=resent-message-id:resent-subject:resent-to:resent-from:resent-date
         :subject:from:cc:to:date:message-id:arc-authentication-results;
        bh=WeSWOiqEqr67GwqutDFrI/fvhPidIwHAQjnS9BNZSWI=;
        b=BwX61NqWCVCujHHnQqBMc+1FXEdN+Cc3IIRSr/GVuersEWitdgH4hHnvE75H2qQNWW
         CjrpS3Tx4XHBZ5sJWNpxcYbAXt+Okx+QHLfK9qs/Z7/49MAiQc0RyxbzghGuM6QCEViX
         drn4IaoYRb1KXLi3w5QSHb52CeKSxaDJiZtue9I6qeEOUJAY++ssgKih2Kt9z87D9Xrg
         0YrSrZgDktslDptxzDotKt5Rvz1M4HU13eJXgaqiTtVEBp2GG7hCV3r7ddbC/9WUbvdi
         A/bzkIfL4P8JjVH6Dhj2n+qmOXpJlMMqaFEJ4n0h2g2o+jk/apXUJ9HFamrBBGHWZttO
         h9eg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of fthain@telegraphics.com.au designates 98.124.60.144 as permitted sender) smtp.mailfrom=fthain@telegraphics.com.au
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of fthain@telegraphics.com.au designates 98.124.60.144 as permitted sender) smtp.mailfrom=fthain@telegraphics.com.au
Message-Id: <5aee5ed3.1c69fb81.19d98.ef06SMTPIN_ADDED_MISSING@mx.google.com>
Date: Sun, 06 May 2018 11:47:52 +1000
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] nubus: Unconditionally register bus type
ReSent-Date: Sun, 6 May 2018 11:47:27 +1000 (AEST)
ReSent-From: fthain@telegraphics.com.au
ReSent-To: geert@linux-m68k.org, gregkh@linuxfoundation.org,
    linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
ReSent-Subject: [PATCH] nubus: Unconditionally register bus type
ReSent-Message-ID: <alpine.LNX.2.21.1805061147270.8@nippy.intranet>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599677433904135296?=
X-GMAIL-MSGID: =?utf-8?q?1599677433904135296?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Loading a NuBus driver module on a non-NuBus machine triggers the
BUG_ON(!drv->bus->p) in driver_register() because the bus does not get
registered unless MACH_IS_MAC(). Avoid this by registering the bus
unconditionally using postcore_initcall().

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reported-by: Michael Schmitz <schmitzmic@gmail.com>
Tested-by: Stan Johnson <userm57@yahoo.com>
Fixes: 7f86c765a6a2 ("nubus: Add support for the driver model")
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/nubus/bus.c   | 3 ++-
 drivers/nubus/nubus.c | 5 -----
 include/linux/nubus.h | 1 -
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/nubus/bus.c b/drivers/nubus/bus.c
index d306c348c857..27ca9f1a281b 100644
--- a/drivers/nubus/bus.c
+++ b/drivers/nubus/bus.c
@@ -63,7 +63,7 @@ static struct device nubus_parent = {
 	.init_name	= "nubus",
 };
 
-int __init nubus_bus_register(void)
+static int __init nubus_bus_register(void)
 {
 	int err;
 
@@ -78,6 +78,7 @@ int __init nubus_bus_register(void)
 	device_unregister(&nubus_parent);
 	return err;
 }
+postcore_initcall(nubus_bus_register);
 
 static void nubus_device_release(struct device *dev)
 {
diff --git a/drivers/nubus/nubus.c b/drivers/nubus/nubus.c
index 4621ff98138c..f6bab483f4cb 100644
--- a/drivers/nubus/nubus.c
+++ b/drivers/nubus/nubus.c
@@ -869,15 +869,10 @@ static void __init nubus_scan_bus(void)
 
 static int __init nubus_init(void)
 {
-	int err;
-
 	if (!MACH_IS_MAC)
 		return 0;
 
 	nubus_proc_init();
-	err = nubus_bus_register();
-	if (err)
-		return err;
 	nubus_scan_bus();
 	return 0;
 }
diff --git a/include/linux/nubus.h b/include/linux/nubus.h
index 6e8200215321..f01e7f4bcff8 100644
--- a/include/linux/nubus.h
+++ b/include/linux/nubus.h
@@ -163,7 +163,6 @@ void nubus_seq_write_rsrc_mem(struct seq_file *m,
 unsigned char *nubus_dirptr(const struct nubus_dirent *nd);
 
 /* Declarations relating to driver model objects */
-int nubus_bus_register(void);
 int nubus_device_register(struct nubus_board *board);
 int nubus_driver_register(struct nubus_driver *ndrv);
 void nubus_driver_unregister(struct nubus_driver *ndrv);
-- 
2.16.1
