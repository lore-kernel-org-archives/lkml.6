Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD37C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E2E42089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="H0bYXmMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E2E42089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeJCV1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:27:44 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42901 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeJCV1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:27:40 -0400
Received: by mail-lf1-f65.google.com with SMTP id s10-v6so4315582lfc.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 07:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TjQPuSPVMZIQ7LGnNwV9hx0MvmHHDvnmuj1+IqpIlaE=;
        b=H0bYXmMhr8euPxdBpNA9AnsaYn53qUB0wHQFSrgL4hE63SPaGSrM+bC/pMemM+dLTN
         py83DMk+1hfKAd+qyzkiu7hbKNlnKXbxAjm3A6CitXadRIugK3gAq3twnJdizU/V0oKe
         4Zecg7CXLZJ8Q7RDZXZR3GMnGDF/iygCBUGfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TjQPuSPVMZIQ7LGnNwV9hx0MvmHHDvnmuj1+IqpIlaE=;
        b=pHYk/i6n8+cdOR8TuwNJx2EiEYKjl9D3UVbnsVkZsWD7WEuvax8TJ6qsFasjG1Y9H8
         hqEkwglQ2jbJpi0IN7TcBkV4xf0/BBkjjvnOfsyfYJYdTHJzMW2baBkqd7VMEmFA4qEn
         5dtFkvmLV5rCiV0DGEIMByJ+1qHAQn3ZndPlO7s2VgtBTMruTconVJA9xNoku3PCH6rf
         qfchCWxTqr5wfn1H2t3LxiCtjVD4xYQDEX5CWmxr6/sOhPpkbuqmsjZgCZvfayF2E38c
         W1jmUfgq9X1TBXwqR9W7Oec5VcefmaMER5T1mSLMj/cqPtwOMSRa1RHBAXg1ujCbR+wa
         69ZQ==
X-Gm-Message-State: ABuFfogVNpcLKB3NKhYbWYbK+AR1c5LMEhQgTTSSrMORgWSZCuSdm9If
        5iOqlNrSPehPoeQNr9JVcx44eQ==
X-Google-Smtp-Source: ACcGV61f5JUyC6umbYRFx0mdAKGPXSoeFi5/0BwWrS2NmAnUsu6nhSdb24pQow20ow245IggCVsDLw==
X-Received: by 2002:a19:ca09:: with SMTP id a9-v6mr1159446lfg.149.1538577538176;
        Wed, 03 Oct 2018 07:38:58 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id 18-v6sm380867ljo.74.2018.10.03.07.38.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 07:38:57 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 11/11] drivers: firmware: psci: Simplify error path of psci_dt_init()
Date:   Wed,  3 Oct 2018 16:38:24 +0200
Message-Id: <20181003143824.13059-12-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181003143824.13059-1-ulf.hansson@linaro.org>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
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

