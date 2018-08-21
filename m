Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2F1C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7AD2151D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="lPWCW4yo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD7AD2151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbeHULoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 07:44:04 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:43589 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbeHULoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 07:44:04 -0400
Received: from pug.e01.socionext.com (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id w7L8NMfY009148;
        Tue, 21 Aug 2018 17:23:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com w7L8NMfY009148
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534839803;
        bh=cHlV1fzTPy2AxA0OS8cxvziMcEGIywYFVaQHfV5ATVQ=;
        h=From:To:Cc:Subject:Date:From;
        b=lPWCW4yoiI7ZOojB5oQd7HPFPlYg0W1pcYGa+NrXQ03MoNNXT6+HorumyrSQHHsca
         jGe01k4xzrcj8CiNv6obsSgSMvQDNHVJJW5mphvVoI3Tv1YK3FgGKtR7fFvgNSj6x7
         VVcm8YNSJWXISZqzXatoOa7evvWWGGl5g/+HCR96QwvKAT96YBzfEdhl6XFvkzH8GX
         TNjhhnLul9OzlQF6GLnXWdL+aHS3sVIOijW2kv6p6iiE/CVAoZXxdIGiJ0Hz02YRvZ
         FGzPzZI61PHC1avf3Np7dxGZfHkT58+U8FcjNMNIVU/tcAO2v174ctXZXQcGxpzKZN
         vDr2IxQnsNTjg==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH] mtd: rawnand: denali: do not pass zero maxchips to nand_scan()
Date:   Tue, 21 Aug 2018 17:23:19 +0900
Message-Id: <1534839799-14112-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 49aa76b16676 ("mtd: rawnand: do not execute nand_scan_ident()
if maxchips is zero") gave a new meaning for calling nand_scan_ident()
with maxchips=0.

It is a special usage for some drivers such as docg4, but in fact
the Denali driver may pass maxchips=0 to nand_scan() when the driver
is enabled but no NAND chip is found on the board for some reasons.

If nand_scan_with_ids() is called with maxchips=0, nand_scan_ident()
is skipped, i.e. nand_set_defaults() is skipped.  Therefore, the
driver must have set chip->controller beforehand.  Otherwise,
nand_attach() causes NULL pointer dereference.

In fact, the Denali controller knows the number of connected chips
before calling nand_scan_ident(); if DEVICE_RESET fails, there is no
chip in that chip select.  Then, denali_reset_banks() sets the maxchips
to the number of detected chips.  If no chip is found, it is zero.

The reason of this trick was, as commit f486287d2372 ("mtd: nand:
denali: fix bank reset function to detect the number of chips")
explained, nand_scan_ident() issued Set Features (0xEF) command
to all CS lines, some of which may not be connected with a chip.
Then, the driver would wait until R/B# response, which never happens.

This problem was solved by commit 107b7d6a7ad4 ("mtd: rawnand: avoid
setting again the timings to mode 0 after a reset").  In the current
code, nand_setup_data_interface() is called from nand_scan_tail(),
which is after the chip detection is done.

Remove the code that is causing NULL pointer dereference.  Now, the
maxchips passed to nand_scan() is the maximum number of chip selects
supported by the IP (typically 4 or 8).  Leave all the chip detection
process to nand_scan_ident().

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mtd/nand/raw/denali.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index ca18612..3e4b8e1 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -1086,7 +1086,6 @@ static void denali_reset_banks(struct denali_nand_info *denali)
 	}
 
 	dev_dbg(denali->dev, "%d chips connected\n", i);
-	denali->max_banks = i;
 }
 
 static void denali_hw_init(struct denali_nand_info *denali)
-- 
2.7.4

