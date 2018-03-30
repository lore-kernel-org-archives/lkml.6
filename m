Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752254AbeC3MvE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 08:51:04 -0400
Received: from smtp58.i.mail.ru ([217.69.128.38]:36982 "EHLO smtp58.i.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751384AbeC3Mu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 08:50:58 -0400
From: Sergey Suloev <ssuloev@orpaltech.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sergey Suloev <ssuloev@orpaltech.com>
Subject: [PATCH v2 2/6] spi: sun6i: handle chip select polarity flag
Date: Fri, 30 Mar 2018 15:50:43 +0300
Message-Id: <20180330125047.13936-3-ssuloev@orpaltech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180330125047.13936-1-ssuloev@orpaltech.com>
References: <20180330125047.13936-1-ssuloev@orpaltech.com>
Authentication-Results: smtp58.i.mail.ru; auth=pass smtp.auth=ssuloev@orpaltech.com smtp.mailfrom=ssuloev@orpaltech.com
X-7FA49CB5: 0D63561A33F958A5FA02BF12BAC891C926FD46E76099F7CD5705F49E3A860CED725E5C173C3A84C30584FF81F342DA0743748A6DB685256DBAAD9279A72BC9ABC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F5D41B9178041F3E72623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-Mailru-Sender: C5364AD02485212F3ACDC11E67D8491781A4B80ABAA47B337E57963255478D82069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The chip select polarity flag is declared as supported
but is not handled in the code.

Signed-off-by: Sergey Suloev <ssuloev@orpaltech.com>

---
 drivers/spi/spi-sun6i.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index 88ad45e..78acc1f 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -193,6 +193,12 @@ static void sun6i_spi_set_cs(struct spi_device *spi, bool enable)
 	else
 		reg &= ~SUN6I_TFR_CTL_CS_LEVEL;
 
+	/* Handle chip select "reverse" polarity */
+	if (spi->mode & SPI_CS_HIGH)
+		reg &= ~SUN6I_TFR_CTL_SPOL;
+	else
+		reg |= SUN6I_TFR_CTL_SPOL;
+
 	/* We want to control the chip select manually */
 	reg |= SUN6I_TFR_CTL_CS_MANUAL;
 
-- 
2.16.2
