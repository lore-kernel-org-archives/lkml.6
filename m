Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA0E3C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 645D92086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aj9uvoe0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645D92086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390407AbeIUT36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:29:58 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37162 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390376AbeIUT35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:29:57 -0400
Received: by mail-it1-f196.google.com with SMTP id h20-v6so1932842itf.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 06:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H7nLG5v+XSqLrjx8hRfsy4SA1JMyZyl0jYSSKjsVG1s=;
        b=Aj9uvoe0eLljVycNPUgMl8KfyKKtmTVjl4ncO91AB7s/R59ohfDeKrxHPC8grr6z5l
         IaxlVFM1EmQkV71zmYHKdXFd5xhmfi2OQWmhRdb7e6ycYAGDVXtGQqfI9cSCqta+BJVg
         z6BCyBXcGxKzHvJVpFirK41vRs+ob5SvC6h1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H7nLG5v+XSqLrjx8hRfsy4SA1JMyZyl0jYSSKjsVG1s=;
        b=exDQOibIZDqAeO+T8NR6qXxUOvYLhBoXNqpLohPheG9fn1Ca6PVOZqGsrq7aYS5Brl
         VKgjxEjdc2MwHarqMxFUd3PPAfOE0qGsjOwODTFraJUg1M07UuEpOmq4JCamZ100ADNx
         yH4PScBJZ8rrgsLugBHgrpG4w+XECreJeGkpoQfcZQWgKQs8sYoP1Tl8AqN6UcGcZm4D
         aSYQ96VjxyhfltphTgGPAbvvlYakGEzrq+kOETmQNm1qzlzRZBIaMRvHnffHLIa0RumP
         u5ZGn1NxAzDo9QK9pY5y+d8tFo78zI5+nmawzTBZ1HIvXw7rkohIZW9o2CS0ILOHVwx9
         ZASA==
X-Gm-Message-State: APzg51CF1AWWMe81Sgbgf278Ff1bqQSxu+0LSH5N2xKFg0t4WkL1EQg7
        SgxXhkzcL3QSuwhwNtODdsELjw==
X-Google-Smtp-Source: ANB0VdbQMLmHnofKdAo1tKnovlrwwCGPzeDjRZ37QIbwTXLpiHB1p6Arr4hUa+hm2GcRpbtjvVprBA==
X-Received: by 2002:a24:60d:: with SMTP id 13-v6mr5848982itv.1.1537537262087;
        Fri, 21 Sep 2018 06:41:02 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id c12-v6sm9896298ioq.81.2018.09.21.06.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:41:01 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 24/26] nvmem: use octal permissions instead of constants
Date:   Fri, 21 Sep 2018 06:40:24 -0700
Message-Id: <20180921134026.4596-25-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
References: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Checkpatch emits a warning when using symbolic permissions. Use octal
permissions instead.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index e44a1860a2b3..ad1227df1984 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -154,7 +154,7 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
 static struct bin_attribute bin_attr_rw_nvmem = {
 	.attr	= {
 		.name	= "nvmem",
-		.mode	= S_IWUSR | S_IRUGO,
+		.mode	= 0644,
 	},
 	.read	= bin_attr_nvmem_read,
 	.write	= bin_attr_nvmem_write,
@@ -178,7 +178,7 @@ static const struct attribute_group *nvmem_rw_dev_groups[] = {
 static struct bin_attribute bin_attr_ro_nvmem = {
 	.attr	= {
 		.name	= "nvmem",
-		.mode	= S_IRUGO,
+		.mode	= 0444,
 	},
 	.read	= bin_attr_nvmem_read,
 };
@@ -201,7 +201,7 @@ static const struct attribute_group *nvmem_ro_dev_groups[] = {
 static struct bin_attribute bin_attr_rw_root_nvmem = {
 	.attr	= {
 		.name	= "nvmem",
-		.mode	= S_IWUSR | S_IRUSR,
+		.mode	= 0600,
 	},
 	.read	= bin_attr_nvmem_read,
 	.write	= bin_attr_nvmem_write,
@@ -225,7 +225,7 @@ static const struct attribute_group *nvmem_rw_root_dev_groups[] = {
 static struct bin_attribute bin_attr_ro_root_nvmem = {
 	.attr	= {
 		.name	= "nvmem",
-		.mode	= S_IRUSR,
+		.mode	= 0400,
 	},
 	.read	= bin_attr_nvmem_read,
 };
-- 
2.19.0

