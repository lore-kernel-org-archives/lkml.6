Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF48ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C322075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iTG7FDAX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0C322075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732015AbeGRC74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:59:56 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:47852 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731917AbeGRC7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:59:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6I2KnHt170139;
        Wed, 18 Jul 2018 02:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=RiGhTN6g///YxNlAnsuvWKTlhs2d21Xsjt/HDHC/SIs=;
 b=iTG7FDAXGwTMiZ8zK5ULPF5fizQZ60z46iy4me3cJSC1wbXonGpaJdcnUDmKDeDYp3b5
 Tg0r6YuYW2yHnFai5KP+KTKLAwxj9yo0tNOxbwICBLi6YRilyfSrsj82JWhrIkyJC2we
 tH9RQnnQdklP2/SqYG+dXeDuDgV+XJzK4Q4bTdRtwUV162bKdOJB6Jh+FK6vnzc/aUnh
 HCFxxrFiEeHesqyu5qRJ3dQvgJrNyWJx+SKVm+uk5kTQxyWb3C+dwCV9TWwG8AVsJbRA
 wWTwhi+4Yto6toSdKyBrWRBBBMCP2/+ExnEkC5mLL3ffNhecvbfniGsXthgwmJA3nbdc wA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2k7a3tb448-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:23:03 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6I2N3wf028164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:23:03 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6I2N29K020724;
        Wed, 18 Jul 2018 02:23:02 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 19:23:01 -0700
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
Subject: [PATCH v14 17/25] time: default boot time offset to local_clock()
Date:   Tue, 17 Jul 2018 22:22:03 -0400
Message-Id: <20180718022211.6259-18-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180718022211.6259-1-pasha.tatashin@oracle.com>
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8957 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=781
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807180026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

read_persistent_wall_and_boot_offset() is called during boot to read
both the persistent clock and also return the offset between the boot time
and the value of persistent clock.

Change the default boot_offset from zero to local_clock() so architectures,
that do not have a dedicated boot_clock but have early sched_clock(), such
as SPARCv9, x86, and possibly more will benefit from this change by getting
a better and more consistent estimate of the boot time without need for an
arch specific implementation.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 kernel/time/timekeeping.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index cb738f825c12..30d7f64ffc87 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1503,14 +1503,17 @@ void __weak read_persistent_clock64(struct timespec64 *ts64)
  * Weak dummy function for arches that do not yet support it.
  * wall_time	- current time as returned by persistent clock
  * boot_offset	- offset that is defined as wall_time - boot_time
- *		  default to 0.
+ * The default function calculates offset based on the current value of
+ * local_clock(). This way architectures that support sched_clock() but don't
+ * support dedicated boot time clock will provide the best estimate of the
+ * boot time.
  */
 void __weak __init
 read_persistent_wall_and_boot_offset(struct timespec64 *wall_time,
 				     struct timespec64 *boot_offset)
 {
 	read_persistent_clock64(wall_time);
-	*boot_offset = (struct timespec64){0};
+	*boot_offset = ns_to_timespec64(local_clock());
 }
 
 /* Flag for if timekeeping_resume() has injected sleeptime */
-- 
2.18.0

