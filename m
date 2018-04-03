Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752641AbeDCPad (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 11:30:33 -0400
Received: from smtp54.i.mail.ru ([217.69.128.34]:56006 "EHLO smtp54.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751436AbeDCP3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 11:29:12 -0400
From: Sergey Suloev <ssuloev@orpaltech.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sergey Suloev <ssuloev@orpaltech.com>
Subject: [PATCH v2 1/6] spi: core: handle timeout error from transfer_one()
Date: Tue,  3 Apr 2018 18:29:00 +0300
Message-Id: <20180403152905.1524-2-ssuloev@orpaltech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180403152905.1524-1-ssuloev@orpaltech.com>
References: <20180403152905.1524-1-ssuloev@orpaltech.com>
Authentication-Results: smtp54.i.mail.ru; auth=pass smtp.auth=ssuloev@orpaltech.com smtp.mailfrom=ssuloev@orpaltech.com
X-7FA49CB5: 0D63561A33F958A59F78EFC36D0BDFDAFD153644D6503B5891E74D64282E1D84725E5C173C3A84C3A1C30C8AFC676C8BE6E9CFB9FB6231F8B25CBF701D1BE873C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D8491757F44F8B6190076D6C29EAC4837C1FD6069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As long as sun4i/sun6i SPI drivers have overriden the default
"wait for completion" procedure then we need to properly
handle -ETIMEDOUT error from transfer_one().

Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>
---
 drivers/spi/spi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b33a727..2dcd4f6 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1028,7 +1028,7 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 			reinit_completion(&ctlr->xfer_completion);
 
 			ret = ctlr->transfer_one(ctlr, msg->spi, xfer);
-			if (ret < 0) {
+			if (ret < 0 && ret != -ETIMEDOUT) {
 				SPI_STATISTICS_INCREMENT_FIELD(statm,
 							       errors);
 				SPI_STATISTICS_INCREMENT_FIELD(stats,
@@ -1051,7 +1051,7 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 								 msecs_to_jiffies(ms));
 			}
 
-			if (ms == 0) {
+			if (ms == 0 || ret == -ETIMEDOUT) {
 				SPI_STATISTICS_INCREMENT_FIELD(statm,
 							       timedout);
 				SPI_STATISTICS_INCREMENT_FIELD(stats,
@@ -1059,6 +1059,7 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 				dev_err(&msg->spi->dev,
 					"SPI transfer timed out\n");
 				msg->status = -ETIMEDOUT;
+				ret = 0;
 			}
 		} else {
 			if (xfer->len)
-- 
2.16.2
