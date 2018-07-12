Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23059C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF37E208E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aDwa/YIG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF37E208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390990AbeGLANN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 20:13:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:35440 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390892AbeGLANJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 20:13:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6C04YNX185816;
        Thu, 12 Jul 2018 00:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=KIc2q7BCkp3E2/GG6EsGHTnVhfILanH2549gIYVBqmw=;
 b=aDwa/YIG7RFi/XaK5u5+dUKGWcEAydvceL+Y3ZojbV8s3L9ZtVg4kSVNhdITtGJa99BL
 pKeILv40Y7GJsKmT9AX9eIRJBX23/1DplMA8dbLUw7UjY5Clb2dKUrnvvxo0vM0kTDln
 Pk3PY7xBxOcuf7VPiELxQ9eOSNVp6mvLVadQ/VvFhD0svhFBkP/rMH3Nlp0UmOx9y7Gh
 qley2oDbXjkRwaAv+ycqltFO0S979WLDkKF8dX4OHq+bFsxpcIUl6838Z5NJqNOESBFz
 d/C11lzyR6GJ7aHsAyZnlY6L+NFHrV4yYmv/EsDQfweTmZxT0HddjVzHhQpAPJdrLJqX bw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2k2p7e09gd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 00:04:34 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6C04YSn032620
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 00:04:34 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6C04Ug5004536;
        Thu, 12 Jul 2018 00:04:31 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Jul 2018 17:04:30 -0700
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
Subject: [PATCH v13 03/18] x86/CPU: Call detect_nopl() only on the BSP
Date:   Wed, 11 Jul 2018 20:04:04 -0400
Message-Id: <20180712000419.5165-4-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712000419.5165-1-pasha.tatashin@oracle.com>
References: <20180712000419.5165-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8951 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=840
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807110252
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@alien8.de>

Make it use the setup_* variants and have it be called only on the BSP
and drop the call in generic_identify() - X86_FEATURE_NOPL will be
replicated to the APs through the forced caps. Helps keep the mess at a
manageable level.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/kernel/cpu/common.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 71281ac43b15..46408a8cdf62 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1024,12 +1024,12 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
  * unless we can find a reliable way to detect all the broken cases.
  * Enable it explicitly on 64-bit for non-constant inputs of cpu_has().
  */
-static void detect_nopl(struct cpuinfo_x86 *c)
+static void detect_nopl(void)
 {
 #ifdef CONFIG_X86_32
-	clear_cpu_cap(c, X86_FEATURE_NOPL);
+	setup_clear_cpu_cap(X86_FEATURE_NOPL);
 #else
-	set_cpu_cap(c, X86_FEATURE_NOPL);
+	setup_force_cpu_cap(X86_FEATURE_NOPL);
 #endif
 }
 
@@ -1108,7 +1108,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 	if (!pgtable_l5_enabled())
 		setup_clear_cpu_cap(X86_FEATURE_LA57);
 
-	detect_nopl(c);
+	detect_nopl();
 }
 
 void __init early_cpu_init(void)
@@ -1206,8 +1206,6 @@ static void generic_identify(struct cpuinfo_x86 *c)
 
 	get_model_name(c); /* Default name */
 
-	detect_nopl(c);
-
 	detect_null_seg_behavior(c);
 
 	/*
-- 
2.18.0

