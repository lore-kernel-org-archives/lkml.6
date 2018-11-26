Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2956EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E515A2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 11:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwrZnFHQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E515A2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbeKZV4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:56:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:39902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729290AbeKZV4d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:56:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F190021104;
        Mon, 26 Nov 2018 11:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543230168;
        bh=EPAxqVIfuKBje7BY4dkySFcOZhqu2H8hK5EANgoRQF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PwrZnFHQvgBa8Io65CyM0EFji6MHbcyNO1bHjVTvPdNczK+/SkkAefhO/2Qj/H2V7
         Gk8vDMoJypQVfrMnvqeVb0NvZ6DTh9pZTq7oC4dQS/UvFSwrcRdxlYJNqvzQeQJhex
         f4uNEZeqvYKLrKh3S5GmPcv6Fl0kTtxJCbAojQyQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 032/118] serial: sh-sci: Fix receive on SCIFA/SCIFB variants with DMA
Date:   Mon, 26 Nov 2018 11:50:26 +0100
Message-Id: <20181126105101.174510502@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105059.832485122@linuxfoundation.org>
References: <20181126105059.832485122@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 3649b83ef863..effba6ce0caa 100644
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



