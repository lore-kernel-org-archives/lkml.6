Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC7BC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0839A208FA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 06:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aQuui7/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0839A208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753973AbeGCGuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 02:50:21 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44740 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753033AbeGCGuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 02:50:19 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w636iJNb117137;
        Tue, 3 Jul 2018 06:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : content-type :
 content-transfer-encoding; s=corp-2017-10-26;
 bh=5uuzG7uVNpV6P+yJSI5AsQLYX+rFUQo92zJAOhM9/EE=;
 b=aQuui7/uVajDrHRcZpCv1CbZJH+x+kJEpuw/mPR/Hqub9aXPN6FVje4fNFtzfp7hW072
 FkbrKDOZ8A80EDD4kcSF6KRyglA5eMaAj4fIFcanyTizNJPvd5hvWEODMPg047fN9cvx
 4+44tfdZVbHi+HcSOlNSHjTE1+SosLo2RiTwu3tRy6ZU6OvRHpUItsIS7n7Ql75kRKw4
 XA8xCC7zdTzLt9pP9BD8uEkmgDamyOR2boo7s4CpAXO6Z3/hzU6lZrSeT8P/jYPIvCIB
 g6jruT4LmZzSTL0bIc7D/TtbxR7Hp8d/e/aXRf6eHhIM0UEBAbAwttniXMpQUcUPGYvG WQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2jwyccqac1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jul 2018 06:49:55 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w636nsxt024118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jul 2018 06:49:55 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w636nsXi028318;
        Tue, 3 Jul 2018 06:49:54 GMT
MIME-Version: 1.0
Message-ID: <b07b6ae9-4b57-4b40-b9bc-50c2c67f1d91@default>
Date:   Mon, 2 Jul 2018 23:49:54 -0700 (PDT)
From:   Zhenzhong Duan <zhenzhong.duan@oracle.com>
To:     <linux-kernel@vger.kernel.org>
Cc:     <mingo@redhat.com>, <x86@kernel.org>, <tglx@linutronix.de>,
        <srinivas.eeda@oracle.com>, <hpa@zytor.com>
Subject: [PATCH] x86/mm/32: Initialize CR4 shadow before __flush_tlb_all()
X-Mailer: Zimbra on Oracle Beehive
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8942 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=829
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807030077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In x86_32, __flush_tlb_all() may have read cr4 shadow before the
initialization of cr4 shadow in cpuinit().

Fix it by adding cr4_init_shadow() call ahead of __flush_tlb_all().

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc: Srinivas Reddy Eeda <srinivas.eeda@oracle.com>
---
 arch/x86/kernel/smpboot.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index c2f7d1d..db9656e 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -221,6 +221,11 @@ static void notrace start_secondary(void *unused)
 #ifdef CONFIG_X86_32
 =09/* switch away from the initial page table */
 =09load_cr3(swapper_pg_dir);
+=09/*
+=09 * Initialize the CR4 shadow before doing anything that could
+=09 * try to read it.
+=09 */
+=09cr4_init_shadow();
 =09__flush_tlb_all();
 #endif
 =09load_current_idt();
--=20
1.7.3
