Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A25C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 006E72146E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lwp0Vi0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006E72146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403809AbeGLANe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 20:13:34 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35500 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403780AbeGLANN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 20:13:13 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6C04xDA186497;
        Thu, 12 Jul 2018 00:04:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=n6H4M0pLO9X3x0dfQGU9b3MMfcpTx8+qreKjinBKqjI=;
 b=lwp0Vi0vdJKQsFitL8xzK9s3kShZkttbmpp8AgI2s77XohJPKI8K7epHmWa6AVFzHBGq
 at5CE88VrfYkA+k6sGtRA1R/G8OmS0KUWXGn40UZkUxHDTpuMuITgJKhCWkOiJMU3i4r
 4crV5v27aYDAPZ1W7/INydqlVBkoyivFnT/RiehcVzj8MCv7XiXkEAuCNqHpWwVs/j+9
 gQrKW/CvpyoqMGZS9SHRLZnA35Xoz2GhEbMD+fWKk+3Dv0ZVuhdRf7lhwV7Bg0jsstpu
 684a6dlid+46+u+qO31poa3JUpu2YhB1RmuKXM1ZISj14heecQNEXr8fLPxDIqTxeRvH 3Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2k2p7e09gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 00:04:58 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6C04v08029824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 00:04:57 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6C04vKd032166;
        Thu, 12 Jul 2018 00:04:57 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Jul 2018 17:04:57 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, pasha.tatashin@oracle.com,
        boris.ostrovsky@oracle.com, jgross@suse.com
Subject: [PATCH v13 17/18] sched: early boot clock
Date:   Wed, 11 Jul 2018 20:04:18 -0400
Message-Id: <20180712000419.5165-18-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712000419.5165-1-pasha.tatashin@oracle.com>
References: <20180712000419.5165-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8951 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807110252
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow sched_clock() to be used before schec_clock_init() is called.
This provides with a way to get early boot timestamps on machines with
unstable clocks.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 init/main.c          |  2 +-
 kernel/sched/clock.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/init/main.c b/init/main.c
index 162d931c9511..ff0a24170b95 100644
--- a/init/main.c
+++ b/init/main.c
@@ -642,7 +642,6 @@ asmlinkage __visible void __init start_kernel(void)
 	softirq_init();
 	timekeeping_init();
 	time_init();
-	sched_clock_init();
 	printk_safe_init();
 	perf_event_init();
 	profile_init();
@@ -697,6 +696,7 @@ asmlinkage __visible void __init start_kernel(void)
 	acpi_early_init();
 	if (late_time_init)
 		late_time_init();
+	sched_clock_init();
 	calibrate_delay();
 	pid_idr_init();
 	anon_vma_init();
diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index 3b02be1fdfda..4d07b785d566 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -201,7 +201,15 @@ static void __sched_clock_gtod_offset(void)
 
 void __init sched_clock_init(void)
 {
+	unsigned long flags;
+
 	sched_clock_running = 1;
+
+	/* Adjust __gtod_offset for contigious transition from early clock */
+	local_irq_save(flags);
+	sched_clock_tick();
+	local_irq_restore(flags);
+	__sched_clock_gtod_offset();
 }
 /*
  * We run this as late_initcall() such that it runs after all built-in drivers,
@@ -355,7 +363,7 @@ u64 sched_clock_cpu(int cpu)
 		return sched_clock() + __sched_clock_offset;
 
 	if (unlikely(!sched_clock_running))
-		return 0ull;
+		return sched_clock();
 
 	preempt_disable_notrace();
 	scd = cpu_sdc(cpu);
-- 
2.18.0

