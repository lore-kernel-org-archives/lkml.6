Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbeC2S7k (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 14:59:40 -0400
Received: from fallback7.mail.ru ([94.100.181.128]:50154 "EHLO
        fallback.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751096AbeC2S7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 14:59:38 -0400
From: Sergey Suloev <ssuloev@orpaltech.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sergey Suloev <ssuloev@orpaltech.com>
Subject: [PATCH 1/6] spi: core: handle timeout error from transfer_one()
Date: Thu, 29 Mar 2018 21:59:02 +0300
Message-Id: <20180329185907.27281-2-ssuloev@orpaltech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180329185907.27281-1-ssuloev@orpaltech.com>
References: <20180329185907.27281-1-ssuloev@orpaltech.com>
X-7FA49CB5: 0D63561A33F958A580B087001892C764A67B693F76D0AEE7805F6469B87D5BC0725E5C173C3A84C37C6C241D99759064AE0A0621C6B81FEB3946EFC6A664F553C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D84917DA9421E42869FF8C6A3CB6A274E9D547069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
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
