Return-Path: <joel.stan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518419356; cv=none;
        d=google.com; s=arc-20160816;
        b=Cirr6M67kbJF9QRlmrGFtseVTzxnokCEH5NvQsRnd/XXEQCukgxdvcQNminHFPrnDD
         F02s52sRcWqE5otltspUdlIzCmKjrPl101G2y90Rpb5SzS0oMh/PoAqGJhe0uxtG8H0Q
         0/x6ah1PopvFzKsv67P7XX+dfDzV4Xw4Y+ixqVKOiX4b/H/NAk3c6uDRm4T27tZqCN2m
         8CqeD4BByUv1craxEOf0IE1ecYSnbODA86t5u1xV8P92dgusDy/nH9xtyXnB85mPX4RE
         hD7LpW4tA+Bp8pa+VATPXbeQGrvppgaE3J5AAPdI/Tn/+TOUO8OgKNMZhMxxQ2Gebjvg
         xu3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:sender
         :dkim-signature:arc-authentication-results;
        bh=NwL7A4hTUadKcUHHkqCgS88GiYok4oil6lnWHhgTt2o=;
        b=ey8CK5ze90RHNNaSfGTg3JZY9VAI4o5ZH1JW6Y+Q07rpHLnCmsOfQ4+6XwwZUj0uYY
         ikz65+WdAK4uSopn5SJO2mThCXGVgoscWbx9yBMI3TTLLMAvdoNTzJ/H4hwO5IoZJQEQ
         S3/c398/9nKp6nVuX6JsQR3AUhQkQtFIbD1b8QGnLb671qfFOs4GlUsV9xZ9StMuswS9
         PM8KVzI9iFF3D5u9QG8WwtJKyyisgNvPWG7PaQVTGPhxYsncIj9qKnHgfc3CkKx+xl3+
         qeP1hvK1PFzVEUi18IX/c9cDyxs7hC71kCqdL6+P6aHjjhYaIxYYnJ3fdehLIre333p0
         IGyg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RzFA6AUh;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RzFA6AUh;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
X-Google-Smtp-Source: AH8x225ox2rDdEn3vqyBUirsPHv0UZAntu/ba8jiSH2OxUXnLjv/7aa6es9wf8bqguDQrTs1fD0ijQ==
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: Lee Jones <lee.jones@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Jeffery <andrew@aj.id.au>,
	Cyril Bur <cyrilbur@gmail.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Lei YU <mine260309@gmail.com>
Subject: [PATCH 2/3] misc: aspeed-lpc: Request and enable LPC clock
Date: Mon, 12 Feb 2018 17:38:46 +1030
Message-Id: <20180212070847.32387-3-joel@jms.id.au>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180212070847.32387-1-joel@jms.id.au>
References: <20180212070847.32387-1-joel@jms.id.au>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592178094702498887?=
X-GMAIL-MSGID: =?utf-8?q?1592178094702498887?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The LPC device needs to ensure it's clock is enabled before it can do
anything.

In the past the clock was enabled and left running by u-boot, however
Linux now has an upstream clock driver that disables unused clocks.

Tested-by: Lei YU <mine260309@gmail.com>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/misc/aspeed-lpc-ctrl.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/aspeed-lpc-ctrl.c b/drivers/misc/aspeed-lpc-ctrl.c
index b5439643f54b..1827b7aa6674 100644
--- a/drivers/misc/aspeed-lpc-ctrl.c
+++ b/drivers/misc/aspeed-lpc-ctrl.c
@@ -7,6 +7,7 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#include <linux/clk.h>
 #include <linux/mfd/syscon.h>
 #include <linux/miscdevice.h>
 #include <linux/mm.h>
@@ -26,6 +27,7 @@
 struct aspeed_lpc_ctrl {
 	struct miscdevice	miscdev;
 	struct regmap		*regmap;
+	struct clk		*clk;
 	phys_addr_t		mem_base;
 	resource_size_t		mem_size;
 	u32		pnor_size;
@@ -221,16 +223,33 @@ static int aspeed_lpc_ctrl_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	lpc_ctrl->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(lpc_ctrl->clk)) {
+		dev_err(dev, "couldn't get clock\n");
+		return PTR_ERR(lpc_ctrl->clk);
+	}
+	rc = clk_prepare_enable(lpc_ctrl->clk);
+	if (rc) {
+		dev_err(dev, "couldn't enable clock\n");
+		return rc;
+	}
+
 	lpc_ctrl->miscdev.minor = MISC_DYNAMIC_MINOR;
 	lpc_ctrl->miscdev.name = DEVICE_NAME;
 	lpc_ctrl->miscdev.fops = &aspeed_lpc_ctrl_fops;
 	lpc_ctrl->miscdev.parent = dev;
 	rc = misc_register(&lpc_ctrl->miscdev);
-	if (rc)
+	if (rc) {
 		dev_err(dev, "Unable to register device\n");
-	else
-		dev_info(dev, "Loaded at %pr\n", &resm);
+		goto err;
+	}
+
+	dev_info(dev, "Loaded at %pr\n", &resm);
+
+	return 0;
 
+err:
+	clk_disable_unprepare(lpc_ctrl->clk);
 	return rc;
 }
 
@@ -239,6 +258,7 @@ static int aspeed_lpc_ctrl_remove(struct platform_device *pdev)
 	struct aspeed_lpc_ctrl *lpc_ctrl = dev_get_drvdata(&pdev->dev);
 
 	misc_deregister(&lpc_ctrl->miscdev);
+	clk_disable_unprepare(lpc_ctrl->clk);
 
 	return 0;
 }
-- 
2.15.1
