Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0451EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F98B2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SwuaU0eM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F98B2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbeITEAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:00:49 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37527 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbeITEAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:00:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id h69-v6so3353523pfd.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=eozK+qk21bu6C0o4GTQGviL35NBsR1qUdySDKI0vP2I=;
        b=SwuaU0eMFXWnHwJhPlvOyv1Ga8JLS7+7VSsRo3kxfYuFSx+xD06mKbdqANxh0D6aTu
         yLH7qygik4fIlLze/wJlcC5Jp2Y8uuYOFSS9qnG2Ec1Z4KM/QmhRNrRZfrZjs0N9C6oK
         mghgYTt71zKhka1NiY4O/UJ9fQUBja1hRVG7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=eozK+qk21bu6C0o4GTQGviL35NBsR1qUdySDKI0vP2I=;
        b=WYQkUVW4tRz3tFjKyjDQZeKi8VgrQ3JS9t3R7cr2SLZtUGw0BPxfohnIY/eyh6H2LE
         TDQwJTGAeAp7bo3CpO82SfMTc+u8kmCSwRsSnD4OQMvzR4sm34sJwZ8SM4mfI00+A9+q
         rki+vublp5ySPuqCUYt/g7XQJJKK/afdy0qrzQkO5U3L6b5Zr28LpFOZhiiARUPPo2SP
         qPI8k1Y5IiQ8BCGwBcmy7tU6whnkRjLwbsd0Vum4bbCEwLwuYs2BT1AawEleT7J9vh+a
         LlQw+noUMuMOwKtgm61PqED6oeYdxzFmzVHrSnR2r21+MnyOAaqs5q5ZRY2NY3rkbDWm
         Z4HA==
X-Gm-Message-State: APzg51CXr3FhH+blqGBwj+fmd3oNPwtOyO2/SN01eOSntRZusSQCxf8y
        MzmZ901ZaWFCAYXdqBBOT1PykQ==
X-Google-Smtp-Source: ANB0VdYiF7rqZS1Mv5+Ge9lYSY73jpKTdzsiNjN4ilcRmn+P2v8UF6/zWvOCzUBqoNaESoDs1IdfTg==
X-Received: by 2002:a62:6690:: with SMTP id s16-v6mr38022974pfj.152.1537395645964;
        Wed, 19 Sep 2018 15:20:45 -0700 (PDT)
Received: from localhost ([209.121.128.187])
        by smtp.gmail.com with ESMTPSA id e190-v6sm45557047pfc.81.2018.09.19.15.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 15:20:45 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 02/12] OPP: Don't try to remove all OPP tables on failure
Date:   Wed, 19 Sep 2018 15:20:21 -0700
Message-Id: <404b1369ea26f598b96ae4d3183262a879703cfe.1537394233.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1537394233.git.viresh.kumar@linaro.org>
References: <cover.1537394233.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_pm_opp_of_cpumask_add_table() creates the OPP table for all CPUs
present in the cpumask and on errors it should revert all changes it has
done.

It actually is doing a bit more than that. On errors, it tries to free
all the OPP tables, even the one it hasn't created yet. This may also
end up freeing the OPP tables which were created from separate path,
like dev_pm_opp_set_supported_hw().

Reported-and-tested-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/cpu.c | 8 ++++++--
 drivers/opp/of.c  | 4 ++--
 drivers/opp/opp.h | 2 +-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/opp/cpu.c b/drivers/opp/cpu.c
index 0c0910709435..2eb5e2e7ff66 100644
--- a/drivers/opp/cpu.c
+++ b/drivers/opp/cpu.c
@@ -108,7 +108,8 @@ void dev_pm_opp_free_cpufreq_table(struct device *dev,
 EXPORT_SYMBOL_GPL(dev_pm_opp_free_cpufreq_table);
 #endif	/* CONFIG_CPU_FREQ */
 
-void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of)
+void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of,
+				      int last_cpu)
 {
 	struct device *cpu_dev;
 	int cpu;
@@ -116,6 +117,9 @@ void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of)
 	WARN_ON(cpumask_empty(cpumask));
 
 	for_each_cpu(cpu, cpumask) {
+		if (cpu == last_cpu)
+			break;
+
 		cpu_dev = get_cpu_device(cpu);
 		if (!cpu_dev) {
 			pr_err("%s: failed to get cpu%d device\n", __func__,
@@ -140,7 +144,7 @@ void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of)
  */
 void dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask)
 {
-	_dev_pm_opp_cpumask_remove_table(cpumask, false);
+	_dev_pm_opp_cpumask_remove_table(cpumask, false, -1);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_cpumask_remove_table);
 
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 20988c426650..86222586f27b 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -592,7 +592,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_add_table_indexed);
  */
 void dev_pm_opp_of_cpumask_remove_table(const struct cpumask *cpumask)
 {
-	_dev_pm_opp_cpumask_remove_table(cpumask, true);
+	_dev_pm_opp_cpumask_remove_table(cpumask, true, -1);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_remove_table);
 
@@ -627,7 +627,7 @@ int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask)
 				 __func__, cpu, ret);
 
 			/* Free all other OPPs */
-			dev_pm_opp_of_cpumask_remove_table(cpumask);
+			_dev_pm_opp_cpumask_remove_table(cpumask, true, cpu);
 			break;
 		}
 	}
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 7c540fd063b2..a9d22aa534c3 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -196,7 +196,7 @@ struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table);
 void _opp_free(struct dev_pm_opp *opp);
 int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *opp_table, bool rate_not_available);
 int _opp_add_v1(struct opp_table *opp_table, struct device *dev, unsigned long freq, long u_volt, bool dynamic);
-void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of);
+void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, bool of, int last_cpu);
 struct opp_table *_add_opp_table(struct device *dev);
 
 #ifdef CONFIG_OF
-- 
2.14.1

