Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F40EC61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 22:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65032086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 22:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lae9wRKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbfASWGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 17:06:03 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43669 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbfASWGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 17:06:02 -0500
Received: by mail-qt1-f195.google.com with SMTP id i7so19128090qtj.10
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 14:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gAjdUFdnRCROsG1samA/pnuTK9kci1xm5HXmNld29iA=;
        b=Lae9wRKazdNd7tQNBAvcwNR3qlYRZAG3fp8w3ybWEbfvYKBSm1Sw44w6mK2EgF6m3J
         SA1DvJ9KLFNt05TnqHoIaWLrB+G/UsIKiifFKSSNp5WrNg8tSd4E+r73fE9SBuNO6GhI
         uMCkKvEyTwgLzVusqL9m4WcWUh9p8kc9vbjxa1YjHvcCWN0IpKUQhCQNZQxax8gEGaId
         pZvVGIBcCa9TecQz2fnTjM+5lA+Zr4dK14IR+lBTcSwerUhElkIdz022e5vsyKwjm9HX
         yXHch/NHKqpS229wAYkw1SfdPQ9nd/3uC1bhnXGPjkhR+WEM3+pxgAFQKARXFN0pbLN8
         wYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gAjdUFdnRCROsG1samA/pnuTK9kci1xm5HXmNld29iA=;
        b=CjqT1WmWmvREkkGd3m0JA8JzZqck5XK7lzjMo2UZYtWoA1tRMG3le9NwnAcoSH7ITP
         3ULSUl7v4gBcutMoCjLsu74pyvitemYFA+gAn8vDEukiroNdFb+MTxRgbya80LVZC3HU
         WWxuh4OoPsJ7znToTlrYGWcdGxYDufNRNiw4Q85LFpBrSUJlY4R69W4Deq6rWQtBxsMq
         YgejydtF/Hfqx8zzh4UC3ViUjmtgieOFk/cGgQhhj87yVGfMwkwMFM8ohnlMcALbjs57
         NAWM8ZPfnXms+32ovSDdFmdI51qKVnpsg0KsHrDrravKMNyeo8HLOFZgh5lz9+ZNhuXc
         lE7A==
X-Gm-Message-State: AJcUukf2G14O6ZnlBGYvFohKkxm2b5lbXRWaAndXWacVyrTjwCFTQ8Xc
        rYzBrEJ/nISPwNSoO344gwg=
X-Google-Smtp-Source: ALg8bN76VGWRVDqsYjjduYQBiiMOiF9b8vJhCkv3nwabVpcQJy2Jq0N+uCCG/SyLbWUqQ7cw2VWvmA==
X-Received: by 2002:a0c:ebc8:: with SMTP id k8mr20669351qvq.14.1547935561818;
        Sat, 19 Jan 2019 14:06:01 -0800 (PST)
Received: from localhost.localdomain ([23.233.244.16])
        by smtp.gmail.com with ESMTPSA id c17sm80382610qtb.14.2019.01.19.14.06.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 14:06:01 -0800 (PST)
From:   Antoine Robertson <antoinerbrtsn@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Antoine Robertson <antoinerbrtsn@gmail.com>
Subject: [PATCH] tty: moxa: Fix coding style issues
Date:   Sat, 19 Jan 2019 17:05:58 -0500
Message-Id: <20190119220558.28927-1-antoinerbrtsn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coding style issues

Signed-off-by: Antoine Robertson <antoinerbrtsn@gmail.com>
---
 drivers/tty/moxa.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
index 3a1a5e0ee93f..8641f8ecf1d6 100644
--- a/drivers/tty/moxa.c
+++ b/drivers/tty/moxa.c
@@ -42,7 +42,7 @@
 #include <linux/slab.h>
 #include <linux/ratelimit.h>
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/uaccess.h>
 
 #include "moxa.h"
@@ -74,8 +74,7 @@ enum {
 	MOXA_BOARD_CP204J,
 };
 
-static char *moxa_brdname[] =
-{
+static char *moxa_brdname[] = {
 	"C218 Turbo PCI series",
 	"C218 Turbo ISA series",
 	"C320 Turbo PCI series",
@@ -1159,9 +1158,8 @@ static int moxa_open(struct tty_struct *tty, struct file *filp)
 	int port;
 
 	port = tty->index;
-	if (port == MAX_PORTS) {
+	if (port == MAX_PORTS)
 		return capable(CAP_SYS_ADMIN) ? 0 : -EPERM;
-	}
 	if (mutex_lock_interruptible(&moxa_openlock))
 		return -ERESTARTSYS;
 	brd = &moxa_boards[port / MAX_PORTS_PER_BOARD];
@@ -1357,8 +1355,7 @@ static void moxa_new_dcdstate(struct moxa_port *p, u8 dcd)
         	spin_unlock_irqrestore(&p->port.lock, flags);
 		if (!dcd)
 			tty_port_tty_hangup(&p->port, true);
-	}
-	else
+	} else
 		spin_unlock_irqrestore(&p->port.lock, flags);
 }
 
@@ -1625,10 +1622,10 @@ static void MoxaPortFlushData(struct moxa_port *port, int mode)
  *      Syntax:
  *      void MoxaPortFlushData(int port, int mode);
  *           int port           : port number (0 - 127)
- *           int mode    
- *                      0       : flush the Rx buffer 
- *                      1       : flush the Tx buffer 
- *                      2       : flush the Rx and Tx buffer 
+ *           int mode
+ *                      0       : flush the Rx buffer
+ *                      1       : flush the Tx buffer
+ *                      2       : flush the Rx and Tx buffer
  *
  *
  *      Function 20:    Write data.
-- 
2.17.1

