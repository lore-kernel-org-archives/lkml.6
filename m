Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id R/ZeF7FFGVvWJAAAmS7hNA
	; Thu, 07 Jun 2018 14:48:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 64155608C1; Thu,  7 Jun 2018 14:48:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CBD36608B8;
	Thu,  7 Jun 2018 14:48:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CBD36608B8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935098AbeFGOsc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:48:32 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40841 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935083AbeFGOs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:48:29 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbX-0005Zj-Ma; Thu, 07 Jun 2018 15:09:31 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbA-0003A0-Ij; Thu, 07 Jun 2018 15:09:08 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Viresh Kumar" <viresh.kumar@linaro.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.483210210@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 304/410] cpufreq: s3c24xx: Fix broken s3c_cpufreq_init()
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Viresh Kumar <viresh.kumar@linaro.org>

commit 0373ca74831b0f93cd4cdbf7ad3aec3c33a479a5 upstream.

commit a307a1e6bc0d "cpufreq: s3c: use cpufreq_generic_init()"
accidentally broke cpufreq on s3c2410 and s3c2412.

These two platforms don't have a CPU frequency table and used to skip
calling cpufreq_table_validate_and_show() for them.  But with the
above commit, we started calling it unconditionally and that will
eventually fail as the frequency table pointer is NULL.

Fix this by calling cpufreq_table_validate_and_show() conditionally
again.

Fixes: a307a1e6bc0d "cpufreq: s3c: use cpufreq_generic_init()"
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/cpufreq/s3c24xx-cpufreq.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/cpufreq/s3c24xx-cpufreq.c
+++ b/drivers/cpufreq/s3c24xx-cpufreq.c
@@ -370,7 +370,13 @@ struct clk *s3c_cpufreq_clk_get(struct d
 static int s3c_cpufreq_init(struct cpufreq_policy *policy)
 {
 	policy->clk = clk_arm;
-	return cpufreq_generic_init(policy, ftab, cpu_cur.info->latency);
+
+	policy->cpuinfo.transition_latency = cpu_cur.info->latency;
+
+	if (ftab)
+		return cpufreq_table_validate_and_show(policy, ftab);
+
+	return 0;
 }
 
 static int __init s3c_cpufreq_initclks(void)
