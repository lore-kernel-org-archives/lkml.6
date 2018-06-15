Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EC34AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 15:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27C6208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 15:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E/vIE3kE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A27C6208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965991AbeFOP6O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 11:58:14 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:58460 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965975AbeFOP6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 11:58:10 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5FFsT8M069912;
        Fri, 15 Jun 2018 15:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2017-10-26;
 bh=yUWqIp9+8RD7OjliaE/vj9Mpm4ihOlswZO8+N4srvus=;
 b=E/vIE3kEeE3sd8WX1d1/I8VDn4TTYq0r0VSY0hQOrv67kBnzOmVEmdaHiHWAqt10T5lo
 R5oB2i58cOXDEKoLXz9oiBBeFOU12W6EJ3K9SjZ/XNdjoe1+SADRM4k7fwjzUXM94j1E
 zD9+SKJXcd1eiHZQP1pzuR4IN8wXl2Whdu3A4Er5nXV6zP6aU9bVW6Gv8MwKnXUk3ZFL
 DyOczKwtEw8zKwAqTLRKRlrmP5CGDTd9vQKSLkb0rRnvuRx2+QkAdK6VECETqt5kTWb/
 J2n/L2esp69QW/v3gRR0STl/DhauGuwCz6O/3/8TG+YkCJQymMwfiPFVwzbdyhCfkGyE dg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2jk0xr1k28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 15:57:42 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5FFvfGm021529
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jun 2018 15:57:42 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5FFveue022206;
        Fri, 15 Jun 2018 15:57:40 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Jun 2018 08:57:40 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com, n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org,
        osalvador@suse.de, willy@infradead.org, mingo@kernel.org,
        dan.j.williams@intel.com, ying.huang@intel.com
Subject: [PATCH] mm: skip invalid pages block at a time in zero_resv_unresv
Date:   Fri, 15 Jun 2018 11:57:33 -0400
Message-Id: <20180615155733.1175-1-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8924 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806150171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The role of zero_resv_unavail() is to make sure that every struct page that
is allocated but is not backed by memory that is accessible by kernel is
zeroed and not in some uninitialized state.

Since struct pages are allocated in blocks (2M pages in x86 case), we can
skip pageblock_nr_pages at a time, when the first one is found to be
invalid.

This optimization may help since now on x86 every hole in e820 maps
is marked as reserved in memblock, and thus will go through this function.

This function is called before sched_clock() is initialized, so I used my
x86 early boot clock patches to measure the performance improvement.

With 1T hole on i7-8700 currently we would take 0.606918s of boot time, but
with this optimization 0.001103s.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 mm/page_alloc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1521100f1e63..94f1b3201735 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6404,8 +6404,11 @@ void __paginginit zero_resv_unavail(void)
 	pgcnt = 0;
 	for_each_resv_unavail_range(i, &start, &end) {
 		for (pfn = PFN_DOWN(start); pfn < PFN_UP(end); pfn++) {
-			if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages)))
+			if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages))) {
+				pfn = ALIGN_DOWN(pfn, pageblock_nr_pages)
+					+ pageblock_nr_pages - 1;
 				continue;
+			}
 			mm_zero_struct_page(pfn_to_page(pfn));
 			pgcnt++;
 		}
-- 
2.17.1

