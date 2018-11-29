Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8138CC18DF5
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A91213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YO5P3hwG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A91213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbeK3Exp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:53:45 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44563 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730942AbeK3Exo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:53:44 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so2511555lji.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rtb7ncC0WwEMpjQCLG7tBribMPasaZ8gXOaK80cYa2Y=;
        b=YO5P3hwGz2f1/PGj8M6IIJCJ+iADNSFbLBsUFJh+FZ0WQVq2L2h0C6vPtpjcJudSN+
         6iWdepfrH5LRe2GaGEODv4e8urAWb5kwAA/Ub/lmuunyphoDeHrSFmg1i0l5N5P4tPyE
         QD54E4ThDFkrMQtqrBqXe0ymN4yniaZGb4Swc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rtb7ncC0WwEMpjQCLG7tBribMPasaZ8gXOaK80cYa2Y=;
        b=QnYjS6a88DOlBypi5H1ylWnzs5cIcim1mI1qdaRRykVsk0TmvETmKxD8cQ1VlwUdag
         MMy9Pf4Gn+Q3EEEKQY/332xHZ53EwMMKwZDFBq6sZXBMY2NkbgvS0vyOhsx5q+xdnfQJ
         wEjEXGGAmUZI61otE2ZvZA7MGMvdNhEtRWMJt3Yw1fgR/aNr5vZ2URrksNYEy2BRE7Bq
         jz7LyJjbguuzs847A6Nc+zhj3bwUOw3qo4ZRfxt4yauA9Zq+ZRhDAr9tKrpkPbWRTtwk
         oTK3kqyXUVDq5ohjH4atTmO6qQ+Luz/E3vSTkhVn93hDy5ahh/CEZbm0vPMizgoJs6ht
         1rSw==
X-Gm-Message-State: AA+aEWb8ZyahAZYSo/ODXdofd/eDxJ+GLC++8mgZwQb6LvMuP2/smnO9
        WVL9SvOx+IW+d8bYpJl6XPPvTA==
X-Google-Smtp-Source: AFSGD/VLjWAQoPNsfdrAeTLoSV15h4LBoJmHssLv9tcjNYnWxIaJytuQxOgS2zsBwJGIgj+JV0GVVQ==
X-Received: by 2002:a2e:131a:: with SMTP id 26-v6mr1850088ljt.107.1543513652968;
        Thu, 29 Nov 2018 09:47:32 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:47:32 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 14/27] drivers: firmware: psci: Simplify error path of psci_dt_init()
Date:   Thu, 29 Nov 2018 18:46:47 +0100
Message-Id: <20181129174700.16585-15-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
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

Changes in v10:
	- None.

---
 drivers/firmware/psci/psci.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 631e20720a22..6bfa47cbd174 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -609,9 +609,9 @@ static int __init psci_0_2_init(struct device_node *np)
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
@@ -619,11 +619,7 @@ static int __init psci_0_2_init(struct device_node *np)
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
@@ -635,9 +631,8 @@ static int __init psci_0_1_init(struct device_node *np)
 	int err;
 
 	err = get_set_conduit_method(np);
-
 	if (err)
-		goto out_put_node;
+		return err;
 
 	pr_info("Using PSCI v0.1 Function IDs from DT\n");
 
@@ -661,9 +656,7 @@ static int __init psci_0_1_init(struct device_node *np)
 		psci_ops.migrate = psci_migrate;
 	}
 
-out_put_node:
-	of_node_put(np);
-	return err;
+	return 0;
 }
 
 static const struct of_device_id psci_of_match[] __initconst = {
@@ -678,6 +671,7 @@ int __init psci_dt_init(void)
 	struct device_node *np;
 	const struct of_device_id *matched_np;
 	psci_initcall_t init_fn;
+	int ret;
 
 	np = of_find_matching_node_and_match(NULL, psci_of_match, &matched_np);
 
@@ -685,7 +679,10 @@ int __init psci_dt_init(void)
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

