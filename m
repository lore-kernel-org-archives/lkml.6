Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC03CECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D522084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 20:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lb9Pauuk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91D522084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731701AbeGSVmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 17:42:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45826 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730315AbeGSVmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 17:42:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6JKsSHZ191938;
        Thu, 19 Jul 2018 20:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=Ll/YJfhEp8kkigECxmh0rN/scwVAYPDz9KNxD8BsL3o=;
 b=lb9PauukOkB31hMwsKQBtXHPa+wbdWqD7YBpRgRjrWLRfavu40xHz81cW5WNewWFvJoc
 mwrNapoCRVCsX5gL7jt8iqeZORqIL2q31IAxAf++1NMFDqKT3kQiM25sSfcJZFQJRSNl
 sTyEszU4fdCoR45bOZdKno+enz13uUOglq0TQI5F0ADptz95tKJJC9yEmnA7o3qIkxAz
 q/BEurbd3SUifFLjsOniKQJj3vpQ551pvkeeRc8ramKHIkRaU1/CqhxhLtH+UOMCd2pj
 p4bsL2YTJBUSdH3iEFudMSnx7pmxbkbHOgfdNqmpkyCHoerhUPDeva/BDtXdMwOSW2OF qA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2k9yjgrugy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 20:56:53 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6JKuq6a014472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jul 2018 20:56:52 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6JKupZN026990;
        Thu, 19 Jul 2018 20:56:51 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Jul 2018 20:56:51 +0000
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
Subject: [PATCH v15 21/26] x86/tsc: use tsc early
Date:   Thu, 19 Jul 2018 16:55:40 -0400
Message-Id: <20180719205545.16512-22-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180719205545.16512-1-pasha.tatashin@oracle.com>
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8959 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=997
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807190218
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
index 7ea0718a4c75..9277ae9b68b3 100644
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

