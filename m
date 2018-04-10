Return-Path: <baijiaju1990@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523350744; cv=none;
        d=google.com; s=arc-20160816;
        b=QctYRFo7xnoI+CoE2uq8jtlD0l7nU62QW8ejdrgtrJGSLFg3v2+Hq91ogNOAmssnpI
         tkRgYGRE/YW9CD57CtE7WaWDpCpMf7zm8KfaJm4rUIsMj3v5ulpezAIdhl3hVkVXi1Tr
         O8fzw+xwsUh1M8xKyzjCU1Hg4q9suEKLYYNnEMcNbU27/rbuRQ3YpEg6uAMpU2r9+KNG
         65BEsrDrkfXuTERrM/5tW8L8wDYkCelUx9fvfFfoGv0u89U2brJ3iZhpprajUkMm9CRh
         9xyOlf7v2gw9bxwLEcSBGqY8fH6kI+nC0ot74jTNeWv/2QxeBazDSLMWM3UU9mXR2520
         bVag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=DF0neRQQv9y2FNCQF3XxcSDPKU9wzCezYAxhVAR57dQ=;
        b=VWi6qJ2qQMMKXBNUcPDYtu1IW7zHhIhY3drxAh2u6Cld/tLE9up8Evdk6BbRi6/odc
         bPf1wmxPPOfjZK20e1WMXOQyCa3qw8rED5l6XOZKLAPW0s4oAUTaFhpaF4F04nAnXMhV
         3BCOk4WJXcaYV5jSpiyQVl5RZCB3guzOGtnDFGlIsm3rsNEBxcNlx96H37a7FKjE96yz
         5wSjEo+yZKXaxqtvrMaFzRtduKtCOH1jR5kCdzohjhkw9wzmiyqiwO+535rJzlBbm3I/
         texHoPloMCDpKMfLrchZEnYXaPcBfxFIGAV/cgq9eFH30gbEEdFSsDf3V3kT3lIncxG0
         9r3w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=o1oCCQid;
       spf=pass (google.com: domain of baijiaju1990@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=baijiaju1990@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=o1oCCQid;
       spf=pass (google.com: domain of baijiaju1990@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=baijiaju1990@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+rIrVXJJiYvqo7UQQXiJiTiM5wARNYQiI7bRUO9IBc5GPvBOfKOOhA7s+r77MmFn9TSPqJJg==
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: gregkh@linuxfoundation.org,
	me@tobin.cc
Cc: devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] staging: ks7010: Replace mdelay with usleep_range in ks7010_upload_firmware
Date: Tue, 10 Apr 2018 16:58:54 +0800
Message-Id: <1523350734-29664-1-git-send-email-baijiaju1990@gmail.com>
X-Mailer: git-send-email 1.9.1
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597349030341500859?=
X-GMAIL-MSGID: =?utf-8?q?1597349030341500859?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ks7010_upload_firmware() is never called in atomic context.

The call chain ending up at ks7010_upload_firmware() is:
[1] ks7010_upload_firmware() <- ks7010_sdio_probe()

ks7010_sdio_probe() is set as ".probe" in struct sdio_driver.
This function is not called in atomic context.

Despite never getting called from atomic context, ks7010_upload_firmware()
calls mdelay() to busily wait.
This is not necessary and can be replaced with usleep_range() to
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/staging/ks7010/ks7010_sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
index 8cfdff1..8d7bc26 100644
--- a/drivers/staging/ks7010/ks7010_sdio.c
+++ b/drivers/staging/ks7010/ks7010_sdio.c
@@ -719,7 +719,7 @@ static int ks7010_upload_firmware(struct ks_sdio_card *card)
 
 	/* Firmware running check */
 	for (n = 0; n < 50; ++n) {
-		mdelay(10);	/* wait_ms(10); */
+		usleep_range(10000, 11000);	/* wait_ms(10); */
 		ret = ks7010_sdio_readb(priv, GCR_A, &byte);
 		if (ret)
 			goto release_firmware;
-- 
1.9.1
