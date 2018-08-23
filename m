Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D17C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88EBE2098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 15:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MG87EkOp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88EBE2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732685AbeHWSho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 14:37:44 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:49363 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbeHWSho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 14:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1535036859; x=1566572859;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=kAGrB5tv6imeHk5vcFULqDzkxVTR88rMy5TBeKlEyUs=;
  b=MG87EkOp58lZCvXtkhhAEmfoGDp3Upv65BtiaoRn7kWPSNk3LjZYfH1m
   GJNx86XAmPHubgQMihWhobEB6FhS9PJyWtzHSxxpbmpOUgRgyIxcLHcV0
   8KCp7f0m4+RRbN8kHrLRW/7N1W6+qZEUvwogMvCWjj460R99uXdefdCjN
   4=;
X-IronPort-AV: E=Sophos;i="5.53,278,1531785600"; 
   d="scan'208";a="735091387"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 23 Aug 2018 15:07:37 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w7NF7XqS085595
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 23 Aug 2018 15:07:35 GMT
Received: from EX13D05UWB004.ant.amazon.com (10.43.161.208) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 23 Aug 2018 15:07:34 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D05UWB004.ant.amazon.com (10.43.161.208) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 23 Aug 2018 15:07:34 +0000
Received: from localhost (10.88.182.97) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 23 Aug 2018 15:07:33 +0000
From:   Eduardo Valentin <eduval@amazon.com>
To:     Andi Kleen <ak@linux.intel.com>
CC:     Eduardo Valentin <eduval@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kan Liang" <kan.liang@linux.intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCHv2 1/1] perf/x86/intel: make error messages less confusing
Date:   Thu, 23 Aug 2018 08:07:32 -0700
Message-ID: <20180823150732.11249-1-eduval@amazon.com>
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
users leading to wrong understanding that the kernel
does not support the CPU model.

This patch rewords the messages on the failure path to:
[ 0.667154] Performance Events: CPU does not support PMU: no PMU driver, software events only.

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
Signed-off-by: Eduardo Valentin <eduval@amazon.com>
---

Changes from V1->V2:
- As per initial review, the propose messaging was even
more confusing. Simplified it by only saying that
the CPU does not support PMU.


 arch/x86/events/intel/core.c | 15 +++++++++++----
 arch/x86/events/intel/p4.c   |  5 +----
 arch/x86/events/intel/p6.c   |  1 -
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 035c37481f57..2ddb97f03f4a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3889,15 +3889,22 @@ __init int intel_pmu_init(void)
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
+			pr_cont("CPU does not support PMU: ");
+		return ret;
 	}
 
 	/*
diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index d32c0eed38ca..fb5e8576d9ac 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -1345,11 +1345,8 @@ __init int p4_pmu_init(void)
 	BUILD_BUG_ON(ARCH_P4_MAX_CCCR > INTEL_PMC_MAX_GENERIC);
 
 	rdmsr(MSR_IA32_MISC_ENABLE, low, high);
-	if (!(low & (1 << 7))) {
-		pr_cont("unsupported Netburst CPU model %d ",
-			boot_cpu_data.x86_model);
+	if (!(low & (1 << 7)))
 		return -ENODEV;
-	}
 
 	memcpy(hw_cache_event_ids, p4_hw_cache_event_ids,
 		sizeof(hw_cache_event_ids));
diff --git a/arch/x86/events/intel/p6.c b/arch/x86/events/intel/p6.c
index 408879b0c0d4..e8e03e68b22f 100644
--- a/arch/x86/events/intel/p6.c
+++ b/arch/x86/events/intel/p6.c
@@ -269,7 +269,6 @@ __init int p6_pmu_init(void)
 		break;
 
 	default:
-		pr_cont("unsupported p6 CPU model %d ", boot_cpu_data.x86_model);
 		return -ENODEV;
 	}
 
-- 
2.18.0

