Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F19C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A93D206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="5fxPzjdQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A93D206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbeLDWoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:44:04 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:55356 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbeLDWoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:44:02 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wB4Md6Sb150470;
        Tue, 4 Dec 2018 22:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=X9/RoA88m1xINqvMc/YZ1hMWuRFEDathW8WcQhLsLO4=;
 b=5fxPzjdQlcl0pkfzHqubR4iRBbvALOrjnohTQfkOnQhS+dXdaD0pMfLw3O4AYgqaFDm6
 WmUZWC6JDjrMJ3IAgZhvobnRzV3M1jCYlTSUHURME43dex/q2c+bfsbWUh5YKNsvv+hE
 RPm8Zv7BXC3RU5wTHwbJbMwAfvtWuIHyqdev1PO0hzC1cOiFHAA01mgntl6DPIXdaqtU
 rv82VDEaxLibIEs88t6a7gAMoFVuf5tJEXKGqllAF3dVWVrO7+chHxEcHVJYPPnhfnVv
 edjQnKFD+s06OJTWeIvZsFoVRDAGiJCrzkFWOq9xthjWuZJBP63riBEuTAWlouXewkV0 0Q== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2p3jxrf6un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Dec 2018 22:42:46 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wB4Mgial008623
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Dec 2018 22:42:45 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wB4MggCR023869;
        Tue, 4 Dec 2018 22:42:42 GMT
Received: from ayz-linux.us.oracle.com (/10.39.194.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Dec 2018 22:42:41 +0000
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org, vbabka@suse.cz,
        sfr@canb.auug.org.au, willy@infradead.org,
        kirill.shutemov@linux.intel.com, rppt@linux.vnet.ibm.com,
        mhocko@suse.com, alexander.h.duyck@linux.intel.com,
        hannes@cmpxchg.org, miles.chen@mediatek.com,
        n-horiguchi@ah.jp.nec.com
Subject: [PATCH] /proc/kpagecount: return 0 for special pages that are never mapped
Date:   Tue,  4 Dec 2018 14:45:26 -0800
Message-Id: <1543963526-27917-1-git-send-email-anthony.yznaga@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9097 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=890
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812040194
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain pages that are never mapped to userspace have a type
indicated in the page_type field of their struct pages (e.g. PG_buddy).
page_type overlaps with _mapcount so set the count to 0 and avoid
calling page_mapcount() for these pages.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 fs/proc/page.c             | 2 +-
 include/linux/page-flags.h | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

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
index 50ce1bddaf56..f9a1c50ccefc 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -673,10 +673,17 @@ static inline int TestClearPageDoubleMap(struct page *page)
 #define PG_balloon	0x00000100
 #define PG_kmemcg	0x00000200
 #define PG_table	0x00000400
+#define PAGE_TYPE_ALL	(PG_buddy | PG_balloon | PG_kmemcg | PG_table)
 
 #define PageType(page, flag)						\
 	((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
 
+static inline int page_has_type(struct page *page)
+{
+	return (PageType(page, 0) &&
+	       ((page->page_type & PAGE_TYPE_ALL) != PAGE_TYPE_ALL));
+}
+
 #define PAGE_TYPE_OPS(uname, lname)					\
 static __always_inline int Page##uname(struct page *page)		\
 {									\
-- 
1.8.3.1

