Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050BFC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9402086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ELHuP3Bm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9402086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390464AbeIUTbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:31:16 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:37140 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390171AbeIUT3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:29:40 -0400
Received: by mail-it1-f195.google.com with SMTP id h20-v6so1931996itf.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 06:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1WOadb3iuIVom3UaIoauT6I1srE+Zn3wqDVMF0ti348=;
        b=ELHuP3BmUjiKqyZgLxnGxM/oKiagySfCrVKhE/rXo2Krw+e4XJwLkxp/n1d8aiXtdY
         h0iVo2H+8G+nOT8hihm4MHIKfHQy1p8jC60rqAWEf8nOOKZFb4SKv8U2Oh3zUutGBTDl
         fkdbGKo7SsSxITTcqiN4cKEsSMdZhib1O7Vng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1WOadb3iuIVom3UaIoauT6I1srE+Zn3wqDVMF0ti348=;
        b=KjhMIPT5kZYghUGhJ68o1QmlRXT078BdMJGN439YT+Ou5GNF8nJBecOC5VAvdiEGwf
         03WMk0No8YYWJ1/RwQwfMqcrGjnyAFOdFGxRKJd3WfdrwuGBbBr3Fphpanuxx2js+D0f
         w8CKn6rBZ+9QNexEZ5qK2WvWvxsQZCuha4e871VYq/WjCkj0MqqZstjyAAYHST2cnNV4
         cP2KK4sJTunkLeABJMNQk88/bYtLR3to7ZITkQdoZ7esTZFR1UbcET4tQMyaXjzSIKjs
         54ApcO+pwKAljO/HWek3YHDiFJ9uUI3uA9EonMktZcTulUL6fgQEyeP3U/lT/fDuo3R/
         qiwA==
X-Gm-Message-State: APzg51AvkZWHCJJdy9WnStsCQ8sSgGRI52xjZ+nQ+o4o0uMUVep4tsLE
        hJlzLk51IptPm4LgNNa0wzW+gw==
X-Google-Smtp-Source: ANB0VdYWbKApjY84s2LcqeeCU5pLzQ1ZP0QVZfg7XQUkPhXlSJj7LBiS7b1Y9Uj4wm9Noa6BjNJlkA==
X-Received: by 2002:a24:d507:: with SMTP id a7-v6mr6054608itg.7.1537537244799;
        Fri, 21 Sep 2018 06:40:44 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id c12-v6sm9896298ioq.81.2018.09.21.06.40.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:40:44 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 09/26] nvmem: sunxi_sid: return -ENOMEM if kzalloc() fails
Date:   Fri, 21 Sep 2018 06:40:09 -0700
Message-Id: <20180921134026.4596-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
References: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The driver currently returns -EINVAL if kzalloc() fails in probe().
Change it to -ENOMEM as it should be.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sunxi_sid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index d020f89248fd..4d0b7e72aa2e 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -187,7 +187,7 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 
 	randomness = kzalloc(size, GFP_KERNEL);
 	if (!randomness) {
-		ret = -EINVAL;
+		ret = -ENOMEM;
 		goto err_unreg_nvmem;
 	}
 
-- 
2.19.0

