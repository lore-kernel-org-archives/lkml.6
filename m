Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27BBECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E42208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m62KAKL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61E42208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbeJYWxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:53:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731064AbeJYWx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:53:29 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 787232146E;
        Thu, 25 Oct 2018 14:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477231;
        bh=KM1UJBXYeA0QVo4eoGyHMkI5gUhlNOVS3DwVonlzS6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m62KAKL9vNhhELw8CEWiE7zsR9GgCdmSZ9DvtNiEjGAvIQFftAPngT60ye1adpt9B
         wHDCMtYmu5rbNC1uLUxpIwjroehmkG59Rx6IfoVIbHEtFqtK6hsAuoclA6oJHC/faT
         BsUeW6I1on2M0ruc6a4uJAMoR+Hgmy+Ds+1BRdgE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stefan Agner <stefan@agner.ch>,
        Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 64/98] tty: serial: fsl_lpuart: fix clearing of receive flag
Date:   Thu, 25 Oct 2018 10:18:19 -0400
Message-Id: <20181025141853.214051-64-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Agner <stefan@agner.ch>

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

