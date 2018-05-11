Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526036973; cv=none;
        d=google.com; s=arc-20160816;
        b=cwq98zoN307oHZsGucl0anX0wyYbe0STEoVWlxeng7FK/CFNZUhrKbDT3yHna7+40f
         LWF21LYMwqEUweUhEzlo+J+Zx2QOwjPt1LlFsbIzZDuA15Z5cyzXbnp2tkDNZgln81xe
         xnBCtMbBsnIZLtpUd0xpVtZJ9qzI6uNUWXkWJz5kzCe/5sGU8u1baLF5JYpekul+zyl7
         lBa/TAKqjjEvAxmZebLLD6v6eftl8CtzNgbo/xvNy5I5h/IoeO9lPAEBpDE4RkxuY40B
         GkhweEDntjuAYD2dPHNAfsnDwt7i9h4noU6RBI4PSZbqdWrLTvPSC0smxFhwNG59YI3b
         G8tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=H0qz3G2Yf+qnI2Pb4BPJFyzQj57UjzkRbyWc8uQk8Mg=;
        b=zcwrfPqamoLVWI71Y+UMlPXI59GSv6jsAkv+7+tiC/OD0wjfkeFOt7fqsu0AKfXWWH
         EficsNJVsbVFESa1hTt4C0k6FH+uyzLXBomuqDCEl2VxicUpjXLPfTYMbAm4Te5idtpj
         o4rlv8S8rL/AHrKXnRNVX8ggA69gNa7oeaqtB/0+Qj6Yd7KnPY7a9xLA5k6YvNq6Te/H
         XIVG2/5r9eLSwQSk0104PdqNtwEQdz8sGrsrcg0JqDMnqK4xbHN1DOIQ51mXPQT4f0id
         KFDnkH1QhVCQ5JkeKnrfL7az5WUC4enblDUl5lwVbGSXtKZ7QtLbDVzaHhVjXEXVcVja
         OHjw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=jaBGao1Q;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=jaBGao1Q;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZruCo6faolWDJ4g2fWw6UkbFGGJXLUrxSEG1vLHXTXn8R8DitaMCGuEjqoFjDbs8VcqU6MKZQ==
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 4/8] nvmem: meson-efuse: remove econfig global
Date: Fri, 11 May 2018 12:06:59 +0100
Message-Id: <20180511110703.4924-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180511110703.4924-1-srinivas.kandagatla@linaro.org>
References: <20180511110703.4924-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600165745808248271?=
X-GMAIL-MSGID: =?utf-8?q?1600165745808248271?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jerome Brunet <jbrunet@baylibre.com>

Having a global structure holding a reference to the device
structure is not very nice. Allocate the econfig instead and fill
the nvmem information as before

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/meson-efuse.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index 71823d1403c5..2df9b0094f45 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -35,13 +35,6 @@ static int meson_efuse_read(void *context, unsigned int offset,
 	return 0;
 }
 
-static struct nvmem_config econfig = {
-	.name = "meson-efuse",
-	.stride = 1,
-	.word_size = 1,
-	.read_only = true,
-};
-
 static const struct of_device_id meson_efuse_match[] = {
 	{ .compatible = "amlogic,meson-gxbb-efuse", },
 	{ /* sentinel */ },
@@ -50,17 +43,27 @@ MODULE_DEVICE_TABLE(of, meson_efuse_match);
 
 static int meson_efuse_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct nvmem_device *nvmem;
+	struct nvmem_config *econfig;
 	unsigned int size;
 
 	if (meson_sm_call(SM_EFUSE_USER_MAX, &size, 0, 0, 0, 0, 0) < 0)
 		return -EINVAL;
 
-	econfig.dev = &pdev->dev;
-	econfig.reg_read = meson_efuse_read;
-	econfig.size = size;
+	econfig = devm_kzalloc(dev, sizeof(*econfig), GFP_KERNEL);
+	if (!econfig)
+		return -ENOMEM;
+
+	econfig->dev = dev;
+	econfig->name = dev_name(dev);
+	econfig->stride = 1;
+	econfig->word_size = 1;
+	econfig->read_only = true;
+	econfig->reg_read = meson_efuse_read;
+	econfig->size = size;
 
-	nvmem = devm_nvmem_register(&pdev->dev, &econfig);
+	nvmem = devm_nvmem_register(&pdev->dev, econfig);
 
 	return PTR_ERR_OR_ZERO(nvmem);
 }
-- 
2.16.2
