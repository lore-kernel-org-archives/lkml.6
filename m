Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0692CC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59CC2146E
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="xb9+kqqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A59CC2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391052AbeGLANw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 20:13:52 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39522 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388774AbeGLANv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 20:13:51 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6C04kZt178248;
        Thu, 12 Jul 2018 00:04:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=RiGhTN6g///YxNlAnsuvWKTlhs2d21Xsjt/HDHC/SIs=;
 b=xb9+kqqXpu8CTCnBlEkFShV463SWHkFLNk1KQ71+s/Th3XAxZ75UogYMIbHBHJlpwaFy
 J5Zj7GBkdiC3QBD0X0iilUobPIojLwrPr0lOnLIyoeJk8zYF16F2ThXTZRs5Vr6rf8SF
 Y4KCNN9nqYOtI3xrvYX8mPuZhsAh9Ej3LS2E5DBd9kMTS/ricppdcb5aOVhfXcC9lTqC
 PiwJE0f1eWyiAGNtDCz6b4bW0fR5hPLaOVwQfYl2W+Q/bjIJwZ6SLwTrRItoncZAUPLU
 I3XCliia2ampikgL8T/Y/r/kD1yJXk61QiCYihS95jAx5AM38CHbleYKQdRRciI6jQQr Rg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2k2p760972-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 00:04:46 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6C04jPk029475
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 00:04:45 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6C04iQI011296;
        Thu, 12 Jul 2018 00:04:44 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Jul 2018 17:04:44 -0700
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
Subject: [PATCH v13 10/18] time: default boot time offset to local_clock()
Date:   Wed, 11 Jul 2018 20:04:11 -0400
Message-Id: <20180712000419.5165-11-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712000419.5165-1-pasha.tatashin@oracle.com>
References: <20180712000419.5165-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8951 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=781
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807110252
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

