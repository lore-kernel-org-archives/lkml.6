Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE164C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF59208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="chPszpAi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbfAJVLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:11:24 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:52110 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729343AbfAJVLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 16:11:19 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0AL8qFJ192900;
        Thu, 10 Jan 2019 21:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2018-07-02;
 bh=un0wieK7yWFodUoPf/TbQJCMffDoPehxHgZRzLFUW2o=;
 b=chPszpAiJAbkg+zkadcOBGkMBvHUigW7P3J5U9kXh/4WR4WaTdIqSIJKmzOC/NYFDsyM
 MrFViq/HYuHukuzNxvfAtgv5S+929Mdu9AdazByjvd+OPJMDXYmo8iFtHbKf7joRxxl/
 QVImhgrAo9iB2tmKxcqYcyE2n9GTsgn+pHOsq5kbq0i5OjnVPX2uEIwCk/3vgDm7ck2L
 gdt2Jf6KBycEqmPAG9bKtRrQvpN6O6xgeHZxhQyKMbbVoWzO9mVK92OnrDy3zK7hhBVl
 4ErVypdkvqQImbKrKUjb7pLwtF16Ii9FhyFfMXHHcbV30+4FHsmkdvwuL+W2nUMEn+cL gQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2ptn7r9f50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 21:10:44 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0ALAh5k029012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 21:10:43 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0ALAhqP023547;
        Thu, 10 Jan 2019 21:10:43 GMT
Received: from concerto.internal (/24.9.64.241)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Jan 2019 13:10:42 -0800
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de,
        ak@linux.intel.com, torvalds@linux-foundation.org,
        liran.alon@oracle.com, keescook@google.com, konrad.wilk@oracle.com
Cc:     Khalid Aziz <khalid.aziz@oracle.com>, deepa.srinivasan@oracle.com,
        chris.hyser@oracle.com, tyhicks@canonical.com, dwmw@amazon.co.uk,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        boris.ostrovsky@oracle.com, kanth.ghatraju@oracle.com,
        joao.m.martins@oracle.com, jmattson@google.com,
        pradeep.vincent@oracle.com, john.haxby@oracle.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com, hch@lst.de,
        steven.sistare@oracle.com, kernel-hardening@lists.openwall.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v7 15/16] xpfo, mm: Fix hang when booting with "xpfotlbflush"
Date:   Thu, 10 Jan 2019 14:09:47 -0700
Message-Id: <c65c84a5e0a3df290d2b65dc36867bbedf51cb97.1547153058.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547153058.git.khalid.aziz@oracle.com>
References: <cover.1547153058.git.khalid.aziz@oracle.com>
In-Reply-To: <cover.1547153058.git.khalid.aziz@oracle.com>
References: <cover.1547153058.git.khalid.aziz@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9132 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901100164
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel hangs when booted up with "xpfotlbflush" option. This is caused
by xpfo_kunmap() fliushing TLB while holding xpfo lock starving other
tasks waiting for the lock. This patch moves tlb flush outside of the
code holding xpfo lock.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 mm/xpfo.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/xpfo.c b/mm/xpfo.c
index 85079377c91d..79ffdba6af69 100644
--- a/mm/xpfo.c
+++ b/mm/xpfo.c
@@ -148,6 +148,8 @@ EXPORT_SYMBOL(xpfo_kmap);
 
 void xpfo_kunmap(void *kaddr, struct page *page)
 {
+	bool flush_tlb = false;
+
 	if (!static_branch_unlikely(&xpfo_inited))
 		return;
 
@@ -168,10 +170,13 @@ void xpfo_kunmap(void *kaddr, struct page *page)
 		if (atomic_read(&page->xpfo_mapcount) == 0) {
 			SetPageXpfoUnmapped(page);
 			set_kpte(kaddr, page, __pgprot(0));
-			xpfo_cond_flush_kernel_tlb(page, 0);
+			flush_tlb = true;
 		}
 		spin_unlock(&page->xpfo_lock);
 	}
+
+	if (flush_tlb)
+		xpfo_cond_flush_kernel_tlb(page, 0);
 }
 EXPORT_SYMBOL(xpfo_kunmap);
 
-- 
2.17.1

