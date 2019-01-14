Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062F6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB27820659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BeXpdXPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfANKVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:21:30 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39847 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfANKV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:21:27 -0500
Received: by mail-wm1-f65.google.com with SMTP id y8so8202360wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 02:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=CxA8ebFB4r9OLZ96bqgPVVsxsgvpcqnBcZSvktTXPrA=;
        b=BeXpdXPJWTOyjVfEKcnsuBOavIGy7gWpa7ZK+wmEiGluSGhnRKP5bxARIEJBza1dh7
         6h+HXqgf8LjTMw+8387u5M56b796rChvDvvHl7Gw96PhKYFnajv8VpE9Xre7z6pjeSZ0
         MGK+1bHBoivW1wC05g3MczWDHDCj8gSOdsvj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=CxA8ebFB4r9OLZ96bqgPVVsxsgvpcqnBcZSvktTXPrA=;
        b=hltpkrEJQtgPomiU63q2+v8znoUZQR26HitG6YZyabUW5UBlpxBn597OFmzKSGygEY
         MqvkZlptY51maXkfnF1b4I2cq5KI6vxQuiFlnTG3Uy7E1JYbReUJgVRxxm0KXhEd9Gqt
         yODW19QFa+yaLIYxnO8hJZ7QY0/OP6RXs8UUjxTgWsqkZaekgortL7vW+A4Bo3VvOj5N
         N0Z+vq/lZdsA7DmCgnvSxfX4ZyFAaQYWUwsrVZCU8DurtUBXCbqgNVRp2Q27gR/g2hY/
         qdoedB4XDdGABteixPswfdA/WoA/3HQiyF6bhUDSi1Q5BfxDHvpW+jZIoTVFVE8NSFOL
         K3bw==
X-Gm-Message-State: AJcUukcyTZnl02Ze7DEfao+uv6GQOiMpf3SklJCuvlqlvkGGCQC/0RZa
        pa64O7ZlRWocJSQfvTE0Jk7099IUWAE=
X-Google-Smtp-Source: ALg8bN4tZ1gdXoiZAfGmOsdJ0DEeokQS/vuwjwKn6VKlGSotSb246Hw43rTqz8tsZFkHibwqg3mliw==
X-Received: by 2002:a1c:ab87:: with SMTP id u129mr11368856wme.104.1547461285223;
        Mon, 14 Jan 2019 02:21:25 -0800 (PST)
Received: from localhost ([49.248.81.155])
        by smtp.gmail.com with ESMTPSA id d16sm56370701wru.52.2019.01.14.02.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 02:21:24 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org,
        dianders@chromium.org, mka@chromium.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY DRIVERS)
Subject: [PATCH v2 1/9] [ALREADY QUEUED] cpufreq: qcom-hw: Move to device_initcall
Date:   Mon, 14 Jan 2019 15:51:03 +0530
Message-Id: <2ae45b9263f51a14a7f672f40da2193caf174971.1547458732.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Resent to allow people testing the series to test it easily)

subsys_initcall causes problems registering the driver as a thermal
cooling device.

If "faster boot" is the main reason for doing subsys_initcall, this
should be handled in the bootloader or another boot constraint
framework.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index d83939a1b3d4..649dddd72749 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -296,7 +296,7 @@ static int __init qcom_cpufreq_hw_init(void)
 {
 	return platform_driver_register(&qcom_cpufreq_hw_driver);
 }
-subsys_initcall(qcom_cpufreq_hw_init);
+device_initcall(qcom_cpufreq_hw_init);
 
 static void __exit qcom_cpufreq_hw_exit(void)
 {
-- 
2.17.1

