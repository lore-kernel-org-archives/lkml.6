Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ABA4C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBBCC208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cAzwWZ4f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBBCC208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966440AbeFORnr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:43:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58858 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966007AbeFORnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:43:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5FHcZmZ071375;
        Fri, 15 Jun 2018 17:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=FjZotc37sHYfWrdqgD1E5Dhz5M1myuueHadj/NjahIo=;
 b=cAzwWZ4fP5oDXyrnt62VDhRbhXxJnJmsykDFCdbBTZE73Zd3Q56XoDnCTJCKUQ2toz8O
 RvQkdg+s+gbfkT8FalRX1X5iz0qRHkCbeLPRxuOg3AOGaWCEewwF2CJX5GwdUb8p/7Q1
 Qwg7V18dLCimZrqBsuFoUqK+oSJDfNiqklSRs9p2FPvNZWGzn9TjBUKue90GSGhsHU5f
 jV5TjjZ2PMWF9RnbgAV3YdxcaQClg/fwQKTDhNYT0OMFA1+IN6JNKg+z95Db72/AfjnL
 36Q2/dvHpZGpCSnsEZwfxnRP3T6Qoh8/k24KxVrVGUH5NgJNxuYuX0gYVDFh9QHH6a06 Rw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2jk0xrsvpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 17:42:15 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5FHgErM031159
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 17:42:14 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5FHgEKg017022;
        Fri, 15 Jun 2018 17:42:14 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Jun 2018 10:42:14 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk
Subject: [PATCH v10 2/7] time: sync read_boot_clock64() with persistent clock
Date:   Fri, 15 Jun 2018 13:41:59 -0400
Message-Id: <20180615174204.30581-3-pasha.tatashin@oracle.com>
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

read_boot_clock64() returns a boot start timestamp from epoch. Some arches
may need to access the persistent clock interface in order to calculate the
epoch offset. The resolution of the persistent clock, however, might be
low.  Therefore, in order to avoid time discrepancies a new argument 'now'
is added to read_boot_clock64() parameters. Arch may decide to use it
instead of accessing persistent clock again.

Also, change read_boot_clock64() to have __init prototype since it is
accessed only during boot.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/arm/kernel/time.c      | 2 +-
 arch/s390/kernel/time.c     | 2 +-
 include/linux/timekeeping.h | 2 +-
 kernel/time/timekeeping.c   | 8 ++++++--
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index cf2701cb0de8..40fd2e036eef 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -90,7 +90,7 @@ void read_persistent_clock64(struct timespec64 *ts)
 	__read_persistent_clock(ts);
 }
 
-void read_boot_clock64(struct timespec64 *ts)
+void __init read_boot_clock64(struct timespec64 *now, struct timespec64 *ts)
 {
 	__read_boot_clock(ts);
 }
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index cf561160ea88..9b0c69e3d795 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -221,7 +221,7 @@ void read_persistent_clock64(struct timespec64 *ts)
 	ext_to_timespec64(clk, ts);
 }
 
-void read_boot_clock64(struct timespec64 *ts)
+void __init read_boot_clock64(struct timespec64 *now, struct timespec64 *ts)
 {
 	unsigned char clk[STORE_CLOCK_EXT_SIZE];
 	__u64 delta;
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 86bc2026efce..6b607e8bedfa 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -243,7 +243,7 @@ extern void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot);
 extern int persistent_clock_is_local;
 
 extern void read_persistent_clock64(struct timespec64 *ts);
-extern void read_boot_clock64(struct timespec64 *ts);
+extern void read_boot_clock64(struct timespec64 *now, struct timespec64 *ts);
 extern int update_persistent_clock64(struct timespec64 now);
 
 /*
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4786df904c22..fb6898fab374 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1502,9 +1502,13 @@ void __weak read_persistent_clock64(struct timespec64 *ts64)
  * Function to read the exact time the system has been started.
  * Returns a timespec64 with tv_sec=0 and tv_nsec=0 if unsupported.
  *
+ * Argument 'now' contains time from persistent clock to calculate offset from
+ * epoch. May contain zeros if persist ant clock is not available.
+ *
  *  XXX - Do be sure to remove it once all arches implement it.
  */
-void __weak read_boot_clock64(struct timespec64 *ts)
+void __weak __init read_boot_clock64(struct timespec64 *now,
+				     struct timespec64 *ts)
 {
 	ts->tv_sec = 0;
 	ts->tv_nsec = 0;
@@ -1535,7 +1539,7 @@ void __init timekeeping_init(void)
 	} else if (now.tv_sec || now.tv_nsec)
 		persistent_clock_exists = true;
 
-	read_boot_clock64(&boot);
+	read_boot_clock64(&now, &boot);
 	if (!timespec64_valid_strict(&boot)) {
 		pr_warn("WARNING: Boot clock returned invalid value!\n"
 			"         Check your CMOS/BIOS settings.\n");
-- 
2.17.1

