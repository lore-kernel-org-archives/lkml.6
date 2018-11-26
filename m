Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC345C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688F92082F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 08:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QBCZRsM7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 688F92082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbeKZTDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 14:03:44 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46555 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeKZTDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 14:03:43 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so5782323pgp.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 00:10:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O17aol/D58byrR6YndIqp0QVKFatgqkI1jJsfGYUpvQ=;
        b=QBCZRsM7c0CDjL3a9IctQ5rWPCRNCCbAVwe7Q598+yA7zTaLJXtfjMZDulL89g6L9u
         twpaP3O0Xu8Ptyyos4mtiC8O9mZULhZEnTOXnZQPL16B9unMLt18nFsp2wbmKI0DorGu
         daYMKbV+82VJSiKwmk0vEsC3VeN5n8fVqnXGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O17aol/D58byrR6YndIqp0QVKFatgqkI1jJsfGYUpvQ=;
        b=QoQdpF9ADnQiwZGDM5/TE3vIdySfhhNe1wEmr50sv8cw9ljNS4UcQ10uexN6GbWmyc
         9E2FyePhiG0cfDuBzjokY+/9KIolga5ItcMXpfex0vHCyenDcm6BJYHEANTr5wsQrdUM
         4pqgQ9HZF3GalCDPDrB4VHKYw+q+9tUF/HJbU6fmr8Xn+BAaXrLytxekg9KI0oEyiv2y
         UUO459dLjxgFrV9MZmVPGoAMzSl5UOt0X7FBUvnpqFemcvGXrDio0FHnapuVHFFcelLk
         Nj0s9MG2wb+0H1klKeL8jqSL6hUinhQtJtUC3zCX2AqZGFrfo7ZMz0PU3/mgxZQTyZoW
         xrng==
X-Gm-Message-State: AGRZ1gKrkEvGKpwMll8cZu+wwso7D8WzmF0088nb9pIevj7S42CGODr9
        pI5lJNGrvRC1KXa7VSg3tpTz3g==
X-Google-Smtp-Source: AFSGD/UhaHhS7bnxcB1zNYRdTAizWBD8KdEpfKFr4H+cv5R3YH9e2/CPZiWcsyXK88uAQUgN3M44+g==
X-Received: by 2002:a63:cd4c:: with SMTP id a12mr24330079pgj.252.1543219823252;
        Mon, 26 Nov 2018 00:10:23 -0800 (PST)
Received: from localhost ([122.172.88.116])
        by smtp.gmail.com with ESMTPSA id k14sm83287429pgs.52.2018.11.26.00.10.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 00:10:22 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        rnayak@codeaurora.org, niklas.cassel@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/5] OPP: Add dev_pm_opp_xlate_performance_state() helper
Date:   Mon, 26 Nov 2018 13:40:01 +0530
Message-Id: <8bb37fb6120221ded6abb53e69c86620aade20f6.1543219386.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1543219386.git.viresh.kumar@linaro.org>
References: <cover.1543219386.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new helper dev_pm_opp_xlate_performance_state() which will
be used to translate from pstate of a device to another one.

Initially this will be used by genpd to find pstate of a master domain
using its sub-domain's pstate.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 59 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  7 +++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 0eaa954b3f6c..99b71f60b6d8 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1707,6 +1707,65 @@ void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table,
 		dev_err(virt_dev, "Failed to find required device entry\n");
 }
 
+/**
+ * dev_pm_opp_xlate_performance_state() - Find required OPP's pstate for src_table.
+ * @src_table: OPP table which has dst_table as one of its required OPP table.
+ * @dst_table: Required OPP table of the src_table.
+ * @pstate: Current performance state of the src_table.
+ *
+ * This Returns pstate of the OPP (present in @dst_table) pointed out by the
+ * "required-opps" property of the OPP (present in @src_table) which has
+ * performance state set to @pstate.
+ *
+ * Return: Positive performance state on success, otherwise 0 on errors.
+ */
+unsigned int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
+						struct opp_table *dst_table,
+						unsigned int pstate)
+{
+	struct dev_pm_opp *opp;
+	unsigned int dest_pstate = 0;
+	int i;
+
+	/*
+	 * Normally the src_table will have the "required_opps" property set to
+	 * point to one of the OPPs in the dst_table, but in some cases the
+	 * genpd and its master have one to one mapping of performance states
+	 * and so none of them have the "required-opps" property set. Return the
+	 * pstate of the src_table as it is in such cases.
+	 */
+	if (!src_table->required_opp_count)
+		return pstate;
+
+	for (i = 0; i < src_table->required_opp_count; i++) {
+		if (src_table->required_opp_tables[i]->np == dst_table->np)
+			break;
+	}
+
+	if (unlikely(i == src_table->required_opp_count)) {
+		pr_err("%s: Couldn't find matching OPP table (%p: %p)\n",
+		       __func__, src_table, dst_table);
+		return 0;
+	}
+
+	mutex_lock(&src_table->lock);
+
+	list_for_each_entry(opp, &src_table->opp_list, node) {
+		if (opp->pstate == pstate) {
+			dest_pstate = opp->required_opps[i]->pstate;
+			goto unlock;
+		}
+	}
+
+	pr_err("%s: Couldn't find matching OPP (%p: %p)\n", __func__, src_table,
+	       dst_table);
+
+unlock:
+	mutex_unlock(&src_table->lock);
+
+	return dest_pstate;
+}
+
 /**
  * dev_pm_opp_add()  - Add an OPP table from a table definitions
  * @dev:	device for which we do this operation
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 2b2c3fd985ab..5a64a81a1789 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -128,6 +128,7 @@ struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*s
 void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev, struct device *virt_dev, int index);
 void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table, struct device *virt_dev);
+unsigned int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate);
 int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq);
 int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, const struct cpumask *cpumask);
 int dev_pm_opp_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
@@ -280,6 +281,12 @@ static inline struct opp_table *dev_pm_opp_set_genpd_virt_dev(struct device *dev
 }
 
 static inline void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table, struct device *virt_dev) {}
+
+static inline unsigned int dev_pm_opp_xlate_performance_state(struct opp_table *src_table, struct opp_table *dst_table, unsigned int pstate)
+{
+	return 0;
+}
+
 static inline int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
 {
 	return -ENOTSUPP;
-- 
2.19.1.568.g152ad8e3369a

