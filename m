Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA954ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC0320857
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 19:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC0320857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=supermicro.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731871AbeGMUIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 16:08:49 -0400
Received: from mgb.supermicro.com ([207.212.57.85]:35402 "EHLO
        mgb.supermicro.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730017AbeGMUIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 16:08:49 -0400
X-Greylist: delayed 1900 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Jul 2018 16:08:48 EDT
Received: from pps.filterd (MGB.supermicro.com [127.0.0.1])
        by MGB.supermicro.com (8.16.0.22/8.16.0.22) with SMTP id w6DJEKYF013712;
        Fri, 13 Jul 2018 12:19:09 -0700
Received: from ex2013-mbx2.supermicro.com ([10.2.1.38])
        by MGB.supermicro.com with ESMTP id 2k2w4s8t5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 13 Jul 2018 12:19:09 -0700
Received: from [172.16.95.100] (10.2.0.41) by Ex2013-MBX2.supermicro.com
 (10.2.1.38) with Microsoft SMTP Server (TLS) id 15.0.1236.3; Fri, 13 Jul 2018
 12:18:16 -0700
From:   patrickg <patrickg@supermicro.com>
Subject: [RFC] x86, tsc: Add kcmdline args for skipping tsc calibration
 sequences
To:     <len.brown@intel.com>, <linux-kernel@vger.kernel.org>
CC:     <mingo@kernel.org>, <alek.du@intel.com>, <arjan@linux.intel.com>,
        <feng.tang@intel.com>
Message-ID: <fdf96605-a4a0-049b-51c9-1e68cc2a9b93@supermicro.com>
Date:   Fri, 13 Jul 2018 12:19:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.2.0.41]
X-ClientProxiedBy: EX2013-CA1.supermicro.com (10.2.1.31) To
 Ex2013-MBX2.supermicro.com (10.2.1.38)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-13_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=969
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807130172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC patch is intended to allow bypass CPUID, MSR and QuickPIT calibration methods should the user desire to.

The current ordering in ML x86 tsc is to calibrate in the order listed above; returning whenever there's a successful calibration.  However there are certain BIOS/HW Designs for overclocking that cause the TSC to change along with the max core clock; and simple 'trusting' calibration methodologies will lead to the TSC running 'faster' and eventually, TSC instability.

I only know that there's a use-case for me to want to be able to skip CPUID calibration, however I included args for skipping all the rest just so that all functionality is covered in the long run instead of just one use-case.

I included some noise; in the end it's probably not too necessary to have, but it could be useful from a debugging standpoint to see if someone is utilizing the flags.

---
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 74392d9..5a07d12 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -47,6 +47,13 @@ static DEFINE_STATIC_KEY_FALSE(__use_tsc);
 
 int tsc_clocksource_reliable;
 
+/*
+ * TSC calibration sequence disablement
+ */
+int calibrate_cpuid_khz_disabled = 0;
+int calibrate_msr_disabled = 0;
+int calibrate_quick_disabled = 0;
+
 static u32 art_to_tsc_numerator;
 static u32 art_to_tsc_denominator;
 static u64 art_to_tsc_offset;
@@ -281,6 +288,32 @@ static int __init tsc_setup(char *str)
 
 __setup("tsc=", tsc_setup);
 
+static int __init setup_tsc_calibration_order(char *str)
+{
+	if (!str)
+		return -EINVAL;
+
+	while (*str) {
+		if (!strncmp(str, "nocpuid", 7)) {
+			calibrate_cpuid_khz_disabled = 1;
+			pr_info("TSC CPUID khz calibrate disabled\n");
+		} else if (!strncmp(str, "nomsr", 5)) {
+			calibrate_msr_disabled = 1;
+			pr_info("TSC msr calibrate disabled\n");
+		} else if (!strncmp(str, "noquick", 7)) {
+			calibrate_quick_disabled = 1;
+			pr_info("TSC quick calibrate disabled\n");
+		}
+
+		str += strcspn(str, ",");
+		while (*str == ',')
+			str++;
+	}
+	return 1;
+}
+
+__setup("tsc_calibrate=", setup_tsc_calibration_order);
+
 #define MAX_RETRIES     5
 #define SMI_TRESHOLD    50000
 
@@ -675,19 +708,25 @@ unsigned long native_calibrate_cpu(void)
 	unsigned long flags, latch, ms, fast_calibrate;
 	int hpet = is_hpet_enabled(), i, loopmin;
 
-	fast_calibrate = cpu_khz_from_cpuid();
-	if (fast_calibrate)
-		return fast_calibrate;
+	if (!calibrate_cpuid_khz_disabled) {
+		fast_calibrate = cpu_khz_from_cpuid();
+		if (fast_calibrate)
+			return fast_calibrate;
+	}
 
-	fast_calibrate = cpu_khz_from_msr();
-	if (fast_calibrate)
-		return fast_calibrate;
+	if (!calibrate_msr_disabled) {
+		fast_calibrate = cpu_khz_from_msr();
+		if (fast_calibrate)
+			return fast_calibrate;
+	}
 
-	local_irq_save(flags);
-	fast_calibrate = quick_pit_calibrate();
-	local_irq_restore(flags);
-	if (fast_calibrate)
-		return fast_calibrate;
+	if (!calibrate_quick_disabled) {
+		local_irq_save(flags);
+		fast_calibrate = quick_pit_calibrate();
+		local_irq_restore(flags);
+		if (fast_calibrate)
+			return fast_calibrate;
+	}
 
 	/*
 	 * Run 5 calibration loops to get the lowest frequency value

---
