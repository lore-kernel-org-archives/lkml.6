Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD21ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6AD420C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 12:04:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6AD420C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbeGQMg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 08:36:29 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:57191 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731179AbeGQMg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 08:36:28 -0400
Received: from 79.184.255.17.ipv4.supernova.orange.pl (79.184.255.17) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 978821eeaaa6221c; Tue, 17 Jul 2018 14:04:07 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     linux-pm@vger.kernel.org
Cc:     Andreas Herrmann <aherrmann@suse.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: pcc-cpufreq: Disable dynamic scaling on many-CPU systems
Date:   Tue, 17 Jul 2018 14:02:29 +0200
Message-ID: <306375154.NhdH6AhdAd@aspire.rjw.lan>
In-Reply-To: <20180717065048.74mmgk4t5utjaa6a@suselix>
References: <20180717065048.74mmgk4t5utjaa6a@suselix>
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
 drivers/cpufreq/pcc-cpufreq.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-pm/drivers/cpufreq/pcc-cpufreq.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/pcc-cpufreq.c
+++ linux-pm/drivers/cpufreq/pcc-cpufreq.c
@@ -589,6 +589,14 @@ static int __init pcc_cpufreq_init(void)
 		return ret;
 	}
 
+	if (num_present_cpus() > 4) {
+		pcc_cpufreq_driver.flags |= CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING;
+		pr_err("%s: Unsuitable system, dynamic performance scaling disabled\n",
+		       __func__);
+		pr_err("%s: Change BIOS settings and complain to the hardware vendor\n",
+		       __func__);
+	}
+
 	ret = cpufreq_register_driver(&pcc_cpufreq_driver);
 
 	return ret;

