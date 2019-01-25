Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB09CC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C197D2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 19:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbfAYTPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 14:15:21 -0500
Received: from mail.qboosh.pl ([217.73.31.61]:33923 "EHLO mail.qboosh.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbfAYTPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 14:15:20 -0500
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Jan 2019 14:15:19 EST
Received: from stranger.qboosh.pl (dynamic-78-8-88-26.ssp.dialog.net.pl [78.8.88.26])
        by mail.qboosh.pl (Postfix) with ESMTPSA id 6EB9B1A26DA9;
        Fri, 25 Jan 2019 20:09:22 +0100 (CET)
Received: from stranger.qboosh.pl (localhost [127.0.0.1])
        by stranger.qboosh.pl (8.15.2/8.15.2) with ESMTP id x0PJEcNa029398;
        Fri, 25 Jan 2019 20:14:38 +0100
Received: (from qboosh@localhost)
        by stranger.qboosh.pl (8.15.2/8.15.2/Submit) id x0PJEbJr029392;
        Fri, 25 Jan 2019 20:14:37 +0100
Date:   Fri, 25 Jan 2019 20:14:37 +0100
From:   Jakub Bogusz <qboosh@pld-linux.org>
To:     linux-kernel@vger.kernel.org, mitr@volny.cz
Subject: [PATCH][RESEND] wistron_btns needs executable BIOS image
Message-ID: <20190125191437.GA25902@stranger.qboosh.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20170731182010.GA933@stranger.qboosh.pl>
User-Agent: Mutt/1.6.2 (2016-07-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Let's try once again... (take 3)

First time I sent this patch when I prepared it in 2013 for Linux 3.12,
the second time after update for Linux 4.12 in 2017...
And it still applies to Linux 4.20.

Actual description in forwarded message.


-- 
Jakub Bogusz    http://qboosh.pl/

--4Ckj6UjgE2iN1+kY
Content-Type: message/rfc822
Content-Disposition: inline

Date: Mon, 31 Jul 2017 20:20:10 +0200
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org, mitr@volny.cz
Subject: [PATCH] wistron_btns needs executable BIOS image
Message-ID: <20170731182010.GA933@stranger.qboosh.pl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
User-Agent: Mutt/1.6.2 (2016-07-01)


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

This patch (originally agains 3.1x, now I updated include to build
against 4.12.x) fixes winstron_btns module issue with calling BIOS
functions in non-executable memory.

Tested (on Linux 3.10.x and few later versions) on F-S Amilo 8210 laptop.


-- 
Jakub Bogusz    http://qboosh.pl/

--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-wistron-nx.patch"

wistron_btns needs executable BIOS image.

Signed-off-by: Jakub Bogusz <qboosh@pld-linux.org>

--- linux-4.12/drivers/input/misc/wistron_btns.c.orig	2013-11-16 09:05:55.612742472 +0100
+++ linux-4.12/drivers/input/misc/wistron_btns.c	2013-11-16 09:24:37.356028732 +0100
@@ -33,6 +33,7 @@
 #include <linux/types.h>
 #include <linux/platform_device.h>
 #include <linux/leds.h>
+#include <asm/set_memory.h>
 
 /* How often we poll keys - msecs */
 #define POLL_INTERVAL_DEFAULT	500 /* when idle */
@@ -124,6 +125,7 @@
 	if (entry_point >= 0xF0000) {
 		bios_code_map_base = base;
 		bios_entry_point = bios_code_map_base + (entry_point & 0xFFFF);
+		set_memory_x((unsigned long)bios_code_map_base, 0x10000 >> PAGE_SHIFT);
 	} else {
 		iounmap(base);
 		bios_code_map_base = ioremap(entry_point & ~0x3FFF, 0x4000);
@@ -134,6 +136,7 @@
 			goto err;
 		}
 		bios_entry_point = bios_code_map_base + (entry_point & 0x3FFF);
+		set_memory_x((unsigned long)bios_code_map_base, 0x4000 >> PAGE_SHIFT);
 	}
 	/* The Windows driver maps 0x10000 bytes, we keep only one page... */
 	bios_data_map_base = ioremap(0x400, 0xc00);

--UugvWAfsgieZRqgk--

--4Ckj6UjgE2iN1+kY--
