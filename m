Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23ADC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA86B2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TfPcPvvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA86B2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbeKLU3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:29:40 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38069 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729391AbeKLU3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:29:39 -0500
Received: by mail-wr1-f67.google.com with SMTP id e3-v6so8735684wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 02:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WM5wAL+KKZboTpM6WbKDYjrBAu6BnNSI13IkZ9wLSY0=;
        b=TfPcPvvH3gKcN8cVEvQ0BSlxdfw4O1GeXdonxmhhez14nS7/AgKpAb929j2/+CYh4W
         EsAg9FG5/zTzAKFJSDeMbZAyTCWmADEKdGlzgqrvG41gQxtqYnJz9+cfOzzRZl3vVkYl
         01CWlr7aXNZCizQ5QcTCOfbMKxKPOX8EXic0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WM5wAL+KKZboTpM6WbKDYjrBAu6BnNSI13IkZ9wLSY0=;
        b=VQfoumU6QsYkcCqyuNudeWaoVPJ9GaFFQlazcF6Gw2cjvnmQ94S3l/whmdDlQM5o7q
         gvoYrkhVV38gwVbL2JwxOAh0jivBS2u/xv9GHpsNFjcuvrYylhuaRco503DX9Ce9hwa0
         sdKVCKaEexHdDAiyfgDkaK/uBec8BUpu2vo8IVQMT1GoBAr5Ne5lKMpsPtZrkuQJXcjQ
         +iaHirUYgTCCsqfK8uC0FFEKHr6S9GuCvipqytLwWlXx+aApRjTjPYMc6MXx9D9kY/1a
         ssoSHmlqiG3bhDAaIPapYFByzf+D+SyEha/jVpkrFajfyESd1IAoSrwNkBrUqsMOAsCy
         nQYw==
X-Gm-Message-State: AGRZ1gK6QGqpAKPJ/RLK1yTdvvct0RBoKDCQnKagxtVaoxAyEDpJGqko
        +vuA7FGfvjOZTX+hvAhPt0XaiQ==
X-Google-Smtp-Source: AJdET5fXl4vxVaClFYwEy6/ERfQLkn8vORFKryfM6ZjTN6slWpbjxqNH0bu9xEhDHAGJ5iQ8buT2pw==
X-Received: by 2002:adf:a20a:: with SMTP id p10-v6mr402746wra.249.1542019019555;
        Mon, 12 Nov 2018 02:36:59 -0800 (PST)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id z17-v6sm13747187wrm.65.2018.11.12.02.36.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 02:36:58 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     marc.zyngier@arm.com
Cc:     sudeep.holla@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        rnayak@codeaurora.org, sboyd@kernel.org, srini@kernel.org,
        bjorn.andersson@linaro.org, nicolas.dechesne@linaro.org,
        ctatlor97@gmail.com, vkoul@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RFC PATCH v3 2/4] irqchip/gic: common: add support to device tree based quirks
Date:   Mon, 12 Nov 2018 10:33:38 +0000
Message-Id: <20181112103340.24702-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181112103340.24702-1-srinivas.kandagatla@linaro.org>
References: <20181112103340.24702-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to device tree based quirks based on
device tree compatible string.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/irqchip/irq-gic-common.c | 12 ++++++++++++
 drivers/irqchip/irq-gic-common.h |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index 01e673c680cd..3c93c6f4d1f1 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -36,6 +36,18 @@ void gic_set_kvm_info(const struct gic_kvm_info *info)
 	gic_kvm_info = info;
 }
 
+void gic_enable_of_quirks(const struct device_node *np,
+			  const struct gic_quirk *quirks, void *data)
+{
+	for (; quirks->desc; quirks++) {
+		if (!of_device_is_compatible(np, quirks->compatible))
+			continue;
+		if (quirks->init(data))
+			pr_info("GIC: enabling workaround for %s\n",
+				quirks->desc);
+	}
+}
+
 void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 		void *data)
 {
diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
index 3919cd7c5285..97e58fb6c232 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -23,6 +23,7 @@
 
 struct gic_quirk {
 	const char *desc;
+	const char *compatible;
 	bool (*init)(void *data);
 	u32 iidr;
 	u32 mask;
@@ -35,6 +36,8 @@ void gic_dist_config(void __iomem *base, int gic_irqs,
 void gic_cpu_config(void __iomem *base, void (*sync_access)(void));
 void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 		void *data);
+void gic_enable_of_quirks(const struct device_node *np,
+			  const struct gic_quirk *quirks, void *data);
 
 void gic_set_kvm_info(const struct gic_kvm_info *info);
 
-- 
2.19.1

