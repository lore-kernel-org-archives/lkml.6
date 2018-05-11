Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526036975; cv=none;
        d=google.com; s=arc-20160816;
        b=gnsK025zH6yCydoxGl7KgbB4jfFgjfsvNfL5h89afNt1Jk+MFM8dTIFx6DmqFGXkrs
         OV8YFzn2xHUbYnlqPUgb/vnBuaPW1PqeETtT4io0jWTMpXES1ZeCXZ6XY1SU6BOaupOb
         DIgKI+2ZRd45my9zUqx3DQjlnFbtnRB7hrMr3fgkvUi7Kor6tBFF5qBaeRV66YbRSjLg
         u5sADwP7e7HSRyIocMcsaXqgUnrT/sANgapqxbkDefM4XCcFjpGsQ11bdLT7/XT5hf5y
         jQUfALMvQUrlbrNzG0WHpzBIVEmUVk+8DlKJ2BnAi3/ZO/Qq+T9N4kL6JbXIeAZEiVto
         4X+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=knlOZa3kWejwQyXaSPUlYA5Ylqs5mOu7wvB+yHzU8sg=;
        b=wLx+baiczB7Ako21ZmLEXhtKewwDsicHEe6GKCKTjr+DetxmITCT3Uj9r8IViv/teS
         Yos0xhMldDuN2I5OVS+yl5HckPWu2X1UaFYqSxnlO4P/0sfVkB7O/Xm6bHUoONtyvDa/
         G4x4Bw/3tzh0EVhPBN3a2MGM0noSUxsbhBxJrMdKaZ7JIyFMB3tANxW8cPtzxVWANUyK
         KAieayZgIwPY+0hnTUPmk2PNqQo2ezWEk4K+LiDI3lULPZWKDRDD7NpsqG1XamHPWfln
         SRNUM2oEYV7zrJmyThWpPUdUEsh1uL2R8H2vVfXLt1jPRTpISOmPwpZVxmZW0ZtNPAUw
         MmWg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=hxTlPOpr;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=hxTlPOpr;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZpelSlz56hhW9w0Jse3/7fjYWfE99CSjZ2vgnOPaiSAIBkeJ9d4aVi/R5/Am0oFp4evExRrIg==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 6/8] nvmem: meson-efuse: add write support
Date: Fri, 11 May 2018 12:07:01 +0100
Message-Id: <20180511110703.4924-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180511110703.4924-1-srinivas.kandagatla@linaro.org>
References: <20180511110703.4924-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600165748027826959?=
X-GMAIL-MSGID: =?utf-8?q?1600165748027826959?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jerome Brunet <jbrunet@baylibre.com>

Add write support to the meson-gx efuse driver.
Beware, this efuse is one time programmable !

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/meson-efuse.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index 4623249dfd87..d769840d1e18 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -28,6 +28,13 @@ static int meson_efuse_read(void *context, unsigned int offset,
 				  bytes, 0, 0, 0);
 }
 
+static int meson_efuse_write(void *context, unsigned int offset,
+			     void *val, size_t bytes)
+{
+	return meson_sm_call_write((u8 *)val, bytes, SM_EFUSE_WRITE, offset,
+				   bytes, 0, 0, 0);
+}
+
 static const struct of_device_id meson_efuse_match[] = {
 	{ .compatible = "amlogic,meson-gxbb-efuse", },
 	{ /* sentinel */ },
@@ -52,8 +59,8 @@ static int meson_efuse_probe(struct platform_device *pdev)
 	econfig->name = dev_name(dev);
 	econfig->stride = 1;
 	econfig->word_size = 1;
-	econfig->read_only = true;
 	econfig->reg_read = meson_efuse_read;
+	econfig->reg_write = meson_efuse_write;
 	econfig->size = size;
 
 	nvmem = devm_nvmem_register(&pdev->dev, econfig);
-- 
2.16.2
