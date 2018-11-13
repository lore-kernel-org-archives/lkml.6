Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B3AC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51BBA2245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51BBA2245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=v3.sk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732337AbeKMUUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:20:32 -0500
Received: from shell.v3.sk ([90.176.6.54]:38278 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732030AbeKMUUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:20:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id D0BB9C6B30;
        Tue, 13 Nov 2018 11:23:01 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id H8x7nBaP2HEV; Tue, 13 Nov 2018 11:22:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 159DFC677C;
        Tue, 13 Nov 2018 11:22:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id V23aKxyqXD7u; Tue, 13 Nov 2018 11:22:41 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 28E5BC6B1F;
        Tue, 13 Nov 2018 11:22:41 +0100 (CET)
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
Subject: [PATCH v3 2/6] spi: Deal with slaves that return from transfer_one() unfinished
Date:   Tue, 13 Nov 2018 11:22:24 +0100
Message-Id: <20181113102228.820214-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113102228.820214-1-lkundrak@v3.sk>
References: <20181113102228.820214-1-lkundrak@v3.sk>
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
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changed since v2:
- Corrected the spi_transfer_wait() return value handling to avoid early
  bail out without the necessary cleanup (thanks Geert Uytterhoeven)

 drivers/spi/spi.c | 62 +++++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 6ca59406b0b7..498d3b9bf3ae 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1037,6 +1037,42 @@ static int spi_map_msg(struct spi_controller *ctlr=
, struct spi_message *msg)
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
+			SPI_STATISTICS_INCREMENT_FIELD(statm, timedout);
+			SPI_STATISTICS_INCREMENT_FIELD(stats, timedout);
+			dev_err(&msg->spi->dev,
+				"SPI transfer timed out\n");
+			return -ETIMEDOUT;
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
@@ -1050,7 +1086,6 @@ static int spi_transfer_one_message(struct spi_cont=
roller *ctlr,
 	struct spi_transfer *xfer;
 	bool keep_cs =3D false;
 	int ret =3D 0;
-	unsigned long long ms =3D 1;
 	struct spi_statistics *statm =3D &ctlr->statistics;
 	struct spi_statistics *stats =3D &msg->spi->statistics;
=20
@@ -1079,28 +1114,9 @@ static int spi_transfer_one_message(struct spi_con=
troller *ctlr,
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
-
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
+			ret =3D spi_transfer_wait(ctlr, msg, xfer);
+			if (ret < 0)
+				msg->status =3D ret;
 		} else {
 			if (xfer->len)
 				dev_err(&msg->spi->dev,
--=20
2.19.1

