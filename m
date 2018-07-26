Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BD6C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054D0206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cXN2QuUK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054D0206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731550AbeGZUyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:54:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56124 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730402AbeGZUyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:54:00 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6QJSRF9153802;
        Thu, 26 Jul 2018 19:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=4zEpFMlFhWgE0aXlCk/41YZX98c+jpFomxA+EUOlTjk=;
 b=cXN2QuUK5ZauhLNe8IWHTOXd8UAqgieEgcrnvX3AxCV/K/BstspmXbQ8CaHwUUxAuBQn
 f6llF1STawbFSDPnu0m1FudEQQLpWh4OmJLwyKgxlL8R15KcYY2dSqRtSy8ApsCOSu0V
 ygay7XUBu9uzRG2Zc4ZkYSMVZbSEViH6ahGluNBD3iAjrWIJ7lsiq8oFddabRo0C2Ekt
 mXu31ITcw7QB6p/PIMdjzzbcJ/8R+dCkh8U1uhCEXBZP41cf8n4DODYeYJOCel19o1cH
 mXTp+DiO+LuGvufMVobzoWDy2yul9MfFwWGW+W+MUSUCW9XoRLYzR0XVQXMNozga9KYP Zg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2kbvsp4hpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 19:35:21 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6QJZKJ0021229
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jul 2018 19:35:20 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6QJZIjM000784;
        Thu, 26 Jul 2018 19:35:18 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Jul 2018 12:35:18 -0700
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
Subject: [PATCH v2 1/3] mm: make memmap_init a proper function
Date:   Thu, 26 Jul 2018 15:35:07 -0400
Message-Id: <20180726193509.3326-2-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726193509.3326-1-pasha.tatashin@oracle.com>
References: <20180726193509.3326-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8966 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=687
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807260200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memmap_init is sometimes a macro sometimes a function based on
__HAVE_ARCH_MEMMAP_INIT. It is only a function on ia64. Make
memmap_init a weak function instead, and let ia64 redefine it.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
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
index 2dec8056a091..6796dacd46ac 100644
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

