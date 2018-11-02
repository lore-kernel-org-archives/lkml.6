Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2059AC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E689920843
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSd9ry1O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E689920843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbeKCDt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:49:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728699AbeKCDt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:49:28 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80F4520848;
        Fri,  2 Nov 2018 18:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184076;
        bh=00b0YqzTRz25xxlSNTeO1eXeT315IvVT4bhEetAYL2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PSd9ry1OCvKqEHhWxvtjcUyKxqA3JwjGn0cx7Pro5zlN7ktJtm0KzJpFqgWVH7B1O
         WSWbprhqe+bQvpRKNFByVWU3xN+nP1cpBUzRgx3J9DOhA9Tc4GbV5ze/mG2mnHBaSY
         mbrZ2tELTCb+eyNbuIZ+NK70jLHaKoGb74grgd8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 072/150] mm/migrate.c: split only transparent huge pages when allocation fails
Date:   Fri,  2 Nov 2018 19:33:54 +0100
Message-Id: <20181102182908.622200912@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit e6112fc300702f96374f34368513d57795fc6d23 ]

split_huge_page_to_list() fails on HugeTLB pages.  I was experimenting
with moving 32MB contig HugeTLB pages on arm64 (with a debug patch
applied) and hit the following stack trace when the kernel crashed.

[ 3732.462797] Call trace:
[ 3732.462835]  split_huge_page_to_list+0x3b0/0x858
[ 3732.462913]  migrate_pages+0x728/0xc20
[ 3732.462999]  soft_offline_page+0x448/0x8b0
[ 3732.463097]  __arm64_sys_madvise+0x724/0x850
[ 3732.463197]  el0_svc_handler+0x74/0x110
[ 3732.463297]  el0_svc+0x8/0xc
[ 3732.463347] Code: d1000400 f90b0e60 f2fbd5a2 a94982a1 (f9000420)

When unmap_and_move[_huge_page]() fails due to lack of memory, the
splitting should happen only for transparent huge pages not for HugeTLB
pages.  PageTransHuge() returns true for both THP and HugeTLB pages.
Hence the conditonal check should test PagesHuge() flag to make sure that
given pages is not a HugeTLB one.

Link: http://lkml.kernel.org/r/1537798495-4996-1-git-send-email-anshuman.khandual@arm.com
Fixes: 94723aafb9 ("mm: unclutter THP migration")
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Zi Yan <zi.yan@cs.rutgers.edu>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 2a55289ee9f1..f49eb9589d73 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1415,7 +1415,7 @@ retry:
 				 * we encounter them after the rest of the list
 				 * is processed.
 				 */
-				if (PageTransHuge(page)) {
+				if (PageTransHuge(page) && !PageHuge(page)) {
 					lock_page(page);
 					rc = split_huge_page_to_list(page, from);
 					unlock_page(page);
-- 
2.17.1



