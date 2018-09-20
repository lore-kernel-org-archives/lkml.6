Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66307ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CE621525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="W8aAZlC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CE621525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388646AbeIUBDZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:03:25 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42194 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388617AbeIUBDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:03:24 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so4874853pgp.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DQ6AeLYKgMl29948+vO+BNj/3zw6RiFnxzOn0pmvo2w=;
        b=W8aAZlC5ejzWl3bXMcYMponk+ydOQp/GrRVqdwtCF4bWGfFl+Xn487HB7B43L1jNke
         W2l7wP95SCU/Alscsv/SqryhVZJPu3YmflQi7r4qFwkZ8PGH+M46fJglrGEP4ylXNKPk
         W09/QfHEnh4W0w7OEnAm/JxaZOZ2BzGMlttb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DQ6AeLYKgMl29948+vO+BNj/3zw6RiFnxzOn0pmvo2w=;
        b=dNXv0liPY+uN/Gawz//jFTBGETdyvaiqwYlQB4ooy9XeWtfHXnglv8Vo2txdx6qYNy
         H5ww1jkS7UpG0/Cs7ikPi7uMJmZoh5wF+druaxM2i/DAcpvhyoq7was3pLPEKqNZPi6g
         Ew+iPSkKB9DRebe9z8M0s9KT/x+2Eh1+62v2N+PTsPbd9bzzAm1mK0y4G5f8IyMRGrIN
         VqeVEG0ME1XbGU5EVJe+DQUtzICgRassPjm3iLRZbBJD4hWkiCg1cpgRgLfxYcxhQMyE
         GprKwHDMVVKOT1kWw6NFD8o3s7yHpM8IdZiXNZzTiaR0G48PzsoWwoAGq0ALPZn/lRaG
         ownQ==
X-Gm-Message-State: APzg51B1IAI7NwybVZqg7X5ku673lz8OHVvU80xPue6HszoAlfDjddGb
        Eboy9IMN5d6KCS6xWHmVFvkT/Q==
X-Google-Smtp-Source: ANB0VdbRV+0Oe2zArqM8DMhV/C9CV7Uji5rewlNYSXTwXzGKkKhay8K0tX5b6VZRwows3qQAizrFQg==
X-Received: by 2002:a62:5cc1:: with SMTP id q184-v6mr43397619pfb.241.1537471105761;
        Thu, 20 Sep 2018 12:18:25 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.18.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:18:24 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 03/44] coresight: platform: Fix refcounting for graph nodes
Date:   Thu, 20 Sep 2018 13:17:38 -0600
Message-Id: <1537471099-19781-4-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

The coresight driver doesn't drop the references on the
remote endpoint/port nodes. Add the missing of_node_put()
calls.

Reported-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/of_coresight.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 70205f3eae8e..28d3aef1660b 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -168,6 +168,11 @@ static int of_coresight_parse_endpoint(struct device *dev,
 		ret = 1;
 	} while (0);
 
+	if (rparent)
+		of_node_put(rparent);
+	if (rport)
+		of_node_put(rport);
+
 	return ret;
 }
 
-- 
2.7.4

