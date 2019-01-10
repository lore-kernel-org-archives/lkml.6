Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A2AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28A922173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="1RiH7Ayt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731007AbfAJVLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:11:05 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:38942 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729343AbfAJVLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 16:11:04 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0AL8jJN186995;
        Thu, 10 Jan 2019 21:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2018-07-02;
 bh=igejgCvAio6u1Ussld9AuQC3Ul6s8euovTImu0aEjD4=;
 b=1RiH7Ayttgl67HmBUpj9Zdch6LCLPksWDKHZCY0c3O4g6K6f5lB+hFkquaMWY/CeqG2c
 WA3MN5u8IJiO8Q9EgRsR9weHv6aPXsg7lHvl6yVYGrFoAElAl/Qtxo/16weY5EyApWJw
 ZcUENEhCipmYwEhouhHCKcEms6inTWl5F8KMuKzhwQTrjTOoEAagowAB7i5Bu3g6vsTO
 g6DsIP3fE09F4sXWS4Bh+elRfQKiEMVnQyVSwOrGHEEUPs0EeBDb01Zp18Asj2eNwi1g
 Wr2MJ/rH5TiF9nQr2d44cNyQBMa8MVknWh6/vaIjGPPQMqxLcxhzgvfyKlQJRmStxkM5 KA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2ptj3e9tgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 21:10:24 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0ALAOTF011482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 21:10:24 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0ALAOpv023399;
        Thu, 10 Jan 2019 21:10:24 GMT
Received: from concerto.internal (/24.9.64.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Jan 2019 13:10:24 -0800
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de,
        ak@linux.intel.com, torvalds@linux-foundation.org,
        liran.alon@oracle.com, keescook@google.com, konrad.wilk@oracle.com
Cc:     Tycho Andersen <tycho@docker.com>, deepa.srinivasan@oracle.com,
        chris.hyser@oracle.com, tyhicks@canonical.com, dwmw@amazon.co.uk,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        boris.ostrovsky@oracle.com, kanth.ghatraju@oracle.com,
        joao.m.martins@oracle.com, jmattson@google.com,
        pradeep.vincent@oracle.com, john.haxby@oracle.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com, hch@lst.de,
        steven.sistare@oracle.com, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Khalid Aziz <khalid.aziz@oracle.com>
Subject: [RFC PATCH v7 06/16] xpfo: add primitives for mapping underlying memory
Date:   Thu, 10 Jan 2019 14:09:38 -0700
Message-Id: <5deed7a1eb65fc6c66acb8a00d46d63e7f0fd22f.1547153058.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547153058.git.khalid.aziz@oracle.com>
References: <cover.1547153058.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1547153058.git.khalid.aziz@oracle.com>
References: <cover.1547153058.git.khalid.aziz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9132 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=972
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901100164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tycho Andersen <tycho@docker.com>

In some cases (on arm64 DMA and data cache flushes) we may have unmapped
the underlying pages needed for something via XPFO. Here are some
primitives useful for ensuring the underlying memory is mapped/unmapped in
the face of xpfo.

Signed-off-by: Tycho Andersen <tycho@docker.com>
Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 include/linux/xpfo.h | 22 ++++++++++++++++++++++
 mm/xpfo.c            | 30 ++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/linux/xpfo.h b/include/linux/xpfo.h
index e38b823f44e3..2682a00ebbcb 100644
--- a/include/linux/xpfo.h
+++ b/include/linux/xpfo.h
@@ -37,6 +37,15 @@ void xpfo_free_pages(struct page *page, int order);
 
 bool xpfo_page_is_unmapped(struct page *page);
 
+#define XPFO_NUM_PAGES(addr, size) \
+	(PFN_UP((unsigned long) (addr) + (size)) - \
+		PFN_DOWN((unsigned long) (addr)))
+
+void xpfo_temp_map(const void *addr, size_t size, void **mapping,
+		   size_t mapping_len);
+void xpfo_temp_unmap(const void *addr, size_t size, void **mapping,
+		     size_t mapping_len);
+
 #else /* !CONFIG_XPFO */
 
 static inline void xpfo_kmap(void *kaddr, struct page *page) { }
@@ -46,6 +55,19 @@ static inline void xpfo_free_pages(struct page *page, int order) { }
 
 static inline bool xpfo_page_is_unmapped(struct page *page) { return false; }
 
+#define XPFO_NUM_PAGES(addr, size) 0
+
+static inline void xpfo_temp_map(const void *addr, size_t size, void **mapping,
+				 size_t mapping_len)
+{
+}
+
+static inline void xpfo_temp_unmap(const void *addr, size_t size,
+				   void **mapping, size_t mapping_len)
+{
+}
+
+
 #endif /* CONFIG_XPFO */
 
 #endif /* _LINUX_XPFO_H */
diff --git a/mm/xpfo.c b/mm/xpfo.c
index cdbcbac582d5..f79075bf7d65 100644
--- a/mm/xpfo.c
+++ b/mm/xpfo.c
@@ -13,6 +13,7 @@
  * the Free Software Foundation.
  */
 
+#include <linux/highmem.h>
 #include <linux/mm.h>
 #include <linux/module.h>
 #include <linux/page_ext.h>
@@ -235,3 +236,32 @@ bool xpfo_page_is_unmapped(struct page *page)
 	return test_bit(XPFO_PAGE_UNMAPPED, &xpfo->flags);
 }
 EXPORT_SYMBOL(xpfo_page_is_unmapped);
+
+void xpfo_temp_map(const void *addr, size_t size, void **mapping,
+		   size_t mapping_len)
+{
+	struct page *page = virt_to_page(addr);
+	int i, num_pages = mapping_len / sizeof(mapping[0]);
+
+	memset(mapping, 0, mapping_len);
+
+	for (i = 0; i < num_pages; i++) {
+		if (page_to_virt(page + i) >= addr + size)
+			break;
+
+		if (xpfo_page_is_unmapped(page + i))
+			mapping[i] = kmap_atomic(page + i);
+	}
+}
+EXPORT_SYMBOL(xpfo_temp_map);
+
+void xpfo_temp_unmap(const void *addr, size_t size, void **mapping,
+		     size_t mapping_len)
+{
+	int i, num_pages = mapping_len / sizeof(mapping[0]);
+
+	for (i = 0; i < num_pages; i++)
+		if (mapping[i])
+			kunmap_atomic(mapping[i]);
+}
+EXPORT_SYMBOL(xpfo_temp_unmap);
-- 
2.17.1

