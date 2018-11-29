Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760A5C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3850F213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oq4RLwG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3850F213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731189AbeK3EyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:54:07 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37962 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731113AbeK3EyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:54:05 -0500
Received: by mail-lf1-f65.google.com with SMTP id p86so2108132lfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=creKAO5CsDdP5/fdWi07H8cJaJAAKbloLoHhussbOK8=;
        b=Oq4RLwG9RC6q2KpDvl5rQwPShMgDUxq9Bcao8uuCY9Q4AUGv2qJ6j4CCs4QQpzURNm
         TPpTC3Cm6RmvLVIsxY6SlVz5CJCcQKq09+p++pgz9zsmI8exx5qUyut7Q3F4AYFnUW5Q
         CrFgG6cAu86X9HxVLNMns/Wgs98w0VXiRfNds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=creKAO5CsDdP5/fdWi07H8cJaJAAKbloLoHhussbOK8=;
        b=RzrecE2uskVhJFbgGBeIbXmRyTXZHxi52Rfo/KFlxQB60s6/hRVYhrmvvYORWyiHDg
         GKuLq6CwHi8ym/4eNk8CvAmxQs/mhhgwvUkn/xMQZ9mDLenfWIUZQRX8s+Z8l31G8PJM
         dNymd0WKfVJEnUQSPVww3SV4vx9wn/xtKo9L+njKDPmFP1PaJTzrmTd1g4SJYyvCRPg3
         k44q2MacUpkFiCmiLokI+WVK9qv+HSWzzJsMBvga8sfec2WLZdMV9awVl1QcKX5+/2j0
         jrPHSI0WP0Ews9lztN9GC2kuK5DNYedjBe8x60oKx82cPSeXhiH1QdLkGNI1LS2LumLg
         dy9g==
X-Gm-Message-State: AA+aEWYWFAMKE9VZEraglRbkHxxuaf6BFNZt+8THA/BOg+kb04gXa4yx
        bKss/NmaIOofjYGbbc3SsQTVPQ==
X-Google-Smtp-Source: AFSGD/XXZec1/y3UQsrlSnc/06AM5EYbLIVlOfcxbfHPLR90+FhEc7xHuwtxbcuBhvmXGgdvSxh8tw==
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr1724953lfc.124.1543513673516;
        Thu, 29 Nov 2018 09:47:53 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:47:52 -0800 (PST)
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
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v10 25/27] arm64: kernel: Respect the hierarchical CPU topology in DT for PSCI
Date:   Thu, 29 Nov 2018 18:46:58 +0100
Message-Id: <20181129174700.16585-26-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To let the PSCI driver parse for the hierarchical CPU topology in DT and
thus potentially initiate the corresponding PM domain data structures,
let's call psci_dt_topology_init() from the existing topology_init()
subsys_initcall.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- None.

---
 arch/arm64/kernel/setup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index f4fc1e0544b7..4d59a72f8b0b 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -364,6 +364,9 @@ static int __init topology_init(void)
 {
 	int i;
 
+	if (acpi_disabled)
+		psci_dt_topology_init();
+
 	for_each_online_node(i)
 		register_one_node(i);
 
-- 
2.17.1

