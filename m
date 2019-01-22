Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA71EC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3ACD20855
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729115AbfAVPMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:12:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:58398 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728961AbfAVPMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:12:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 621C1B04F;
        Tue, 22 Jan 2019 15:12:05 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     thomas@winischhofer.net
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3/4] sisusb: let files build only when needed
Date:   Tue, 22 Jan 2019 16:12:01 +0100
Message-Id: <20190122151202.18152-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190122151202.18152-1-jslaby@suse.cz>
References: <20190122151202.18152-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the previous patch we see, that whole files are ifdeffed depending
on CONFIG options. So do not build the files at all if the CONFIG is not
enabled. (I.e. move the check from .c to Makefile.)

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/usb/misc/sisusbvga/Makefile      | 3 ++-
 drivers/usb/misc/sisusbvga/sisusb_con.c  | 7 -------
 drivers/usb/misc/sisusbvga/sisusb_init.c | 5 -----
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/misc/sisusbvga/Makefile b/drivers/usb/misc/sisusbvga/Makefile
index 6ed3a638261a..6551bce68ac5 100644
--- a/drivers/usb/misc/sisusbvga/Makefile
+++ b/drivers/usb/misc/sisusbvga/Makefile
@@ -5,4 +5,5 @@
 
 obj-$(CONFIG_USB_SISUSBVGA) += sisusbvga.o
 
-sisusbvga-y := sisusb.o sisusb_init.o sisusb_con.o
+sisusbvga-y := sisusb.o
+sisusbvga-$(CONFIG_USB_SISUSBVGA_CON) += sisusb_con.o sisusb_init.o
diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c b/drivers/usb/misc/sisusbvga/sisusb_con.c
index 10c15723a7c5..8e6d1b02e7c2 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_con.c
+++ b/drivers/usb/misc/sisusbvga/sisusb_con.c
@@ -70,8 +70,6 @@
 #include "sisusb.h"
 #include "sisusb_init.h"
 
-#ifdef CONFIG_USB_SISUSBVGA_CON
-
 #define sisusbcon_writew(val, addr)	(*(addr) = (val))
 #define sisusbcon_readw(addr)		(*(addr))
 #define sisusbcon_memmovew(d, s, c)	memmove(d, s, c)
@@ -1534,8 +1532,3 @@ void __init sisusb_init_concode(void)
 	for (i = 0; i < MAX_NR_CONSOLES; i++)
 		mysisusbs[i] = NULL;
 }
-
-#endif /* INCL_CON */
-
-
-
diff --git a/drivers/usb/misc/sisusbvga/sisusb_init.c b/drivers/usb/misc/sisusbvga/sisusb_init.c
index 0f7170f5b53f..66f6ab5acd97 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_init.c
+++ b/drivers/usb/misc/sisusbvga/sisusb_init.c
@@ -44,9 +44,6 @@
 #include <linux/spinlock.h>
 
 #include "sisusb.h"
-
-#ifdef CONFIG_USB_SISUSBVGA_CON
-
 #include "sisusb_init.h"
 
 /*********************************************/
@@ -955,5 +952,3 @@ int SiSUSBSetVESAMode(struct SiS_Private *SiS_Pr, unsigned short VModeNo)
 
 	return SiSUSBSetMode(SiS_Pr, ModeNo);
 }
-
-#endif /* CONFIG_USB_SISUSBVGA_CON */
-- 
2.20.1

