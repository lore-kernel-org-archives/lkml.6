Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99EBC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDD62086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WPxuH4FE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BDD62086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeH2Lxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:53:46 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43728 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbeH2Lxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:53:45 -0400
Received: by mail-lf1-f65.google.com with SMTP id h64-v6so3496339lfi.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WGcGxBYbMR3lYiFeso6+j/q0sgMwNMyzkoeytqhrrrw=;
        b=WPxuH4FEJqGnE517ARbt1uzfFsPp8ytr1oMwjBDUNHNo5fmIpTQAAm9y3sI9brHI6A
         tdqnUm2Ed0vS+hZ9vrptewg9I8ejvYK6kQd+oAq107kuxp5OJ7qNkfC9fwYNgCNdxNoM
         OhtlFc4FsSCXYJ5lABPkWmE/YP03pcxk6Y4lE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WGcGxBYbMR3lYiFeso6+j/q0sgMwNMyzkoeytqhrrrw=;
        b=dZ+Zh1NfWT9uYG7aDCty8TFi7UogdRp0t7slKkx6sy6GPKlUsd8mslCsvii8ZUcHBT
         uHRxSR6oejyAskeeeqoqykS02lI4AXYj/0gLHFeiItWO+wXr6Ow69coZZELrF+gep9oo
         hloFKB9lXGkSlratlXwd36mnrUtHZfwrAJ4zXISEu6zg1ygxaoG3eLnD4e374Bgqk75h
         iPYRbIPqrN4qWXuU9ZMx52dUvXeurr6Rm6/Sv9Dm5fBpH9KL65WpdtGApLsZ9HGjtGhc
         V3OL0tWFiMhqgwirgFbcg1dLkZ/79ZVv+oQP51TvgUKuLQhz9Wgrh8hmZQeye+vDuHnT
         USDA==
X-Gm-Message-State: APzg51C3+A2kFbu5OhsIan/VMqf6CiO6aYZfF7N4su1pef3zkDTv13yv
        EzMQFF6aecg/RlDa62ABNLf1XA==
X-Google-Smtp-Source: ANB0VdbbFl2j18WiFp8S5cwsXkWO0k5xxDWzgqly5jEGGRu/P+vPtVIar2mp9pEp9FccfyJyHbn3fg==
X-Received: by 2002:a19:be55:: with SMTP id o82-v6mr3353559lff.58.1535529486221;
        Wed, 29 Aug 2018 00:58:06 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id j9-v6sm592303ljh.40.2018.08.29.00.58.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 00:58:05 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 8/9] soc: qcom: apr: Avoid string overflow
Date:   Wed, 29 Aug 2018 09:57:22 +0200
Message-Id: <20180829075724.9095-9-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829075724.9095-1-niklas.cassel@linaro.org>
References: <20180829075724.9095-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'adev->name' is used as a NUL-terminated string, but using strncpy() with the
length equal to the buffer size may result in lack of the termination:

In function 'apr_add_device',
    inlined from 'of_register_apr_devices' at drivers//soc/qcom/apr.c:264:7,
    inlined from 'apr_probe' at drivers//soc/qcom/apr.c:290:2:
drivers//soc/qcom/apr.c:222:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
   strncpy(adev->name, np->name, APR_NAME_SIZE);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This changes it to use the safer strscpy() instead.

Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/soc/qcom/apr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
index 57af8a537332..ee9197f5aae9 100644
--- a/drivers/soc/qcom/apr.c
+++ b/drivers/soc/qcom/apr.c
@@ -219,9 +219,9 @@ static int apr_add_device(struct device *dev, struct device_node *np,
 	adev->domain_id = id->domain_id;
 	adev->version = id->svc_version;
 	if (np)
-		strncpy(adev->name, np->name, APR_NAME_SIZE);
+		strscpy(adev->name, np->name, APR_NAME_SIZE);
 	else
-		strncpy(adev->name, id->name, APR_NAME_SIZE);
+		strscpy(adev->name, id->name, APR_NAME_SIZE);
 
 	dev_set_name(&adev->dev, "aprsvc:%s:%x:%x", adev->name,
 		     id->domain_id, id->svc_id);
-- 
2.17.1

