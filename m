Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C2FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A708F2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A708F2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbeIFAJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:09:39 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44632 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbeIFAJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:09:38 -0400
Received: by mail-oi0-f65.google.com with SMTP id l82-v6so15896617oih.11;
        Wed, 05 Sep 2018 12:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GgCElFhdjQyThXth4aH8s7Qmwk29mwNME1dnAGCxWmw=;
        b=HgVs64jow0hvpvmgicYmIMzRHhtfR74JrySKD05KW4MZXxN1URHw9cdLyWlfpn+95j
         QYOj1XRpz8FDEzjAew+sayRTJRpLkPMrU6oRuvn9t9U057yR0b8U2VkG5GJtTGmG8Lzr
         5R1JSLDPks6P1CDU+GibzdzS6JB5s9Nv8wHqBIVscA6mMH9n8Xi6/JFuzQSpevuK4htX
         U7xZeG/jxEBnH5ApJw2A+y3/K5u/yZyD3wCgvVBXZIops4qWb29krwN+kngiIBmfZgXx
         R7q6W/lez939kRMWQPKj9dM7y5F5IahfLsE80QmXA9LALd5+6cbAEeEt9yjt5iaYWl2j
         aP+Q==
X-Gm-Message-State: APzg51Af6OvC9+Dg9Qa9I+5E/wEiDB6qSVmjp4uNxv4wXOfNm9hTewzI
        8hMlrue7xK2QedoQXlEA8G9TFVc=
X-Google-Smtp-Source: ANB0VdaJ4lyns0aVhNeLdPoxbSHllUF+Gpbvzj+80JhE9l5Kw7PvApCPW7qgsJVEvHFF0G1m+kGUHw==
X-Received: by 2002:aca:3507:: with SMTP id c7-v6mr34041839oia.46.1536176279859;
        Wed, 05 Sep 2018 12:37:59 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u21-v6sm2296053oie.22.2018.09.05.12.37.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:37:59 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: [PATCH 17/21] clk: mvebu: use for_each_of_cpu_node iterator
Date:   Wed,  5 Sep 2018 14:37:34 -0500
Message-Id: <20180905193738.19325-18-robh@kernel.org>
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

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take via the DT tree. This is dependent on the
first 2 patches.

 drivers/clk/mvebu/clk-cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mvebu/clk-cpu.c b/drivers/clk/mvebu/clk-cpu.c
index 072aa38374ce..3045067448fb 100644
--- a/drivers/clk/mvebu/clk-cpu.c
+++ b/drivers/clk/mvebu/clk-cpu.c
@@ -183,7 +183,7 @@ static void __init of_cpu_clk_setup(struct device_node *node)
 		pr_warn("%s: pmu-dfs base register not set, dynamic frequency scaling not available\n",
 			__func__);

-	for_each_node_by_type(dn, "cpu")
+	for_each_of_cpu_node(dn)
 		ncpus++;

 	cpuclk = kcalloc(ncpus, sizeof(*cpuclk), GFP_KERNEL);
@@ -194,7 +194,7 @@ static void __init of_cpu_clk_setup(struct device_node *node)
 	if (WARN_ON(!clks))
 		goto clks_out;

-	for_each_node_by_type(dn, "cpu") {
+	for_each_of_cpu_node(dn) {
 		struct clk_init_data init;
 		struct clk *clk;
 		char *clk_name = kzalloc(5, GFP_KERNEL);
--
2.17.1
