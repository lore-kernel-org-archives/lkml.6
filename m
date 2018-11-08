Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095DEC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D0920844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wQ6QE70M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D0920844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbeKIHdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:33:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:49456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728951AbeKIHdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:33:38 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C31D220892;
        Thu,  8 Nov 2018 21:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714170;
        bh=YLmCx82ocb9RuUFgAsuHuhj8YE/KYq8DRgy4fJa4RQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wQ6QE70MomBCDQbB5DZUNxYz9eEkBc19K+Iuya6d3cLpjjB9mu0F1J2Id8LhUoI9E
         po4Sj7ElgCh2XNnUjKZ8yI2WEHy4c27A3Ti0HiNo1j3npx50CH9SXbsuxz6+kBeFHJ
         IP8RZBi2VImQV6Lk9v3ziUO2Ps8JcRMZceZWOp8U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 093/144] tty: serial: fsl_lpuart: fix clearing of receive flag
Date:   Thu,  8 Nov 2018 13:51:04 -0800
Message-Id: <20181108215103.075842925@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d68827c62a105eec547945daedf4d1d3e283717d ]

Commit 8e4934c6d6c6 ("tty: serial: fsl_lpuart: clear receive flag on FIFO
flush") implemented clearing of the receive flag by reading the status register
only. It turned out that even though we flush the FIFO afterwards, a explicit
read of the data register is still required.

This leads to a FIFO underrun. To avoid this, follow the advice in the overrun
"Operation section": Unconditionally clear RXUF after using RXFLUSH.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/fsl_lpuart.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index af3047d8322a..92b7a5bf7c4d 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -910,13 +910,16 @@ static void lpuart_setup_watermark(struct lpuart_port *sport)
 	writeb(val | UARTPFIFO_TXFE | UARTPFIFO_RXFE,
 			sport->port.membase + UARTPFIFO);
 
-	/* explicitly clear RDRF */
-	readb(sport->port.membase + UARTSR1);
-
 	/* flush Tx and Rx FIFO */
 	writeb(UARTCFIFO_TXFLUSH | UARTCFIFO_RXFLUSH,
 			sport->port.membase + UARTCFIFO);
 
+	/* explicitly clear RDRF */
+	if (readb(sport->port.membase + UARTSR1) & UARTSR1_RDRF) {
+		readb(sport->port.membase + UARTDR);
+		writeb(UARTSFIFO_RXUF, sport->port.membase + UARTSFIFO);
+	}
+
 	writeb(0, sport->port.membase + UARTTWFIFO);
 	writeb(1, sport->port.membase + UARTRWFIFO);
 
-- 
2.17.1



