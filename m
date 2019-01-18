Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B34C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2395D2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbfAROiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:38:52 -0500
Received: from baptiste.telenet-ops.be ([195.130.132.51]:59108 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbfAROiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:38:50 -0500
Received: from ramsan ([84.194.111.163])
        by baptiste.telenet-ops.be with bizsmtp
        id Rqen1z00Z3XaVaC01qenMl; Fri, 18 Jan 2019 15:38:48 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gkVIF-0007kw-5o; Fri, 18 Jan 2019 15:38:47 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gkUlz-0007bb-Un; Fri, 18 Jan 2019 15:05:27 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nguyen An Hoan <na-hoan@jinso.co.jp>, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 1/2] eeprom: at25: Merge "off" and "offset" in at25_ee_write()
Date:   Fri, 18 Jan 2019 15:05:24 +0100
Message-Id: <20190118140525.29189-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190118140525.29189-1-geert+renesas@glider.be>
References: <20190118140525.29189-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 01973a01f9ec34b7 ("eeprom: at25: remove nvmem regmap
dependency") changed the type of "off" from "loff_t" to "unsigned int",
"off" and "offset" are now the same type, and can be merged into a
single variable.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Merge "off" and "offset" into a single variable instead of just
    killing the cast, as suggested by Arnd.
---
 drivers/misc/eeprom/at25.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 99de6939cd5ac2e3..2d8e5388e574710d 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -130,7 +130,8 @@ static int at25_ee_read(void *priv, unsigned int offset,
 	return status;
 }
 
-static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
+static int at25_ee_write(void *priv, unsigned int offset, void *val,
+			 size_t count)
 {
 	struct at25_data *at25 = priv;
 	const char *buf = val;
@@ -138,10 +139,10 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 	unsigned		buf_size;
 	u8			*bounce;
 
-	if (unlikely(off >= at25->chip.byte_len))
+	if (unlikely(offset >= at25->chip.byte_len))
 		return -EFBIG;
-	if ((off + count) > at25->chip.byte_len)
-		count = at25->chip.byte_len - off;
+	if ((offset + count) > at25->chip.byte_len)
+		count = at25->chip.byte_len - offset;
 	if (unlikely(!count))
 		return -EINVAL;
 
@@ -160,7 +161,6 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 	do {
 		unsigned long	timeout, retries;
 		unsigned	segment;
-		unsigned	offset = (unsigned) off;
 		u8		*cp = bounce;
 		int		sr;
 		u8		instr;
@@ -234,7 +234,7 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 			break;
 		}
 
-		off += segment;
+		offset += segment;
 		buf += segment;
 		count -= segment;
 
-- 
2.17.1

