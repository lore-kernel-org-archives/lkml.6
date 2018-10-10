Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC6EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78681214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78681214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeJKAdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:33:37 -0400
Received: from shell.v3.sk ([90.176.6.54]:54280 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbeJKAdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:33:37 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 59D09BCFB4;
        Wed, 10 Oct 2018 19:10:31 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Ru0PvWjLugRn; Wed, 10 Oct 2018 19:10:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 5E881B8064;
        Wed, 10 Oct 2018 19:09:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FmnBgW3ay-B2; Wed, 10 Oct 2018 19:09:57 +0200 (CEST)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id A0214BCF91;
        Wed, 10 Oct 2018 19:09:55 +0200 (CEST)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     James Cameron <quozl@laptop.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 11/11] spi: pxa2xx: Deal with the leftover garbage in TXFIFO
Date:   Wed, 10 Oct 2018 19:09:36 +0200
Message-Id: <20181010170936.316862-12-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181010170936.316862-1-lkundrak@v3.sk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There doesn't seem to be a way to empty TXFIFO on MMP2. The datasheet is
super-secret and the method described in Armada 16x manual won't work:

  "The TXFIFO and RXFIFO are cleared to 0b0 when the SSPx port is reset o=
r
  disabled (by writing a 0b0 to the <Synchronous Serial Port Enable> fiel=
d
  in the SSP Control Register 0)."

  # devmem 0xd4037008           # read SSSR
  0x0000F204
  # devmem 0xd4037000 32 0x80   # SSE off in SSCR0
  # devmem 0xd4037000 32 0x87   # SSE on
  # devmem 0xd4037008
  0x0000F204
         ^ TXFIFO level is still 2. Sigh.

The OLPC 1.75 boot firmware leaves two bytes in the TXFIFO. Those are
basically throwaway bytes used in response to the messages from the EC.
The OLPC kernel copes with this by power-cycling the hardware. Perhaps
the firmware should do this instead.

Other than that, there's not much we can do other than complain loudly
until the garbage gets drained and discard the actual data... For the
OLPC EC this will work just fine and pushing more data to TXFIFO would
break further transactions.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/spi/spi-pxa2xx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index a3b4b12c1077..2662b99d4439 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1076,6 +1076,20 @@ static int pxa2xx_spi_transfer_one(struct spi_cont=
roller *master,
 			pxa2xx_spi_write(drv_data, SSTO, chip->timeout);
 	}
=20
+	if (drv_data->ssp_type =3D=3D MMP2_SSP) {
+		u8 tx_level =3D (pxa2xx_spi_read(drv_data, SSSR)
+					& SSSR_TFL_MASK) >> 8;
+
+		if (tx_level) {
+			/* On MMP2, flipping SSE doesn't to empty TXFIFO. */
+			dev_warn(&spi->dev, "%d bytes of garbage in TXFIFO!\n",
+								tx_level);
+			if (tx_level > transfer->len)
+				tx_level =3D transfer->len;
+			drv_data->tx +=3D tx_level;
+		}
+	}
+
 	if (spi_controller_is_slave(master)) {
 		while (drv_data->write(drv_data))
 			;
--=20
2.19.0

