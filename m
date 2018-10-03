Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502DBC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B0672089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fx8drnSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B0672089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbeJCV1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:27:33 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35023 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbeJCV1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:27:31 -0400
Received: by mail-lj1-f193.google.com with SMTP id o14-v6so5374542ljj.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 07:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cS7yfKOveXJgyBYsXQ8YQO6oBGRBpzCQCXH8+3mFFEo=;
        b=fx8drnSOtxA3anI913lckFGxRqtRu9w78vmnWNXJmbewRUm68yE+tLRZwARZiLhlbp
         8s2PeeUM6AktExnm3R52LXidDskn4om25dn5FRc/BgLRDtDTAc6QkltsvqzkgyCSrEaP
         JRgkyom0mn8LCuWB9BTRe59/wnvMkVSCX+CA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cS7yfKOveXJgyBYsXQ8YQO6oBGRBpzCQCXH8+3mFFEo=;
        b=gao82WOsU+xlYszghh196YEAO6gS4Sn869KymZHwyDoiZ9vdadQmpRf7tamXBBoQKG
         58l+Boy+g2FTgI7pYgmjBFTHpguuNreAl//7eT3x1sSjoxQ8aOZLwvxtVdMwLjjqVicH
         lg+webXCO0lrxXQZ+hpeaCXAucs1oObtxUXnaw48foDv1OF0c1FnZxRrOF4tbwO9xZCE
         tX6NC3edwCzjQPCZcYbxPJFd3sTmZDLL/Tl9bUuVv6Hp/9gikwFcxwkvzXa3eedLUq6O
         EZ2AmhCifmjZDCZ7OfF160TGzuAVbooi2406jgOcp0+gAsYl3xA2m2Ust4ERXi0xdfMz
         8JnA==
X-Gm-Message-State: ABuFfoinhSnmXBTozTZHA6xSUM3lF0Dyaq9hp2qDoG+cngAeBHRfYSXs
        r3kmcCSIosoCgJfOssDrr7qA+A==
X-Google-Smtp-Source: ACcGV60jlY8/LrhTbGcUaUP2h57fyQo8XWU2VREO/R04Mmves3FRLEypNxsuTv3kNJxTH2FkfaaWHg==
X-Received: by 2002:a2e:6a19:: with SMTP id f25-v6mr1412659ljc.50.1538577528355;
        Wed, 03 Oct 2018 07:38:48 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id 18-v6sm380867ljo.74.2018.10.03.07.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 07:38:47 -0700 (PDT)
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
        devicetree@vger.kernel.org
Subject: [PATCH v9 05/11] of: base: Add of_get_cpu_state_node() to get idle states for a CPU node
Date:   Wed,  3 Oct 2018 16:38:18 +0200
Message-Id: <20181003143824.13059-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181003143824.13059-1-ulf.hansson@linaro.org>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU's idle state nodes are currently parsed at the common cpuidle DT
library, but also when initializing back-end data for the arch specific CPU
operations, as in the PSCI driver case.

To avoid open-coding, let's introduce of_get_cpu_state_node(), which takes
the device node for the CPU and the index to the requested idle state node,
as in-parameters. In case a corresponding idle state node is found, it
returns the node with the refcount incremented for it, else it returns
NULL.

Moreover, for ARM, there are two generic methods, to describe the CPU's
idle states, either via the flattened description through the
"cpu-idle-states" binding [1] or via the hierarchical layout, using the
"power-domains" and the "domain-idle-states" bindings [2]. Hence, let's
take both options into account.

[1]
Documentation/devicetree/bindings/arm/idle-states.txt
[2]
Documentation/devicetree/bindings/arm/psci.txt

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: Lina Iyer <ilina@codeaurora.org>
Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 drivers/of/base.c  | 35 +++++++++++++++++++++++++++++++++++
 include/linux/of.h |  8 ++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 74eaedd5b860..bf1d5fa34899 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -424,6 +424,41 @@ int of_cpu_node_to_id(struct device_node *cpu_node)
 }
 EXPORT_SYMBOL(of_cpu_node_to_id);
 
+/**
+ * of_get_cpu_state_node - Get CPU's idle state node at the given index
+ *
+ * @cpu_node: The device node for the CPU
+ * @index: The index in the list of the idle states
+ *
+ * Two generic methods can be used to describe a CPU's idle states, either via
+ * a flattened description through the "cpu-idle-states" binding or via the
+ * hierarchical layout, using the "power-domains" and the "domain-idle-states"
+ * bindings. This function check for both and returns the idle state node for
+ * the requested index.
+ *
+ * In case and idle state node is found at index, the refcount incremented for
+ * it, so call of_node_put() on it when done. Returns NULL if not found.
+ */
+struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
+					  int index)
+{
+	struct of_phandle_args args;
+	int err;
+
+	err = of_parse_phandle_with_args(cpu_node, "power-domains",
+					"#power-domain-cells", 0, &args);
+	if (!err) {
+		struct device_node *state_node =
+			of_parse_phandle(args.np, "domain-idle-states", index);
+
+		of_node_put(args.np);
+		return state_node;
+	}
+
+	return of_parse_phandle(cpu_node, "cpu-idle-states", index);
+}
+EXPORT_SYMBOL(of_get_cpu_state_node);
+
 /**
  * __of_device_is_compatible() - Check if the node matches given constraints
  * @device: pointer to node
diff --git a/include/linux/of.h b/include/linux/of.h
index 99b0ebf49632..42dae048674c 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -353,6 +353,8 @@ extern const void *of_get_property(const struct device_node *node,
 				const char *name,
 				int *lenp);
 extern struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);
+extern struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
+						 int index);
 #define for_each_property_of_node(dn, pp) \
 	for (pp = dn->properties; pp != NULL; pp = pp->next)
 
@@ -754,6 +756,12 @@ static inline struct device_node *of_get_cpu_node(int cpu,
 	return NULL;
 }
 
+static inline struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
+					int index)
+{
+	return NULL;
+}
+
 static inline int of_n_addr_cells(struct device_node *np)
 {
 	return 0;
-- 
2.17.1

