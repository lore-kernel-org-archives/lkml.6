Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4604AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A8120645
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 16:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="SNuLBgKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A8120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeIDUsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:48:42 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53358 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbeIDUsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=punHLCxYXCikWb/crrLEBqiI942vmU4QaE7szHqjKHA=; b=SNuLBgKjOWBP
        XSjkRKZw5WlP1sz9mtm1AkKq0ZtQeVaRa8dajwiWKn3svBJRYANVK+CYxE/5VtKb94UgnBXMYX++R
        G3XGUIeEX1P2Yc0JLEVc2TuU5uLi5c7gJUffBFeVQlOy6aqDx29RTaIQkdK9mvXh9a0BC2d3noVrB
        dGUy4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fxE6L-0001Ug-NE; Tue, 04 Sep 2018 16:22:49 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7424B11227D8; Tue,  4 Sep 2018 17:22:49 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Applied "spi: spidev_test: Improve decoded text part of hex dump" to the spi tree
In-Reply-To:  <20180903173323.7436-1-geert+renesas@glider.be>
Message-Id: <20180904162249.7424B11227D8@debutante.sirena.org.uk>
Date:   Tue,  4 Sep 2018 17:22:49 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spidev_test: Improve decoded text part of hex dump

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 35386dfd13b746daf36a393bdf066dbe9b9b7aed Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 3 Sep 2018 19:33:23 +0200
Subject: [PATCH] spi: spidev_test: Improve decoded text part of hex dump

- Print spaces as spaces,
  - Do not print characters > 126, as they will be shown as garbage
    in the modern UTF-8 era,
  - Use a normal period instead of its hexadecimal ASCII value,
  - Delimit the text part with pipe symbols on both sides (was left side
    only), without any spaces, to make it clear where the decoded text
    starts and ends,
  - Drop a useless comment.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/spi/spidev_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 8c590cd1171a..4c12e6aea5d5 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -73,12 +73,12 @@ static void hex_dump(const void *src, size_t length, size_t line_size,
 				while (i++ % line_size)
 					printf("__ ");
 			}
-			printf(" | ");  /* right close */
+			printf(" |");
 			while (line < address) {
 				c = *line++;
-				printf("%c", (c < 33 || c == 255) ? 0x2E : c);
+				printf("%c", (c < 32 || c > 126) ? '.' : c);
 			}
-			printf("\n");
+			printf("|\n");
 			if (length > 0)
 				printf("%s | ", prefix);
 		}
-- 
2.19.0.rc1

