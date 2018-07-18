Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419F3ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F17602075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i+jKjLy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F17602075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbeGRDAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 23:00:12 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45088 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731894AbeGRC7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:59:43 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6I2K26M001249;
        Wed, 18 Jul 2018 02:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=vpVuqI3dCGRTRVqqUCAOO+Kfyc5A1QkjfDo78BnIP54=;
 b=i+jKjLy7TZL8CLrWb5asfXBdMh+MdRxbX2itJstMsgl6hneDJ2os/InkWxfLgeIL11Am
 KCpj2ePrilKYUPM1qyK5jx7hXZNwQU0AbCBj+3WBMUsclJrHHBAWqaf3Pxwm+EZGUOBC
 CUKHTBeXhzqHGF0rrwKhBIUsw2axZSxA5/vRdyWdelkG00PtTG6sZoU4Sr2OHg6og+6j
 SQgclupg5Ahl7Fkk2nQiGIzPVM22b+5WL//f2eeVH7eScJB2pezhBbM7sbe8yWVWl2LP
 Q1IuK+oyMHBBLgyZY9Bz8lyqHgm9rtCRgWlmWI3EdrSyVSOsSZeP3Rq2k9yFVb2YMfiI wQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2k7a3t34db-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:22:50 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6I2MnKh023963
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:22:49 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6I2Mn8l015983;
        Wed, 18 Jul 2018 02:22:49 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 19:22:49 -0700
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
Subject: [PATCH v14 12/25] x86/tsc: redefine notsc to behave as tsc=unstable
Date:   Tue, 17 Jul 2018 22:21:58 -0400
Message-Id: <20180718022211.6259-13-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180718022211.6259-1-pasha.tatashin@oracle.com>
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8957 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807180026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, notsc kernel parameter disables the use of tsc register by
sched_clock(). However, this parameter does not prevent linux from
accessing tsc in other places in kernel.

The only rational to boot with notsc is to avoid timing discrepancies on
multi-socket systems where different tsc frequencies may present, and thus
fallback to jiffies for clock source.

However, there is another method to solve the above problem, it is to boot
with tsc=unstable parameter. This parameter allows sched_clock() to use tsc
but in case tsc is outside of expected interval it is corrected back to a
sane value.

This is why there is no reason to keep notsc, and it can be removed. But,
for compatibility reasons we will keep this parameter but change its
definition to be the same as tsc=unstable.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 .../admin-guide/kernel-parameters.txt          |  2 --
 Documentation/x86/x86_64/boot-options.txt      |  4 +---
 arch/x86/kernel/tsc.c                          | 18 +++---------------
 3 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 533ff5c68970..5aed30cd0350 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2835,8 +2835,6 @@
 
 	nosync		[HW,M68K] Disables sync negotiation for all devices.
 
-	notsc		[BUGS=X86-32] Disable Time Stamp Counter
-
 	nowatchdog	[KNL] Disable both lockup detectors, i.e.
 			soft-lockup and NMI watchdog (hard-lockup).
 
diff --git a/Documentation/x86/x86_64/boot-options.txt b/Documentation/x86/x86_64/boot-options.txt
index 8d109ef67ab6..66114ab4f9fe 100644
--- a/Documentation/x86/x86_64/boot-options.txt
+++ b/Documentation/x86/x86_64/boot-options.txt
@@ -92,9 +92,7 @@ APICs
 Timing
 
   notsc
-  Don't use the CPU time stamp counter to read the wall time.
-  This can be used to work around timing problems on multiprocessor systems
-  with not properly synchronized CPUs.
+  Deprecated, use tsc=unstable instead.
 
   nohpet
   Don't use the HPET timer.
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 74392d9d51e0..186395041725 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -38,11 +38,6 @@ EXPORT_SYMBOL(tsc_khz);
  */
 static int __read_mostly tsc_unstable;
 
-/* native_sched_clock() is called before tsc_init(), so
-   we must start with the TSC soft disabled to prevent
-   erroneous rdtsc usage on !boot_cpu_has(X86_FEATURE_TSC) processors */
-static int __read_mostly tsc_disabled = -1;
-
 static DEFINE_STATIC_KEY_FALSE(__use_tsc);
 
 int tsc_clocksource_reliable;
@@ -248,8 +243,7 @@ EXPORT_SYMBOL_GPL(check_tsc_unstable);
 #ifdef CONFIG_X86_TSC
 int __init notsc_setup(char *str)
 {
-	pr_warn("Kernel compiled with CONFIG_X86_TSC, cannot disable TSC completely\n");
-	tsc_disabled = 1;
+	mark_tsc_unstable("boot parameter notsc");
 	return 1;
 }
 #else
@@ -1307,7 +1301,7 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 
 static int __init init_tsc_clocksource(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_TSC) || tsc_disabled > 0 || !tsc_khz)
+	if (!boot_cpu_has(X86_FEATURE_TSC) || !tsc_khz)
 		return 0;
 
 	if (tsc_unstable)
@@ -1414,12 +1408,6 @@ void __init tsc_init(void)
 		set_cyc2ns_scale(tsc_khz, cpu, cyc);
 	}
 
-	if (tsc_disabled > 0)
-		return;
-
-	/* now allow native_sched_clock() to use rdtsc */
-
-	tsc_disabled = 0;
 	static_branch_enable(&__use_tsc);
 
 	if (!no_sched_irq_time)
@@ -1455,7 +1443,7 @@ unsigned long calibrate_delay_is_known(void)
 	int constant_tsc = cpu_has(&cpu_data(cpu), X86_FEATURE_CONSTANT_TSC);
 	const struct cpumask *mask = topology_core_cpumask(cpu);
 
-	if (tsc_disabled || !constant_tsc || !mask)
+	if (!constant_tsc || !mask)
 		return 0;
 
 	sibling = cpumask_any_but(mask, cpu);
-- 
2.18.0

