Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A71BFC5CFF0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6354320660
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 17:30:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6354320660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934202AbeFKRan (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 13:30:43 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:32410 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933066AbeFKRal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 13:30:41 -0400
Received: from localhost.localdomain ([77.136.205.128])
        by mwinf5d63 with ME
        id xVWe1x00D2mkQqM03VWen6; Mon, 11 Jun 2018 19:30:40 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 11 Jun 2018 19:30:40 +0200
X-ME-IP: 77.136.205.128
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] serial: pxa: Fix an error handling path in 'serial_pxa_probe()'
Date:   Mon, 11 Jun 2018 19:30:35 +0200
Message-Id: <20180611173035.26930-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.17.0
X-Antivirus: Avast (VPS 180611-4, 11/06/2018), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If port.line is out of range, we still need to release some resources, or
we will leak them.

Fixes: afc7851fab83 ("serial: pxa: Fix out-of-bounds access through serial port index")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/tty/serial/pxa.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index eda3c7710d6a..4932b674f7ef 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -887,7 +887,8 @@ static int serial_pxa_probe(struct platform_device *dev)
 		goto err_clk;
 	if (sport->port.line >= ARRAY_SIZE(serial_pxa_ports)) {
 		dev_err(&dev->dev, "serial%d out of range\n", sport->port.line);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_clk;
 	}
 	snprintf(sport->name, PXA_NAME_LEN - 1, "UART%d", sport->port.line + 1);
 
-- 
2.17.0

