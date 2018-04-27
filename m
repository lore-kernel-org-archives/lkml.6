Return-Path: <arvind.yadav.cs@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524826391; cv=none;
        d=google.com; s=arc-20160816;
        b=F4EhskYqitM12DqSaCeX4WCS12WnV06OKBxaPPkn7Ov8XYf4CuS2jsgyr6VPHl3vjz
         Qy/7gjWjDyoJq4SrPRcass8mdWFfo6gQsLG4pBFu4hsMwqWXCFEc/wcAUu0o/o7TDY5H
         GnF8YYIA2QEDjy+pEoWAA5WB3x0PY6KYJ8Jd+Dw1UIClm9iOYsNLPQEQSwCCWKJ5ZP7u
         G9P/G89zvRli6RC72gRkmsbqOMam0UVUK46Zsn+YDDS31dxCK7naBNQBfz9MEtmBgeQO
         TPZhw0ogiFuO74jywKv4OMcE17Tj5dla7O+A1WY+ZsLI2iGVuOCK59hSzBvhD3J6fuTO
         7AYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=m8kMNTWazIgFpYyTtxU8bSGOCA7o9Az1vVcs81uWcRc=;
        b=mMlsabQ+6JXzo44U8sYFEmr7jwSi67yiKvUW//HWoYnTMWzC7q6U/0b6gfxkMNiajE
         sjwQf0Ny/X5tvtlDGUO0Bm5zsCuEXZPKIw9e/6md5KYlaHJR0ZzfmLGKCFCbIwwTuznw
         cCNUtBoLzeNlkE2iTISXrJqorO4Jkk6kpRJGhdBoxxlrLaE/bI9uRBNyu+zapdXY3Vfq
         kmfyqmi3DKis+/uEa2MINvjjnu3Ht30MIqQSlgz57ZrFdnYZCrCIgbBIlSJDZcoxLyq9
         NeB4/M11T4ftbM/r3waxBu3Oo/h5vqHnt4VZn80Hz26dmy0PYHcR+kNc9CyF7SxjrLa5
         QDNg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jy1Sb5Vz;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=jy1Sb5Vz;
       spf=pass (google.com: domain of arvind.yadav.cs@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arvind.yadav.cs@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZq3UyLTrS5Ls5oeKBt+brE1Y08JLpbrlVkJHebkeKMWvQ96Z043fy6mk5XPC2JMtpmsx5j2tg==
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: hvaibhav.linux@gmail.com,
	johan@kernel.org,
	elder@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	greybus-dev@lists.linaro.org,
	devel@driverdev.osuosl.org
Subject: [PATCH] staging: greybus: Use gpio_is_valid()
Date: Fri, 27 Apr 2018 16:22:56 +0530
Message-Id: <785eda4d65f396b353393e9538eba21095ce876e.1524825902.git.arvind.yadav.cs@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598896358310387815?=
X-GMAIL-MSGID: =?utf-8?q?1598896358310387815?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Replace the manual validity checks for the GPIO with the
gpio_is_valid().

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/staging/greybus/arche-platform.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
index 83254a7..fc6bf60 100644
--- a/drivers/staging/greybus/arche-platform.c
+++ b/drivers/staging/greybus/arche-platform.c
@@ -448,9 +448,9 @@ static int arche_platform_probe(struct platform_device *pdev)
 	arche_pdata->svc_reset_gpio = of_get_named_gpio(np,
 							"svc,reset-gpio",
 							0);
-	if (arche_pdata->svc_reset_gpio < 0) {
+	if (!gpio_is_valid(arche_pdata->svc_reset_gpio)) {
 		dev_err(dev, "failed to get reset-gpio\n");
-		return arche_pdata->svc_reset_gpio;
+		return -ENODEV;
 	}
 	ret = devm_gpio_request(dev, arche_pdata->svc_reset_gpio, "svc-reset");
 	if (ret) {
@@ -468,9 +468,9 @@ static int arche_platform_probe(struct platform_device *pdev)
 	arche_pdata->svc_sysboot_gpio = of_get_named_gpio(np,
 							  "svc,sysboot-gpio",
 							  0);
-	if (arche_pdata->svc_sysboot_gpio < 0) {
+	if (!gpio_is_valid(arche_pdata->svc_sysboot_gpio)) {
 		dev_err(dev, "failed to get sysboot gpio\n");
-		return arche_pdata->svc_sysboot_gpio;
+		return -ENODEV;
 	}
 	ret = devm_gpio_request(dev, arche_pdata->svc_sysboot_gpio, "sysboot0");
 	if (ret) {
@@ -487,9 +487,9 @@ static int arche_platform_probe(struct platform_device *pdev)
 	arche_pdata->svc_refclk_req = of_get_named_gpio(np,
 							"svc,refclk-req-gpio",
 							0);
-	if (arche_pdata->svc_refclk_req < 0) {
+	if (!gpio_is_valid(arche_pdata->svc_refclk_req)) {
 		dev_err(dev, "failed to get svc clock-req gpio\n");
-		return arche_pdata->svc_refclk_req;
+		return -ENODEV;
 	}
 	ret = devm_gpio_request(dev, arche_pdata->svc_refclk_req,
 				"svc-clk-req");
-- 
1.9.1
