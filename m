Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752140AbeDIMvs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 08:51:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:40900 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751589AbeDIMvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 08:51:47 -0400
Date: Mon, 9 Apr 2018 14:51:43 +0200
From: Jean Delvare <jdelvare@suse.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] firmware: dmi_scan: Fix UUID length safety check
Message-ID: <20180409145143.4daa1706@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test which ensures that the DMI type 1 structure is long enough
to hold the UUID is off by one. It would fail if the structure is
exactly 24 bytes long, while that's sufficient to hold the UUID.

I don't expect this bug to cause problem in practice because all
implementations I have seen had length 8, 25 or 27 bytes, in line
with the SMBIOS specifications. But let's fix it still.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Fixes: a814c3597a6b ("firmware: dmi_scan: Check DMI structure length")
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/firmware/dmi_scan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-4.16.orig/drivers/firmware/dmi_scan.c	2018-04-08 09:32:20.508719012 +0200
+++ linux-4.16/drivers/firmware/dmi_scan.c	2018-04-09 11:24:57.937044642 +0200
@@ -186,7 +186,7 @@ static void __init dmi_save_uuid(const s
 	char *s;
 	int is_ff = 1, is_00 = 1, i;
 
-	if (dmi_ident[slot] || dm->length <= index + 16)
+	if (dmi_ident[slot] || dm->length < index + 16)
 		return;
 
 	d = (u8 *) dm + index;


-- 
Jean Delvare
SUSE L3 Support
