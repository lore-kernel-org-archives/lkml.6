Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7A2ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7446820862
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kibDvQCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7446820862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbeGSVmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 17:42:19 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45278 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731254AbeGSVmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 17:42:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6JKs5c3191508;
        Thu, 19 Jul 2018 20:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=KIc2q7BCkp3E2/GG6EsGHTnVhfILanH2549gIYVBqmw=;
 b=kibDvQCj1aC1eZMch/wTp4iH9P6wAqIh/qf9ArsG05FlwUie2fAlyXZFIlq+BDj0p2W6
 km3DO6JTnz7Qz52p8lMsjchAVdGboL+DrXrKPFMAKH5+s9grcgwr+kngMIRqHXGizdhK
 8sgyzpMYcjTjDcz/MyB9P+PtUJ14ViyCI5xZW7WOrQIHMj1u0MiZjcrDzQWbkH6kCnkz
 ObrMLP14UpKMj1KI5AGuj8AsBvZG7N8UgGD5fYMwPY1HZdO/k8bUl341sGLFrw4HgXnf
 BN8ISD5PvMqrjqll/Ny76Y36vMugmUiOFk0Ub5+oFvv8kwU94A1fgPk+Qey0W03zfMYg XA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2k9yjgrufb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 20:56:32 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6JKuVv3022438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 20:56:31 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6JKuU4n003646;
        Thu, 19 Jul 2018 20:56:30 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Jul 2018 20:56:30 +0000
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
Subject: [PATCH v15 10/26] x86/CPU: Call detect_nopl() only on the BSP
Date:   Thu, 19 Jul 2018 16:55:29 -0400
Message-Id: <20180719205545.16512-11-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180719205545.16512-1-pasha.tatashin@oracle.com>
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8959 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=868
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807190218
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

