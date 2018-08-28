Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B1CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E55208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E55208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbeH1FnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:43:09 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45034 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbeH1FmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:42:23 -0400
Received: by mail-oi0-f67.google.com with SMTP id l82-v6so1707053oih.11;
        Mon, 27 Aug 2018 18:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N5bgoqfM5UiblPUohKxewB3I7xGYDLNRVmBHYWF2U/E=;
        b=WAfUDA4VWMXGFcL3up1tFmRl7UjWYZ2bAMYeFXkpwaOLc1Qh8j0FbRnAQIAL5NAfEY
         v5wkWHQZh17AbFe4vWCzpzYwxcssXO+04YsvB8X5Uc5jB7ObLWUGy2hd69qTZeQAKHgv
         eCWgR4JeDuuMhJbA5qQZq/wII0NF8LiG8UDUoZUVI2xWcxjCCzMmbIs4WpCf5xQNH5di
         LjB7ypYk2hIGpUhqBR2di4pis4yr4x0YMmAjEWF17lqrMt05H5tKgiVYJ5fIAD7X/Kxg
         599s7SI8ygUGikNUSahk11EMmuYNTsmYKsFDIFqXuK4NuAWYfbn1kgktDUdOJdF3bDSO
         ouAw==
X-Gm-Message-State: APzg51BrXLAWBM+Fvoblkb8hfxyAB9JtJOz1am1yOVkwQXPRia01B4EN
        olGZqk7Cp9HchvmpY+KBG9pnRTo=
X-Google-Smtp-Source: ANB0VdZTD7AmWtgOFatgXeQB0z+2z7dWWXDZr6UoVlgR9vtj2H2l87rlr03HbjbiT+Uzzfp49dPHsQ==
X-Received: by 2002:aca:cc90:: with SMTP id c138-v6mr1152461oig.282.1535421187683;
        Mon, 27 Aug 2018 18:53:07 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:53:07 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH] cpufreq: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:15 -0500
Message-Id: <20180828015252.28511-14-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/cpufreq/s5pv210-cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 5d31c2db12a3..dbecd7667db2 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -611,8 +611,8 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 	for_each_compatible_node(np, NULL, "samsung,s5pv210-dmc") {
 		id = of_alias_get_id(np, "dmc");
 		if (id < 0 || id >= ARRAY_SIZE(dmc_base)) {
-			pr_err("%s: failed to get alias of dmc node '%s'\n",
-				__func__, np->name);
+			pr_err("%s: failed to get alias of dmc node '%pOFn'\n",
+				__func__, np);
 			of_node_put(np);
 			return id;
 		}
-- 
2.17.1

