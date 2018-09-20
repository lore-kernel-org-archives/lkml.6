Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC33ECE567
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56B921525
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 19:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="L9kS2n2d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56B921525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388777AbeIUBDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:03:37 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46420 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388760AbeIUBDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:03:37 -0400
Received: by mail-pl1-f195.google.com with SMTP id t20-v6so1358161ply.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 12:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=t1KhZyFjqvp9qI0UT6EcOP3PoDOXaznF3Gjt2laGV3Y=;
        b=L9kS2n2dYrjXqP0FTqo/L6z3LMjLPFZnDy1/NCam49Pu/9K5j/V+6sKe2M7p5Sp/cJ
         Z3hvIIYw+O79vv50spP1XsQXNliUqi2HoSqh31VVfSkKUJhGdL3H7ASB9G5B4tyKJ9tV
         2AC8LCNxWzW9GZesWiMNPqxLLy02oDiLe8/Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=t1KhZyFjqvp9qI0UT6EcOP3PoDOXaznF3Gjt2laGV3Y=;
        b=Uqj4dLrtO1Xuok4Ku4QtjjxZqAl/QRGqgoizgoRGAZ5nEdcqc304WcG7xywEuZDGlH
         +H1435/TntbohuNnpZ5oHV5DJwzuWe4uhuUEjValRvDE3K8+ig7pmwNGcZwYWiasNMrq
         9Tk3PfwVmjfRgN/brCABNVpYLonxq+tdHKWBudcdvutdvN/9RiEPyp6QYaezREdmWffw
         /44frR0KRQ2vOvC9KC6bxObFgaVTw+GMld9R8SaRd47ClFIgE3MehSQ0bugrc1Iwehap
         kywUrAGrW83eKOg9lynR5IJBCRSLWad6Y1O/NWwdmWT6Ongpl19SARrKyooPLkzvn1rG
         6mKw==
X-Gm-Message-State: APzg51AxsgqJ2SPrd6dWEhw+5ckB/SW0OyP5uf6kVjdIxr92A2pstySr
        l5FQ2LJ7CJwdD7n1LQBw4euD6A==
X-Google-Smtp-Source: ANB0VdYTBg5r/C1+hrHdb5s4YaIbTjnFnaLgZxipUXMCoSGtE6sUSH+ebi0O60bOMmKqVZz0VpGZNA==
X-Received: by 2002:a17:902:14d:: with SMTP id 71-v6mr39564481plb.146.1537471118323;
        Thu, 20 Sep 2018 12:18:38 -0700 (PDT)
Received: from localhost.localdomain ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4424443pgf.37.2018.09.20.12.18.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 12:18:37 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 11/44] coresight: etb10: Fix handling of perf mode
Date:   Thu, 20 Sep 2018 13:17:46 -0600
Message-Id: <1537471099-19781-12-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
References: <1537471099-19781-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

If the ETB is already enabled in sysfs mode, the ETB reports
success even if a perf mode is requested. Fix this by checking
the requested mode.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 306119eaf16a..0dad8626bcfb 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -147,6 +147,10 @@ static int etb_enable(struct coresight_device *csdev, u32 mode)
 	if (val == CS_MODE_PERF)
 		return -EBUSY;
 
+	/* Don't let perf disturb sysFS sessions */
+	if (val == CS_MODE_SYSFS && mode == CS_MODE_PERF)
+		return -EBUSY;
+
 	/* Nothing to do, the tracer is already enabled. */
 	if (val == CS_MODE_SYSFS)
 		goto out;
-- 
2.7.4

