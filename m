Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5ECC65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 225142145D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 18:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9iAkn/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 225142145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeLAFxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 00:53:24 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42289 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeLAFxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 00:53:23 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so2859848pga.9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 10:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a54bpJWkTONWX4xBh3sap+Bcri1qS8QIiPLNgbLvU28=;
        b=C9iAkn/eQ81AquoFVcDRP4BXRSDPvwi5lVom0WpXgdndGwCZmQdUQsc0LJ39BK7HH0
         kCT8HZiFlMoI5S4CO9wUbiQmU+YZDXl22GevrHwzuI5arIPYrQvWzJxP3iPajaMdBtt3
         B7ETOxXhQlqkn/G+DbDeFP7LSMBZC/Fqh/uNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a54bpJWkTONWX4xBh3sap+Bcri1qS8QIiPLNgbLvU28=;
        b=b/2sIEzY6iBWO411LIZJw+7iKR150WRbkVkf1P+b+KcfofhArui0FasDH+AqnVwgnN
         YCPqnYs9VBz3X4I55/+Fpisn3sU1bmBgNngJGzXqZkO6j59ZbkJwT63Kfoyx/vOq8MpP
         eFCGu2bTX75j9JDDq8gHWDT4lY6Esth40NRckkZMlGiEN0cC0tAK2deJkfmRn9FLWvIv
         OniSdk1TxC/esx3MjMrhgXC5+G3abHalgCjuf78tbX0wVy0JnUrodt4Hh5pSIkvKTJlD
         XPaSeztqSOKTrnDs2IHXh6NTh4FHy66v1ulSZGc1yQpc9XQbA/wllRE3E39VtZpZH3+V
         L5XQ==
X-Gm-Message-State: AA+aEWay07siDFjv5z4e1bdZuAMsWclVrk/LZZR+umIwVgrf2mI48CxJ
        qz/tUlcHCyZTVPKlfNbuF94YYw==
X-Google-Smtp-Source: AFSGD/UZy7zWwm4JsDtF8rlBsET0+PI69OZOzPIlytWx/XBEcg/oYw6hn5webSmFz8TovtjTTzOxzw==
X-Received: by 2002:a62:1541:: with SMTP id 62mr6721900pfv.230.1543603391929;
        Fri, 30 Nov 2018 10:43:11 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id l184sm12743147pfc.112.2018.11.30.10.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 30 Nov 2018 10:43:11 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] coresight: etf: Release CLAIM tag after disabling the HW
Date:   Fri, 30 Nov 2018 11:43:04 -0700
Message-Id: <1543603387-32645-4-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543603387-32645-1-git-send-email-mathieu.poirier@linaro.org>
References: <1543603387-32645-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch rectifies the sequence of events in function
tmc_etb_disable_hw() by disabling the HW first and then releasing the
CLAIM tag.  Otherwise we could be corrupting the configuration done by an
external agent that would have claimed the device after we have released
it.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 5864ac55e275..a5f053f2db2c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -86,8 +86,8 @@ static void __tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 
 static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 {
-	coresight_disclaim_device(drvdata->base);
 	__tmc_etb_disable_hw(drvdata);
+	coresight_disclaim_device(drvdata->base);
 }
 
 static void __tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
-- 
2.7.4

