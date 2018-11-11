Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E12C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB7920818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:30:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB7920818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbeKLGUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:20:04 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:50448 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730414AbeKLFsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:20 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsg-0000tu-Pf; Sun, 11 Nov 2018 19:58:51 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsa-0001s9-BT; Sun, 11 Nov 2018 19:58:44 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Arnd Bergmann" <arnd@arndb.de>,
        "Mauro Carvalho Chehab" <mchehab@s-opensource.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.522503794@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 344/366] [media] ir-core: fix gcc-7 warning on bool
 arithmetic
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit bd7e31bbade02bc1e92aa00d5cf2cee2da66838a upstream.

gcc-7 suggests that an expression using a bitwise not and a bitmask
on a 'bool' variable is better written using boolean logic:

drivers/media/rc/imon.c: In function 'imon_incoming_scancode':
drivers/media/rc/imon.c:1725:22: error: '~' on a boolean expression [-Werror=bool-operation]
    ictx->pad_mouse = ~(ictx->pad_mouse) & 0x1;
                      ^
drivers/media/rc/imon.c:1725:22: note: did you mean to use logical not?

I agree.

Fixes: 21677cfc562a ("V4L/DVB: ir-core: add imon driver")

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/rc/imon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -1530,7 +1530,7 @@ static void imon_incoming_packet(struct
 	if (kc == KEY_KEYBOARD && !ictx->release_code) {
 		ictx->last_keycode = kc;
 		if (!nomouse) {
-			ictx->pad_mouse = ~(ictx->pad_mouse) & 0x1;
+			ictx->pad_mouse = !ictx->pad_mouse;
 			dev_dbg(dev, "toggling to %s mode\n",
 				ictx->pad_mouse ? "mouse" : "keyboard");
 			spin_unlock_irqrestore(&ictx->kc_lock, flags);

