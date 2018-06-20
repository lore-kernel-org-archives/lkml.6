Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503F8C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 056392083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rROkX0Ph"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056392083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933524AbeFTV2X (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 17:28:23 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:41424 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933459AbeFTV2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 17:28:19 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5KLO6Zb134489;
        Wed, 20 Jun 2018 21:27:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=KTfTGJuEknVpsQbIpnFslikTrYwobpFQwyRMEWyqxcg=;
 b=rROkX0Pha+rhdNM0M0wqEGdTx0hVgOBjaLGS8o7I82S99D2PzJ9OfISTxwgZbSikI75/
 mLAE4A8I5z7V1KUcB9nfs/SREzxG+HqD/k0eGUQCFC77RII1kR5oghbaylX2IijUQOdF
 1HtLaT+Sdxx3XAil/wS3y1sDzoC41bP89UmF+VAXrxPHXln1KkT3gojviGjAcHYK599E
 yBdLMUD7+tZwMqxTiehOix5r2BndhOjemboPwMj2Fjws5t6FESGgKsFaFa5t84lNNCCF
 efL1n8HPGNXXCI1KUNtHV/Q+AAGjhL3K2lStOtLIVAjX+I9SuvLiQbvkPdh8vRyZ/Jl0 jA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2jmr2mpewd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 21:27:10 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5KLR8Dx013300
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 21:27:08 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5KLR7WI026522;
        Wed, 20 Jun 2018 21:27:07 GMT
Received: from xakep.us.oracle.com (/10.39.216.167)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jun 2018 14:27:06 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk
Subject: [PATCH v11 1/6] x86/tsc: redefine notsc to behave as tsc=unstable
Date:   Wed, 20 Jun 2018 17:26:55 -0400
Message-Id: <20180620212700.29178-2-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620212700.29178-1-pasha.tatashin@oracle.com>
References: <20180620212700.29178-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8930 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806200231
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
---
 .../admin-guide/kernel-parameters.txt          |  2 --
 Documentation/x86/x86_64/boot-options.txt      |  4 +---
 arch/x86/kernel/tsc.c                          | 18 +++---------------
 3 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index efc7aa7a0670..f7123d28f318 100644
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
2.17.1

