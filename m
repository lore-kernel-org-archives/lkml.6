Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAA2C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E8A208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E8A208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbeH1FoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:44:22 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39807 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbeH1FoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:44:21 -0400
Received: by mail-oi0-f65.google.com with SMTP id c190-v6so15270oig.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 18:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uEBFqehdY54NE59d0C2vGmkFabPfL8kTAoMP2yEcUzA=;
        b=Pzd0TwTzK9DSppPqN/WrK81ofesUnFWkllpB56PsGnzQL4swkTRkLQmNbgY8y3W9mv
         VOUw945oKw7Uv4nDZksJQK0s9I+jhjx55hmVw+ljmyYarZS5VUO7trqnMqhv5xly+2FE
         iFNp8gHqRHLJso+3EIXhOPmTVhn3cSsHG5U9ZtFz7TgQ9B85ZqNZF/XfbDYtiiRjFRw2
         P33mpf7u9BMkZwd8UlfYFefD342j4pmNjZAKH4LxX4JVXk8tLMgGb0/5H9fRyAbIjkMR
         AHmguAtIow5av9uG6Au76dREILrZCtUvYXVsOGoapb5WyYWJgceGRIMLMUmjRtBltm3g
         10fQ==
X-Gm-Message-State: APzg51CIcGgGfGDinCI3a5o+mxHu5CXPhq/vyYtxeoaLUu/wui3t5l3P
        87/ELPR1uMNJUebIfgUEIVw/cWg=
X-Google-Smtp-Source: ANB0VdbjJoQ2/XEX3Cl6kR0VP7peeSptPtBkJamD491j9HX3pofcglyBr/PCEeOIWWReq1wixBgWpw==
X-Received: by 2002:aca:c74d:: with SMTP id x74-v6mr985625oif.97.1535421304958;
        Mon, 27 Aug 2018 18:55:04 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:55:04 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] perf: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:39 -0500
Message-Id: <20180828015252.28511-38-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/perf/arm_pmu_platform.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
index 96075cecb0ae..933bd8410fc2 100644
--- a/drivers/perf/arm_pmu_platform.c
+++ b/drivers/perf/arm_pmu_platform.c
@@ -77,14 +77,14 @@ static int pmu_parse_irq_affinity(struct device_node *node, int i)
 
 	dn = of_parse_phandle(node, "interrupt-affinity", i);
 	if (!dn) {
-		pr_warn("failed to parse interrupt-affinity[%d] for %s\n",
-			i, node->name);
+		pr_warn("failed to parse interrupt-affinity[%d] for %pOFn\n",
+			i, node);
 		return -EINVAL;
 	}
 
 	cpu = of_cpu_node_to_id(dn);
 	if (cpu < 0) {
-		pr_warn("failed to find logical CPU for %s\n", dn->name);
+		pr_warn("failed to find logical CPU for %pOFn\n", dn);
 		cpu = nr_cpu_ids;
 	}
 
-- 
2.17.1

