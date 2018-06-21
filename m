Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB7AC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3219D223FE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bBT2ldvO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3219D223FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933841AbeFUV1Y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:27:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37390 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933686AbeFUV0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:26:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5LLNrIX138879;
        Thu, 21 Jun 2018 21:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=ReGjLhaAMuvhh0hoEf/lu+nZxGNGBTlWtg+LG22EG3s=;
 b=bBT2ldvOVk03dFtHqpvKuhqgKXyhu6B9KmGvj1vmU6WoFIhqSuZAezice5+yEBLqhHfN
 KW8F0TvjFHNVEnksEk5fUG1L1C9SYq86xmekVHbRrwk8ayZmyOViUsZihGS3r9iIgNub
 SeuINYEJ82xIIIV252j4JfCEFPYFYCOHEwAXvpbppJu7XEA6Wcf19Kvq+HHLtY4ez1C4
 p5+1T8oT8VtoF2CqvmMF/5CcbEz56XRJgGgR4jQaAAz5ojSCeJs024w32spR8qJxhJ9Z
 XT8zFq09Q0jdBHCXgCdCUEzb8+xF2z4Sa4ezT6F73BPXxzKTOxRmMbjeClgj3ioXDLLn GQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2jmtgx3qdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jun 2018 21:25:39 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5LLPd9i016638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jun 2018 21:25:39 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5LLPcEb014079;
        Thu, 21 Jun 2018 21:25:38 GMT
Received: from xakep.us.oracle.com (/10.39.228.116)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Jun 2018 14:25:37 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org
Subject: [PATCH v12 08/11] ARM/time: remove read_boot_clock64()
Date:   Thu, 21 Jun 2018 17:25:15 -0400
Message-Id: <20180621212518.19914-9-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180621212518.19914-1-pasha.tatashin@oracle.com>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8931 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=827
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806210230
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

read_boot_clock64() is deleted, and replaced with
read_persistent_wall_and_boot_offset().

The default implementation of read_persistent_wall_and_boot_offset()
provides a better fallback than the current stubs for read_boot_clock64()
that arm has, so remove the old code.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/arm/kernel/time.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index cf2701cb0de8..0a6a457b13c7 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -83,29 +83,19 @@ static void dummy_clock_access(struct timespec64 *ts)
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
 int __init register_persistent_clock(clock_access_fn read_boot,
 				     clock_access_fn read_persistent)
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
 
-- 
2.17.1

