Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03E8C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA27421532
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XHQRhZpW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA27421532
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390144AbeIUT3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:29:36 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52077 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389870AbeIUT3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:29:34 -0400
Received: by mail-it1-f195.google.com with SMTP id e14-v6so1997381itf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 06:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UGnBvrzQNBCErkim5skLyhtAPY6JidTg2ZjK6bwL0Pg=;
        b=XHQRhZpWHWvjJ1HHghjY9gPp4UA339mxuh/WlDr9PI3jFbtg48oXCQXdRO5TdtOrTM
         B+Bs62KNEssz+/VjvbIb43bqGIncMBgkitbigVCSnbSoRSNST2MO8CVTQs3eVnEr2F5X
         e4a9x4l5s5ZT4hhdSnOPNGD7Er0MZd82q9nQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UGnBvrzQNBCErkim5skLyhtAPY6JidTg2ZjK6bwL0Pg=;
        b=jFjmj62rEXNqTQvbRz8qyurfbLHgAlpc5fN2hHFt/GUPpHMiNiQRULenEEUJy14Tvq
         BpCs2p/Om7I4RMBrXg4iaD3Uh/E0s2/YqOBN2OL+ZUcHivIMRHv12qIrkvdEsIdOguSQ
         Rt3kVb6UH2ryMVemhLmR8Iq2dpZkjGZLZ2V+s2bAC+yXszoqyR5nDmFdNfereXOCB5ay
         5HLoWjY/EtOy3ru5sthd/Ns2fJ/RxP5Fcbj7/buHrkDT8tepZDsNLddAgUtqkjkVYfyh
         cdnqd6Co4P3DFwo956mlsTY6R0kvcp/K/D1p+5FJEN+S7H7b8hPP+oeurjQ/PrRVoGA2
         6mLA==
X-Gm-Message-State: APzg51AqRiFJ6k9QWyeJOHyI6cGPWjuH60mcg6lhPBC6BHkmgydvePvH
        irze1xlaU2kHr8kM5DHqGVS+Ag==
X-Google-Smtp-Source: ANB0VdZEzjLYkt8TFQRsLWGaoLZMlJuEVtsHaZln3vxW54SeFunAa3FIYnYicKD3jLaLPd6OedmfqQ==
X-Received: by 2002:a24:37d6:: with SMTP id r205-v6mr5569309itr.66.1537537238629;
        Fri, 21 Sep 2018 06:40:38 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id c12-v6sm9896298ioq.81.2018.09.21.06.40.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:40:38 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 03/26] nvmem: provide nvmem_dev_name()
Date:   Fri, 21 Sep 2018 06:40:03 -0700
Message-Id: <20180921134026.4596-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
References: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Kernel users don't have any means of checking the names of nvmem
devices. Add a routine that returns the name of the nvmem provider.

This will be useful for future nvmem notifier subscribers - otherwise
they can't check what device is being added/removed.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 13 +++++++++++++
 include/linux/nvmem-consumer.h |  8 ++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 6f064002f439..11afa3b6d551 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1343,6 +1343,19 @@ int nvmem_device_write(struct nvmem_device *nvmem,
 }
 EXPORT_SYMBOL_GPL(nvmem_device_write);
 
+/**
+ * nvmem_dev_name() - Get the name of a given nvmem device.
+ *
+ * @nvmem: nvmem device.
+ *
+ * Return: name of the nvmem device.
+ */
+const char *nvmem_dev_name(struct nvmem_device *nvmem)
+{
+	return dev_name(&nvmem->dev);
+}
+EXPORT_SYMBOL_GPL(nvmem_dev_name);
+
 static int __init nvmem_init(void)
 {
 	return bus_register(&nvmem_bus_type);
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 4e85447f7860..0389fe00b177 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -55,6 +55,8 @@ ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
 int nvmem_device_cell_write(struct nvmem_device *nvmem,
 			    struct nvmem_cell_info *info, void *buf);
 
+const char *nvmem_dev_name(struct nvmem_device *nvmem);
+
 #else
 
 static inline struct nvmem_cell *nvmem_cell_get(struct device *dev,
@@ -143,6 +145,12 @@ static inline int nvmem_device_write(struct nvmem_device *nvmem,
 {
 	return -ENOSYS;
 }
+
+static inline const char *nvmem_dev_name(struct nvmem_device *nvmem)
+{
+	return NULL;
+}
+
 #endif /* CONFIG_NVMEM */
 
 #if IS_ENABLED(CONFIG_NVMEM) && IS_ENABLED(CONFIG_OF)
-- 
2.19.0

