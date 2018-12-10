Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8258C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820D12082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NW3pZive"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 820D12082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbeLJWdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:33:38 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:38832 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeLJWdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:33:38 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBAMSw32085664;
        Mon, 10 Dec 2018 22:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=jUnh0rJMfafk5uqoQf72BO44rZn02glTolGypQZLmVE=;
 b=NW3pZivewFgevt2l7va0D9mfwh3zFUe7mwrCovLb6bxu0v5BSwAMoR+JGJdHDgmDmpfO
 CRY0THv9hw3PBjZmGSTnTewGbucUun6eAg2BCWOsKSUM+RrWHnfywrwepTK59wMsO8rb
 cebboWfLDWz1g/SnGVrUbdKDVo3uuzzIuP2bNLzFlOo2fmirjX/lElOofYkCqBHDcZU6
 IFcjX9IJiaeSpFi+oSEZ23jLQloy2EMIvdAzaJm3Z3uHJ9KulUUpMKH/arAwCZumlViq
 sIPSl9igcZZrZ03DjJ1B4kppNjt97COYyCmwj/SDfMsICKNt/FQNYT4vsAHLHvc9dmVY 1w== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2p86kqrpsh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 22:32:55 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wBAMWovZ025392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Dec 2018 22:32:50 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBAMWlYi002057;
        Mon, 10 Dec 2018 22:32:47 GMT
Received: from ayz-linux.us.oracle.com (/10.39.193.52)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Dec 2018 14:32:46 -0800
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org, vbabka@suse.cz,
        sfr@canb.auug.org.au, willy@infradead.org,
        kirill.shutemov@linux.intel.com, rppt@linux.vnet.ibm.com,
        mhocko@suse.com, alexander.h.duyck@linux.intel.com,
        hannes@cmpxchg.org, miles.chen@mediatek.com,
        n-horiguchi@ah.jp.nec.com
Subject: [PATCH v2] /proc/kpagecount: return 0 for special pages that are never mapped
Date:   Mon, 10 Dec 2018 14:35:13 -0800
Message-Id: <1544481313-27318-1-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9103 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=877
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812100201
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain pages that are never mapped to userspace have a type
indicated in the page_type field of their struct pages (e.g. PG_buddy).
page_type overlaps with _mapcount so set the count to 0 and avoid
calling page_mapcount() for these pages.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
Acked-by: Matthew Wilcox <willy@infradead.org>
---
	v2 - incorporated feedback from Matthew Wilcox

 fs/proc/page.c             | 2 +-
 include/linux/page-flags.h | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 6c517b11acf8..40b05e0d4274 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -46,7 +46,7 @@ static ssize_t kpagecount_read(struct file *file, char __user *buf,
 			ppage = pfn_to_page(pfn);
 		else
 			ppage = NULL;
-		if (!ppage || PageSlab(ppage))
+		if (!ppage || PageSlab(ppage) || page_has_type(ppage))
 			pcount = 0;
 		else
 			pcount = page_mapcount(ppage);
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 50ce1bddaf56..39b4494e29f1 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -669,6 +669,7 @@ static inline int TestClearPageDoubleMap(struct page *page)
 
 #define PAGE_TYPE_BASE	0xf0000000
 /* Reserve		0x0000007f to catch underflows of page_mapcount */
+#define PAGE_MAPCOUNT_RESERVE	-128
 #define PG_buddy	0x00000080
 #define PG_balloon	0x00000100
 #define PG_kmemcg	0x00000200
@@ -677,6 +678,11 @@ static inline int TestClearPageDoubleMap(struct page *page)
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
 
+static inline int page_has_type(struct page *page)
+{
+	return (int)page->page_type < PAGE_MAPCOUNT_RESERVE;
+}
+
 #define PAGE_TYPE_OPS(uname, lname)					\
 static __always_inline int Page##uname(struct page *page)		\
 {									\
-- 
1.8.3.1

