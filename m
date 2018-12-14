Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA18C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559C82080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:15:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="khDtGEfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559C82080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbeLNKPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:15:54 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40695 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729554AbeLNKPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:15:51 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so2619742pfo.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 02:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xyjawys4UfIoyfyJqxfe5ExEUR+bqqWyP70n7MDXOvA=;
        b=khDtGEfVB/sQdSXhCsKW1uxgppS0APiKDXcuRJvBpegeebjDiue+kswR4jYdpva13/
         wGzp8Dvnkmt97N42PG3bc3VO+Tsuwol5McAJ/ACOsWIKWn49t37WATWrR1A1qyrB1fkE
         1plqUL7bHf9qHgCAd/+gDA7bzi+UhVLxMULLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xyjawys4UfIoyfyJqxfe5ExEUR+bqqWyP70n7MDXOvA=;
        b=P4iBk1t1EfMv+mjB4oukUNVSDHy9BUeomq5sGU04vyniWu4ycf1SM2BfenbtnDJYmO
         qvbBFds+S46dV6eI0QllxdbL9msqsujw5mgGOTD3NhGfUddmfWnbjGc/T7MIsCRLHwfh
         8WONizSU+l0zDnwZtkqy/S8LBwEkFBDrJqBE0bHM0y2XrRT3caVEQZkOI+/RY18fYvP0
         Jnv/yhVU/6FW6N/t4C3BCcgTKB8xepkpN34AVFwzTiw6uqzn7y+cbkpo21Na7e+tLbto
         g+DeKg/mRzEUmDe2k2lCyMyEculL//Stdb0xWhZlp4549xcFv4+Q4OOiMGHJRSj0QcBX
         egiA==
X-Gm-Message-State: AA+aEWasYxKgql/yfpO7p3l5ohSEBL+4p5kWacNGKVG5YK7fiolgRUyy
        JZbN5wZkEIHF2qJPgaW4gMlLfw==
X-Google-Smtp-Source: AFSGD/X/7c83r9MXWHr6nJJoArnhP3Nj4pr5wLZtKTVNFRWpENbautysJ5tZqp950mnub7EbAYakNg==
X-Received: by 2002:a62:a510:: with SMTP id v16mr2276882pfm.18.1544782550346;
        Fri, 14 Dec 2018 02:15:50 -0800 (PST)
Received: from localhost ([122.172.23.29])
        by smtp.gmail.com with ESMTPSA id u87sm10663737pfi.2.2018.12.14.02.15.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 02:15:49 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     ulf.hansson@linaro.org, Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        rnayak@codeaurora.org, niklas.cassel@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 4/7] OPP: Don't return 0 on error from of_get_required_opp_performance_state()
Date:   Fri, 14 Dec 2018 15:45:30 +0530
Message-Id: <b8efe7f3f52c7d5736df279173467cd6c40f28d2.1544782279.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e3369a
In-Reply-To: <cover.1544782279.git.viresh.kumar@linaro.org>
References: <cover.1544782279.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_get_required_opp_performance_state() returns 0 on errors currently
and a positive performance state otherwise. Since 0 is a valid
performance state (representing off), it would be better if this routine
returns negative values on error.

That will also make it behave similar to
dev_pm_opp_xlate_performance_state(), which also returns performance
states and returns negative values on error. Change the return type of
the function to "int" in order to return negative values.

This doesn't have any users for now and so no other part of the kernel
will be impacted with this change.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c       | 10 +++++-----
 include/linux/pm_opp.h |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 8e57d257be77..68b512846d72 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -995,19 +995,19 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_get_sharing_cpus);
  * Returns the performance state of the OPP pointed out by the "required-opps"
  * property at @index in @np.
  *
- * Return: Positive performance state on success, otherwise 0 on errors.
+ * Return: Zero or positive performance state on success, otherwise negative
+ * value on errors.
  */
-unsigned int of_get_required_opp_performance_state(struct device_node *np,
-						   int index)
+int of_get_required_opp_performance_state(struct device_node *np, int index)
 {
 	struct dev_pm_opp *opp;
 	struct device_node *required_np;
 	struct opp_table *opp_table;
-	unsigned int pstate = 0;
+	int pstate = -EINVAL;
 
 	required_np = of_parse_required_opp(np, index);
 	if (!required_np)
-		return 0;
+		return -EINVAL;
 
 	opp_table = _find_table_of_opp_np(required_np);
 	if (IS_ERR(opp_table)) {
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 0b04c2093eb9..0a2a88e5a383 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -321,7 +321,7 @@ void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask);
 int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask);
 struct device_node *dev_pm_opp_of_get_opp_desc_node(struct device *dev);
 struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp);
-unsigned int of_get_required_opp_performance_state(struct device_node *np, int index);
+int of_get_required_opp_performance_state(struct device_node *np, int index);
 #else
 static inline int dev_pm_opp_of_add_table(struct device *dev)
 {
@@ -360,9 +360,9 @@ static inline struct device_node *dev_pm_opp_get_of_node(struct dev_pm_opp *opp)
 {
 	return NULL;
 }
-static inline unsigned int of_get_required_opp_performance_state(struct device_node *np, int index)
+static inline int of_get_required_opp_performance_state(struct device_node *np, int index)
 {
-	return 0;
+	return -ENOTSUPP;
 }
 #endif
 
-- 
2.19.1.568.g152ad8e3369a

