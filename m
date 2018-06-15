Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB8CC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B9C208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jMBthNUC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B9C208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966423AbeFORnp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:43:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58854 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965916AbeFORnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:43:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5FHcXrw071369;
        Fri, 15 Jun 2018 17:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=PhlQovQUtqxvQY7YwG/AEyhHnbXUMSQojHf+J/RT/Wo=;
 b=jMBthNUCUa2BrHBZSqhkE1rTTeOp7mXmnghZ+oJSruRpSbYpa5XiXi2zPNiB7vvKFxD6
 YK8cR+iKfmwm0V/bUPjfdLoBrVKNFauG6hnbr4PH8CwH37u/ZNXmi0nMorEw5F9ll7Z3
 V6T9PnIs+J9/bGpLTczp7N3AkGQ2bD+Fci7yKOiYWXfvquHYmGLKYQqcEuRPGClD4eWz
 OCUIjOaWmAQOzOZKTFCmlvwHB9Wzqs33MKQ8SeiwzemPWa8ac4Jgw3pJo6mS9MWZ79Qe
 Uz87bhp/AmiPXR1QRKUPzCw36aBRqnQ32reaxH9ykf1qb4kcbQwLbEAyd4d4Lu3Df9JO SA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2jk0xrsvpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 17:42:20 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5FHgJ7w009868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 17:42:19 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5FHgIpe022515;
        Fri, 15 Jun 2018 17:42:18 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Jun 2018 10:42:18 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk
Subject: [PATCH v10 4/7] sched: early boot clock
Date:   Fri, 15 Jun 2018 13:42:01 -0400
Message-Id: <20180615174204.30581-5-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180615174204.30581-1-pasha.tatashin@oracle.com>
References: <20180615174204.30581-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8925 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=979
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806150189
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow sched_clock() to be used before schec_clock_init() and
sched_clock_init_late() are called. This provides us with a way to get
early boot timestamps on machines with unstable clocks.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 kernel/sched/clock.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index 10c83e73837a..f034392b0f6c 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -205,6 +205,11 @@ void clear_sched_clock_stable(void)
  */
 static int __init sched_clock_init_late(void)
 {
+	/* Transition to unstable clock from early clock */
+	local_irq_disable();
+	__gtod_offset = sched_clock() + __sched_clock_offset - ktime_get_ns();
+	local_irq_enable();
+
 	sched_clock_running = 2;
 	/*
 	 * Ensure that it is impossible to not do a static_key update.
@@ -350,8 +355,9 @@ u64 sched_clock_cpu(int cpu)
 	if (sched_clock_stable())
 		return sched_clock() + __sched_clock_offset;
 
-	if (unlikely(!sched_clock_running))
-		return 0ull;
+	/* Use early clock until sched_clock_init_late() */
+	if (unlikely(sched_clock_running < 2))
+		return sched_clock() + __sched_clock_offset;
 
 	preempt_disable_notrace();
 	scd = cpu_sdc(cpu);
-- 
2.17.1

