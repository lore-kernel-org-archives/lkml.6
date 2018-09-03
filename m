Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A2CDC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3340020658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3340020658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbeICWFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:05:10 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:33574 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729773AbeICVye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:54:34 -0400
Received: from ramsan.of.borg ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id X5ZQ1y00D3XaVaC015ZQqT; Mon, 03 Sep 2018 19:33:24 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fwsj6-0001Al-7M; Mon, 03 Sep 2018 19:33:24 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fwsj6-0001wh-5Z; Mon, 03 Sep 2018 19:33:24 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: spidev_test: Improve decoded text part of hex dump
Date:   Mon,  3 Sep 2018 19:33:23 +0200
Message-Id: <20180903173323.7436-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Print spaces as spaces,
  - Do not print characters > 126, as they will be shown as garbage
    in the modern UTF-8 era,
  - Use a normal period instead of its hexadecimal ASCII value,
  - Delimit the text part with pipe symbols on both sides (was left side
    only), without any spaces, to make it clear where the decoded text
    starts and ends,
  - Drop a useless comment.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 tools/spi/spidev_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 8c590cd1171a99c2..4c12e6aea5d5d0d1 100644
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
2.17.1

