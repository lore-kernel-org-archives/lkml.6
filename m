Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1173C46469
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8995E20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 01:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="3OI9XnRy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8995E20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeIKF47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 01:56:59 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59428 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbeIKF46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 01:56:58 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8B103Rl100843;
        Tue, 11 Sep 2018 01:00:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=GIGrhLpkq/UwRHuhh/oLny6MvSnAXVnSlsgDHYSyP4U=;
 b=3OI9XnRydeGejeV8QwnfkqjVjJlEVTTMlsrePEqSQOp4Y9+cOHcgzFBVUPLTe7hH4VG8
 de/MXWq1vMnQphx5FIDoOT4uZACs36ca8V1BVUnHkeMMNa3XwmVGXdTm0fl+uyO0nfNg
 He8/OjcPsPrUB0WIUZZ1f8ImYmmUv+wzyUBW7Dv3tRNEFLL+wwEJ20ujHgCATBJ9I53F
 mnzO7Z/KcdCSHNxoSwnBezQ7Eg/GfHI/OP+aA+M5DEUESD6TqwxBevbtVAq9C6dl5nJU
 Qkm34sbCV3bwoRuStRnX/I3qZSMzMh8fPlTctpw9vzGKzeLRuuj60WW1ictvvwTA04hv Ug== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2mc6cph2dv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 01:00:03 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w8B0xvuJ012610
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Sep 2018 00:59:58 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w8B0xvqe026769;
        Tue, 11 Sep 2018 00:59:57 GMT
Received: from localhost.localdomain (/73.143.71.164)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Sep 2018 17:59:57 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Cc:     aaron.lu@intel.com, ak@linux.intel.com, akpm@linux-foundation.org,
        dave.dice@oracle.com, dave.hansen@linux.intel.com,
        hannes@cmpxchg.org, levyossi@icloud.com,
        ldufour@linux.vnet.ibm.com, mgorman@techsingularity.net,
        mhocko@kernel.org, Pavel.Tatashin@microsoft.com,
        steven.sistare@oracle.com, tim.c.chen@intel.com,
        vdavydov.dev@gmail.com, ying.huang@intel.com
Subject: [RFC PATCH v2 5/8] mm: enable concurrent LRU removals
Date:   Mon, 10 Sep 2018 20:59:46 -0400
Message-Id: <20180911005949.5635-2-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180911004240.4758-1-daniel.m.jordan@oracle.com>
References: <20180911004240.4758-1-daniel.m.jordan@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9012 signatures=668708
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=928
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809110009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patch used the concurrent algorithm serially to see that it
was stable for one task.  Now in release_pages, take lru_lock as reader
instead of writer to allow concurrent removals from one or more LRUs.

Suggested-by: Yosef Lev <levyossi@icloud.com>
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 mm/swap.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 613b841bd208..b1030eb7f459 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -737,8 +737,8 @@ void release_pages(struct page **pages, int nr)
 		 * same pgdat. The lock is held only if pgdat != NULL.
 		 */
 		if (locked_pgdat && ++lock_batch == SWAP_CLUSTER_MAX) {
-			write_unlock_irqrestore(&locked_pgdat->lru_lock,
-						flags);
+			read_unlock_irqrestore(&locked_pgdat->lru_lock,
+					       flags);
 			locked_pgdat = NULL;
 		}
 
@@ -748,9 +748,8 @@ void release_pages(struct page **pages, int nr)
 		/* Device public page can not be huge page */
 		if (is_device_public_page(page)) {
 			if (locked_pgdat) {
-				write_unlock_irqrestore(
-						      &locked_pgdat->lru_lock,
-						      flags);
+				read_unlock_irqrestore(&locked_pgdat->lru_lock,
+						       flags);
 				locked_pgdat = NULL;
 			}
 			put_zone_device_private_or_public_page(page);
@@ -763,9 +762,8 @@ void release_pages(struct page **pages, int nr)
 
 		if (PageCompound(page)) {
 			if (locked_pgdat) {
-				write_unlock_irqrestore(
-						      &locked_pgdat->lru_lock,
-						      flags);
+				read_unlock_irqrestore(&locked_pgdat->lru_lock,
+						       flags);
 				locked_pgdat = NULL;
 			}
 			__put_compound_page(page);
@@ -776,14 +774,14 @@ void release_pages(struct page **pages, int nr)
 			struct pglist_data *pgdat = page_pgdat(page);
 
 			if (pgdat != locked_pgdat) {
-				if (locked_pgdat) {
-					write_unlock_irqrestore(
-					      &locked_pgdat->lru_lock, flags);
-				}
+				if (locked_pgdat)
+					read_unlock_irqrestore(
+						      &locked_pgdat->lru_lock,
+						      flags);
 				lock_batch = 0;
 				locked_pgdat = pgdat;
-				write_lock_irqsave(&locked_pgdat->lru_lock,
-						   flags);
+				read_lock_irqsave(&locked_pgdat->lru_lock,
+						  flags);
 			}
 
 			lruvec = mem_cgroup_page_lruvec(page, locked_pgdat);
@@ -800,7 +798,7 @@ void release_pages(struct page **pages, int nr)
 		list_add(&page->lru, &pages_to_free);
 	}
 	if (locked_pgdat)
-		write_unlock_irqrestore(&locked_pgdat->lru_lock, flags);
+		read_unlock_irqrestore(&locked_pgdat->lru_lock, flags);
 
 	mem_cgroup_uncharge_list(&pages_to_free);
 	free_unref_page_list(&pages_to_free);
-- 
2.18.0

