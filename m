Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792DBC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D74120874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216081;
	bh=k+xhMifa6pMdYSDyTVl71yg0EHd61XlAo+cs4IETlRc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AekcUahvRujtwD3/n2H4s4xAJq89hsQBgaBlJbL5xxmncsP1MMzucYrxbocrODfMR
	 Cd2wxbf8Tzh6o52L3+TfDECSw6/OJgQlLJVbpYLuinVMxDLWwruv66+dQcyaajb484
	 4gx5DOADQasq2D4TjFSCAf9nms3lvv5OL6+ySO6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733110AbfAKOOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:14:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:58380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733073AbfAKOOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:14:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01BCD214D8;
        Fri, 11 Jan 2019 14:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216078;
        bh=k+xhMifa6pMdYSDyTVl71yg0EHd61XlAo+cs4IETlRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wTl/ZC+vWE/O8Avls7UqyL8dzP+3XYiR6C/A1MrHCBi3I+iZsDtGqgISdX8XIj80l
         S9aSXjJ2f5/cFmFU90Et82yzfaDUz7snr8JlhQmSafDpZs45IIZ5xeaQqqIRaS8Bow
         0nT0rguuZH10kngr3fDedYohsaIKBMJidfV7RJjE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3.18 05/47] gpio: max7301: fix driver for use with CONFIG_VMAP_STACK
Date:   Fri, 11 Jan 2019 15:07:50 +0100
Message-Id: <20190111130956.854184298@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111130956.170952125@linuxfoundation.org>
References: <20190111130956.170952125@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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


