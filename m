Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2C5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD0B2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD0B2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbeJJVDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:03:08 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:38638 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeJJVDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:03:04 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id lpgl1y00b3XaVaC01pglJS; Wed, 10 Oct 2018 15:40:48 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1gAEjF-00006x-TZ; Wed, 10 Oct 2018 15:40:45 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gAEjF-0002Ah-Sc; Wed, 10 Oct 2018 15:40:45 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/3] eeprom: at25: Use spi_message_init_with_transfers() instead of open coding
Date:   Wed, 10 Oct 2018 15:40:35 +0200
Message-Id: <20181010134036.8296-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181010134036.8296-1-geert+renesas@glider.be>
References: <20181010134036.8296-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce code duplication in at25_ee_read() by using the
spi_message_init_with_transfers() helper.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/misc/eeprom/at25.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 7707d3fb49b526d9..5c8dc7ad391435f7 100644
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

