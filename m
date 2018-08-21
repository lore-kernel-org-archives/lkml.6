Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6908C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9707D217DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Nrk1pnCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9707D217DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeHVAqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 20:46:20 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:37220 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeHVAqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 20:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1534886671; x=1566422671;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=ejVBKa0T+g1YWl45u51OBZNIMC1Eg8VLBZCLEtTqQHw=;
  b=Nrk1pnCG8cBs/IzmQkHzeSx5pS/GL5VS9e8zXv5afZFB/1h4MmGSs39Z
   8CvxYsNqfgR4AOoVAMWdH1ReBBiea4N4640SnMHlIv50OvbPJezm+TRF+
   mKlTt3rZK2u65Lfubj2Kh51f0CihnR30UPTnDFMxZChPUxS5KHL4BozzB
   I=;
X-IronPort-AV: E=Sophos;i="5.53,271,1531785600"; 
   d="scan'208";a="755281504"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 Aug 2018 21:16:28 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w7LLFet8092301
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 21 Aug 2018 21:15:41 GMT
Received: from EX13D05UWC003.ant.amazon.com (10.43.162.226) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 21 Aug 2018 21:15:41 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D05UWC003.ant.amazon.com (10.43.162.226) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 21 Aug 2018 21:15:40 +0000
Received: from localhost (10.55.160.46) by mail-relay.amazon.com
 (10.43.162.232) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 21 Aug 2018 21:15:40 +0000
From:   Eduardo Valentin <eduval@amazon.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Eduardo Valentin <eduval@amazon.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Jia Zhang" <qianyue.zj@alibaba-inc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] perf/x86/intel: make error messages less confusing
Date:   Tue, 21 Aug 2018 14:15:28 -0700
Message-ID: <20180821211528.8575-1-eduval@amazon.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a system with X86_FEATURE_ARCH_PERFMON disabled
and with a model not known by family PMU drivers,
user gets a kernel message log like the following:
[ 0.100114] Performance Events: unsupported p6 CPU model 85 no PMU driver, software events only.

The "unsupported .. CPU" part may be confusing for some
users. Rewording the messages on the failure path to:
[ 0.667154] Performance Events: unknown p6 PMU on CPU model 85: !X86_FEATURE_ARCH_PERFMON: no PMU driver, software events only.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Eduardo Valentin <eduval@amazon.com>
Cc: Jia Zhang <qianyue.zj@alibaba-inc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Reported-by: Matt Wilson <msw@amazon.com>
Signed-off-by: Eduardo Valentin <eduval@amazon.com>
---
 arch/x86/events/intel/core.c | 15 +++++++++++----
 arch/x86/events/intel/p4.c   |  2 +-
 arch/x86/events/intel/p6.c   |  3 ++-
 3 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 86f0c15dcc2d..b57a16997ee6 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3884,15 +3884,22 @@ __init int intel_pmu_init(void)
 	char *name;
 
 	if (!cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
+		int ret = -ENODEV;
+
 		switch (boot_cpu_data.x86) {
 		case 0x6:
-			return p6_pmu_init();
+			ret = p6_pmu_init();
+			break;
 		case 0xb:
-			return knc_pmu_init();
+			ret = knc_pmu_init();
+			break;
 		case 0xf:
-			return p4_pmu_init();
+			ret = p4_pmu_init();
+			break;
 		}
-		return -ENODEV;
+		if (ret)
+			pr_cont(" !X86_FEATURE_ARCH_PERFMON: ");
+		return ret;
 	}
 
 	/*
diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index d32c0eed38ca..963d2b0600f6 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -1346,7 +1346,7 @@ __init int p4_pmu_init(void)
 
 	rdmsr(MSR_IA32_MISC_ENABLE, low, high);
 	if (!(low & (1 << 7))) {
-		pr_cont("unsupported Netburst CPU model %d ",
+		pr_cont("unknown Netburst PMU on CPU model %d: ",
 			boot_cpu_data.x86_model);
 		return -ENODEV;
 	}
diff --git a/arch/x86/events/intel/p6.c b/arch/x86/events/intel/p6.c
index 408879b0c0d4..221e374299b2 100644
--- a/arch/x86/events/intel/p6.c
+++ b/arch/x86/events/intel/p6.c
@@ -269,7 +269,8 @@ __init int p6_pmu_init(void)
 		break;
 
 	default:
-		pr_cont("unsupported p6 CPU model %d ", boot_cpu_data.x86_model);
+		pr_cont("unknown p6 PMU on CPU model %d: ",
+			boot_cpu_data.x86_model);
 		return -ENODEV;
 	}
 
-- 
2.18.0

