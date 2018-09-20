Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E50ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36BA521525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IOiqhG0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36BA521525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388663AbeIUBD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:03:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44164 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388617AbeIUBD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:03:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so4811694pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eF89dC211phJ/o1YWVyp4RY+3QE6f2Ht0jxF9gJ+Hsw=;
        b=IOiqhG0ZxY4l4OUYmyy3hVpYx/Li3dpgxhA74liU/HAO4yMwDnWb5CrMBpgZqmCClb
         e3hD4OR839R5o2VElvqYOHaLxri0nwS5JpI2mzMLuGdaEzCCl3hpnk9ECkU0ya/beQzG
         VldY3GY2wRKJ8TuuG8eCLcR3SAiyJuaydqEm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eF89dC211phJ/o1YWVyp4RY+3QE6f2Ht0jxF9gJ+Hsw=;
        b=gjr2w2HfhjVh+tYZZbI1j+pRa8xMD5Nb1575YgJaZnNQUNtUahas7WKTraVf5PnK+g
         kY3XEZ6tkMhzQI22t6I/+wwsjfmiXkPyeHW0R2Dz4NsBsOTQk5OpMp/kgGRcLXrzMutX
         DNnVxbgKa+ZyFTy+OaGYFTPFi7D3DVFnfNhBGiwYmkTPv3ltYHEW/Ge8LBPkx63nHsk+
         qa63HIEPMo05eANeocD8NIdZx7zEp1Ea+LyC6DIWZ3J9lQVkumdW7ABfO/mU0lJ+gR32
         pel+ZdeaEu2nA9GlmYkLlZOv+toP3PuFzBcH3et+GkMLyW2Rm6okdaWQgc5GX+Zx5nW+
         Kmhg==
X-Gm-Message-State: APzg51BXBQRi/iSWIAjicPOKW8Wvuy94TsJ7V6/RqB0C11Jt/31SR2Ys
        KYwGGhTRnqW+Ti9y3fujykeQiw==
X-Google-Smtp-Source: ANB0VdZ8aR5hCr7igHfdJqNdMpwmPx0TDkliHEesw73vXh7D55JeaEM83AtiGtAsNhIsdnmrD1tL9g==
X-Received: by 2002:a63:7107:: with SMTP id m7-v6mr37801119pgc.73.1537471107422;
        Thu, 20 Sep 2018 12:18:27 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:18:26 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 04/44] coresight: platform: Fix leaking device reference
Date:   Thu, 20 Sep 2018 13:17:39 -0600
Message-Id: <1537471099-19781-5-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

We don't drop the reference on the remote device while parsing the
connection, held by bus_find_device(). Fix this by duplicating the
device name and dropping the reference.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Kim Phillips <kim.phillips@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/of_coresight.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 28d3aef1660b..4b279f8fea0c 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -162,7 +162,9 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		}
 
 		pdata->outports[i] = endpoint.port;
-		pdata->child_names[i] = dev_name(rdev);
+		pdata->child_names[i] = devm_kstrdup(dev,
+						     dev_name(rdev),
+						     GFP_KERNEL);
 		pdata->child_ports[i] = rendpoint.id;
 		/* Connection record updated */
 		ret = 1;
@@ -172,6 +174,8 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		of_node_put(rparent);
 	if (rport)
 		of_node_put(rport);
+	if (rdev)
+		put_device(rdev);
 
 	return ret;
 }
-- 
2.7.4

