Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E36FC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238752081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 06:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rj4f5AW1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238752081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbeKEPzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 10:55:21 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44350 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729398AbeKEPzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 10:55:20 -0500
Received: by mail-pl1-f196.google.com with SMTP id s5-v6so3932446plq.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 22:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w59iisoJQ78soOoIeJ+J+gAbXxrCAkavZgo9Hnt+aE4=;
        b=Rj4f5AW1+BA3NUNvWqeTjieSLCp56uqjDOnTkd1zeupuaVDqmjavpQ9jwF4s8XRVfU
         uuKA4c/VT/XVQwq29U5ELFcqai41MZ62End4FWp2TXM43zl1KnFDh8+Meup6iU2IUSHa
         YmLF1RhPKhm5I2eKi7ukKVLRX5HcMC36ERHLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w59iisoJQ78soOoIeJ+J+gAbXxrCAkavZgo9Hnt+aE4=;
        b=lAQgNP/qBlADrvJU6w0JyGUCMm9JvZ+5Zto8JWHtmjJrJRyfSWFezdu0KRu+jeLNOp
         59aeCfVlhm9rHoEJe2/PRZ6KNnYqA6bEylTYU7/OtIjrbjdBZNwAoePUg7xXATHLaH0g
         cFhLIsIFqIo7Od8VQhY3gnRQmecbfVUCgpXlCPHwHxp2U6UjSiXYkftaBGY3OzMDIjf6
         1EVqxBGv7lh26NtV4mc8Ai50e/uJIkWED72HEguA1qZxj1NiOYHcBrRwAY4vKjY3onGE
         l/s9i+W/xw2anw0cZ+YRZIzwxQPNjQOfxS+trl4JQhuxVXr1aKiy7mfWCzFkXZw63X9T
         bNrw==
X-Gm-Message-State: AGRZ1gJqz8UdGZFAPNkrPw1SpeQpMxFti7X33oMxy0uAthWRyTINFwCW
        z0XkV0u/6R0X34v96H6aYvONTQ==
X-Google-Smtp-Source: AJdET5fhDFxR95kWS0fcU3f92QPJrhEgQZDOHpKe20DxevoGhrB81Q7ysM0rPNPYtty58zzLRoou9w==
X-Received: by 2002:a17:902:a9:: with SMTP id a38-v6mr9378635pla.7.1541399833493;
        Sun, 04 Nov 2018 22:37:13 -0800 (PST)
Received: from localhost ([171.61.116.174])
        by smtp.gmail.com with ESMTPSA id m5-v6sm52108824pfc.188.2018.11.04.22.37.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 22:37:12 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        niklas.cassel@linaro.org, rnayak@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] OPP: Add dev_pm_opp_xlate_performance_state() helper
Date:   Mon,  5 Nov 2018 12:06:43 +0530
Message-Id: <cedbfc3a7fffc4c400908c4c3af518bea408d318.1541399301.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1541399301.git.viresh.kumar@linaro.org>
References: <cover.1541399301.git.viresh.kumar@linaro.org>
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
 drivers/opp/core.c     | 49 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  7 ++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 0eaa954b3f6c..010a4268e8dd 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1707,6 +1707,55 @@ void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table,
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
+	for (i = 0; i < src_table->required_opp_count; i++) {
+		if (src_table->required_opp_tables[i] == dst_table)
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

