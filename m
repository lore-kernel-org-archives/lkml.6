Return-Path: <flo@geekplace.eu>
X-Google-Smtp-Source: AB8JxZpDbgo6lw50HN7fnMI/7hH22etPDf+WB6iLNtqGA7nt4GvwPwewpKC9iORA6MNTrOJyaIDK
ARC-Seal: i=1; a=rsa-sha256; t=1526472330; cv=none;
        d=google.com; s=arc-20160816;
        b=J1gjaNLfhWmKvp3U9P7gAVqwUUEIhbJKTKpv1r6uBxQ/Jxn657RdRUILjGQtPZjlac
         Wh+mzvroiB9KFJIDSafOENYxoEgRGoKrmMMNzDc4vZl1YEgvXvo1zYW2Hh4ZwFoXelPy
         YbeUpzaWiZs7vXeBDzZULAhCBe1zFg8Kz5/M7APOliIJsse/NCdntDC0OYHFALTMZhAG
         MWz1HEr1PANi96KeYEnUeiJLrP9UXbMTM5gvK2B97865ORFalqzlHiaQBQhcVIGJtHDY
         j4yrKY22GQ0zA+XMrRsMraElq3aMcz53pJVC7UjQosAA/HfZ/lvOd9/QXkCHLBbA6W/P
         tPBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KtjxP1pNPwF2agSvPRzXsGi9GetHyHCv92Zr3tyO968=;
        b=i0uDvPV41AG1X1LMu6cpsOCf1YmTK2B3bT6bWjOBx6dnLB1bOj7SdxlMsIClFajrsY
         p7xg040PM4T7sBtsNbR5HKL1l3/qI14r8rKQqGiKyX/+yXjruvaVrnjk97pHt0PvGXFl
         +8NWPf/+mvnHDZeVbTmuKuVh5OuOCKj0t7Gyx3chPal++plyWNsm/+/ziu7rUXuyWVkj
         X3dzHtS/F1pQtqjiGxusGgpOR/LJ1r925rgTUSY0DTF0iHscJASUFqUGv8wDrc12vxKP
         xt6jM/s25KvoKc1xGF2fTfF2bvzBcJQRyatb9RD8smhltuF4FJCnuzg7iNUgkJlbIRSX
         POaw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of flo@geekplace.eu designates 2a03:4000:6:3a8::1 as permitted sender) smtp.mailfrom=flo@geekplace.eu
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of flo@geekplace.eu designates 2a03:4000:6:3a8::1 as permitted sender) smtp.mailfrom=flo@geekplace.eu
From: Florian Schmaus <flo@geekplace.eu>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Florian Schmaus <flo@geekplace.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] driver-core: return EINVAL error instead of BUG_ON()
Date: Wed, 16 May 2018 14:05:25 +0200
Message-Id: <20180516120527.29403-2-flo@geekplace.eu>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180516120527.29403-1-flo@geekplace.eu>
References: <20180516120527.29403-1-flo@geekplace.eu>
In-Reply-To: <20180515135114.31939-1-flo@geekplace.eu>
References: <20180515135114.31939-1-flo@geekplace.eu>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600538307173968753?=
X-GMAIL-MSGID: =?utf-8?q?1600622250652122681?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I triggerd the BUG_ON() in driver_register() when booting a domU Xen
domain. Since there was no contextual information logged, I needed to
attach kgdb to determine the culprit (the wmi-bmof driver in my
case). The BUG_ON() was added in commit f48f3febb2cb ("driver-core: do
not register a driver with bus_type not registered").

Instead of running into a BUG_ON() we print an error message
identifying the, likely faulty, driver but continue booting.

Signed-off-by: Florian Schmaus <flo@geekplace.eu>
---

Notes:
    - Also print out the bus name
    - Use pr_err() instead of printk()

 drivers/base/driver.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index ba912558a510..203fa731e3ee 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -148,7 +148,12 @@ int driver_register(struct device_driver *drv)
 	int ret;
 	struct device_driver *other;
 
-	BUG_ON(!drv->bus->p);
+	if (!drv->bus->p) {
+		pr_err("Driver '%s' was unable to register with bus_type '%s'"
+			   " because it was not initialized.\n",
+			   drv->name, drv->bus->name);
+		return -EINVAL;
+	}
 
 	if ((drv->bus->probe && drv->probe) ||
 	    (drv->bus->remove && drv->remove) ||
-- 
2.16.1
