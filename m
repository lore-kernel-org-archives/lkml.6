Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41358C43610
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 19:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D74720855
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 19:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIBNba9J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D74720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbeKZGjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 01:39:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39514 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbeKZGjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 01:39:32 -0500
Received: by mail-wm1-f66.google.com with SMTP id u13-v6so16274114wmc.4
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 11:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YzP74p89FV3nHKyLJN9eSl4PTI/yDx70Z2XdXYx85P0=;
        b=nIBNba9JH8NwYOk0aEju2qyihNV6BI6zGiKz26O4WJ11HkZqc0g+lCcdbFnK4MVg7L
         VS4coJmh/686qP3JUEtisuUutCscWY0uNS2z58FyB6UYawtYYRHeDhi/ruWH37NU12nc
         wYzctWytoYNqDM28/L7JHKZnWb6GgWUk/inhtqwoo5MRPOSxJAAPfznHmrgyTUa5pzEv
         5DAH9ZzD7ON/KrRaWZhepS7yQ0p0oB0GOHPaCkRKYsd+MFXLOdIL6LTEByk+m2nhF4Nd
         LNNEZF4BfL35JHAy2goYYGEZQKMbYtMt6MGMZVOM3p0pNFEG/IDWFeK0ZCDctW+Upn43
         W5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YzP74p89FV3nHKyLJN9eSl4PTI/yDx70Z2XdXYx85P0=;
        b=Ju87Bd50VvJx8e1fvf3kMs+Tg9K2xCWGv+7KE76hyJQuirL+Qoq5JIzCLYsoKHZTHT
         VnliNKSwljzXoNZFgR1POuyimkt6u/IHYFDZOWNIyw9MuY9ezXg8myTyolnE3UJZbEsg
         hvEB2G3imrmHqnfM6ncXsldtGwK/DnPfWv66wp1dnzpVwm7No2hx88HfBRrnH2Rxx1Cn
         JPXmrEKNCHdlYXjF5t3BHrL+nCKQNDJh5VBFSfjxLzYLnJjrhrtmMFJ/+m9toKQxbuvu
         5RvJie6Q0Ptd5+JCWVWpFKr1Oibw2d3bSmoFDAlfU2jxZcsQOc6fUqwJj0XIXod4CIZU
         WjAQ==
X-Gm-Message-State: AGRZ1gJxcGCAQRqoLO83+AdvIo0cw5p/l0RzQXGV8Bu0OuzciqZlr/ez
        i5rx+os6FKYtvR+rgJw+klI=
X-Google-Smtp-Source: AFSGD/UPXOYCjNKQ4FsmBz7N1bLfcPf32ZKDHDh03zvTsJhW+BzFz5VfDQ2KC2vxtFe5jr3kz56zJQ==
X-Received: by 2002:a1c:6e09:: with SMTP id j9mr22041858wmc.105.1543175262021;
        Sun, 25 Nov 2018 11:47:42 -0800 (PST)
Received: from localhost.localdomain (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id y138sm15744436wmc.16.2018.11.25.11.47.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 11:47:41 -0800 (PST)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 1/6] char: lp: remove trailing whitespace
Date:   Sun, 25 Nov 2018 19:47:32 +0000
Message-Id: <20181125194737.5591-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch error for trailing whitespace.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/char/lp.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index 8c4dd1a3bb6a..7b15272c0510 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -46,8 +46,8 @@
  *	lp=auto				(assign lp devices to all ports that
  *				         have printers attached, as determined
  *					 by the IEEE-1284 autoprobe)
- * 
- *	lp=reset			(reset the printer during 
+ *
+ *	lp=reset			(reset the printer during
  *					 initialisation)
  *
  *	lp=off				(disable the printer driver entirely)
@@ -188,7 +188,7 @@ static int lp_preempt(void *handle)
 }
 
 
-/* 
+/*
  * Try to negotiate to a new mode; if unsuccessful negotiate to
  * compatibility mode.  Return the mode we ended up in.
  */
@@ -326,7 +326,7 @@ static ssize_t lp_write(struct file * file, const char __user * buf,
  	 */
 	lp_claim_parport_or_block (&lp_table[minor]);
 	/* Go to the proper mode. */
-	lp_table[minor].current_mode = lp_negotiate (port, 
+	lp_table[minor].current_mode = lp_negotiate (port,
 						     lp_table[minor].best_mode);
 
 	parport_set_timeout (lp_table[minor].dev,
@@ -355,7 +355,7 @@ static ssize_t lp_write(struct file * file, const char __user * buf,
 			/* incomplete write -> check error ! */
 			int error;
 
-			parport_negotiate (lp_table[minor].dev->port, 
+			parport_negotiate (lp_table[minor].dev->port,
 					   IEEE1284_MODE_COMPAT);
 			lp_table[minor].current_mode = IEEE1284_MODE_COMPAT;
 
@@ -372,8 +372,8 @@ static ssize_t lp_write(struct file * file, const char __user * buf,
 			}
 
 			parport_yield_blocking (lp_table[minor].dev);
-			lp_table[minor].current_mode 
-			  = lp_negotiate (port, 
+			lp_table[minor].current_mode
+			  = lp_negotiate (port,
 					  lp_table[minor].best_mode);
 
 		} else if (need_resched())
@@ -389,13 +389,13 @@ static ssize_t lp_write(struct file * file, const char __user * buf,
 					retv = -EFAULT;
 				break;
 			}
-		}	
+		}
 	} while (count > 0);
 
-	if (test_and_clear_bit(LP_PREEMPT_REQUEST, 
+	if (test_and_clear_bit(LP_PREEMPT_REQUEST,
 			       &lp_table[minor].bits)) {
 		printk(KERN_INFO "lp%d releasing parport\n", minor);
-		parport_negotiate (lp_table[minor].dev->port, 
+		parport_negotiate (lp_table[minor].dev->port,
 				   IEEE1284_MODE_COMPAT);
 		lp_table[minor].current_mode = IEEE1284_MODE_COMPAT;
 		lp_release_parport (&lp_table[minor]);
@@ -542,7 +542,7 @@ static int lp_open(struct inode * inode, struct file * file)
 	/* Determine if the peripheral supports ECP mode */
 	lp_claim_parport_or_block (&lp_table[minor]);
 	if ( (lp_table[minor].dev->port->modes & PARPORT_MODE_ECP) &&
-             !parport_negotiate (lp_table[minor].dev->port, 
+             !parport_negotiate (lp_table[minor].dev->port,
                                  IEEE1284_MODE_ECP)) {
 		printk (KERN_INFO "lp%d: ECP mode\n", minor);
 		lp_table[minor].best_mode = IEEE1284_MODE_ECP;
@@ -615,7 +615,7 @@ static int lp_do_ioctl(unsigned int minor, unsigned int cmd,
 		case LPWAIT:
 			LP_WAIT(minor) = arg;
 			break;
-		case LPSETIRQ: 
+		case LPSETIRQ:
 			return -EINVAL;
 			break;
 		case LPGETIRQ:
@@ -908,7 +908,7 @@ static int __init lp_setup (char *str)
 
 static int lp_register(int nr, struct parport *port)
 {
-	lp_table[nr].dev = parport_register_device(port, "lp", 
+	lp_table[nr].dev = parport_register_device(port, "lp",
 						   lp_preempt, NULL, NULL, 0,
 						   (void *) &lp_table[nr]);
 	if (lp_table[nr].dev == NULL)
@@ -921,7 +921,7 @@ static int lp_register(int nr, struct parport *port)
 	device_create(lp_class, port->dev, MKDEV(LP_MAJOR, nr), NULL,
 		      "lp%d", nr);
 
-	printk(KERN_INFO "lp%d: using %s (%s).\n", nr, port->name, 
+	printk(KERN_INFO "lp%d: using %s (%s).\n", nr, port->name,
 	       (port->irq == PARPORT_IRQ_NONE)?"polling":"interrupt-driven");
 
 #ifdef CONFIG_LP_CONSOLE
@@ -1060,7 +1060,7 @@ static int __init lp_init_module (void)
 				else {
 					char *ep;
 					unsigned long r = simple_strtoul(parport[n], &ep, 0);
-					if (ep != parport[n]) 
+					if (ep != parport[n])
 						parport_nr[n] = r;
 					else {
 						printk(KERN_ERR "lp: bad port specifier `%s'\n", parport[n]);
-- 
2.11.0

