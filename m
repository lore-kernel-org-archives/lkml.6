Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24733C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1DF720856
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 00:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o327C6cV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1DF720856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388602AbeGYBfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 21:35:25 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52276 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388495AbeGYBfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 21:35:24 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6P0NvdY146026;
        Wed, 25 Jul 2018 00:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=6aWuan11IWk/DcBupTrYoAeSdfAJLrkW5ftubRZU8OU=;
 b=o327C6cVX2BuJz1UGd+tYK9O6iWH/6vEnDrETVH4HfFfevq+MGKk8mbipzGifHpTTjWf
 gggz+9E6jMy6pwZbn6Iwh01M48HuUqx9hdWejRj1oC8OdgVgYMNjhLht6BaE0nXvC/NI
 pkTF5nxLPt1WDoBFjV/OWb024N3rfYgn6/RxBer8suFaGm91U2I6SDZx4vfNFQpLXbbK
 GLpudTcZ03HzaJJqwkbtxux7ZqFjwDWRYnCy6TZ0igXKNSiR7lvdGxEEMuBeZ1TcfqtK
 u1PQvzN1kFsFEncrCX9Ab8PkmZGzu4QYoAV6EEXau1Zzr4pWekhFUVmF6mF4u/5oKru0 sw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2kbtbcue8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jul 2018 00:25:51 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6P0PoxH004882
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Jul 2018 00:25:50 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6P0Pm6p012502;
        Wed, 25 Jul 2018 00:25:48 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 24 Jul 2018 16:55:27 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, dan.j.williams@intel.com, jack@suse.cz,
        jglisse@redhat.com, jrdr.linux@gmail.com, bhe@redhat.com,
        gregkh@linuxfoundation.org, vbabka@suse.cz,
        richard.weiyang@gmail.com, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org,
        osalvador@techadventures.net, pasha.tatashin@oracle.com,
        abdhalee@linux.vnet.ibm.com, mpe@ellerman.id.au
Subject: [PATCH 1/3] mm: make memmap_init a proper function
Date:   Tue, 24 Jul 2018 19:55:18 -0400
Message-Id: <20180724235520.10200-2-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724235520.10200-1-pasha.tatashin@oracle.com>
References: <20180724235520.10200-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8964 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=605
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807250002
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memmap_init is sometimes a macro sometimes a function based on
__HAVE_ARCH_MEMMAP_INIT. It is only a function on ia64. Make
memmap_init a weak function instead, and let ia64 redefine it.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/ia64/include/asm/pgtable.h | 1 -
 mm/page_alloc.c                 | 9 +++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
index 165827774bea..b1e7468eb65a 100644
--- a/arch/ia64/include/asm/pgtable.h
+++ b/arch/ia64/include/asm/pgtable.h
@@ -544,7 +544,6 @@ extern struct page *zero_page_memmap_ptr;
 
 #  ifdef CONFIG_VIRTUAL_MEM_MAP
   /* arch mem_map init routine is needed due to holes in a virtual mem_map */
-#   define __HAVE_ARCH_MEMMAP_INIT
     extern void memmap_init (unsigned long size, int nid, unsigned long zone,
 			     unsigned long start_pfn);
 #  endif /* CONFIG_VIRTUAL_MEM_MAP */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a790ef4be74e..cea749b26394 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5554,10 +5554,11 @@ static void __meminit zone_init_free_lists(struct zone *zone)
 	}
 }
 
-#ifndef __HAVE_ARCH_MEMMAP_INIT
-#define memmap_init(size, nid, zone, start_pfn) \
-	memmap_init_zone((size), (nid), (zone), (start_pfn), MEMMAP_EARLY, NULL)
-#endif
+void __meminit __weak memmap_init(unsigned long size, int nid,
+				  unsigned long zone, unsigned long start_pfn)
+{
+	memmap_init_zone(size, nid, zone, start_pfn, MEMMAP_EARLY, NULL);
+}
 
 static int zone_batchsize(struct zone *zone)
 {
-- 
2.18.0

