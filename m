Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE567ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A21CC2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yXAIdtwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A21CC2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731795AbeGRC7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:59:38 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45018 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731209AbeGRC7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:59:37 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6I2K3Mh001258;
        Wed, 18 Jul 2018 02:23:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=5hjyk2dD33x04Cj4BddolvqMLS1cRPCrW3/wBUG7AgE=;
 b=yXAIdtwmv5L91cVKZXAcqTBD2A9zWsHhGM/j51Z6Rz4s0u6ek+2Zoy6uYS7rR/8Q4mZ8
 0TqZGiUHCU6VgYjbUNLBAsWA1fAvFKcDJvG34bTwCbCRer4HI3yeIVlmcdyPdbAHafM+
 uOfUjl9Xq4hBN2rvz2BtpmdQQ/HiWa88pSblgQiM6DkRp43AK0np5hGw9EtYC/UIdKVI
 CdZ7IRSns7/oGGGO+KgPf7nDlhCflJUZwz1lXvakPgQQK+yx7WGBTupmH+6i4hcXd/TU
 +9ICTenaKZv9NWTQ4dEEORTsISnHwxZsksKtUr0MnDrIec9BNcXn+Nyab8i15xWPJSu8 TQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2k7a3t34dy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:23:24 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6I2NNto024718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:23:23 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6I2NM7M020876;
        Wed, 18 Jul 2018 02:23:22 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 19:23:22 -0700
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
Subject: [PATCH v14 25/25] sched: use static key for sched_clock_running
Date:   Tue, 17 Jul 2018 22:22:11 -0400
Message-Id: <20180718022211.6259-26-pasha.tatashin@oracle.com>
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

sched_clock_running may be read every time sched_clock_cpu() is called.
Yet, this variable is updated only twice during boot, and never changes
again, therefore it is better to make it a static key.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 kernel/sched/clock.c | 16 ++++++++--------
 kernel/sched/debug.c |  2 --
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index 7a8a63b940ee..858a1c8f594c 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -67,7 +67,7 @@ unsigned long long __weak sched_clock(void)
 }
 EXPORT_SYMBOL_GPL(sched_clock);
 
-__read_mostly int sched_clock_running;
+static DEFINE_STATIC_KEY_FALSE(sched_clock_running);
 
 #ifdef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK
 /*
@@ -191,7 +191,7 @@ void clear_sched_clock_stable(void)
 
 	smp_mb(); /* matches sched_clock_init_late() */
 
-	if (sched_clock_running == 2)
+	if (static_key_count(&sched_clock_running.key) == 2)
 		__clear_sched_clock_stable();
 }
 
@@ -204,7 +204,7 @@ void __init sched_clock_init(void)
 {
 	unsigned long flags;
 
-	sched_clock_running = 1;
+	static_branch_inc(&sched_clock_running);
 
 	/* Adjust __gtod_offset for contigious transition from early clock */
 	local_irq_save(flags);
@@ -218,7 +218,7 @@ void __init sched_clock_init(void)
  */
 static int __init sched_clock_init_late(void)
 {
-	sched_clock_running = 2;
+	static_branch_inc(&sched_clock_running);
 	/*
 	 * Ensure that it is impossible to not do a static_key update.
 	 *
@@ -363,7 +363,7 @@ u64 sched_clock_cpu(int cpu)
 	if (sched_clock_stable())
 		return sched_clock() + __sched_clock_offset;
 
-	if (unlikely(!sched_clock_running))
+	if (!static_branch_unlikely(&sched_clock_running))
 		return sched_clock();
 
 	preempt_disable_notrace();
@@ -386,7 +386,7 @@ void sched_clock_tick(void)
 	if (sched_clock_stable())
 		return;
 
-	if (unlikely(!sched_clock_running))
+	if (!static_branch_unlikely(&sched_clock_running))
 		return;
 
 	lockdep_assert_irqs_disabled();
@@ -445,13 +445,13 @@ EXPORT_SYMBOL_GPL(sched_clock_idle_wakeup_event);
 
 void __init sched_clock_init(void)
 {
-	sched_clock_running = 1;
+	static_branch_inc(&sched_clock_running);
 	generic_sched_clock_init();
 }
 
 u64 sched_clock_cpu(int cpu)
 {
-	if (unlikely(!sched_clock_running))
+	if (!static_branch_unlikely(&sched_clock_running))
 		return 0;
 
 	return sched_clock();
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index e593b4118578..b0212f489a33 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -623,8 +623,6 @@ void print_dl_rq(struct seq_file *m, int cpu, struct dl_rq *dl_rq)
 #undef PU
 }
 
-extern __read_mostly int sched_clock_running;
-
 static void print_cpu(struct seq_file *m, int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-- 
2.18.0

