Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF4FECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C124F2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="09kGirLI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C124F2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbeGRDBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 23:01:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47798 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731799AbeGRC7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:59:39 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6I2JKQ0168737;
        Wed, 18 Jul 2018 02:23:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=JVe5h6ti7ArCXiGDX/fS8cVGfeHjybL4Dirx8y+GgZE=;
 b=09kGirLIpyjqqherJMYnCUINn+tR6tL57HTQHgT59RxWPSb7CMDBACQ28Ty9DvfGDV2N
 j7FwOoxhOjwvB4ypwAkZYP04jTLO12FyeCygA+sRK0K1MLmKaLJS1yXmLHqRUSymJULB
 k9YSCaBrbMZKmY+HYeG1c2eeGprutkTmrvngMosVe68IAOdJ0T4+CSxqzVgr0bZ1h9o/
 6iGPL9XvBJuiMpzHa+dusuwyaEYW0lIi1qFqdbuv/i6FoQi2FcCsL4TF4uhmTIvzZlOd
 AZ4tRg4GEwQ7tjoRoUT7bBHawLNrENIGOfd7iNU4KuNwQLuoEZ2NPBJZ8PfosF1HF5JY 7Q== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2k7a3tb44e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:23:13 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6I2NCD2029031
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:23:12 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6I2NCND016158;
        Wed, 18 Jul 2018 02:23:12 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 19:23:11 -0700
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
Subject: [PATCH v14 21/25] x86/tsc: initialize cyc2ns when tsc freq. is determined
Date:   Tue, 17 Jul 2018 22:22:07 -0400
Message-Id: <20180718022211.6259-22-pasha.tatashin@oracle.com>
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

cyc2ns converts tsc to nanoseconds, and it is handled in a per-cpu data
structure.

Currently, the setup code for c2ns data for every possible CPU goes through
the same sequence of calculations as for the boot CPU, but is based on the
same tsc frequency as the boot CPU, and thus this is not necessary.

Initialize the boot cpu when tsc frequency is determined. Copy the
calculated data from the boot CPU to the other CPUs in tsc_init().

In addition do the following:

- Remove unnecessary zeroing of c2ns data by removing cyc2ns_data_init()
- Split set_cyc2ns_scale() into two functions, so set_cyc2ns_scale() can be
  called when system is up, and wraps around __set_cyc2ns_scale() that can
  be called directly when system is booting but avoids saving restoring
  IRQs and going and waking up from idle.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/kernel/tsc.c | 94 ++++++++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 41 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index bc8eb82050a3..0b1abe7fdd8e 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -103,23 +103,6 @@ void cyc2ns_read_end(void)
  *                      -johnstul@us.ibm.com "math is hard, lets go shopping!"
  */
 
-static void cyc2ns_data_init(struct cyc2ns_data *data)
-{
-	data->cyc2ns_mul = 0;
-	data->cyc2ns_shift = 0;
-	data->cyc2ns_offset = 0;
-}
-
-static void __init cyc2ns_init(int cpu)
-{
-	struct cyc2ns *c2n = &per_cpu(cyc2ns, cpu);
-
-	cyc2ns_data_init(&c2n->data[0]);
-	cyc2ns_data_init(&c2n->data[1]);
-
-	seqcount_init(&c2n->seq);
-}
-
 static inline unsigned long long cycles_2_ns(unsigned long long cyc)
 {
 	struct cyc2ns_data data;
@@ -135,18 +118,11 @@ static inline unsigned long long cycles_2_ns(unsigned long long cyc)
 	return ns;
 }
 
-static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_now)
+static void __set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_now)
 {
 	unsigned long long ns_now;
 	struct cyc2ns_data data;
 	struct cyc2ns *c2n;
-	unsigned long flags;
-
-	local_irq_save(flags);
-	sched_clock_idle_sleep_event();
-
-	if (!khz)
-		goto done;
 
 	ns_now = cycles_2_ns(tsc_now);
 
@@ -178,12 +154,55 @@ static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_
 	c2n->data[0] = data;
 	raw_write_seqcount_latch(&c2n->seq);
 	c2n->data[1] = data;
+}
+
+static void set_cyc2ns_scale(unsigned long khz, int cpu, unsigned long long tsc_now)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	sched_clock_idle_sleep_event();
+
+	if (khz)
+		__set_cyc2ns_scale(khz, cpu, tsc_now);
 
-done:
 	sched_clock_idle_wakeup_event();
 	local_irq_restore(flags);
 }
 
+/*
+ * Initialize cyc2ns for boot cpu
+ */
+static void __init cyc2ns_init_boot_cpu(void)
+{
+	struct cyc2ns *c2n = this_cpu_ptr(&cyc2ns);
+
+	seqcount_init(&c2n->seq);
+	__set_cyc2ns_scale(tsc_khz, smp_processor_id(), rdtsc());
+}
+
+/*
+ * Secondary CPUs do not run through cyc2ns_init(), so set up
+ * all the scale factors for all CPUs, assuming the same
+ * speed as the bootup CPU. (cpufreq notifiers will fix this
+ * up if their speed diverges)
+ */
+static void __init cyc2ns_init_secondary_cpus(void)
+{
+	unsigned int cpu, this_cpu = smp_processor_id();
+	struct cyc2ns *c2n = this_cpu_ptr(&cyc2ns);
+	struct cyc2ns_data *data = c2n->data;
+
+	for_each_possible_cpu(cpu) {
+		if (cpu != this_cpu) {
+			seqcount_init(&c2n->seq);
+			c2n = per_cpu_ptr(&cyc2ns, cpu);
+			c2n->data[0] = data[0];
+			c2n->data[1] = data[1];
+		}
+	}
+}
+
 /*
  * Scheduler clock - returns current time in nanosec units.
  */
@@ -1385,6 +1404,10 @@ void __init tsc_early_init(void)
 	if (!determine_cpu_tsc_frequncies())
 		return;
 	loops_per_jiffy = get_loops_per_jiffy();
+
+	/* Sanitize TSC ADJUST before cyc2ns gets initialized */
+	tsc_store_and_check_tsc_adjust(true);
+	cyc2ns_init_boot_cpu();
 }
 
 void __init tsc_init(void)
@@ -1400,23 +1423,12 @@ void __init tsc_init(void)
 			mark_tsc_unstable("could not calculate TSC khz");
 			return;
 		}
+		/* Sanitize TSC ADJUST before cyc2ns gets initialized */
+		tsc_store_and_check_tsc_adjust(true);
+		cyc2ns_init_boot_cpu();
 	}
 
-	/* Sanitize TSC ADJUST before cyc2ns gets initialized */
-	tsc_store_and_check_tsc_adjust(true);
-
-	/*
-	 * Secondary CPUs do not run through tsc_init(), so set up
-	 * all the scale factors for all CPUs, assuming the same
-	 * speed as the bootup CPU. (cpufreq notifiers will fix this
-	 * up if their speed diverges)
-	 */
-	cyc = rdtsc();
-	for_each_possible_cpu(cpu) {
-		cyc2ns_init(cpu);
-		set_cyc2ns_scale(tsc_khz, cpu, cyc);
-	}
-
+	cyc2ns_init_secondary_cpus();
 	static_branch_enable(&__use_tsc);
 
 	if (!no_sched_irq_time)
-- 
2.18.0

