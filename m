Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27147ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB85D2081D
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KAhi1q2w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB85D2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387734AbeKFCRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 21:17:30 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38834 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387677AbeKFCR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 21:17:29 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wA5Gs0qK097046;
        Mon, 5 Nov 2018 16:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=a2OiRCY8BwYFe4eDIMRKDWwH3Sf4ADRCu0KAZGhXWg0=;
 b=KAhi1q2wPZLA+lEK3/3KyAFRrNkzLqmyxyDpGjQBIRkQwSlyk2/8oO9cw6hBVtplTD0Y
 Fr8lywyV+UoD7H5NFj17FJ42jAJbGq2lg05a59C8u/REeu+F4N7MwoFCUpeubJBVUKYX
 4N7PDIBXJBmuJNPIuWdfFC39Cj+QCYHBlaGg/AFPGU+mJgSMkbb/ll62cYJUFdZ5JoYJ
 Ui41GCe9B+4kFzh7uMqR7qSdRd4dxCpKg+h9km1Z3MJ1Mdzmd1KfAzxCf3ax3bMAWOYy
 IkW/pkXENgdYH1+GwlT+AYH1b0Tq+o1epsWlUIMJJdcANSEpQiigwKPy+wUK55U6482m Ag== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2nh33tr6bp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Nov 2018 16:56:24 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA5GuOXj025118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Nov 2018 16:56:24 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA5GuNaR008457;
        Mon, 5 Nov 2018 16:56:23 GMT
Received: from localhost.localdomain (/73.60.114.248)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Nov 2018 08:56:23 -0800
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     linux-mm@kvack.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     aarcange@redhat.com, aaron.lu@intel.com, akpm@linux-foundation.org,
        alex.williamson@redhat.com, bsd@redhat.com,
        daniel.m.jordan@oracle.com, darrick.wong@oracle.com,
        dave.hansen@linux.intel.com, jgg@mellanox.com, jwadams@google.com,
        jiangshanlai@gmail.com, mhocko@kernel.org, mike.kravetz@oracle.com,
        Pavel.Tatashin@microsoft.com, prasad.singamsetty@oracle.com,
        rdunlap@infradead.org, steven.sistare@oracle.com,
        tim.c.chen@intel.com, tj@kernel.org, vbabka@suse.cz
Subject: [RFC PATCH v4 10/13] mm: enlarge type of offset argument in mem_map_offset and mem_map_next
Date:   Mon,  5 Nov 2018 11:55:55 -0500
Message-Id: <20181105165558.11698-11-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9068 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=778
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1811050153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes the type of 'offset' from int to unsigned long in both
mem_map_offset and mem_map_next.

This facilitates ktask's use of mem_map_next with its unsigned long
types to avoid silent truncation when these unsigned longs are passed as
ints.

It also fixes the preexisting truncation of 'offset' from unsigned long
to int by the sole caller of mem_map_offset, follow_hugetlb_page.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 mm/internal.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 3b1ec1412fd2..cc90de4d4e01 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -367,7 +367,8 @@ static inline void mlock_migrate_page(struct page *new, struct page *old) { }
  * the maximally aligned gigantic page 'base'.  Handle any discontiguity
  * in the mem_map at MAX_ORDER_NR_PAGES boundaries.
  */
-static inline struct page *mem_map_offset(struct page *base, int offset)
+static inline struct page *mem_map_offset(struct page *base,
+					  unsigned long offset)
 {
 	if (unlikely(offset >= MAX_ORDER_NR_PAGES))
 		return nth_page(base, offset);
@@ -378,8 +379,8 @@ static inline struct page *mem_map_offset(struct page *base, int offset)
  * Iterator over all subpages within the maximally aligned gigantic
  * page 'base'.  Handle any discontiguity in the mem_map.
  */
-static inline struct page *mem_map_next(struct page *iter,
-						struct page *base, int offset)
+static inline struct page *mem_map_next(struct page *iter, struct page *base,
+					unsigned long offset)
 {
 	if (unlikely((offset & (MAX_ORDER_NR_PAGES - 1)) == 0)) {
 		unsigned long pfn = page_to_pfn(base) + offset;
-- 
2.19.1

