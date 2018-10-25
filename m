Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C48ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758F6214F0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EknW+fKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758F6214F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbeJYWyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:54:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731324AbeJYWyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:54:03 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D69120873;
        Thu, 25 Oct 2018 14:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477265;
        bh=MYBLxyrQuMoboMSsB+yel0RZzyLaCVOjytqwrSSLp8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EknW+fKfB4a2AZu7G5gC3kJv4cOus8G9saaIxNp1scSegTRvg19AujXWd7CRPaR2q
         72lD6GvPPZGmraPm3wSfeWjf2eCIHHBkj7f0P8J7SJuU7rnjbnoVgnvkgYiw5OO+A4
         SIuCzPh/kN6JOsbnVPDQ68GxlFZB8y+thICJJR8c=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.cz>,
        Andi Kleen <andi@firstfloor.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 85/98] mm: migrate: hugetlb: putback destination hugepage to active list
Date:   Thu, 25 Oct 2018 10:18:40 -0400
Message-Id: <20181025141853.214051-85-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

[ Upstream commit 3aaa76e125c1dd58c9b599baa8c6021896874c12 ]

Since commit bcc54222309c ("mm: hugetlb: introduce page_huge_active")
each hugetlb page maintains its active flag to avoid a race condition
betwe= en multiple calls of isolate_huge_page(), but current kernel
doesn't set the f= lag on a hugepage allocated by migration because the
proper putback routine isn= 't called.  This means that users could
still encounter the race referred to by bcc54222309c in this special
case, so this patch fixes it.

Fixes: bcc54222309c ("mm: hugetlb: introduce page_huge_active")
Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Michal Hocko <mhocko@suse.cz>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>  [4.1.x]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 4d743bce5a23..57559f9295f9 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1077,7 +1077,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 	if (rc != MIGRATEPAGE_SUCCESS && put_new_page)
 		put_new_page(new_hpage, private);
 	else
-		put_page(new_hpage);
+		putback_active_hugepage(new_hpage);
 
 	if (result) {
 		if (rc)
-- 
2.17.1

