Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_MIXED_ES,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26E8C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEFE20839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 10:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zse5bIBP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DEFE20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbeLLK56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 05:57:58 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35249 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbeLLK55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 05:57:57 -0500
Received: by mail-pf1-f195.google.com with SMTP id z9so8712346pfi.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 02:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AJkZNwTNld7Hpxnxwr+8YYYZfRYJuI5JuELm3hvUKug=;
        b=Zse5bIBPWkBFc0yO+2qjktnsKSHuh/M57oSFih7IYz06V4bnmlKgxbkdAi8rlVEr3f
         FPT0KcD1QTX0iNyN2ZBYDuL5cKzsi8FIRA3X2TJOHK1LBjgDa2kJrO9BsCMryw9tc8zJ
         z8SMX9FtHUhd95TveNOfmPBavHHE2iKG9Bsew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AJkZNwTNld7Hpxnxwr+8YYYZfRYJuI5JuELm3hvUKug=;
        b=jMTnaun06Tn2Bg8XQ5BiSR97BESrde601tY44Uer9pHbEkCY1/L/oyQQv0TLhepdvf
         kew+R9HP5n3IAVx/bOzjQ3IeI6M9v0J4t0Q02j6xJEtv+D52TAaWaWryPKy7hjMpDJ/N
         5wsIu6uYFdnNh3W3mqEH8E7KOAAwgWhEFNrkeM+THl7Q8Ce8wzFwXJAudRgRvasBm8cw
         8layyJXFZ9xLhrU44Kl+EYygy8m6m2qW8c737eauC0TbEdDjkYTlcHCevjqzmo+DVfzZ
         cXabM1d9Eite0Z2H7K59mZw9elktTzvgBwVjQPxqW7TsVRhYNig7fgOtN8rYWdtb+cOd
         kmSQ==
X-Gm-Message-State: AA+aEWbzr0V4dNvwL99f3bWHjK8gZkBBSt6ex2tJXNUvVLmT0p6HavzX
        Qo2l6bPJ5MJhVp1pwPfdsLZflg==
X-Google-Smtp-Source: AFSGD/V5dcIlGQJolWazMqEsT1RncWkM2RNKZD0OoEuCI/ZOW/PvNXn6nVx8Ml7WY7uEP640ilfOdA==
X-Received: by 2002:a63:2744:: with SMTP id n65mr17720584pgn.65.1544612276357;
        Wed, 12 Dec 2018 02:57:56 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id 84sm40430253pfk.134.2018.12.12.02.57.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 02:57:55 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        rnayak@codeaurora.org, niklas.cassel@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 3/6] OPP: Add dev_pm_opp_xlate_performance_state() helper
Date:   Wed, 12 Dec 2018 16:27:26 +0530
Message-Id: <6ea171c4f791aae3281e49077893f76ad4c55677.1544611890.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1544611890.git.viresh.kumar@linaro.org>
References: <cover.1544611890.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_pm_genpd_set_performance_state() needs to handle performance state
propagation going forward. Currently this routine only gets the required
performance state of the device's genpd as an argument, but it doesn't
know how to translate that to master genpd(s) of the device's genpd.

Introduce a new helper dev_pm_opp_xlate_performance_state() which will
be used to translate from performance state of a device (or genpd
sub-domain) to another device (or master genpd).

Normally the src_table (of genpd sub-domain) will have the
"required_opps" property set to point to one of the OPPs in the
dst_table (of master genpd), but in some cases the genpd and its master
have one to one mapping of performance states and so none of them have
the "required-opps" property set. Return the performance state of the
src_table as it is in such cases.

Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 59 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  7 +++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 98e60f0ed8b0..386095e2f4f7 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1713,6 +1713,65 @@ void dev_pm_opp_put_genpd_virt_dev(struct opp_table *opp_table,
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

