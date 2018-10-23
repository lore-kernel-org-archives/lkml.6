Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A8BC004D3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E71A20651
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 01:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C+LTJHHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E71A20651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbeJWJ2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 05:28:31 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34576 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbeJWJ2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 05:28:30 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9N13ke1068196;
        Tue, 23 Oct 2018 01:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2018-07-02;
 bh=xyh+6LIn/zx93kWvvPDDP/CQty6ehgvVf/AunxwN2uc=;
 b=C+LTJHHSGvFQZdlC9BMbs6JgQ+veeFxDfAaH6GMfPDv+6pLugXRrzu8v9ZzH911BAjJd
 RV3mAtc+2T7NEmMNTPRnY7nIKHYdb33QErGioFv0wboR7WuMeCCwKVi3C+YKEXK8pBqS
 7oIzJnroQQTxBWmzitJF2/KC5R/3tu10Y+PH8GbU3raHyfvSy/aX8EG9uJ/ah2iJdCOw
 X8BVvjgBWIH6BtkafpjvBuKxiujsZKNvpCIJDPzBrcZ/qELwINShoNAVTy5znliPGj8J
 248+LKBUvD4ugqlyxpfhCUk49b4d6mrvwzoNmHql7GF0nPEkmThxlJ3jZl47Vyk9WkEE 5Q== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2n7usu24cq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Oct 2018 01:07:14 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w9N17DnR029134
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Oct 2018 01:07:13 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w9N17DQj004243;
        Tue, 23 Oct 2018 01:07:13 GMT
Received: from x250.idc.oracle.com (/10.191.192.178)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Oct 2018 18:07:12 -0700
From:   Allen Pais <allen.pais@oracle.com>
To:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: hugetlb: Register hugepages during arch init
Date:   Tue, 23 Oct 2018 06:36:57 +0530
Message-Id: <1540256817-3327-1-git-send-email-allen.pais@oracle.com>
X-Mailer: git-send-email 1.9.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9054 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=939
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810230008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hstate for each supported hugepage size using arch initcall.

* no hugepage parameters

  Without hugepage parameters, only a default hugepage size is
  available for dynamic allocation.  It's different, for example, from
  x86_64 and sparc64 where all supported hugepage sizes are available.

* only default_hugepagesz= is specified and set not to HPAGE_SIZE

  In spite of the fact that default_hugepagesz= is set to a valid
  hugepage size, it's treated as unsupported and reverted to
  HPAGE_SIZE.  Such behaviour is also different from x86_64 and
  sparc64.

Reviewed-by: Tom Saeger <tom.saeger@oracle.com>
Signed-off-by: Dmitry Klochkov <dmitry.klochkov@oracle.com>
Signed-off-by: Allen Pais <allen.pais@oracle.com>
---
 arch/arm64/mm/hugetlbpage.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index f58ea50..28cbc22 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -429,6 +429,27 @@ void huge_ptep_clear_flush(struct vm_area_struct *vma,
 	clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
 }
 
+static void __init add_huge_page_size(unsigned long size)
+{
+	if (size_to_hstate(size))
+		return;
+
+	hugetlb_add_hstate(ilog2(size) - PAGE_SHIFT);
+}
+
+static int __init hugetlbpage_init(void)
+{
+#ifdef CONFIG_ARM64_4K_PAGES
+	add_huge_page_size(PUD_SIZE);
+#endif
+	add_huge_page_size(PMD_SIZE * CONT_PMDS);
+	add_huge_page_size(PMD_SIZE);
+	add_huge_page_size(PAGE_SIZE * CONT_PTES);
+
+	return 0;
+}
+arch_initcall(hugetlbpage_init);
+
 static __init int setup_hugepagesz(char *opt)
 {
 	unsigned long ps = memparse(opt, &opt);
@@ -440,7 +461,7 @@ static __init int setup_hugepagesz(char *opt)
 	case PMD_SIZE * CONT_PMDS:
 	case PMD_SIZE:
 	case PAGE_SIZE * CONT_PTES:
-		hugetlb_add_hstate(ilog2(ps) - PAGE_SHIFT);
+		add_huge_page_size(ps);
 		return 1;
 	}
 
@@ -449,13 +470,3 @@ static __init int setup_hugepagesz(char *opt)
 	return 0;
 }
 __setup("hugepagesz=", setup_hugepagesz);
-
-#ifdef CONFIG_ARM64_64K_PAGES
-static __init int add_default_hugepagesz(void)
-{
-	if (size_to_hstate(CONT_PTES * PAGE_SIZE) == NULL)
-		hugetlb_add_hstate(CONT_PTE_SHIFT);
-	return 0;
-}
-arch_initcall(add_default_hugepagesz);
-#endif
-- 
1.8.3.1

