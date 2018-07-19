Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4019FECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5F72084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eg8Uu9vR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC5F72084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731612AbeGSVmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 17:42:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50464 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730358AbeGSVml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 17:42:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6JKsHcF160593;
        Thu, 19 Jul 2018 20:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=7LQv2NjuP1X+eZWi1Io1tq4pZKVS5ChpEiPREULa3w8=;
 b=eg8Uu9vRIc8hwuFojd5j5MNW2lMxUGYwrRJ1hyRTurLbXYIuM5gxcBNlMcMNlWgFapPD
 Xr9+hPN1xI9rk+L7kXrW1mPWG43sqCzwU8hsp1nylI1aXlQu/7QJqeQXsp9QFUa5JMrm
 h01wziSdO51zlgrUnVv41qOLYv7/miyrSr0YB/Gix3kvxBPnapa7RN8xOSl2HrMw3Nmp
 tLN9hyowAIPk/BFav7krCTDLOv784MldCe4e82Y5gDrZ3EP05l2HebRsMi2EykLotk20
 x4aZkWydSxInUSzM+7vUCR/thvBYpjGXwl7PMQnlwg9IGmVd0qTG5vGbUQbsVZPcv61D pA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2k9ykc8v6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 20:56:46 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6JKuimn001744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 20:56:45 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6JKuhdh027550;
        Thu, 19 Jul 2018 20:56:44 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Jul 2018 20:56:43 +0000
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
Subject: [PATCH v15 17/26] s390/time: remove read_boot_clock64()
Date:   Thu, 19 Jul 2018 16:55:36 -0400
Message-Id: <20180719205545.16512-18-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180719205545.16512-1-pasha.tatashin@oracle.com>
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8959 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=836
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807190218
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

read_boot_clock64() was replaced by read_persistent_wall_and_boot_offset()
so remove it.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/s390/kernel/time.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index d1f5447d5687..e8766beee5ad 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -239,19 +239,6 @@ void __init read_persistent_wall_and_boot_offset(struct timespec64 *wall_time,
 	*boot_offset = timespec64_sub(*wall_time, boot_time);
 }
 
-void read_boot_clock64(struct timespec64 *ts)
-{
-	unsigned char clk[STORE_CLOCK_EXT_SIZE];
-	__u64 delta;
-
-	delta = initial_leap_seconds + TOD_UNIX_EPOCH;
-	memcpy(clk, tod_clock_base, 16);
-	*(__u64 *) &clk[1] -= delta;
-	if (*(__u64 *) &clk[1] > delta)
-		clk[0]--;
-	ext_to_timespec64(clk, ts);
-}
-
 static u64 read_tod_clock(struct clocksource *cs)
 {
 	unsigned long long now, adj;
-- 
2.18.0

