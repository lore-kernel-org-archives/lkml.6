Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F59ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85896206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85896206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388821AbeGTNWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:22:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41060 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388096AbeGTNWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:22:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D66A40704BB;
        Fri, 20 Jul 2018 12:34:38 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-116-17.ams2.redhat.com [10.36.116.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 061CE111AF1D;
        Fri, 20 Jul 2018 12:34:34 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Huang Ying <ying.huang@intel.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
        Petr Tesarik <ptesarik@suse.cz>
Subject: [PATCH v1 1/2] mm: clarify semantics of reserved pages
Date:   Fri, 20 Jul 2018 14:34:21 +0200
Message-Id: <20180720123422.10127-2-david@redhat.com>
In-Reply-To: <20180720123422.10127-1-david@redhat.com>
References: <20180720123422.10127-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 20 Jul 2018 12:34:38 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 20 Jul 2018 12:34:38 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'david@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reserved bit once was used to hinder pages from getting swapped. While
this still works, the semantics are a little bit stronger nowadays: The
page should never be touched by anybody in the system except by the owner.
The original comment already gave a hint about that.

So especially, these pages should also not be dumped by dumping tools.
Let's make that more clear by updating the comment.

This will be useful especially in the future in virtual environments where
pages marked with the reserved bit might no longer be accessible.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Matthew Wilcox <mawilcox@microsoft.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Miles Chen <miles.chen@mediatek.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: Petr Tesarik <ptesarik@suse.cz>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 901943e4754b..ba81e11a868c 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -17,8 +17,8 @@
 /*
  * Various page->flags bits:
  *
- * PG_reserved is set for special pages, which can never be swapped out. Some
- * of them might not even exist...
+ * PG_reserved is set for special pages, which should never be touched (read/
+ * write) by anybody except their owner. Some of them might not even exist.
  *
  * The PG_private bitflag is set on pagecache pages if they contain filesystem
  * specific data (which is normally at page->private). It can be used by
-- 
2.17.1

