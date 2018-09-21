Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B282EECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8D22154E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JqSJTbxE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8D22154E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390267AbeIUT3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:29:45 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:47090 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390237AbeIUT3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:29:44 -0400
Received: by mail-io1-f67.google.com with SMTP id y12-v6so12191420ioj.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 06:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l3sT58gzthwq0kvVJ4CsyyveZVtgLHLAG2tBKFHIZlU=;
        b=JqSJTbxEKQvQOXaEkfQjp/iRQ7x9puYJ+QW0uHOhB3uJSYlNbp2DuJ68X/Wyklbkym
         KrhjyLcD/Dznzou1QA8u81mSiqtTgGxZL1oC9ZzMH0Z8De+3SI8wowWOWQZdB4HJV/FF
         4PEOmjyOM9UVX5cEtdde8ErQA7P7YLygjQ9U8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l3sT58gzthwq0kvVJ4CsyyveZVtgLHLAG2tBKFHIZlU=;
        b=lWYD3/6FB9TudvOETcaaLIxZY6p2R8/cf4cgXwppWygwYMsHBNMmvLTxZhP910GwEJ
         XEFHQ3+7ZtbTKzgWWcyaebb6AWMqNrX09WX8ywSaNJoL40b0Z28i0ItII95vw50tcJSj
         8Fspq8/P4P0R9Dx1rvP1/ncO3sVKbY67iBOV8iXEvgehxFFinwqKkQoDp2izBVHK2Vmg
         lILFB16oMLyCKQ+KXmEibvWaMgXBeM4aDHtd2FSXsQBVqqrgkNv6c9EWNSEPTlrGGQ6k
         tsuYD6HMkXpLEvpzWcWnSxmhLBIUv6gsNmEASb1c8CyfUI8bb91IEF3Un8e8YhCfwj0x
         60qA==
X-Gm-Message-State: APzg51D1ZzRtIoodXnL8KF5Wf1jLiUtklWBYltOaeyimKxU0MadWI55v
        pNoxs8pqzWOcYHnexKRFVreEQw==
X-Google-Smtp-Source: ANB0VdaZ+OfMANwViK9NUjh0Et1gAKwKPKMxQp0TfOm2WuY+Hs0auIrrscDexhJAdFLqrXGg56+zdg==
X-Received: by 2002:a02:ba98:: with SMTP id g24-v6mr4497339jao.73.1537537249218;
        Fri, 21 Sep 2018 06:40:49 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id c12-v6sm9896298ioq.81.2018.09.21.06.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:40:48 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 13/26] nvmem: change the signature of nvmem_unregister()
Date:   Fri, 21 Sep 2018 06:40:13 -0700
Message-Id: <20180921134026.4596-14-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
References: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

We switched the nvmem framework to using kref instead of manually
checking the current number of users in nvmem_unregister() so this
function can no longer fail. We also converted all remaining users
that still checked the return value of nvmem_unregister() to using
devm_nvmem_register(). Make the routine return void.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 8 ++------
 include/linux/nvmem-provider.h | 9 +++------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 920b56e500cc..bd14d04782cd 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -553,20 +553,16 @@ static void nvmem_device_release(struct kref *kref)
  * nvmem_unregister() - Unregister previously registered nvmem device
  *
  * @nvmem: Pointer to previously registered nvmem device.
- *
- * Return: Will be an negative on error or a zero on success.
  */
-int nvmem_unregister(struct nvmem_device *nvmem)
+void nvmem_unregister(struct nvmem_device *nvmem)
 {
 	kref_put(&nvmem->refcnt, nvmem_device_release);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(nvmem_unregister);
 
 static void devm_nvmem_release(struct device *dev, void *res)
 {
-	WARN_ON(nvmem_unregister(*(struct nvmem_device **)res));
+	nvmem_unregister(*(struct nvmem_device **)res);
 }
 
 /**
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 24def6ad09bb..0f357d0c1e75 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -70,7 +70,7 @@ struct nvmem_config {
 #if IS_ENABLED(CONFIG_NVMEM)
 
 struct nvmem_device *nvmem_register(const struct nvmem_config *cfg);
-int nvmem_unregister(struct nvmem_device *nvmem);
+void nvmem_unregister(struct nvmem_device *nvmem);
 
 struct nvmem_device *devm_nvmem_register(struct device *dev,
 					 const struct nvmem_config *cfg);
@@ -87,10 +87,7 @@ static inline struct nvmem_device *nvmem_register(const struct nvmem_config *c)
 	return ERR_PTR(-ENOSYS);
 }
 
-static inline int nvmem_unregister(struct nvmem_device *nvmem)
-{
-	return -ENOSYS;
-}
+static inline void nvmem_unregister(struct nvmem_device *nvmem) {}
 
 static inline struct nvmem_device *
 devm_nvmem_register(struct device *dev, const struct nvmem_config *c)
@@ -101,7 +98,7 @@ devm_nvmem_register(struct device *dev, const struct nvmem_config *c)
 static inline int
 devm_nvmem_unregister(struct device *dev, struct nvmem_device *nvmem)
 {
-	return nvmem_unregister(nvmem);
+	return -ENOSYS;
 
 }
 
-- 
2.19.0

