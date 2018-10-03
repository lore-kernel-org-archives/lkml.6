Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63531C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26BC42089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HckMrUez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BC42089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbeJCV1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:27:40 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37576 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbeJCV1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:27:38 -0400
Received: by mail-lj1-f194.google.com with SMTP id 63-v6so5361821ljs.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 07:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3WUKn2dvevp+IRdH7T6aKSOygQUa+Gx75wLOTzgVKrQ=;
        b=HckMrUezE7fEmusY25qeIMXC09B5MKn2lggvEGrfhbXvyprgkkZsbk7mSbfl9OS+39
         PyEOZG79GlLGsAnHWfz2AlLsFCJdLxauI2i2sQj9/26x5rW7kQtlBpWOut+Ow7BI/pST
         hDY8lQaAmmvARDGOc0V/ih3wyyznRhC1IGRM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3WUKn2dvevp+IRdH7T6aKSOygQUa+Gx75wLOTzgVKrQ=;
        b=rutVvCkCBmcdPymDICE/EmaA4kkwd+AFIVrzqHnlOpLN2WQLV0edwG0EsxKyaq+goz
         iPfPIEAY6Yhsv1h67ET7algo0aq90yko3XQ0Do++kHJx/1lucc3rZO/2hYZnJAxJJXPc
         vCkbliEYQhHNg9HL1Z+1RyFai0b0raMpK15GI3+i/PjsPlWCOeHaZnVnFPCk5PbcgxDx
         Wtijf0khCj77MjhgrIeLYj3pgVZKqsTWs5z2NGq+IyoGrg1wVBOc5fyZOT6ev43ZAeYa
         uVQlVh0eedByU5KuobQtz2Hvu4VbAZLXmUM/2uSKu9tgRNLEpSRKm1zwivPeMeNA21/g
         ZDFg==
X-Gm-Message-State: ABuFfoiojHDAifn38XEcHFVzbKTA5Qtu0ICQfa2mlQ3YpXIOB6noPKiX
        T7s9p7hLQaNbp2zmxo4DoA8ijA==
X-Google-Smtp-Source: ACcGV62S/kE0nzS+/14hY0+pwMhcgKntySwtELjwoN11ELXKVw3eYUQRrI9eg/ZW2gbrfOGyyqP2qw==
X-Received: by 2002:a2e:86ca:: with SMTP id n10-v6mr1531860ljj.90.1538577536631;
        Wed, 03 Oct 2018 07:38:56 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id 18-v6sm380867ljo.74.2018.10.03.07.38.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 07:38:56 -0700 (PDT)
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
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v9 10/11] drivers: firmware: psci: Support hierarchical CPU idle states
Date:   Wed,  3 Oct 2018 16:38:23 +0200
Message-Id: <20181003143824.13059-11-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181003143824.13059-1-ulf.hansson@linaro.org>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <lina.iyer@linaro.org>

Currently CPU's idle states are represented in a flattened model, via the
"cpu-idle-states" binding from within the CPU's device nodes.

Support the hierarchical layout, simply by converting to calling the new OF
helper, of_get_cpu_state_node().

Cc: Lina Iyer <ilina@codeaurora.org>
Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/psci/psci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 9788bfc1cf8b..256b4edbb20a 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -294,8 +294,7 @@ static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 	struct device_node *state_node;
 
 	/* Count idle states */
-	while ((state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
-					      count))) {
+	while ((state_node = of_get_cpu_state_node(cpu_node, count))) {
 		count++;
 		of_node_put(state_node);
 	}
@@ -308,7 +307,7 @@ static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 		return -ENOMEM;
 
 	for (i = 0; i < count; i++) {
-		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
+		state_node = of_get_cpu_state_node(cpu_node, i);
 		ret = psci_dt_parse_state_node(state_node, &psci_states[i]);
 		of_node_put(state_node);
 
-- 
2.17.1

