Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F74C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF4F20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="U8pYcg45"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF4F20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932838AbeFTRXS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:23:18 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:46819 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932691AbeFTRXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:23:13 -0400
Received: by mail-lf0-f65.google.com with SMTP id u5-v6so438743lff.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cV7qOWslovasm3reIVu1jS3ltOLzaMhL00jKgYh6Nhw=;
        b=U8pYcg45t8FOmO1McVT3H9JZ/G4uT7s9zkL4ps+KG/97JI/6Ql0hgjW9pAV01OKjUi
         lyeaNcYRIuTt8+8veRE0Bzw6OJ9lpOrym7fbVoRr6D+0rpM6K+6snow/l8smcLBEdb5h
         uXLrPEAmJMZ8jeGhQipkGtVEEJwGc4BPpQO+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cV7qOWslovasm3reIVu1jS3ltOLzaMhL00jKgYh6Nhw=;
        b=rIHALvBY0XYzm94zl8uEgLXMssse/m+EiMvse6k2OgX2FP564Oy7zOzyDgLKTLF61D
         wFX3KXcfxjpWptOCn/vFDQ40hbSIDOFhk2B+/bSKlgCjxJOqf5HCRC+o/u5QNPFZ5Wsm
         Oma4rNhFLKchGcqBPugASCBJ4bdRm/1r6PuVH0ec/zVxIpAVjMbXQGrntgUeRjRaGHln
         UaQmhuy+XOCzy8TEYlcYdPeByj3rmKbg3zztRZLpatiXpcUVAuBWT3wAhKK70DcDw/ik
         /STNkMWrRQTi+iIFo+giniLknZhCs9VNAL1YkNy2dXWNy5QTQyHp3uW0o4bgGl0oTyTI
         dfTg==
X-Gm-Message-State: APt69E1GRj27a61QQzFpkFbopQsEP+Xkfa98eycvUogDP+nuaEHDt4zr
        ysllds2XYkRhn33FDp0edqbU9QqgR/I=
X-Google-Smtp-Source: ADUXVKJJVNGM+2m2TzrlaYwXiNDTFLn50Pzw7JzQr2AX+vT+UeroiBIEV4hh+8y1pNT5a7XW22BNMQ==
X-Received: by 2002:a2e:5d5d:: with SMTP id r90-v6mr14518777ljb.125.1529515391711;
        Wed, 20 Jun 2018 10:23:11 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b2-v6sm514441lji.85.2018.06.20.10.23.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 10:23:11 -0700 (PDT)
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
Subject: [PATCH v8 20/26] drivers: firmware: psci: Share a few internal PSCI functions
Date:   Wed, 20 Jun 2018 19:22:20 +0200
Message-Id: <20180620172226.15012-21-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620172226.15012-1-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following changes needs to be able to call psci_get|set_domain_state() and
psci_dt_parse_state_node(), but from a separate file. Let's make that
possible by sharing them via a new internal PSCI header file.

Cc: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/psci/psci.c | 14 ++++++++------
 drivers/firmware/psci/psci.h | 13 +++++++++++++
 2 files changed, 21 insertions(+), 6 deletions(-)
 create mode 100644 drivers/firmware/psci/psci.h

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 40b2b8945018..463f78cda3be 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -34,6 +34,8 @@
 #include <asm/smp_plat.h>
 #include <asm/suspend.h>
 
+#include "psci.h"
+
 /*
  * While a 64-bit OS can make calls with SMC32 calling conventions, for some
  * calls it is necessary to use SMC64 to pass or return 64-bit values.
@@ -90,12 +92,12 @@ static u32 psci_function_id[PSCI_FN_MAX];
 static DEFINE_PER_CPU(u32, domain_state);
 static u32 psci_cpu_suspend_feature;
 
-static inline u32 psci_get_domain_state(void)
+u32 psci_get_domain_state(void)
 {
 	return this_cpu_read(domain_state);
 }
 
-static inline void psci_set_domain_state(u32 state)
+void psci_set_domain_state(u32 state)
 {
 	this_cpu_write(domain_state, state);
 }
@@ -285,10 +287,7 @@ static int __init psci_features(u32 psci_func_id)
 			      psci_func_id, 0, 0);
 }
 
-#ifdef CONFIG_CPU_IDLE
-static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
-
-static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
+int psci_dt_parse_state_node(struct device_node *np, u32 *state)
 {
 	int err = of_property_read_u32(np, "arm,psci-suspend-param", state);
 
@@ -305,6 +304,9 @@ static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
 	return 0;
 }
 
+#ifdef CONFIG_CPU_IDLE
+static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
+
 static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 {
 	int i, ret = 0, count = 0;
diff --git a/drivers/firmware/psci/psci.h b/drivers/firmware/psci/psci.h
new file mode 100644
index 000000000000..dc7b596daa2b
--- /dev/null
+++ b/drivers/firmware/psci/psci.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __PSCI_H
+#define __PSCI_H
+
+struct device_node;
+
+u32 psci_get_domain_state(void);
+void psci_set_domain_state(u32 state);
+
+int psci_dt_parse_state_node(struct device_node *np, u32 *state);
+
+#endif /* __PSCI_H */
-- 
2.17.1

