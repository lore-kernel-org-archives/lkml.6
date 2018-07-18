Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AB9ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D92352075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SfjXTS66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D92352075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731834AbeGRC7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 22:59:40 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45034 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731759AbeGRC7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:59:38 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6I2KC0F001408;
        Wed, 18 Jul 2018 02:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=Bm1hL3z8KtKQZK7Ksi8zPH4LHPDtf/936zlUb2rvrFk=;
 b=SfjXTS66am7xCl/QbAWU2aH03j9EzBY8TcAsa8RySLwlL9JVxh67jp+xtOD8NkU7fsHp
 wAkfn3BCY8QSJwoi1MwIbyMggboQpesB4MHeyrRVR4Atl9HPC/5QTNpJA2PRtFMeqmMt
 7KBPOJJt8tuxL99HX0//NBdnXuRM/o6+oyfLy8B8ye71J4HGLOivans5ggqsHL/TVyV4
 Pnon/gHNGzTO1zKiukNdZRMXvjKu2fgYr62g+UQ+Ahz5q0XjnEyN4LDF/VNV1lfw04kN
 2ttqqhJ49sRedFZrC7tQOQvsd9Dxzc4FIthuehtFBarngbmRpk+3SOgiH9HGRhKAlDdi ww== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2k7a3t34dt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:23:16 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6I2NFGd024566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:23:15 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6I2NEvG020853;
        Wed, 18 Jul 2018 02:23:14 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 19:23:14 -0700
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
Subject: [PATCH v14 22/25] x86/tsc: use tsc early
Date:   Tue, 17 Jul 2018 22:22:08 -0400
Message-Id: <20180718022211.6259-23-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180718022211.6259-1-pasha.tatashin@oracle.com>
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8957 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=946
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807180026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get timestamps and high resultion clock available to us as early as
possible.

native_sched_clock() outputs time based either on tsc after tsc_init() is
called later in boot, or using jiffies when clock interrupts are enabled,
which is also happens later in boot.

On the other hand, tsc frequency is known from as early as when
tsc_early_init() is called.

Use the early tsc calibration to output timestamps early.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/kernel/tsc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 0b1abe7fdd8e..39ff2881f622 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1408,6 +1408,7 @@ void __init tsc_early_init(void)
 	/* Sanitize TSC ADJUST before cyc2ns gets initialized */
 	tsc_store_and_check_tsc_adjust(true);
 	cyc2ns_init_boot_cpu();
+	static_branch_enable(&__use_tsc);
 }
 
 void __init tsc_init(void)
-- 
2.18.0

