Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BD7ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52BB2133D
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 21:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmHP3kJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E52BB2133D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbeKIHeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:34:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:50356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727463AbeKIHeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:34:00 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D502821019;
        Thu,  8 Nov 2018 21:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714192;
        bh=FkO+DPUYMtJ5uDJ1S9M3TOqZMh3NHsM12chFSfGUeG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FmHP3kJ2oXzFyFy1Q4zuZrUR+gJ0GfTULLGEu70lQy3KMf/pJzGVS0OdhkFD0ViRH
         0RzFMJXYAsq6RAldZ0i1DktB6U6EnFrxnzdUeXyQ9Lk1lhCCptEwuYHM8VJnx10p0P
         ZDcE8gn9i3/rPpRofhak9wuuuLfkEN84XuX7m+no=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.cz>,
        Andi Kleen <andi@firstfloor.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 113/144] mm: migrate: hugetlb: putback destination hugepage to active list
Date:   Thu,  8 Nov 2018 13:51:24 -0800
Message-Id: <20181108215106.088438909@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215054.826084593@linuxfoundation.org>
References: <20181108215054.826084593@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
@@ -1077,7 +1077,7 @@ out:
 	if (rc != MIGRATEPAGE_SUCCESS && put_new_page)
 		put_new_page(new_hpage, private);
 	else
-		put_page(new_hpage);
+		putback_active_hugepage(new_hpage);
 
 	if (result) {
 		if (rc)
-- 
2.17.1



