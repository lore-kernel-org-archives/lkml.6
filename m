Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8A0C2F43D
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E6D20870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MSRTlrDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbfAUPoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:44:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46690 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbfAUPn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:43:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so23845168wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 07:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=zLqXF7SYoovkgBMNm7MtzJSzeE0VgZYQlKefNmrl8Go=;
        b=MSRTlrDVky4wuhprrrQEcgS4g/A7iauwDUwHh2yTA2fvbfncJR+0YY/bCyhOfDD81i
         6p2yhk24s9j+HJy0rPQkvX64Ac3b6OQfUFJh17Tm5vC8fLjAzF7EbNmAgGVNYikIV3At
         Pu8omYSPt/6n+u5VdPnEwpyp1tJ82t5ApivNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=zLqXF7SYoovkgBMNm7MtzJSzeE0VgZYQlKefNmrl8Go=;
        b=aelsO/l0sZL3dJj1kyEDzdZxvEoAk0ALzInf5Tv9J1WPMKLbPLNu6u6whX8Z7nNjyX
         Y62UNB7nGCgXqZa7n8ZNKjkvuQUr/82li72G3u5Gzmm+/LPyqX/MmIJWPVroEFMj78bp
         eNjHvWaE3CNSZUF9UbvcQKYaGVBpH5S6tgiNqe7HHAQWu7eCohehZ8VndVBvkGKPEAsi
         jJPec/DCJLOmoZdPEVWOJV6RLi1UyTrueG0sy8p1VFSi/t7xmwGyI7j2lE17qO70tNuu
         Q0m3MtZDMg3Wgw8cKLxEm9nmwj1nFG3h+Vwckz4L0rfZd/4K9jXYrExu786qBHph4ipQ
         HqgA==
X-Gm-Message-State: AJcUukewqmAXhYCNIBKvSZyQ+qmP08/pgzbJX5mATWwMGKo/kN87NEkj
        Y3tgfz/7gD5XVzCNpbi5Y9dQXASBws8=
X-Google-Smtp-Source: ALg8bN5zAnBdL5TmzSZ2NvPz/DwHhSMsJ3KB4Wos2akC0XgB2nSJu5MpqunIo7v/urDtHdzsv9xh4A==
X-Received: by 2002:adf:d089:: with SMTP id y9mr29250380wrh.22.1548085437537;
        Mon, 21 Jan 2019 07:43:57 -0800 (PST)
Received: from localhost ([49.248.61.1])
        by smtp.gmail.com with ESMTPSA id j24sm116519156wrd.86.2019.01.21.07.43.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 07:43:57 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>, linux-pm@vger.kernel.org
Subject: [PATCH v2 3/9] cpufreq: qcom-hw: Register as a cpufreq cooling device
Date:   Mon, 21 Jan 2019 21:10:28 +0530
Message-Id: <fd3e8a6a08968779307bd9b44b1c8ebf9eac652f.1548084260.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548084260.git.amit.kucheria@linaro.org>
References: <cover.1548084260.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548084260.git.amit.kucheria@linaro.org>
References: <cover.1548084260.git.amit.kucheria@linaro.org>
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

