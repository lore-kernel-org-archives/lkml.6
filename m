Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66C0C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D66C2502D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 18:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MZ59kktU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D66C2502D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753216AbeGBSFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 14:05:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44038 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752927AbeGBSFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 14:05:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w62I47gt179602;
        Mon, 2 Jul 2018 18:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2017-10-26;
 bh=C6zE+J8vXI4FLk3e+K2be6GDmydsnKSY9uTRPUSkTVg=;
 b=MZ59kktUtxQ5g94Ni3iRD/YsyfOQBLIV3nA5v9BWR66AOt42Lx2n/Hdbt638CtTVjSs1
 YWV5dNTN8OmkEUOxXpnsqsJtY9AmvGvSksdcHMl7m8Esimpz0DFPZiu91fjXWvIsrblv
 mAXsf6/Q4c7Cpwkg5QEHOdmAkj1VR74CkErLVgek5AGe4LYR0SH8RVidDNiLT8JUBN6C
 tPzhaaH7o4V5TFyWjTVZVkGI9NDLoBzhSGSOwjmM5NOLjVBNTS39ofG1azlS+qnaadLS
 NWvDEKrw9h976po3/UxQeqw8ThEvpScLiWqtGdbKGQBTkEwi9BvaBFMK9DYgauoplTle Mw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2jx2gpwga6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Jul 2018 18:05:42 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w62I5fFl029014
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Jul 2018 18:05:41 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w62I5edp003462;
        Mon, 2 Jul 2018 18:05:40 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Jul 2018 11:05:40 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, mgorman@techsingularity.net,
        gregkh@linuxfoundation.org, pasha.tatashin@oracle.com
Subject: [PATCH v2] mm: teach dump_page() to correctly output poisoned struct pages
Date:   Mon,  2 Jul 2018 14:05:36 -0400
Message-Id: <20180702180536.2552-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8942 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807020202
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If struct page is poisoned, and uninitialized access is detected via
PF_POISONED_CHECK(page) dump_page() is called to output the page. But,
the dump_page() itself accesses struct page to determine how to print
it, and therefore gets into a recursive loop.

For example:
dump_page()
 __dump_page()
  PageSlab(page)
   PF_POISONED_CHECK(page)
    VM_BUG_ON_PGFLAGS(PagePoisoned(page), page)
     dump_page() recursion loop.

Fixes: f165b378bbdf ("mm: uninitialized struct page poisoning sanity checking")

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/debug.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/mm/debug.c b/mm/debug.c
index 56e2d9125ea5..38c926520c97 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -43,12 +43,25 @@ const struct trace_print_flags vmaflag_names[] = {
 
 void __dump_page(struct page *page, const char *reason)
 {
+	bool page_poisoned = PagePoisoned(page);
+	int mapcount;
+
+	/*
+	 * If struct page is poisoned don't access Page*() functions as that
+	 * leads to recursive loop. Page*() check for poisoned pages, and calls
+	 * dump_page() when detected.
+	 */
+	if (page_poisoned) {
+		pr_emerg("page:%px is uninitialized and poisoned", page);
+		goto hex_only;
+	}
+
 	/*
 	 * Avoid VM_BUG_ON() in page_mapcount().
 	 * page->_mapcount space in struct page is used by sl[aou]b pages to
 	 * encode own info.
 	 */
-	int mapcount = PageSlab(page) ? 0 : page_mapcount(page);
+	mapcount = PageSlab(page) ? 0 : page_mapcount(page);
 
 	pr_emerg("page:%px count:%d mapcount:%d mapping:%px index:%#lx",
 		  page, page_ref_count(page), mapcount,
@@ -60,6 +73,7 @@ void __dump_page(struct page *page, const char *reason)
 
 	pr_emerg("flags: %#lx(%pGp)\n", page->flags, &page->flags);
 
+hex_only:
 	print_hex_dump(KERN_ALERT, "raw: ", DUMP_PREFIX_NONE, 32,
 			sizeof(unsigned long), page,
 			sizeof(struct page), false);
@@ -68,7 +82,7 @@ void __dump_page(struct page *page, const char *reason)
 		pr_alert("page dumped because: %s\n", reason);
 
 #ifdef CONFIG_MEMCG
-	if (page->mem_cgroup)
+	if (!page_poisoned && page->mem_cgroup)
 		pr_alert("page->mem_cgroup:%px\n", page->mem_cgroup);
 #endif
 }
-- 
2.18.0

