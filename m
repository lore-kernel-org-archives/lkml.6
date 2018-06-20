Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A15C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89C7E20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cc4UVhff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C7E20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932972AbeFTRX0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:23:26 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41993 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932937AbeFTRXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:23:22 -0400
Received: by mail-lf0-f67.google.com with SMTP id z207-v6so458437lff.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A0wHhSMjy2YWUBymI+ELB3cg7YhnejdDuSmcctGS5h0=;
        b=Cc4UVhffJoYlqO+SbXv2kjA+4gpKKMPUH7+iUg1inol2Yd6GYumCkm6L9D0jffBF9g
         tId+4hG1pleNCzu5HlGkbCq6Z7yj6wdpXf2Fv4FuYgUNGv1mdzBpApn7ACORNAtB01sa
         h+4biO8cruT23jkl70yQj5Iby7nf+htjQvVeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A0wHhSMjy2YWUBymI+ELB3cg7YhnejdDuSmcctGS5h0=;
        b=a+ITyPtev576Uyy/EdFZTvgVHhBF6r50JkABBgDQBF4S/RHw5pJt3dzDvwd2HVorGP
         HQec6CaDOLqkadXhTa09feEOCEHm/agaJG4eGJV7YFu3oFYQjCXEleRi60cuPM7zEfC/
         g2FHYcEjsljeT4LI1CDQ6tkjAjrwFp36omrhagG5+xqVB+lBr3vQBCWJAjyw6VoGrBfI
         mKHy++ZwVvFOvjS96BJgNGCTHomscjgmsxEIJ0vSNr7ixZFCEe19p6Aew7T1Ozd9qiqc
         Vs+FNZpQ03VGQ2S7TDOoTEyhKjoUxPvDPN2HhPSpxBYv2q/sPNn3jdRmgeL+zvlCS3Pl
         yeiw==
X-Gm-Message-State: APt69E3+i6syW64tE2GIU99b0kLhvIJ8eDmDAcQxLdws0fxGMqDns45c
        bm8FzokHxYE7SgxXtWwHLsMJYpjQ/r4=
X-Google-Smtp-Source: ADUXVKKGrJcQbuFacYuCzcPcajO2mFMxaQ9jmU/ZoosHYpnzyrE0TthM05Jg6JQq6VHUdQj72V3vRQ==
X-Received: by 2002:a19:a78a:: with SMTP id q132-v6mr5269049lfe.126.1529515400950;
        Wed, 20 Jun 2018 10:23:20 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b2-v6sm514441lji.85.2018.06.20.10.23.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 10:23:20 -0700 (PDT)
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
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Subject: [PATCH v8 25/26] arm64: kernel: Respect the hierarchical CPU topology in DT for PSCI
Date:   Wed, 20 Jun 2018 19:22:25 +0200
Message-Id: <20180620172226.15012-26-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620172226.15012-1-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To let the PSCI driver to parse the CPU topology in DT, as to create CPU PM
domains in case the hierarchical layout is used, let's call
psci_dt_topology_init() from the existing topology_init() subsys_initcall.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm64/kernel/setup.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 30ad2f085d1f..574a5045f2f0 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -331,6 +331,9 @@ static int __init topology_init(void)
 {
 	int i;
 
+	if (acpi_disabled)
+		psci_dt_topology_init();
+
 	for_each_online_node(i)
 		register_one_node(i);
 
-- 
2.17.1

