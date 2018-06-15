Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E839C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E25208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="tBp22Ku4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E25208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966296AbeFORpJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:45:09 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:59006 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965850AbeFORnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:43:15 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5FHck4b139416;
        Fri, 15 Jun 2018 17:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=T0h2r0sSc7tWjXGwr4r6W2STLW/66D3vCHN8FMxxB04=;
 b=tBp22Ku4eGJqQDkcYdr50jReMmmxjuy++YlqEfR/P4qtWpMRrh7c9d3sDS4B4yLHVrl5
 fdEj/YgBJ9J8VwgQhiEXRo34P2hz/d9YPzRQQISvRNyzi6G6X+GYRniYcuiMf2+f8/uE
 O+5FTDXzzYLwo/8V6PJA6EU1+LNAGZ+MCNHtCYADJ4iHLsLrpvvVub6YLxx0/wW/z4Ri
 NyVAabh43kZh39AgyYLexdBM7dfzGmhiVd6NZ4HyGFQ/ro0ksj4gtI8MnqbwKmZFOQ5R
 2PdW0jnl/YOpFqU3lLafa9GUY3mvc2o4S3vkbr/ij/8e0M9it6UAlekPMV5TiPg/RxxM Og== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2jk0xr1vy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 17:42:16 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5FHgGCL031232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 17:42:16 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5FHgG34017029;
        Fri, 15 Jun 2018 17:42:16 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Jun 2018 10:42:16 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk
Subject: [PATCH v10 3/7] x86/time: read_boot_clock64() implementation
Date:   Fri, 15 Jun 2018 13:42:00 -0400
Message-Id: <20180615174204.30581-4-pasha.tatashin@oracle.com>
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

read_boot_clock64() returns time of when system was started. Now, that
early boot clock is going to be available on x86 it is possible to
implement x86 specific version of read_boot_clock64() that takes advantage
of this new feature.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/kernel/time.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/x86/kernel/time.c b/arch/x86/kernel/time.c
index 774ebafa97c4..32dff35719d9 100644
--- a/arch/x86/kernel/time.c
+++ b/arch/x86/kernel/time.c
@@ -15,6 +15,7 @@
 #include <linux/i8253.h>
 #include <linux/time.h>
 #include <linux/export.h>
+#include <linux/sched/clock.h>
 
 #include <asm/vsyscall.h>
 #include <asm/x86_init.h>
@@ -104,3 +105,32 @@ void __init time_init(void)
 {
 	late_time_init = x86_late_time_init;
 }
+
+/*
+ * Called once during to boot to initialize boot time.
+ * This function returns timestamp in timespec format which is sec/nsec from
+ * epoch of when boot started.
+ * We use sched_clock_cpu() that gives us nanoseconds from when this clock has
+ * been started and it happens quiet early during boot process. To calculate
+ * offset from epoch we use information provided in 'now' by the caller
+ *
+ * If sched_clock_cpu() is not available or if there is any kind of error
+ * i.e. time from epoch is smaller than boot time, we must return zeros in ts,
+ * and the caller will take care of the error: by assuming that the time when
+ * this function was called is the beginning of boot time.
+ */
+void __init read_boot_clock64(struct timespec64 *now, struct timespec64 *ts)
+{
+	u64 ns_boot = sched_clock_cpu(smp_processor_id());
+	bool valid_clock;
+	u64 ns_now;
+
+	ns_now = timespec64_to_ns(now);
+	valid_clock = ns_boot && timespec64_valid_strict(now) &&
+			(ns_now > ns_boot);
+
+	if (!valid_clock)
+		*ts = (struct timespec64){0, 0};
+	else
+		*ts = ns_to_timespec64(ns_now - ns_boot);
+}
-- 
2.17.1

