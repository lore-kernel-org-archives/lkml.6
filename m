Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E0BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6B0206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g+/TUjSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfANQiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:38:02 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54121 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfANQiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:38:01 -0500
Received: by mail-wm1-f65.google.com with SMTP id d15so218200wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 08:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=7AsIbPWyaNVpnciz+rQGAz2HaZ4096BUiIF8+8SbLYU=;
        b=g+/TUjSI97oiEjeIAmXF0JOOEHIisT++1kgUNslcEzl+MXsAQdUqxZKToZSh9xvLT+
         iwBJdUjokPH/r7hq48KAtOiDzOwaPn5OaebqLJo/VGGED1wgBbNvOJDq3EaISIT5YGCZ
         mtgK3e6zdpjv0JzgJoAk//OZxJ+4rH7OVZ6Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=7AsIbPWyaNVpnciz+rQGAz2HaZ4096BUiIF8+8SbLYU=;
        b=WZyO9O16YU6EZ/+gA86Qi60arBtSzpqQq+D0ADbFnyxNAS0/25K06RlLjAa2Nw7EU1
         bzz8n75XqT/58/DdYtbm/EviFbM+8UdrF6QB6m4aI3dVQF4EjYgLxqqP3Fznyqp4x0PL
         7lAeafp4SZrz+/X92M5oK9VYkJ2QTx2idlIo4+LXDlYl0TBX/eT6act2NXiP0XdJe2bN
         d+eZGyoeRWdscHPHkQ+PNKCPfpSfa3GN/h5gtbDIFtZOtZMIW0LQuxTTFE6myQreSFLp
         Yo0XM2vyKQ/PfPJjFIW/WCse4tigQqfB+/XLwyKUx1EPx3Ch15+aV2rrBjATlYEeEPuW
         zdfg==
X-Gm-Message-State: AJcUukdaK3AdWVC8LtXIikct9LQ3iFPZJuV1/0yNjxTVCk1KXu30wBEE
        BD+GeQsMTi3ovLQDm5xKItxDHbMrzJj4Hg==
X-Google-Smtp-Source: ALg8bN4YbrE2x0B5oCkMYfElty4fq9P7zjJAiafghkgojy/xwKBX+KrIZk8zipUnYQKLxT56fwYf6w==
X-Received: by 2002:a7b:c397:: with SMTP id s23mr2889239wmj.127.1547483879688;
        Mon, 14 Jan 2019 08:37:59 -0800 (PST)
Received: from localhost ([49.248.190.171])
        by smtp.gmail.com with ESMTPSA id o82sm26171257wmo.29.2019.01.14.08.37.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 08:37:59 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 04/10] cpufreq: qcom-hw: Register as a cpufreq cooling device
Date:   Mon, 14 Jan 2019 22:04:56 +0530
Message-Id: <bd172905b0208b958f8c4f239b55ac3e345c60a8.1547481320.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547481320.git.amit.kucheria@linaro.org>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547481320.git.amit.kucheria@linaro.org>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the CPUFREQ_AUTO_REGISTER_COOLING_DEV flag to allow the cpufreq core
to auto-register the driver as a cooling device.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
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

