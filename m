Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C347FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9193D21523
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 17:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9193D21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbeJKAd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:33:27 -0400
Received: from shell.v3.sk ([90.176.6.54]:54203 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbeJKAd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 20:33:26 -0400
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id AA289BCFAD;
        Wed, 10 Oct 2018 19:10:19 +0200 (CEST)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id U2d3LQLYW6nf; Wed, 10 Oct 2018 19:10:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 4F841BCF88;
        Wed, 10 Oct 2018 19:09:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xKwGi4kID01v; Wed, 10 Oct 2018 19:09:55 +0200 (CEST)
Received: from belphegor.lan (ip-89-102-31-34.net.upcbroadband.cz [89.102.31.34])
        by zimbra.v3.sk (Postfix) with ESMTPSA id E66EFBCF8E;
        Wed, 10 Oct 2018 19:09:53 +0200 (CEST)
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
Subject: [PATCH 07/11] spi: Deal with slaves that return from transfer_one() unfinished
Date:   Wed, 10 Oct 2018 19:09:32 +0200
Message-Id: <20181010170936.316862-8-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181010170936.316862-1-lkundrak@v3.sk>
References: <20181010170936.316862-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers, such as spi-pxa2xx return from the transfer_one callback
immediately, idicating that the transfer will be finished asynchronously.

Normally, spi_transfer_one_message() synchronously waits for the
transfer to finish with wait_for_completion_timeout(). For slaves, we
don't want the transaction to time out as it can complete in a long time
in future. Use wait_for_completion_interruptible() instead.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/spi/spi.c | 64 +++++++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 22 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9da0bc5a036c..079214a31d2c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -993,6 +993,44 @@ static int spi_map_msg(struct spi_controller *ctlr, =
struct spi_message *msg)
 	return __spi_map_msg(ctlr, msg);
 }
=20
+static int spi_transfer_wait(struct spi_controller *ctlr,
+			     struct spi_message *msg,
+			     struct spi_transfer *xfer)
+{
+	struct spi_statistics *statm =3D &ctlr->statistics;
+	struct spi_statistics *stats =3D &msg->spi->statistics;
+	unsigned long long ms =3D 1;
+
+	if (spi_controller_is_slave(ctlr)) {
+		if (wait_for_completion_interruptible(&ctlr->xfer_completion)) {
+			dev_dbg(&msg->spi->dev, "SPI transfer interrupted\n");
+			return -EINTR;
+		}
+	} else {
+		ms =3D 8LL * 1000LL * xfer->len;
+		do_div(ms, xfer->speed_hz);
+		ms +=3D ms + 200; /* some tolerance */
+
+		if (ms > UINT_MAX)
+			ms =3D UINT_MAX;
+
+		ms =3D wait_for_completion_timeout(&ctlr->xfer_completion,
+						 msecs_to_jiffies(ms));
+
+		if (ms =3D=3D 0) {
+			SPI_STATISTICS_INCREMENT_FIELD(statm,
+						       timedout);
+			SPI_STATISTICS_INCREMENT_FIELD(stats,
+						       timedout);
+			dev_err(&msg->spi->dev,
+				"SPI transfer timed out\n");
+			msg->status =3D -ETIMEDOUT;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * spi_transfer_one_message - Default implementation of transfer_one_mes=
sage()
  *
@@ -1006,7 +1044,6 @@ static int spi_transfer_one_message(struct spi_cont=
roller *ctlr,
 	struct spi_transfer *xfer;
 	bool keep_cs =3D false;
 	int ret =3D 0;
-	unsigned long long ms =3D 1;
 	struct spi_statistics *statm =3D &ctlr->statistics;
 	struct spi_statistics *stats =3D &msg->spi->statistics;
=20
@@ -1035,28 +1072,11 @@ static int spi_transfer_one_message(struct spi_co=
ntroller *ctlr,
 				goto out;
 			}
=20
-			if (ret > 0) {
-				ret =3D 0;
-				ms =3D 8LL * 1000LL * xfer->len;
-				do_div(ms, xfer->speed_hz);
-				ms +=3D ms + 200; /* some tolerance */
-
-				if (ms > UINT_MAX)
-					ms =3D UINT_MAX;
+			if (ret > 0)
+				ret =3D spi_transfer_wait(ctlr, msg, xfer);
=20
-				ms =3D wait_for_completion_timeout(&ctlr->xfer_completion,
-								 msecs_to_jiffies(ms));
-			}
-
-			if (ms =3D=3D 0) {
-				SPI_STATISTICS_INCREMENT_FIELD(statm,
-							       timedout);
-				SPI_STATISTICS_INCREMENT_FIELD(stats,
-							       timedout);
-				dev_err(&msg->spi->dev,
-					"SPI transfer timed out\n");
-				msg->status =3D -ETIMEDOUT;
-			}
+			if (ret < 0)
+				return ret;
 		} else {
 			if (xfer->len)
 				dev_err(&msg->spi->dev,
--=20
2.19.0

