Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD2BC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA674208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ljMbKcHX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA674208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966094AbeFORnk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:43:40 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59012 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966075AbeFORnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:43:15 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5FHcmiI139454;
        Fri, 15 Jun 2018 17:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=QZZNDBMtLradJ4r2PazNNQLYAzjOsg9w4tRyYGQqI7A=;
 b=ljMbKcHXPH/jVAAeCclJ2HY4ZOgNdVFVBphGsPiSPAriAqGiMOUXs5evu7TAcWtXYKDJ
 oBq+0AMQX7xBe7/kV2SEZQuLSV14gw5f0LtuHqF7nUE0fy7TN732DCJfxgxzerOcjUBM
 NJj6T6JZfOqWSxGho0KX1d+cZStXyhupFb8Fs7J1LSuO0wJP914bY/wR0n1bHF6f085w
 9IIq7bB/c3ibJg4Zx0yN/5TEg0PIB88VZU/lG6O9iMI+eyH2EgAG3rt7T4kkgYFyMAqI
 v9LqZ5/M54QcprmYqHKzrO/h3gzuMqJsUs67pXi0hzbRcmuq0RyAk6TjUSNKLxBw2qWd LQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2jk0xr1vy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 17:42:15 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5FHgE43002155
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 17:42:14 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5FHgCAt004391;
        Fri, 15 Jun 2018 17:42:12 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Jun 2018 10:42:12 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk
Subject: [PATCH v10 1/7] x86/tsc: remove tsc_disabled flag
Date:   Fri, 15 Jun 2018 13:41:58 -0400
Message-Id: <20180615174204.30581-2-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615174204.30581-1-pasha.tatashin@oracle.com>
References: <20180615174204.30581-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8925 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806150189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tsc_disabled is set when notsc is passed as kernel parameter. The reason we
have notsc is to avoid timing problems on multi-socket systems.  We already
have a mechanism, however, to detect and resolve these issues by invoking
tsc unstable path. Thus, make notsc to behave the same as tsc=unstable.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
---
 arch/x86/kernel/tsc.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

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

