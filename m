Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E554EECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2DA820647
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 16:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DA820647
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730301AbeGQQuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 12:50:02 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48852 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729640AbeGQQuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 12:50:02 -0400
Received: from 79.184.255.17.ipv4.supernova.orange.pl (79.184.255.17) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id d902f7ba3a093b45; Tue, 17 Jul 2018 18:16:36 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     linux-pm@vger.kernel.org
Cc:     Andreas Herrmann <aherrmann@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] cpufreq: pcc-cpufreq: Disable dynamic scaling on many-CPU systems
Date:   Tue, 17 Jul 2018 18:14:58 +0200
Message-ID: <5423012.ZZnfdYddaT@aspire.rjw.lan>
In-Reply-To: <306375154.NhdH6AhdAd@aspire.rjw.lan>
References: <20180717065048.74mmgk4t5utjaa6a@suselix> <306375154.NhdH6AhdAd@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The firmware interface used by the pcc-cpufreq driver is
fundamentally not scalable and using it for dynamic CPU performance
scaling on systems with many CPUs leads to degraded performance.

For this reason, disable dynamic CPU performance scaling on systems
with pcc-cpufreq where the number of CPUs present at the driver init
time is greater than 4.  Also make the driver print corresponding
complaints to the kernel log.

Reported-by: Andreas Herrmann <aherrmann@suse.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

-> v2: Rework the messages printed in the problematic case.

---
 drivers/cpufreq/pcc-cpufreq.c |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: linux-pm/drivers/cpufreq/pcc-cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/pcc-cpufreq.c
+++ linux-pm/drivers/cpufreq/pcc-cpufreq.c
@@ -589,6 +589,15 @@ static int __init pcc_cpufreq_init(void)
 		return ret;
 	}
 
+	if (num_present_cpus() > 4) {
+		pcc_cpufreq_driver.flags |= CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING;
+		pr_err("%s: Too many CPUs, dynamic performance scaling disabled\n",
+		       __func__);
+		pr_err("%s: Try to enable a different scaling driver through BIOS settings\n",
+		       __func__);
+		pr_err("%s: and complain to the system vendor\n", __func__);
+	}
+
 	ret = cpufreq_register_driver(&pcc_cpufreq_driver);
 
 	return ret;

