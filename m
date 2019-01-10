Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23199C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E0F214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 00:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ia7IWyfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfAJABb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 19:01:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45321 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfAJABa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 19:01:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id t6so9396116wrr.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=P7E60/i5ULtskb0FXpBa3pMJQ03Hyuz/IlsstPzfUWk=;
        b=ia7IWyfCDRdmDLeuNpTKKt21edaajbCK3gTFT9kPHWL2oBsKN3rGtPxu5FFRJ5iSOV
         SostMS/8BVK/Jwec7CKqPMZfwtyhFhlGYJK1/LpV97MK9FqwRTZrm+jH3nJ0s+Y18Tiq
         xKr6xQ55LWwp/m909YLtwEiQ9CnM1OFiGv1z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=P7E60/i5ULtskb0FXpBa3pMJQ03Hyuz/IlsstPzfUWk=;
        b=HeDvT5F75XQPkhfq937SNfoMXqm6Y3SAOwEqmUcsEak2vG3ivPGxcs+BYvNaMKpt5B
         FuTLnf7k/TD+XBqR+8fxHlWnJC96ROe6EAjfKmbK0No2BQUsn/p6XFS+XpsRp1bZJtLP
         us2pB4HSetszDuRMVmNOtO0mbt6WvgTpAOKTbKcorrURvajADSQwJtZiyJxV9V7/mzS+
         0Oa08cuIRsz+gpk4ksSjmOcFGOL4tnQa5BCTPJVQQAa7oy5mr1ZETUWLUIViidCtr3RC
         5LttQqn6cnk6UkEV7I1n71ZRomunToMj0MYGl1Hj4iQKVSEmloCVRLmL+ZDkWnqSqab4
         OIdQ==
X-Gm-Message-State: AJcUuke9ccd9EXix9Q1NivKnRWdCjj3wvdx8tYKmpLb5T7HOM2snx3gj
        po/5lsWuTbfJuiT/eUV4UMoXd2Szx0Y=
X-Google-Smtp-Source: ALg8bN6ZMiImywRfuJp01iQVtD6mjcN6mRBKUTF+EotIU+LfMBT2QbHOTMaozv0r3ZyyVeuQnRwwzg==
X-Received: by 2002:adf:f211:: with SMTP id p17mr6789810wro.293.1547078488517;
        Wed, 09 Jan 2019 16:01:28 -0800 (PST)
Received: from localhost ([49.248.171.190])
        by smtp.gmail.com with ESMTPSA id l20sm123599881wrb.93.2019.01.09.16.01.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 16:01:28 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org,
        dianders@chromium.org, mka@chromium.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY DRIVERS)
Subject: [PATCH v1 4/7] cpufreq: qcom-hw: Move to device_initcall
Date:   Thu, 10 Jan 2019 05:30:53 +0530
Message-Id: <f62562bb1f8ffc021a814707e0c74a91d5d0746f.1547078153.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547078153.git.amit.kucheria@linaro.org>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547078153.git.amit.kucheria@linaro.org>
References: <cover.1547078153.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

