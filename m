Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B294ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49BB52084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tMhXm+Dn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BB52084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731754AbeGSVm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 17:42:56 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56146 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731681AbeGSVmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 17:42:54 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6JKsJFA185968;
        Thu, 19 Jul 2018 20:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=zbfnrlKMaLiQRSXAbRt/PSn1fBhCwCz16x/Y7PUxKvk=;
 b=tMhXm+DnvICE/axdLjHiP6/IEvJ5JPi3JSdke0suzUB4UxNssiaTOjV8RdWb+HmSar7M
 B8y97YbmQUSR279GENqxs/V552VziPPRljQHlym/RrZEIZbjoQFBBKksJRAXYqSACJQJ
 05/wdgzjzdMPIdeT1+gG/rd1t5kybcpKwcKcmup2iNDg4WfFEulzpivZ8IuTQpRdLqzN
 LeoAqiuY0lvw13YO422dPUsHqWzfX8U9Ai8pa5p6P+mVbW1GGl8OZC0pWCqKnDtpfld4
 0vhOxdsKUbL1ycubl0EL3XOae+7W0WwJQw2XFPpceFb1aQFw7m0nc79oUVD2GsE9cXJ7 +g== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2k7a3tca8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 20:57:02 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6JKv174002730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 20:57:01 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6JKv0PG027031;
        Thu, 19 Jul 2018 20:57:00 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Jul 2018 20:56:59 +0000
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, pasha.tatashin@oracle.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
Subject: [PATCH v15 25/26] x86/tsc:  split native_calibrate_cpu() into early and late parts
Date:   Thu, 19 Jul 2018 16:55:44 -0400
Message-Id: <20180719205545.16512-26-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180719205545.16512-1-pasha.tatashin@oracle.com>
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8959 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807190218
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Early in boot CPU can be calibrated using msr, cpuid, and quick pit
methods. The other methods pit/hpet/pmtimer are available only after acpi
is initialized.

Split native_calibrate_cpu() into early and late parts so they can be
called separately during early and late tsc calibration.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/include/asm/tsc.h |  1 +
 arch/x86/kernel/tsc.c      | 54 +++++++++++++++++++++++++-------------
 2 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index c4368ff73652..88140e4f2292 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -40,6 +40,7 @@ extern int unsynchronized_tsc(void);
 extern int check_tsc_unstable(void);
 extern void mark_tsc_async_resets(char *reason);
 extern unsigned long native_calibrate_cpu(void);
+extern unsigned long native_calibrate_cpu_early(void);
 extern unsigned long native_calibrate_tsc(void);
 extern unsigned long long native_sched_clock_from_tsc(u64 tsc);
 
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 9277ae9b68b3..60586779b02c 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -680,30 +680,17 @@ static unsigned long cpu_khz_from_cpuid(void)
 	return eax_base_mhz * 1000;
 }
 
-/**
- * native_calibrate_cpu - calibrate the cpu on boot
+/*
+ * calibrate cpu using pit, hpet, and ptimer methods. They are available
+ * later in boot after acpi is initialized.
  */
-unsigned long native_calibrate_cpu(void)
+static unsigned long pit_hpet_ptimer_calibrate_cpu(void)
 {
 	u64 tsc1, tsc2, delta, ref1, ref2;
 	unsigned long tsc_pit_min = ULONG_MAX, tsc_ref_min = ULONG_MAX;
-	unsigned long flags, latch, ms, fast_calibrate;
+	unsigned long flags, latch, ms;
 	int hpet = is_hpet_enabled(), i, loopmin;
 
-	fast_calibrate = cpu_khz_from_cpuid();
-	if (fast_calibrate)
-		return fast_calibrate;
-
-	fast_calibrate = cpu_khz_from_msr();
-	if (fast_calibrate)
-		return fast_calibrate;
-
-	local_irq_save(flags);
-	fast_calibrate = quick_pit_calibrate();
-	local_irq_restore(flags);
-	if (fast_calibrate)
-		return fast_calibrate;
-
 	/*
 	 * Run 5 calibration loops to get the lowest frequency value
 	 * (the best estimate). We use two different calibration modes
@@ -846,6 +833,37 @@ unsigned long native_calibrate_cpu(void)
 	return tsc_pit_min;
 }
 
+/**
+ * native_calibrate_cpu_early - can calibrate the cpu early in boot
+ */
+unsigned long native_calibrate_cpu_early(void)
+{
+	unsigned long flags, fast_calibrate = cpu_khz_from_cpuid();
+
+	if (!fast_calibrate)
+		fast_calibrate = cpu_khz_from_msr();
+	if (!fast_calibrate) {
+		local_irq_save(flags);
+		fast_calibrate = quick_pit_calibrate();
+		local_irq_restore(flags);
+	}
+	return fast_calibrate;
+}
+
+
+/**
+ * native_calibrate_cpu - calibrate the cpu
+ */
+unsigned long native_calibrate_cpu(void)
+{
+	unsigned long tsc_freq = native_calibrate_cpu_early();
+
+	if (!tsc_freq)
+		tsc_freq = pit_hpet_ptimer_calibrate_cpu();
+
+	return tsc_freq;
+}
+
 void recalibrate_cpu_khz(void)
 {
 #ifndef CONFIG_SMP
-- 
2.18.0

