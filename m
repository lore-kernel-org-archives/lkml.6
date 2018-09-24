Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB86ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D8221486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:25:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D8221486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732960AbeIXS1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:27:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56970 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730683AbeIXS1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:27:23 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 89A871094;
        Mon, 24 Sep 2018 12:25:29 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 4.14 162/173] earlycon: Remove hardcoded port->uartclk initialization in of_setup_earlycon
Date:   Mon, 24 Sep 2018 13:53:16 +0200
Message-Id: <20180924113127.029126750@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michal Simek <michal.simek@xilinx.com>

commit 182ead3e418a20328b73152b8e81fc8b4cac3b0b upstream.

There is no reason to initialize uartclk to BASE_BAUD * 16 for DT based
systems.

[-stable comment: commit 31cb9a8575ca ("earlycon: initialise baud field
 of earlycon device structure") has changed 8250_early.c behavior which
 now tries to setup UART speed.
 Already-backported upstream commit 0ff3ab701963 ("serial:  8250_early:
 Only set divisor if valid clk & baud") handles properly uartclk not
 being set but it still requires backporting fix for wrong uartclk val.
 This fixes malformed early console output on arch-es with BASE_BAUD.]

Fixes: 31cb9a8575ca ("earlycon: initialise baud field of earlycon device structure")
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Tested-by: Matt Redfearn <matt.redfearn@mips.com>
[rmilecki: add -stable comment and Fixes tag]
Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/earlycon.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -254,7 +254,6 @@ int __init of_setup_earlycon(const struc
 		return -ENXIO;
 	}
 	port->mapbase = addr;
-	port->uartclk = BASE_BAUD * 16;
 
 	val = of_get_flat_dt_prop(node, "reg-offset", NULL);
 	if (val)


