Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF43C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B2D263A6
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 01:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BC9LJmh2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B2D263A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935180AbeFZBAv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 21:00:51 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53196 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934558AbeFZA7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:59:06 -0400
Received: by mail-it0-f66.google.com with SMTP id m194-v6so15207914itg.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 17:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U42+N/Pr+kSZibonyjndzWovOO9lsASoVNkEMXPj8tA=;
        b=BC9LJmh2L5hpLyHG3T84x5UZ5U5DhGzecGtUrmIT+Rly7V1hopxHHblcP6cfOEtzkO
         ZzmRAHEAJ8JRGys9QRqZUSXmQQ9KIW8gpdlvG50MM95IF+NNAw//Ok5IIhe7otASbciX
         yqsrdWH68/AA2trGqONsYSOrh6ShggL/c/ox4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U42+N/Pr+kSZibonyjndzWovOO9lsASoVNkEMXPj8tA=;
        b=LJm2ZcppjrstZmKWrQNEvwnyymw/ZXiHi2d5vyhmbpK8XAhDu+a3U6Ht7i1eBu0eLi
         wA2N482VCJrZiz/D87gg+c08bdnwn4lcgSDnluz6SnFtcot5FVY3k6yQ6+bhuzr9g/jW
         AXfIpHdwWU/ztp3AVDZVPbl/CxzEWRrThCnmeFq8zYAUN3/qB6LyMZHdHp4ZiIq2PwYL
         zm44Gp8RlzOfCy/ujCMb3Kj78i7M7EVdrRYnKiQE4E5ly7xCVpWpKcn4oy+5N4+Lmhhm
         cwxkxlI4bDjVrx82fZrz3Y6mXb4nf5l6nFO20aMtpm+NOAfKmy+JOldMXQTcUecTK+25
         jRDQ==
X-Gm-Message-State: APt69E2RGWGNg+LozbNq6ActLIgLQpaxAr4TKqId8efV20+lA7hLET6o
        pAFwuogM8G27lr3d181lsGC0cA==
X-Google-Smtp-Source: ADUXVKJQR2BaXOk9kCbmSjnQZnz6hzxUdywlgchxmYSA73zFAvDdKB/qGJiDfleh+TKjDUJ8IqlKcw==
X-Received: by 2002:a24:9b82:: with SMTP id o124-v6mr2598325itd.56.1529974746126;
        Mon, 25 Jun 2018 17:59:06 -0700 (PDT)
Received: from localhost.localdomain (c-71-195-29-92.hsd1.mn.comcast.net. [71.195.29.92])
        by smtp.gmail.com with ESMTPSA id f193-v6sm372556itf.9.2018.06.25.17.59.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 17:59:05 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     andy.gross@linaro.org
Cc:     clew@codeaurora.org, aneela@codeaurora.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH resend 05/12] soc: qcom: smem: verify both host ids in partition header
Date:   Mon, 25 Jun 2018 19:58:49 -0500
Message-Id: <20180626005856.14174-6-elder@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626005856.14174-1-elder@linaro.org>
References: <20180626005856.14174-1-elder@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The global partition is indicated by having both host values in its
table of contents entry equal SMEM_GLOBAL_HOST=0xfffe.

In qcom_smem_set_global_partition(), we check whether the header
structure at the beginning of the partition contains that host
value, but the check only verifies *one* of them.  Change the check
so the partition header must have SMEM_GLOBAL_HOST for *both* its
host fields.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/soc/qcom/smem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 5d3ed510e54b..6931602d9a9e 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -769,7 +769,7 @@ static int qcom_smem_set_global_partition(struct qcom_smem *smem)
 		return -EINVAL;
 	}
 
-	if (host0 != SMEM_GLOBAL_HOST && host1 != SMEM_GLOBAL_HOST) {
+	if (host0 != SMEM_GLOBAL_HOST || host1 != SMEM_GLOBAL_HOST) {
 		dev_err(smem->dev, "Global partition hosts are invalid\n");
 		return -EINVAL;
 	}
-- 
2.17.1

