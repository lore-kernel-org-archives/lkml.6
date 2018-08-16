Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93316C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FE72148C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FE72148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baidu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390394AbeHPMPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:15:09 -0400
Received: from mx60.baidu.com ([61.135.168.60]:30992 "EHLO
        tc-sys-mailedm03.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390348AbeHPMPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:15:09 -0400
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm03.tc.baidu.com (Postfix) with ESMTP id E46BC624007;
        Thu, 16 Aug 2018 17:17:37 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] mm: introduce kvvirt_to_page() helper
Date:   Thu, 16 Aug 2018 17:17:37 +0800
Message-Id: <1534411057-26276-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.10.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new helper returns address mapping page, which has several users
in individual subsystem, like mem_to_page in xfs_buf.c and pgv_to_page
in af_packet.c, after this, they can be unified

Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 include/linux/mm.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 68a5121694ef..bb34a3c71df5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -599,6 +599,14 @@ static inline void *kvcalloc(size_t n, size_t size, gfp_t flags)
 	return kvmalloc_array(n, size, flags | __GFP_ZERO);
 }
 
+static inline struct page *kvvirt_to_page(const void *addr)
+{
+	if (!is_vmalloc_addr(addr))
+		return virt_to_page(addr);
+	else
+		return vmalloc_to_page(addr);
+}
+
 extern void kvfree(const void *addr);
 
 static inline atomic_t *compound_mapcount_ptr(struct page *page)
-- 
2.16.2

