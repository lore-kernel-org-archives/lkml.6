Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DCEC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B0920657
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pXlQwsE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbfAJVNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:13:53 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:42232 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfAJVNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 16:13:52 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0AL916A187109;
        Thu, 10 Jan 2019 21:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2018-07-02;
 bh=UbctwoSk8tN3IcjUiRawhNiiTGCYFxkfE1vdJR34/p4=;
 b=pXlQwsE6eT5Gwd80itwTVz5RN+Ix5BpvxJmBfde1uZygV+Rslofe7x724kOLvkrhuoDm
 VaufXFJc0x/bhg4csb86xgTa5oRsgGXNUwpk6jBaSYVCOK08HIMLKrRQFFXQuF/ljQLa
 c9M5nGEttCW3mctUWC2vYB1gn4wLmkHIUFEx/Aw1I+7qiQ3knEVUexcfa2bolqzEyvV3
 LmtzvRDDdYXn9ZOKH/gctHRPShqvLWBf/rOrAA8BIVQSKsMuP44bA/KoMe+nCz6XDCkg
 Fj6Mqgg33kI6zR9S0fSK8spVh3Dy3zDN5Jmnk4/mwptg9ykfT++lnvDkaEVHNpTf9Xm8 jw== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2ptj3e9thr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 21:10:41 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0ALAeA3009832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 21:10:40 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0ALAdwe021399;
        Thu, 10 Jan 2019 21:10:39 GMT
Received: from concerto.internal (/24.9.64.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Jan 2019 13:10:38 -0800
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de,
        ak@linux.intel.com, torvalds@linux-foundation.org,
        liran.alon@oracle.com, keescook@google.com, konrad.wilk@oracle.com
Cc:     deepa.srinivasan@oracle.com, chris.hyser@oracle.com,
        tyhicks@canonical.com, dwmw@amazon.co.uk,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        boris.ostrovsky@oracle.com, kanth.ghatraju@oracle.com,
        joao.m.martins@oracle.com, jmattson@google.com,
        pradeep.vincent@oracle.com, john.haxby@oracle.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com, hch@lst.de,
        steven.sistare@oracle.com, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        "Vasileios P . Kemerlis" <vpk@cs.columbia.edu>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Tycho Andersen <tycho@docker.com>,
        Marco Benatto <marco.antonio.780@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Khalid Aziz <khalid.aziz@oracle.com>
Subject: [RFC PATCH v7 13/16] xpfo, mm: optimize spinlock usage in xpfo_kunmap
Date:   Thu, 10 Jan 2019 14:09:45 -0700
Message-Id: <95b6fa40ce6c7afb4a9e58f8d747d86aa7a94177.1547153058.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547153058.git.khalid.aziz@oracle.com>
References: <cover.1547153058.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1547153058.git.khalid.aziz@oracle.com>
References: <cover.1547153058.git.khalid.aziz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9132 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=822
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901100164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julian Stecklina <jsteckli@amazon.de>

Only the xpfo_kunmap call that needs to actually unmap the page
needs to be serialized. We need to be careful to handle the case,
where after the atomic decrement of the mapcount, a xpfo_kmap
increased the mapcount again. In this case, we can safely skip
modifying the page table.

Model-checked with up to 4 concurrent callers with Spin.

Signed-off-by: Julian Stecklina <jsteckli@amazon.de>
Cc: x86@kernel.org
Cc: kernel-hardening@lists.openwall.com
Cc: Vasileios P. Kemerlis <vpk@cs.columbia.edu>
Cc: Juerg Haefliger <juerg.haefliger@canonical.com>
Cc: Tycho Andersen <tycho@docker.com>
Cc: Marco Benatto <marco.antonio.780@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 mm/xpfo.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/xpfo.c b/mm/xpfo.c
index cbfeafc2f10f..dbf20efb0499 100644
--- a/mm/xpfo.c
+++ b/mm/xpfo.c
@@ -149,22 +149,24 @@ void xpfo_kunmap(void *kaddr, struct page *page)
 	if (!PageXpfoUser(page))
 		return;
 
-	spin_lock(&page->xpfo_lock);
-
 	/*
 	 * The page is to be allocated back to user space, so unmap it from the
 	 * kernel, flush the TLB and tag it as a user page.
 	 */
 	if (atomic_dec_return(&page->xpfo_mapcount) == 0) {
-#ifdef CONFIG_XPFO_DEBUG
-		BUG_ON(PageXpfoUnmapped(page));
-#endif
-		SetPageXpfoUnmapped(page);
-		set_kpte(kaddr, page, __pgprot(0));
-		xpfo_cond_flush_kernel_tlb(page, 0);
-	}
+		spin_lock(&page->xpfo_lock);
 
-	spin_unlock(&page->xpfo_lock);
+		/*
+		 * In the case, where we raced with kmap after the
+		 * atomic_dec_return, we must not nuke the mapping.
+		 */
+		if (atomic_read(&page->xpfo_mapcount) == 0) {
+			SetPageXpfoUnmapped(page);
+			set_kpte(kaddr, page, __pgprot(0));
+			xpfo_cond_flush_kernel_tlb(page, 0);
+		}
+		spin_unlock(&page->xpfo_lock);
+	}
 }
 EXPORT_SYMBOL(xpfo_kunmap);
 
-- 
2.17.1

