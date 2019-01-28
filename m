Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88680C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594FC21736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WavQSbx2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfA1Got (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 01:44:49 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51395 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfA1Gos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 01:44:48 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so12697441wmj.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 22:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=zLqXF7SYoovkgBMNm7MtzJSzeE0VgZYQlKefNmrl8Go=;
        b=WavQSbx2bNC7C5yXALjdMV9Q0Wx7HAjLbSy6inoEb7pl1O3r0nECunTHyUcMG7vuj3
         VJd2jcU2RXYVDDZau8U17OeW7DYNzGcnOeP3UHJOaM/HETxWZOlBi8yJWjWduHhZD/FG
         7djYzrGCgCp+9bAJdn/bi36YEKIXc+lSUrowQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=zLqXF7SYoovkgBMNm7MtzJSzeE0VgZYQlKefNmrl8Go=;
        b=Fu8bA5aWJxRWzIievLIsxFQqNqTYM/uljZyr1/YleqvARjSD4RmBZOg595L5TnAqDA
         LQBQrzSd6/wlZVAEwhj9U3vdb5KQSpo1pck4tubJ8QakAjWjAC3OXtgJfoNDm0p4HSRp
         PyAeWTvBuJYbBY5krBp94I48ZcKQOTHZ7nhDNbIm/AMRYdGUq4wmmx25MT5HzzZ9uN8w
         QF5L63iRNdLSkykBcJqWRRh23KgLxVpSjuZsb+wU8YW5aZU/6yYs2XssuZvQxQZ/7sll
         LaZify8qrFM8fefR8Kq0sanU3pJvCLvsri9RRNdWrQt7i1yq877HE1wlWp3e859/MlTj
         po2Q==
X-Gm-Message-State: AJcUukcanW9faECOjZwj0RfjCr0wSB2dCd3vatHJ2xFCvVA3K4cSh+z9
        5TXMaqUFxIp/MMfczPmVUcICUopxpOw=
X-Google-Smtp-Source: ALg8bN7UkOuEhKcfHIYRHHPaGSVvxJfFeTnBD5a4KJZjEJZWS65swEoQhMrr3VA0Kw+7Y7AdEYijSA==
X-Received: by 2002:a1c:7fca:: with SMTP id a193mr15814801wmd.36.1548657886741;
        Sun, 27 Jan 2019 22:44:46 -0800 (PST)
Received: from localhost ([49.248.191.44])
        by smtp.gmail.com with ESMTPSA id 127sm131120424wmm.45.2019.01.27.22.44.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 22:44:46 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>, linux-pm@vger.kernel.org
Subject: [PATCH v4 3/9] cpufreq: qcom-hw: Register as a cpufreq cooling device
Date:   Mon, 28 Jan 2019 12:11:28 +0530
Message-Id: <65d7297bbf98fd525d3785f2e8eb5a412ffd3a6b.1548654899.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548654899.git.amit.kucheria@linaro.org>
References: <cover.1548654899.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548654899.git.amit.kucheria@linaro.org>
References: <cover.1548654899.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the CPUFREQ_AUTO_REGISTER_COOLING_DEV flag to allow the cpufreq core
to auto-register the driver as a cooling device.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index d83939a1b3d4..ed32849a3d40 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -231,7 +231,8 @@ static struct freq_attr *qcom_cpufreq_hw_attr[] = {
 
 static struct cpufreq_driver cpufreq_qcom_hw_driver = {
 	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
-			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
+			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
+			  CPUFREQ_AUTO_REGISTER_COOLING_DEV,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= qcom_cpufreq_hw_target_index,
 	.get		= qcom_cpufreq_hw_get,
-- 
2.17.1

