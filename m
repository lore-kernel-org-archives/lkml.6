Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60574C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280C021783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216300;
	bh=LjXNoPFKqGwaY7OjIqIxvOPCQKJ5hM6LYYg8I2UmTEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zKQscYoz5hwIQZuvY6WLfM2DzcqSPtlw9JOiMkbDXiqZz16HxSdyty8ubvxSLvFql
	 7XTgEyJxBQgW32PPp1xNcHNV7qwsftG5yszyNcQW9yFcT5czQpjIz3HATo4TtdIVCf
	 tSjxxWMBE/p1mBDjq4n1Q8KqO/G7x1IMcSC4BFCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387965AbfAKOST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:18:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:34598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387958AbfAKOSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:18:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6910F21783;
        Fri, 11 Jan 2019 14:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216287;
        bh=LjXNoPFKqGwaY7OjIqIxvOPCQKJ5hM6LYYg8I2UmTEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AQ8l7sQFxQ+NoO4sXxUtMEUaWeOa9IHTe6UGVuM0nFlig5iVhSRmzxcjm+UUyL74r
         br5AaJVRJl6R3ICd7CTkUcVZaYr40cG3Ck/XB2nXldojurjhF/7Vv8pX/qN0gg9pz/
         bsGumzxSdIBR2gqAV4hJrov8Uz/6e/xjYhZnWEZw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.4 10/88] gpio: max7301: fix driver for use with CONFIG_VMAP_STACK
Date:   Fri, 11 Jan 2019 15:07:39 +0100
Message-Id: <20190111131047.766590333@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit abf221d2f51b8ce7b9959a8953f880a8b0a1400d upstream.

spi_read() and spi_write() require DMA-safe memory. When
CONFIG_VMAP_STACK is selected, those functions cannot be used
with buffers on stack.

This patch replaces calls to spi_read() and spi_write() by
spi_write_then_read() which doesn't require DMA-safe buffers.

Fixes: 0c36ec314735 ("gpio: gpio driver for max7301 SPI GPIO expander")
Cc: <stable@vger.kernel.org>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpio-max7301.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

--- a/drivers/gpio/gpio-max7301.c
+++ b/drivers/gpio/gpio-max7301.c
@@ -25,7 +25,7 @@ static int max7301_spi_write(struct devi
 	struct spi_device *spi = to_spi_device(dev);
 	u16 word = ((reg & 0x7F) << 8) | (val & 0xFF);
 
-	return spi_write(spi, (const u8 *)&word, sizeof(word));
+	return spi_write_then_read(spi, &word, sizeof(word), NULL, 0);
 }
 
 /* A read from the MAX7301 means two transfers; here, one message each */
@@ -37,14 +37,8 @@ static int max7301_spi_read(struct devic
 	struct spi_device *spi = to_spi_device(dev);
 
 	word = 0x8000 | (reg << 8);
-	ret = spi_write(spi, (const u8 *)&word, sizeof(word));
-	if (ret)
-		return ret;
-	/*
-	 * This relies on the fact, that a transfer with NULL tx_buf shifts out
-	 * zero bytes (=NOOP for MAX7301)
-	 */
-	ret = spi_read(spi, (u8 *)&word, sizeof(word));
+	ret = spi_write_then_read(spi, &word, sizeof(word), &word,
+				  sizeof(word));
 	if (ret)
 		return ret;
 	return word & 0xff;


