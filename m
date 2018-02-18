Return-Path: <paweldembicki@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518974394; cv=none;
        d=google.com; s=arc-20160816;
        b=s1K3QaTFMMzOjUmcPP8VVZI2+jlT1noApSwLzX23aTVUmH/LZ8ShnmI53NCOCxGff/
         zp7dOzrnvm35ey95Yz1I5vBS/xFb5V1G2cWkPApQX8iHWpJ4QbQahTei8jzqi47E4hSe
         qBcZnnwnXFuI986VKa0b3QrjM+5fuQZhuTy8M72IQCJw7RRhHSh1SzzDz1+ljred0zB2
         RzvSJaEXSyZF+ou9m9qrR9ysX48w5L9apKlN2e/CxP7NvHcVii3e1f+oA/ovkCJqqoZX
         JoyX0rzMSxNQcF+lzBJML9blVKV2EbnLRgI5iAHD/tFvtNVUgepc+7ibujjjYSFScNIS
         rV6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Z+B63DvkiYvWvlZ1hMt5E72mHR3hPrkiziJpYiDk8tU=;
        b=UY/Le0VN2jCIscGHMnkjPD5S0b2Vphm3ZrTihI8SCB/VjzSZihzX6oQE6CdL3kViqo
         mY8Tu2O/18iWptTY2qOY0j1k+PJcaJkE2ZczNA8VxeVGjXyLHM+mVhjRwgT79hJcWd6F
         MdP+CAp55ifjPSDpJ8vSPMhK9cbeZq5UCDDQuoYDu4FqwOU7waDparYUtl4Mv+qnCHj5
         7Fh6SkUAzA5rI8kLAUj6SQl2CtjCvQ0gs9n1P82n2fc+81CUdDJ0jnj9gaq+525vw0bf
         Cx4WOok+hVCuWDW7Gs6Plg2hvVY9YAU3GNT7xMViERCluuQ2cH7Fa+f+dm+i171GS1Yy
         sK/w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Qv8fXBM+;
       spf=pass (google.com: domain of paweldembicki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=paweldembicki@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Qv8fXBM+;
       spf=pass (google.com: domain of paweldembicki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=paweldembicki@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227ib//t8ul794PQevZeTqX5B/KQL83WFo7EtVjRW2o7qHtzkrKN3NSoypDYiQkfKC+cBgCbVA==
From: Pawel Dembicki <paweldembicki@gmail.com>
To: 
Cc: stable@vger.kernel.org,
	Pawel Dembicki <paweldembicki@gmail.com>,
	Evgeniy Polyakov <zbr@ioremap.net>,
	"Andrew F. Davis" <afd@ti.com>,
	Sebastian Reichel <sre@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] w1: gpio: fix problem with platfom data in w1-gpio
Date: Sun, 18 Feb 2018 18:19:26 +0100
Message-Id: <20180218171927.6414-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180218170629.6045-1-paweldembicki@gmail.com>
References: <20180218170629.6045-1-paweldembicki@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592760094452875892?=
X-GMAIL-MSGID: =?utf-8?q?1592760094452875892?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In devices, where fdt is used, is impossible to apply platform data
without proper fdt node.

This patch allow to use platform data in devices with fdt.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
Acked-by: Andrew F. Davis <afd@ti.com>
---
 drivers/w1/masters/w1-gpio.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/w1/masters/w1-gpio.c b/drivers/w1/masters/w1-gpio.c
index a90728ceec5a..7b80762941af 100644
--- a/drivers/w1/masters/w1-gpio.c
+++ b/drivers/w1/masters/w1-gpio.c
@@ -112,17 +112,16 @@ static int w1_gpio_probe_dt(struct platform_device *pdev)
 static int w1_gpio_probe(struct platform_device *pdev)
 {
 	struct w1_bus_master *master;
-	struct w1_gpio_platform_data *pdata;
+	struct w1_gpio_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	int err;
 
-	if (of_have_populated_dt()) {
+	if (of_have_populated_dt() && !pdata) {
 		err = w1_gpio_probe_dt(pdev);
 		if (err < 0)
 			return err;
+		pdata = dev_get_platdata(&pdev->dev);
 	}
 
-	pdata = dev_get_platdata(&pdev->dev);
-
 	if (!pdata) {
 		dev_err(&pdev->dev, "No configuration data\n");
 		return -ENXIO;
-- 
2.14.1
