Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2B0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5664F22513
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtVjBMr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5664F22513
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbeKOI1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:27:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:34364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbeKOI1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:11 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79FAC223DD;
        Wed, 14 Nov 2018 22:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234128;
        bh=C+47D2OYjB7bvRO7f0Ls6LQwIKUD0ykaGlTWN2a2jUI=;
        h=From:To:Cc:Subject:Date:From;
        b=LtVjBMr2oC+k7T6SvR9VRDvNFMwod7hBtCI/3zqjVxlHYe092hGfHmO/fkyATxDOP
         wnHrFJy3OUR7lFuzzq91rVtbXNXHwSvXQkRMSInBoGSOkuSv+NWx5bcvKY7Q7KHY+6
         M0U59pOuK8rqwdCABHRZskWR1/pWR23ujTqFTks4=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 01/73] serial: sh-sci: Fix receive on SCIFA/SCIFB variants with DMA
Date:   Wed, 14 Nov 2018 17:20:55 -0500
Message-Id: <20181114222207.98701-1-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 202dc3cc10b4d37e5251431acf8d5040a8876c7d ]

On SCIFA and SCIFB serial ports with DMA support (i.e. some ports on
R-Car Gen2 and RZ/G1 SoCs), receive DMA operations are submitted before
the DMA channel pointer is initialized.  Hence this fails, and the
driver tries to fall back to PIO.  However, at this early phase in the
initialization sequence, fallback to PIO does not work, leading to a
serial port that cannot receive any data.

Fix this by calling sci_submit_rx() after initialization of the DMA
channel pointer.

Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Fixes: 2c4ee23530ffc022 ("serial: sh-sci: Postpone DMA release when falling back to PIO")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sh-sci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index ab3f6e91853d..e19bfbba8a01 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1614,10 +1614,10 @@ static void sci_request_dma(struct uart_port *port)
 		hrtimer_init(&s->rx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 		s->rx_timer.function = rx_timer_fn;
 
+		s->chan_rx_saved = s->chan_rx = chan;
+
 		if (port->type == PORT_SCIFA || port->type == PORT_SCIFB)
 			sci_submit_rx(s);
-
-		s->chan_rx_saved = s->chan_rx = chan;
 	}
 }
 
-- 
2.17.1

