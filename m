Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D173AECE567
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9134E21533
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SOxHja3K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9134E21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389148AbeIUBE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:04:28 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40019 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389132AbeIUBE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:04:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id l63-v6so4875993pga.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dnhE0czpJg+XaiFH4BtekxN9pZR1jCXAxiDs2QAUsmg=;
        b=SOxHja3KB1sWY9dO4lXhpAwTuwns7vus5Er6PolPLyezj4thRF2NKl4IdI3nLbUrxO
         99GIXd7NOO9EEPe2j1Ww5pcnow5Y1pB29B5y/rlZRGGSoiFFfFbgUTgH2Fi18wQ1anwT
         1SdOEZVke2l/pO9NTnRc08LVGOqAx1npStToM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dnhE0czpJg+XaiFH4BtekxN9pZR1jCXAxiDs2QAUsmg=;
        b=QQ1uA2G3bCncuBBwb5mhZ9h64zXQUReihcbUFZ7wfaW+XYBTl5WtWZdXmsAKvKrey4
         NlRZeFUKLRl/KzWGHRk2NFBHZFLWkIxrKG8AJj9Yo/2QU/NaXq2dGoM9eBbwDXf3lU+B
         gC2zTsSih0iXwQ9DSh+q1yTri3D0cofrTha2/u7NFa+KbLx7BYRsz0xhe+nz9/qoAELF
         hbA4B3X+4QqzG44lTXkYvQmkqOMkN8mLV8rSbc8cqK4n8NQcfVzn7H3laTe9cSdOipIv
         /zsWs0mICA17LU8dDKpl5yFpiEOEH0NaVEIP0rPc4fr+Un14WZYUdlxLe4A8b0PewU4X
         Pu1A==
X-Gm-Message-State: APzg51AgzyEEAbRB6mukHYI3mhpU3ThgKAatCag+lI8LotetVNa5H5f8
        1IsbRo6miy6skK76I5i1LYwyZg==
X-Google-Smtp-Source: ANB0VdZqL2OePQbzIR5xdJmRdVwoK6O04aoT03tjm1eUeMoiijoCUPJXQVL2/v1bFWGYkTsLTcxqAw==
X-Received: by 2002:a63:6d4f:: with SMTP id i76-v6mr37804491pgc.215.1537471168725;
        Thu, 20 Sep 2018 12:19:28 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.19.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:19:27 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 44/44] coresight: Remove redundant null pointer check before of_node_put and put_device
Date:   Thu, 20 Sep 2018 13:18:19 -0600
Message-Id: <1537471099-19781-45-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhong jiang <zhongjiang@huawei.com>

of_node_put and put_device has taken the null pointer check into account.
So it is safe to remove the duplicated check.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/of_coresight.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index da71c975e3f7..89092f83567e 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -219,12 +219,9 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		ret = 1;
 	} while (0);
 
-	if (rparent)
-		of_node_put(rparent);
-	if (rep)
-		of_node_put(rep);
-	if (rdev)
-		put_device(rdev);
+	of_node_put(rparent);
+	of_node_put(rep);
+	put_device(rdev);
 
 	return ret;
 }
-- 
2.7.4

