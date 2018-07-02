Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0A1C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E98224F5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 15:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ez4NJT9j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E98224F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbeGBP2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 11:28:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50514 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbeGBP2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 11:28:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w62FNhXW059281;
        Mon, 2 Jul 2018 15:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2017-10-26;
 bh=7JVta26K3EWVK9Ef4HUOSNMhHsGCCm/X3kHEZ+2IeBY=;
 b=ez4NJT9jXd/9sAGgqM0Hbr2LszyOIZkbFq3gqEPEkwZSuxdcYFNQI1txdUWBDGFVockX
 3613pMoqDicXJRO64eHUYElEbe+CFl/4LrFu3gc3S96va6S0u47+9Mc19M3+83lZEkzD
 d9hV3SSTWw9Oz1T/4H4F4cvzOOKzOjeD3UvVeIk0ENYE3bIWsi6q4UU7DB3/yjRPRzTR
 Mt9RkpZvt3ipEpn/rNNiX68ZQrEQXDgsGuY7/bnXHjqv+SZS9PLbUzDYph+OXXCpefUy
 k1cwMrZHtk/fdr8Ndkh7S6StK1/4tzOXJ1jLqHgs+RCHIwq6nvPODU2bFKYpDbMI1Bdi IA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2jx2gpvx64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Jul 2018 15:27:53 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w62FRpYG026287
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Jul 2018 15:27:51 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w62FRoTu022580;
        Mon, 2 Jul 2018 15:27:50 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Jul 2018 08:27:49 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, mgorman@techsingularity.net,
        gregkh@linuxfoundation.org, pasha.tatashin@oracle.com
Subject: [PATCH] mm: teach dump_page() to correctly output poisoned struct pages
Date:   Mon,  2 Jul 2018 11:27:45 -0400
Message-Id: <20180702152745.27596-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8941 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807020176
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
---
 mm/debug.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/debug.c b/mm/debug.c
index 56e2d9125ea5..469b526e6abc 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -43,12 +43,20 @@ const struct trace_print_flags vmaflag_names[] = {
 
 void __dump_page(struct page *page, const char *reason)
 {
+	bool page_poisoned = PagePoisoned(page);
+	int mapcount;
+
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
@@ -60,6 +68,7 @@ void __dump_page(struct page *page, const char *reason)
 
 	pr_emerg("flags: %#lx(%pGp)\n", page->flags, &page->flags);
 
+hex_only:
 	print_hex_dump(KERN_ALERT, "raw: ", DUMP_PREFIX_NONE, 32,
 			sizeof(unsigned long), page,
 			sizeof(struct page), false);
@@ -68,7 +77,7 @@ void __dump_page(struct page *page, const char *reason)
 		pr_alert("page dumped because: %s\n", reason);
 
 #ifdef CONFIG_MEMCG
-	if (page->mem_cgroup)
+	if (!page_poisoned && page->mem_cgroup)
 		pr_alert("page->mem_cgroup:%px\n", page->mem_cgroup);
 #endif
 }
-- 
2.18.0

