Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536E3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D4422419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="am2cbIC/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D4422419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732527AbeKODx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 22:53:56 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:50442 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbeKODx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 22:53:56 -0500
Received: from trochilidae.toradex.int (unknown [46.140.72.82])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 79FF65C005C;
        Wed, 14 Nov 2018 18:49:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1542217785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=SwMlKre/tFmczZhs5V8n/suDDZFv4a74AdJARw1GjVo=;
        b=am2cbIC/r851Yc7o4wxqAzI3K6GLtV0mtd8N3aueVEh2qP+9OqqBrv6ZHZ7tGKrWthPomB
        viHkP4qZfgnRteqMOaYHklnqGJ3lESMkbKM3N5ROAxbARkbrFww7YIZziBa/b9yxCBqxe1
        Kz7CjwWg2WIVgRYnk1fKFBXGJ5vfVA0=
From:   Stefan Agner <stefan@agner.ch>
To:     gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     fabio.estevam@nxp.com, u.kleine-koenig@pengutronix.de,
        s.hauer@pengutronix.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>
Subject: [PATCH 1/3] serial: imx: fix error handling in console_setup
Date:   Wed, 14 Nov 2018 18:49:38 +0100
Message-Id: <20181114174940.7865-1-stefan@agner.ch>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ipg clock only needs to be unprepared in case preparing
per clock fails. The ipg clock has already disabled at the point.

Fixes: 1cf93e0d5488 ("serial: imx: remove the uart_console() check")
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 drivers/tty/serial/imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 0f67197a3783..313c3b1900a8 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2068,7 +2068,7 @@ imx_uart_console_setup(struct console *co, char *options)
 
 	retval = clk_prepare(sport->clk_per);
 	if (retval)
-		clk_disable_unprepare(sport->clk_ipg);
+		clk_unprepare(sport->clk_ipg);
 
 error_console:
 	return retval;
-- 
2.19.1

