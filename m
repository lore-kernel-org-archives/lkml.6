Return-Path: <hernan@vanguardiasur.com.ar>
ARC-Seal: i=1; a=rsa-sha256; t=1523637511; cv=none;
        d=google.com; s=arc-20160816;
        b=c/mV/iN7zoXliL5oZNNw2K4ba3WlCC2Oj8eFcjcQZU+Jz36g1f/PCUrczPMhQ9OByP
         gv3DkouvrDWQpyNC2qmnZdd2VblJveIZvQUVoDhxbYfv95geDeV8P3SCYF0cOrJeLnY3
         ChBP2+BvbVVMpABqfLjXeVNSI2SQxttz1XcJ+aBnObBRzRDdKf3aBayMvmRYfhTxz5kg
         YFc3ox5NVoQ3q035nJmIye03CJuSvu+bL0+oBzFt6EfKJhcKWzDZMksYWV2ExXdypSOZ
         4GONVToH3y5IQkIxZu+xN9cmTAvNL/eektd1g7QbmfG9m/6YF+qU+9ZYTeUD7YINZt49
         2evw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=gCLllH3REqUzI1sPIV3bnZhs1KmvZS77Al6RA0oTClI=;
        b=tiURo32FbksRn0V1dgAZ5qjUnVnEjWkImZjknrmVR4SlLGZ4c0RANq7oCms9SdFkVu
         IwX+TUkmWyz2V3IYR6GDJ7mdu3ZtKGUBjlzF3tmluskjKSiM7TvCKEUKYQTyIMbZKk8C
         axq9Nrss4yS+sLRAtSYZ4IhYwPdVcGsPTTfTZdTTZa+NsBK4Y+AzDMluCL8fXk38PFvj
         Xdpp5FCc0X6mJUac0SJP+sFwiQNXcB5kUsli7q9nHwlkQtzFlmTWE+TonACnQpAFiaaw
         E3W6FXQ9OjBtHUjYNww4nU9WT2kS6NlpTJftUMtcmmJtkDMMDKS2eQv5eXV1nKetj2EN
         FrGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.s=20150623 header.b=ODyU1ZFq;
       spf=pass (google.com: domain of hernan@vanguardiasur.com.ar designates 209.85.220.65 as permitted sender) smtp.mailfrom=hernan@vanguardiasur.com.ar
Authentication-Results: mx.google.com;
       dkim=pass header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.s=20150623 header.b=ODyU1ZFq;
       spf=pass (google.com: domain of hernan@vanguardiasur.com.ar designates 209.85.220.65 as permitted sender) smtp.mailfrom=hernan@vanguardiasur.com.ar
X-Google-Smtp-Source: AIpwx49pen0DvftBlHHRwoOaMn8sdnK13EqI2fiSDgDiOq8Ma1wMsnOu7yzNNByKxFp7azHQmj03+w==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
Subject: [PATCH v2 08/14] staging: iio: ad7746: Add dt-bindings
Date: Fri, 13 Apr 2018 13:36:45 -0300
Message-Id: <1523637411-8531-9-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1523637411-8531-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597649726803282916?=
X-GMAIL-MSGID: =?utf-8?q?1597649726803282916?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch adds dt bindings by populating a pdata struct in order to
modify as little as possible the existing code. It supports both
platform_data and dt-bindings but uses only one depending on
CONFIG_OF's value.

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 drivers/staging/iio/cdc/ad7746.c | 54 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index d39ab34..c29a221 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -666,6 +666,43 @@ static const struct iio_info ad7746_info = {
 /*
  * device probe and remove
  */
+#ifdef CONFIG_OF
+static struct ad7746_platform_data *ad7746_parse_dt(struct device *dev)
+{
+	struct device_node *np = dev->of_node;
+	struct ad7746_platform_data *pdata;
+	unsigned int tmp;
+	int ret;
+
+	/* The default excitation outputs are not inverted, it should be stated
+	 * in the dt if needed.
+	 */
+
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return NULL;
+
+	ret = of_property_read_u32(np, "adi,exclvl", &tmp);
+	if (ret || tmp > 3) {
+		dev_warn(dev, "Wrong exclvl value, using default\n");
+		pdata->exclvl = 3; /* default value */
+	} else {
+		pdata->exclvl = tmp;
+	}
+
+	pdata->exca_en = true;
+	pdata->excb_en = true;
+	pdata->exca_inv_en = of_property_read_bool(np, "adi,nexca_en");
+	pdata->excb_inv_en = of_property_read_bool(np, "adi,nexcb_en");
+
+	return pdata;
+}
+#else
+static struct ad7746_platform_data *ad7746_parse_dt(struct device *dev)
+{
+	return NULL;
+}
+#endif
 
 static int ad7746_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
@@ -676,6 +713,11 @@ static int ad7746_probe(struct i2c_client *client,
 	unsigned char regval = 0;
 	int ret = 0;
 
+	if (client->dev.of_node)
+		pdata = ad7746_parse_dt(&client->dev);
+	else
+		pdata = client->dev.platform_data;
+
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -739,12 +781,22 @@ static const struct i2c_device_id ad7746_id[] = {
 	{ "ad7747", 7747 },
 	{}
 };
-
 MODULE_DEVICE_TABLE(i2c, ad7746_id);
 
+#ifdef CONFIG_OF
+static const struct of_device_id ad7746_of_match[] = {
+	{ .compatible = "adi,ad7745" },
+	{ .compatible = "adi,ad7746" },
+	{ .compatible = "adi,ad7747" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad7746_of_match);
+#endif
+
 static struct i2c_driver ad7746_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
+		.of_match_table = of_match_ptr(ad7746_of_match),
 	},
 	.probe = ad7746_probe,
 	.id_table = ad7746_id,
-- 
2.7.4
