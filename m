Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1473C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F22214D9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fVIJri1Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69F22214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbeK3XDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:03:00 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34220 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbeK3XCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:02:44 -0500
Received: by mail-ed1-f66.google.com with SMTP id b3so4631240ede.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 03:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zehP8SR5e83ZAa8EuIqw69rvUStjAg1EoGYsdwg63ew=;
        b=fVIJri1ZQrnQWoKV11mNCwZPt2ZEXq0CPQFBNAkqfA249EPI8p2cD5fadANgSGGD4t
         SBJYp5PpWskvhantQSiDnf4i1ehumeZAeZjE5FeN5TDgzSebyOCd2+t8HpgKNZDPXeya
         id9FZZZ2YEQ9QeGTOooL7fzvMTBVRgEopj7Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zehP8SR5e83ZAa8EuIqw69rvUStjAg1EoGYsdwg63ew=;
        b=sIQARGjK4thdtqBNNpsgbsUeHZBgCyAdxkwKHoqE5QLio3NiO6P0S827rq50okl0rB
         nEw8gOFKEGmsSkIt6OunJoEKTZNqPquuGfuexzmP62sFizDodwiT/9njO52ulo3WVciD
         Jcyyw5HUEVAawrj/1+/8e1ohEyErqROARvKHQDzIFBx6qIkt9N86j14AJbYcQXN/ZW0V
         hSKbWRkoeSgG6oJfquCFKLms/SNK7JJw4VGWXi4b9H4rIq9ptLEiV8xiRWUMgNZNYmb3
         ytfMdG/9hr2/889DLloQWxrsCHLFELGJCSOyZdh8VYxaxpsYJKAixjg2Dn7CdOYRXTTD
         Ojgw==
X-Gm-Message-State: AA+aEWb9CTjpg4NQ/dSdXN83VezYY251REsNVUjrE9YWUNxpxcQ0l9Fs
        oe041wuyzZna9O0xIkO69vkByg==
X-Google-Smtp-Source: AFSGD/WvJQIIJLTjlMXtKKLfTf+XhDRLMUDlmt87sCmXwQO9/yT/tXzT8nmLK/htLC4OQYR/yBmJEQ==
X-Received: by 2002:a50:8b26:: with SMTP id l35mr4822677edl.146.1543578821670;
        Fri, 30 Nov 2018 03:53:41 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t10-v6sm767932ejg.41.2018.11.30.03.53.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 03:53:41 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/6] nvmem: meson-efuse: add peripheral clock
Date:   Fri, 30 Nov 2018 11:53:23 +0000
Message-Id: <20181130115325.16539-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181130115325.16539-1-srinivas.kandagatla@linaro.org>
References: <20181130115325.16539-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

Get and enable the peripheral clock required by the efuse device.
The driver has been handle to work without it so far because the
clock was left enabled by default but it won't be the case soon.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/meson-efuse.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index 40b9df1d030d..99372768446b 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -14,6 +14,7 @@
  * more details.
  */
 
+#include <linux/clk.h>
 #include <linux/module.h>
 #include <linux/nvmem-provider.h>
 #include <linux/of.h>
@@ -46,7 +47,31 @@ static int meson_efuse_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct nvmem_device *nvmem;
 	struct nvmem_config *econfig;
+	struct clk *clk;
 	unsigned int size;
+	int ret;
+
+	clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to get efuse gate");
+		return ret;
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		dev_err(dev, "failed to enable gate");
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev,
+				       (void(*)(void *))clk_disable_unprepare,
+				       clk);
+	if (ret) {
+		dev_err(dev, "failed to add disable callback");
+		return ret;
+	}
 
 	if (meson_sm_call(SM_EFUSE_USER_MAX, &size, 0, 0, 0, 0, 0) < 0) {
 		dev_err(dev, "failed to get max user");
-- 
2.19.2

