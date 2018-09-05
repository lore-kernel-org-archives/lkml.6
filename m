Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D29C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8992073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8992073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbeIFAJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:09:42 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42571 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbeIFAJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:09:41 -0400
Received: by mail-oi0-f65.google.com with SMTP id k81-v6so15916221oib.9;
        Wed, 05 Sep 2018 12:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XSLGQ9uqdAn4wTY6t09Z9k1WYMJrEeRcoehNp+zGb14=;
        b=qOnEtPzxHa9mvw8XvkK4/zDt5kveZn+IfJIBlXQS8AHq9iAx5Vx8pFQxSbNTSuviaE
         hsCQgW/fEWchWRYMJ3ATA/HW7xr5pOTfg7zojNYjmwvTtYaJXq4tOB3y43A6P+iBahQE
         npg8XR3W30eh5HzxgnStOaPrBskRpljUytEFLMSNZzYhQDXq9fYZ1hCeNEAXUp2FeZu0
         C9ZCMwRSDnj0VIHbXYafAfCka6r98TiZaph1IWcN6FTUoUbNr0S3628j1kYzmZ3vzTqO
         yAOP9Q/epiwiy/8O3tFlp5xdkZAsPNyyHpcTMKcM+o5cZNR2a5fyWtQdT4nKEt645ycI
         1Rhg==
X-Gm-Message-State: APzg51DPv/hSkJZ5XX+2Td1eRTFAU1sbm1OeS/uGf/gvY0anPXRhwjpH
        G6eyhOZZ/QTMclocbx4cwtaNQ+Y=
X-Google-Smtp-Source: ANB0VdYiQD0eFHyLkCrmfG6rZpnBOQQ3kc8tDuUOYJUUApy5qs81eyCPEqLuxHc/uGWVtrkqzxE+Fg==
X-Received: by 2002:aca:3fc2:: with SMTP id m185-v6mr31989616oia.240.1536176283327;
        Wed, 05 Sep 2018 12:38:03 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u21-v6sm2296053oie.22.2018.09.05.12.38.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:38:02 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH 20/21] of: use for_each_of_cpu_node iterator
Date:   Wed,  5 Sep 2018 14:37:37 -0500
Message-Id: <20180905193738.19325-21-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905193738.19325-1-robh@kernel.org>
References: <20180905193738.19325-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the for_each_of_cpu_node iterator to iterate over cpu nodes. This
has the side effect of defaulting to iterating using "cpu" node names in
preference to the deprecated (for FDT) device_type == "cpu".

Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take via the DT tree. This is dependent on the
first 2 patches.

 drivers/of/base.c    |  2 +-
 drivers/of/of_numa.c | 15 ++-------------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 6389aeb2f48c..8285c07cab44 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -389,7 +389,7 @@ struct device_node *of_get_cpu_node(int cpu, unsigned int *thread)
 {
 	struct device_node *cpun;

-	for_each_node_by_type(cpun, "cpu") {
+	for_each_of_cpu_node(cpun) {
 		if (arch_find_n_match_cpu_physical_id(cpun, cpu, thread))
 			return cpun;
 	}
diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
index 27d9b4bba535..f165fe28f49d 100644
--- a/drivers/of/of_numa.c
+++ b/drivers/of/of_numa.c
@@ -24,18 +24,9 @@ static void __init of_numa_parse_cpu_nodes(void)
 {
 	u32 nid;
 	int r;
-	struct device_node *cpus;
-	struct device_node *np = NULL;
-
-	cpus = of_find_node_by_path("/cpus");
-	if (!cpus)
-		return;
-
-	for_each_child_of_node(cpus, np) {
-		/* Skip things that are not CPUs */
-		if (of_node_cmp(np->type, "cpu") != 0)
-			continue;
+	struct device_node *np;

+	for_each_of_cpu_node(np) {
 		r = of_property_read_u32(np, "numa-node-id", &nid);
 		if (r)
 			continue;
@@ -46,8 +37,6 @@ static void __init of_numa_parse_cpu_nodes(void)
 		else
 			node_set(nid, numa_nodes_parsed);
 	}
-
-	of_node_put(cpus);
 }

 static int __init of_numa_parse_memory_nodes(void)
--
2.17.1
