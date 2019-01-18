Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF870C43444
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC6D22054F
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 14:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfAROix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 09:38:53 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:54910 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfAROiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 09:38:51 -0500
Received: from ramsan ([84.194.111.163])
        by andre.telenet-ops.be with bizsmtp
        id Rqen1z00H3XaVaC01qencT; Fri, 18 Jan 2019 15:38:49 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gkVIF-0007kw-4O; Fri, 18 Jan 2019 15:38:47 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gkUm1-0007bf-Eo; Fri, 18 Jan 2019 15:05:29 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nguyen An Hoan <na-hoan@jinso.co.jp>, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 2/2] eeprom: at25: Use spi_message_init_with_transfers() instead of open coding
Date:   Fri, 18 Jan 2019 15:05:25 +0100
Message-Id: <20190118140525.29189-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190118140525.29189-1-geert+renesas@glider.be>
References: <20190118140525.29189-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce code duplication in at25_ee_read() by using the
spi_message_init_with_transfers() helper.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by.
---
 drivers/misc/eeprom/at25.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 2d8e5388e574710d..18a093e14517ab45 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -103,16 +103,15 @@ static int at25_ee_read(void *priv, unsigned int offset,
 		*cp++ = offset >> 0;
 	}
 
-	spi_message_init(&m);
 	memset(t, 0, sizeof(t));
 
 	t[0].tx_buf = command;
 	t[0].len = at25->addrlen + 1;
-	spi_message_add_tail(&t[0], &m);
 
 	t[1].rx_buf = buf;
 	t[1].len = count;
-	spi_message_add_tail(&t[1], &m);
+
+	spi_message_init_with_transfers(&m, t, ARRAY_SIZE(t));
 
 	mutex_lock(&at25->lock);
 
-- 
2.17.1

