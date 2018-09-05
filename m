Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FACC04E82
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C399B20645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 19:37:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C399B20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbeIFAJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 20:09:25 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44585 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbeIFAJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 20:09:23 -0400
Received: by mail-oi0-f65.google.com with SMTP id l82-v6so15895166oih.11;
        Wed, 05 Sep 2018 12:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2baCbrjxYhnRd701tIbNh2fl7IulRiMGM3GGiuSaTNc=;
        b=J5ggoyifVIgVvgVglbiLUdYUSZgJ32qMGemCKojnnW7zOYhV0NDp3As36wQqXqtcrL
         51WNDLiUPfClODvVLdBu1Iq7NlgVSi22PmKoeX2MXSrz8f8hsTnSmzd70W2BlomsPbNZ
         suJDJppZX8q+n2XXAmdv8r89v6D8OhJiZpFloEoGaSYqOxliQBglvcVsyqe6N+2018Mm
         Xw8dzLMHf2HYVyMLGVa7WfVWTw/dQfva27Q/f35pZYqLr+jLcK+4IXM7DD+YcOcrgtPh
         a3vnwoMvigcUa+SwwXAEnuwQrkbEYwW6/P6NyulxjlEojcLVkONePte2nT4zo3Gpu3Jv
         7Ekg==
X-Gm-Message-State: APzg51BCRtWoq9nQVLBHcjpea67CHVmU6SP4IKDmvfHfrL2LMEsaAROT
        5DFdNr/WEXzXu7uvQdJnfhK5WOk=
X-Google-Smtp-Source: ANB0VdaYLb3WFrtY/wTjAzRAx9Ta7do3t62HQFaJ67zjSvxB8otEo4PQwwzD86MjGzmLy6vOdkd/Qw==
X-Received: by 2002:aca:44c5:: with SMTP id r188-v6mr32621954oia.280.1536176265556;
        Wed, 05 Sep 2018 12:37:45 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u21-v6sm2296053oie.22.2018.09.05.12.37.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:37:45 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 05/21] ARM: shmobile: use for_each_of_cpu_node iterator
Date:   Wed,  5 Sep 2018 14:37:22 -0500
Message-Id: <20180905193738.19325-6-robh@kernel.org>
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

Cc: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-renesas-soc@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack and I will take via the DT tree. This is dependent on the
first 2 patches.

 arch/arm/mach-shmobile/pm-rcar-gen2.c |  8 ++------
 arch/arm/mach-shmobile/pm-rmobile.c   |  2 +-
 arch/arm/mach-shmobile/timer.c        | 10 ++--------
 3 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-shmobile/pm-rcar-gen2.c b/arch/arm/mach-shmobile/pm-rcar-gen2.c
index 345af3ebcc3a..7efe95bd584f 100644
--- a/arch/arm/mach-shmobile/pm-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/pm-rcar-gen2.c
@@ -50,7 +50,7 @@ void __init rcar_gen2_pm_init(void)
 	void __iomem *p;
 	u32 bar;
 	static int once;
-	struct device_node *np, *cpus;
+	struct device_node *np;
 	bool has_a7 = false;
 	bool has_a15 = false;
 	struct resource res;
@@ -59,11 +59,7 @@ void __init rcar_gen2_pm_init(void)
 	if (once++)
 		return;

-	cpus = of_find_node_by_path("/cpus");
-	if (!cpus)
-		return;
-
-	for_each_child_of_node(cpus, np) {
+	for_each_of_cpu_node(np) {
 		if (of_device_is_compatible(np, "arm,cortex-a15"))
 			has_a15 = true;
 		else if (of_device_is_compatible(np, "arm,cortex-a7"))
diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
index e348bcfe389d..94fdeef11b81 100644
--- a/arch/arm/mach-shmobile/pm-rmobile.c
+++ b/arch/arm/mach-shmobile/pm-rmobile.c
@@ -202,7 +202,7 @@ static void __init get_special_pds(void)
 	const struct of_device_id *id;

 	/* PM domains containing CPUs */
-	for_each_node_by_type(np, "cpu")
+	for_each_of_cpu_node(np)
 		add_special_pd(np, PD_CPU);

 	/* PM domain containing console */
diff --git a/arch/arm/mach-shmobile/timer.c b/arch/arm/mach-shmobile/timer.c
index 828e8aea037e..e48b0939693f 100644
--- a/arch/arm/mach-shmobile/timer.c
+++ b/arch/arm/mach-shmobile/timer.c
@@ -22,22 +22,16 @@

 void __init shmobile_init_delay(void)
 {
-	struct device_node *np, *cpus;
+	struct device_node *np;
 	u32 max_freq = 0;

-	cpus = of_find_node_by_path("/cpus");
-	if (!cpus)
-		return;
-
-	for_each_child_of_node(cpus, np) {
+	for_each_of_cpu_node(np) {
 		u32 freq;

 		if (!of_property_read_u32(np, "clock-frequency", &freq))
 			max_freq = max(max_freq, freq);
 	}

-	of_node_put(cpus);
-
 	if (!max_freq)
 		return;

--
2.17.1
