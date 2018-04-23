Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932607AbeDWVlF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 17:41:05 -0400
Received: from bert.emutex.com ([91.103.1.109]:54295 "EHLO bert.emutex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932461AbeDWVie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 17:38:34 -0400
From: Javier Arteaga <javier@emutex.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Javier Arteaga <javier@emutex.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Dan O'Donovan" <dan@emutex.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicola Lunghi <nicola.lunghi@emutex.com>
Subject: [PATCH v2 2/3] iio: adc128s052: add ACPI _HID AANT1280
Date: Mon, 23 Apr 2018 22:38:04 +0100
Message-Id: <20180423213805.12591-3-javier@emutex.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180423213805.12591-1-javier@emutex.com>
References: <20180423213805.12591-1-javier@emutex.com>
X-Spam-Score: -1.0 (-)
X-Spam-Report: Spam detection software, running on the system "statler.emutex.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  From: Nicola Lunghi <nicola.lunghi@emutex.com> ACPI _HID AANT1280
    matches an ADC124S101 present on E3940 SKUs of the UP Squared board. Add
   it to the driver. [...]
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicola Lunghi <nicola.lunghi@emutex.com>

ACPI _HID AANT1280 matches an ADC124S101 present on E3940 SKUs of the UP
Squared board.

Add it to the driver.

Signed-off-by: Nicola Lunghi <nicola.lunghi@emutex.com>
[javier@emutex.com: fix up commit message and one checkpatch warning]
Signed-off-by: Javier Arteaga <javier@emutex.com>
---
 drivers/iio/adc/ti-adc128s052.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index e6716c326c5e..bc5096e98900 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -12,6 +12,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/acpi.h>
 #include <linux/err.h>
 #include <linux/spi/spi.h>
 #include <linux/module.h>
@@ -136,9 +137,22 @@ static int adc128_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
 	struct adc128 *adc;
-	int config = spi_get_device_id(spi)->driver_data;
+	int config;
 	int ret;
 
+	if (ACPI_COMPANION(&spi->dev)) {
+		const struct acpi_device_id *ad_id;
+
+		ad_id = acpi_match_device(spi->dev.driver->acpi_match_table,
+					  &spi->dev);
+		if (!ad_id)
+			return -ENODEV;
+
+		config = ad_id->driver_data;
+	} else {
+		config = spi_get_device_id(spi)->driver_data;
+	}
+
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -207,10 +221,19 @@ static const struct spi_device_id adc128_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, adc128_id);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id adc128_acpi_match[] = {
+	{ "AANT1280", 2 }, /* ADC124S021 compatible ACPI ID */
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, adc128_acpi_match);
+#endif
+
 static struct spi_driver adc128_driver = {
 	.driver = {
 		.name = "adc128s052",
 		.of_match_table = of_match_ptr(adc128_of_match),
+		.acpi_match_table = ACPI_PTR(adc128_acpi_match),
 	},
 	.probe = adc128_probe,
 	.remove = adc128_remove,
-- 
2.17.0
