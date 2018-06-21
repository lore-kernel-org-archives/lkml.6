Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34463C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC2A22400
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SVBje/5B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC2A22400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933809AbeFUV1V (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:27:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37388 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933690AbeFUV0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:26:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5LLNo0q138854;
        Thu, 21 Jun 2018 21:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=jDp3kdeO+V3FT/o8M9ffwTtPyTe32mY/+j/FMS01+ls=;
 b=SVBje/5BKVsULwWsyhruIEjcrjG5bhKW/0t8Jgs/Q1ld9KbGRQictsyAXBg3ImFyfYCo
 qO5lUlKJWYJVEm1jipIl0Db7ALeh13xaAodaA0iQ191/MXSrELl75qsAVyQF5u+Bo2MT
 krKMUEjrYhEK7xxIYYXWnpI+91iVAOGmd+GJlZgl0dU7WEjkjB2Xqlb331l54OnIpehD
 iTPqIuVLoqTE2Aw6/v+VdS5NfeyU5chxgPnOL4vpf4oIgjnboZ+o4MQMibcd72pcdqa9
 gVR/yITWpfT8rdvQb/k84SU1gq7sllSWDTf0aK/M34GReDcC0jZOaxLKvnh2Exzjrxnv MA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2jmtgx3qdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jun 2018 21:25:37 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5LLPbVU030978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jun 2018 21:25:37 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5LLPagE015272;
        Thu, 21 Jun 2018 21:25:36 GMT
Received: from xakep.us.oracle.com (/10.39.228.116)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Jun 2018 14:25:36 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org
Subject: [PATCH v12 07/11] s390/time: remove read_boot_clock64()
Date:   Thu, 21 Jun 2018 17:25:14 -0400
Message-Id: <20180621212518.19914-8-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621212518.19914-1-pasha.tatashin@oracle.com>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8931 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=726
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806210230
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
2.17.1

