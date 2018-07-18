Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5313FECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097E62075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yodSs06Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 097E62075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732076AbeGRDBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 23:01:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58280 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731792AbeGRC7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:59:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6I2JlXw165263;
        Wed, 18 Jul 2018 02:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=MCNtFBSgc9d+voKZ0Fx9i/XHcYPhNKcB7IccuXZg1cs=;
 b=yodSs06ZMzW+wyU9pRUagM//V4Q0u3igY6Wv8UJrfIbx/mq9zJE56LWTqrNJMWbxn2r1
 ZN1G9iiqnugF90dzKArDgmOXH+J34BrGoFiscf5Hvpm3cW2bxphjpvjw+IxBz0qVLmQA
 Z3BeH/3q6gMZb58lydDJ9wed4+c3Hjdgbwvgcyn1OT0Prbc58TD3ZoSrysSIS/0hYweB
 I78QFjwiknJmTIOCmuXjAuErsiO3HqfNOiDSpGrR2Ca3NWrU788gNxLQFrJi3JsowNrL
 DP4RPqVNTRDar9Blq0J+uebocNmFM/UT8cjjxi61ATADmvtJeIu6oosf/IDZe6ZlPAmJ BA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2k7a3ju3cb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:23:08 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6I2N8ki024415
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:23:08 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6I2N75N013690;
        Wed, 18 Jul 2018 02:23:07 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 19:23:06 -0700
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
Subject: [PATCH v14 19/25] ARM/time: remove read_boot_clock64()
Date:   Tue, 17 Jul 2018 22:22:05 -0400
Message-Id: <20180718022211.6259-20-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180718022211.6259-1-pasha.tatashin@oracle.com>
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8957 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=869
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807180026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

read_boot_clock64() is deleted, and replaced with
read_persistent_wall_and_boot_offset().

The default implementation of read_persistent_wall_and_boot_offset()
provides a better fallback than the current stubs for read_boot_clock64()
that arm has with no users, so remove the old code.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/arm/include/asm/mach/time.h    |  3 +--
 arch/arm/kernel/time.c              | 15 ++-------------
 arch/arm/plat-omap/counter_32k.c    |  2 +-
 drivers/clocksource/tegra20_timer.c |  2 +-
 4 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/arch/arm/include/asm/mach/time.h b/arch/arm/include/asm/mach/time.h
index 0f79e4dec7f9..4ac3a019a46f 100644
--- a/arch/arm/include/asm/mach/time.h
+++ b/arch/arm/include/asm/mach/time.h
@@ -13,7 +13,6 @@
 extern void timer_tick(void);
 
 typedef void (*clock_access_fn)(struct timespec64 *);
-extern int register_persistent_clock(clock_access_fn read_boot,
-				     clock_access_fn read_persistent);
+extern int register_persistent_clock(clock_access_fn read_persistent);
 
 #endif
diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index cf2701cb0de8..078b259ead4e 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -83,29 +83,18 @@ static void dummy_clock_access(struct timespec64 *ts)
 }
 
 static clock_access_fn __read_persistent_clock = dummy_clock_access;
-static clock_access_fn __read_boot_clock = dummy_clock_access;
 
 void read_persistent_clock64(struct timespec64 *ts)
 {
 	__read_persistent_clock(ts);
 }
 
-void read_boot_clock64(struct timespec64 *ts)
-{
-	__read_boot_clock(ts);
-}
-
-int __init register_persistent_clock(clock_access_fn read_boot,
-				     clock_access_fn read_persistent)
+int __init register_persistent_clock(clock_access_fn read_persistent)
 {
 	/* Only allow the clockaccess functions to be registered once */
-	if (__read_persistent_clock == dummy_clock_access &&
-	    __read_boot_clock == dummy_clock_access) {
-		if (read_boot)
-			__read_boot_clock = read_boot;
+	if (__read_persistent_clock == dummy_clock_access) {
 		if (read_persistent)
 			__read_persistent_clock = read_persistent;
-
 		return 0;
 	}
 
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index 2438b96004c1..fcc5bfec8bd1 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -110,7 +110,7 @@ int __init omap_init_clocksource_32k(void __iomem *vbase)
 	}
 
 	sched_clock_register(omap_32k_read_sched_clock, 32, 32768);
-	register_persistent_clock(NULL, omap_read_persistent_clock64);
+	register_persistent_clock(omap_read_persistent_clock64);
 	pr_info("OMAP clocksource: 32k_counter at 32768 Hz\n");
 
 	return 0;
diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
index c337a8100a7b..2242a36fc5b0 100644
--- a/drivers/clocksource/tegra20_timer.c
+++ b/drivers/clocksource/tegra20_timer.c
@@ -259,6 +259,6 @@ static int __init tegra20_init_rtc(struct device_node *np)
 	else
 		clk_prepare_enable(clk);
 
-	return register_persistent_clock(NULL, tegra_read_persistent_clock64);
+	return register_persistent_clock(tegra_read_persistent_clock64);
 }
 TIMER_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
-- 
2.18.0

