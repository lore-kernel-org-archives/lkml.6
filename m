Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16609C41536
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88472075C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D88472075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeJJVDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:03:02 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:54854 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeJJVDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:03:01 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id lpgl1y00z3XaVaC01pgmPe; Wed, 10 Oct 2018 15:40:46 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1gAEjF-000072-UI; Wed, 10 Oct 2018 15:40:45 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1gAEjF-0002Ak-TE; Wed, 10 Oct 2018 15:40:45 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] eeprom: at25: Split writes in two SPI transfers to optimize DMA
Date:   Wed, 10 Oct 2018 15:40:36 +0200
Message-Id: <20181010134036.8296-4-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181010134036.8296-1-geert+renesas@glider.be>
References: <20181010134036.8296-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently EEPROM writes are implemented using a single SPI transfer,
which contains all of command, address, and payload data bytes.
As some SPI controllers impose limitations on transfers with respect to
the use of DMA, they may have to fall back to PIO. E.g. DMA may require
the transfer length to be a multiple of 4 bytes.

Optimize writes for DMA by splitting writes in two SPI transfers:
  - The first transfer contains command and address bytes,
  - The second transfer contains the actual payload data, now stored at
    the start of the (kmalloc() aligned) buffer, to improve payload
    alignment.

E.g. for a 25LC040 EEPROM with a page size 16 bytes, a 16-byte write
aligned to the page size was transferred using an 18-byte write.
After this change, the write is split in a 2-byte and an aligned 16-byte
write.

Note that EEPROM reads already use a similar scheme, due to the
different data directions for command and address bytes versus payload
data.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/misc/eeprom/at25.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index 5c8dc7ad391435f7..f84d1681835b4ded 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -136,6 +136,7 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 	int			status = 0;
 	unsigned		buf_size;
 	u8			*bounce;
+	struct spi_transfer	t[2];
 
 	if (unlikely(off >= at25->chip.byte_len))
 		return -EFBIG;
@@ -160,7 +161,7 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 		unsigned long	timeout, retries;
 		unsigned	segment;
 		unsigned	offset = off;
-		u8		*cp = bounce;
+		u8		*cp = bounce + buf_size;
 		int		sr;
 		u8		instr;
 
@@ -194,9 +195,17 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 		segment = buf_size - (offset % buf_size);
 		if (segment > count)
 			segment = count;
-		memcpy(cp, buf, segment);
-		status = spi_write(at25->spi, bounce,
-				segment + at25->addrlen + 1);
+		memcpy(bounce, buf, segment);
+
+		memset(t, 0, sizeof(t));
+
+		t[0].tx_buf = bounce + buf_size;
+		t[0].len = at25->addrlen + 1;
+
+		t[1].tx_buf = bounce;
+		t[1].len = segment;
+
+		status = spi_sync_transfer(at25->spi, t, ARRAY_SIZE(t));
 		dev_dbg(&at25->spi->dev, "write %u bytes at %u --> %d\n",
 			segment, offset, status);
 		if (status < 0)
-- 
2.17.1

