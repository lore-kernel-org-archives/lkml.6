Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD36FC64EB4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738F32146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NwobcONk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 738F32146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbeK3XCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 18:02:43 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39044 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbeK3XCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 18:02:43 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so4610119edt.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 03:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zXEVfusJTtHYF8K5u4w1iFuAS8eAG0ioA/9REdMjm+I=;
        b=NwobcONkSwjo+2uQ7nVK59I6q9dEFNNQt0qdWrVE4SJw0H6DF1/imJGhMY8ETyv1fb
         vZWJx25r7w9bAVyo5eoVr0UFMnGRDe0vYXub7f27c1DHcwlDXAjgZPrKqlBSyXYUJTxM
         /v9os+2zIGXg9lN2RQ+4RXIaiPb0RuGYhPveQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zXEVfusJTtHYF8K5u4w1iFuAS8eAG0ioA/9REdMjm+I=;
        b=tSi6rqDypV4ariEtjKLdJbmcv5qBESrS9mwhcXrTtWwNG5fQwZQX+8YW9o0CIs/pgD
         0XPUFCby05TMCqp03Z8wJmLofNCqsauMMcg/1swWbOaWOchTcTmNZNssqwUbHmNBt7w0
         J/r0JXFWWncHTo+AfKKY2Qjdf49QLmae92Kjwa5mPfVdDVOeBFuWQ8J88Puvz6PJ5/m+
         u3Hu9IdHTUC0jW7pS/Pb4IkkevP4DTXlm157Zs+kjZ0SeIWRepsxVzJ81tpgIlvngJYG
         tWDHQmZgZZb+Gg5fa3L8M5bguYAb5HPYwvLMv7h8yGUv4OYBFV/q9Uk8Me6+D0iFX5sl
         Q5Qw==
X-Gm-Message-State: AA+aEWa3QHgk54PfCyHY3c74ketdfJkGPmvOpmJ/e9A4D1qY6TsDsUsH
        Pt3d1DjO3LTgtCoFgwf5Y3yMRA==
X-Google-Smtp-Source: AFSGD/WZJTmp50ywpr4eKQxd8QBM+weXSK4dwweqIiOuOH6jN8TNYw08uo9DsAN1/wQEapCvYN0Wvw==
X-Received: by 2002:a50:cf41:: with SMTP id d1mr5126997edk.242.1543578819645;
        Fri, 30 Nov 2018 03:53:39 -0800 (PST)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t10-v6sm767932ejg.41.2018.11.30.03.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 03:53:37 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/6] nvmem: meson-efuse: add error message on user_max failure.
Date:   Fri, 30 Nov 2018 11:53:21 +0000
Message-Id: <20181130115325.16539-3-srinivas.kandagatla@linaro.org>
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

Add an explicit error message when SM_EFUSE_USER_MAX command fails

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/meson-efuse.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index d769840d1e18..40b9df1d030d 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -48,8 +48,10 @@ static int meson_efuse_probe(struct platform_device *pdev)
 	struct nvmem_config *econfig;
 	unsigned int size;
 
-	if (meson_sm_call(SM_EFUSE_USER_MAX, &size, 0, 0, 0, 0, 0) < 0)
+	if (meson_sm_call(SM_EFUSE_USER_MAX, &size, 0, 0, 0, 0, 0) < 0) {
+		dev_err(dev, "failed to get max user");
 		return -EINVAL;
+	}
 
 	econfig = devm_kzalloc(dev, sizeof(*econfig), GFP_KERNEL);
 	if (!econfig)
-- 
2.19.2

