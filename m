Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE07C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FA420836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FperrAB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81FA420836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932739AbeFTRXN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:23:13 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34234 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754591AbeFTRXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:23:07 -0400
Received: by mail-lf0-f65.google.com with SMTP id e13-v6so504133lfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TjQPuSPVMZIQ7LGnNwV9hx0MvmHHDvnmuj1+IqpIlaE=;
        b=FperrAB5E7YDSjYoP6q0jhEs2Ox1HY0CxDVeDxyDEatvk5EZ/4z2r8mMTpWW2c/L4s
         gkPJqTo9YiUfQY1rNcGhu8tbZfXXmVL7mgsOkFqSiSEH03eiQBsLjeQ4zNQ7OebEbRfa
         U+dUGEMYyssb5EltEDwG3oNn2SDVaeN8eJijM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TjQPuSPVMZIQ7LGnNwV9hx0MvmHHDvnmuj1+IqpIlaE=;
        b=K8JoltLLdiKfV+2GkYeEI9RDfepEOxFJ3+srxzayJZ91favZJCf1pGU3pAB101wzV/
         V19kF0Zi+M8OXX+PrNP6VfNbtz5TM+ZAXE3J8LLRpLNhXvNMOmdOlLxfdINroBMruZNn
         9AKLuXANAzABHNpsS0Ojw6l7N7lrXHdEWXqdDE85oi3xAuAw8FZvShsWy2PSU1Pwftxs
         31/cR11FgoPLRcL+B02HuRzNvWPpj7u+NR5LP+Jc8jbMZh2g2DVuIKXxyh3W/A4Jo+cf
         7lXNyF9YTPfH6QLO1jvuyNKdTxUlaX8peiU0vJ76c9rxdkeJRqzlU4kGmUKRCtNsn/TV
         5q0g==
X-Gm-Message-State: APt69E1Gz7k/5vMTmu+e/8Ay7c02Vyzjhm7qMggPT011UrEdpK/thwcN
        LPdLf+/mdWA7EHffe9B38Je/Og==
X-Google-Smtp-Source: ADUXVKLqDwiJhzmBIyfbizy0XbX1XsRN+liNcsyiQfmTjx25S14cNOUZ4NdRtHhfg2gbblf3geySsg==
X-Received: by 2002:a2e:9ac4:: with SMTP id p4-v6mr14792545ljj.60.1529515386233;
        Wed, 20 Jun 2018 10:23:06 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b2-v6sm514441lji.85.2018.06.20.10.23.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 10:23:05 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc:     Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 17/26] drivers: firmware: psci: Simplify error path of psci_dt_init()
Date:   Wed, 20 Jun 2018 19:22:17 +0200
Message-Id: <20180620172226.15012-18-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620172226.15012-1-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having each psci init function taking care of the of_node_put(),
let's deal with that from psci_dt_init(), as this enables a bit simpler
error path for each psci init function.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 drivers/firmware/psci/psci.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 256b4edbb20a..38881007584e 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -608,9 +608,9 @@ static int __init psci_0_2_init(struct device_node *np)
 	int err;
 
 	err = get_set_conduit_method(np);
-
 	if (err)
-		goto out_put_node;
+		return err;
+
 	/*
 	 * Starting with v0.2, the PSCI specification introduced a call
 	 * (PSCI_VERSION) that allows probing the firmware version, so
@@ -618,11 +618,7 @@ static int __init psci_0_2_init(struct device_node *np)
 	 * can be carried out according to the specific version reported
 	 * by firmware
 	 */
-	err = psci_probe();
-
-out_put_node:
-	of_node_put(np);
-	return err;
+	return psci_probe();
 }
 
 /*
@@ -634,9 +630,8 @@ static int __init psci_0_1_init(struct device_node *np)
 	int err;
 
 	err = get_set_conduit_method(np);
-
 	if (err)
-		goto out_put_node;
+		return err;
 
 	pr_info("Using PSCI v0.1 Function IDs from DT\n");
 
@@ -660,9 +655,7 @@ static int __init psci_0_1_init(struct device_node *np)
 		psci_ops.migrate = psci_migrate;
 	}
 
-out_put_node:
-	of_node_put(np);
-	return err;
+	return 0;
 }
 
 static const struct of_device_id psci_of_match[] __initconst = {
@@ -677,6 +670,7 @@ int __init psci_dt_init(void)
 	struct device_node *np;
 	const struct of_device_id *matched_np;
 	psci_initcall_t init_fn;
+	int ret;
 
 	np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
 
@@ -684,7 +678,10 @@ int __init psci_dt_init(void)
 		return -ENODEV;
 
 	init_fn = (psci_initcall_t)matched_np->data;
-	return init_fn(np);
+	ret = init_fn(np);
+
+	of_node_put(np);
+	return ret;
 }
 
 #ifdef CONFIG_ACPI
-- 
2.17.1

