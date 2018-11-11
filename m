Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EFDC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434F0214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:12:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434F0214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbeKLGBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:01:55 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52590 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730702AbeKLGBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 01:01:54 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvt3-0000l4-Dq; Sun, 11 Nov 2018 19:59:13 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsR-0001Wx-Lc; Sun, 11 Nov 2018 19:58:35 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Zi Yan" <zi.yan@cs.rutgers.edu>,
        "Daniel Colascione" <dancol@google.com>,
        "Andrei Vagin" <avagin@openvz.org>,
        "Naoya Horiguchi" <n-horiguchi@ah.jp.nec.com>,
        "Huang Ying" <ying.huang@intel.com>,
        "Jerome Glisse" <jglisse@redhat.com>,
        "Konstantin Khlebnikov" <khlebnikov@yandex-team.ru>,
        "Michal Hocko" <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.667318046@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 125/366] mm: /proc/pid/pagemap: hide swap entries
 from unprivileged users
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Huang Ying <ying.huang@intel.com>

commit ab6ecf247a9321e3180e021a6a60164dee53ab2e upstream.

In commit ab676b7d6fbf ("pagemap: do not leak physical addresses to
non-privileged userspace"), the /proc/PID/pagemap is restricted to be
readable only by CAP_SYS_ADMIN to address some security issue.

In commit 1c90308e7a77 ("pagemap: hide physical addresses from
non-privileged users"), the restriction is relieved to make
/proc/PID/pagemap readable, but hide the physical addresses for
non-privileged users.

But the swap entries are readable for non-privileged users too.  This
has some security issues.  For example, for page under migrating, the
swap entry has physical address information.  So, in this patch, the
swap entries are hided for non-privileged users too.

Link: http://lkml.kernel.org/r/20180508012745.7238-1-ying.huang@intel.com
Fixes: 1c90308e7a77 ("pagemap: hide physical addresses from non-privileged users")
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Reviewed-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Andrei Vagin <avagin@openvz.org>
Cc: Jerome Glisse <jglisse@redhat.com>
Cc: Daniel Colascione <dancol@google.com>
Cc: Zi Yan <zi.yan@cs.rutgers.edu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16:
 - Only PTEs can be swap entries
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -938,8 +938,9 @@ static void pte_to_pagemap_entry(pagemap
 		if (pte_swp_soft_dirty(pte))
 			flags2 |= __PM_SOFT_DIRTY;
 		entry = pte_to_swp_entry(pte);
-		frame = swp_type(entry) |
-			(swp_offset(entry) << MAX_SWAPFILES_SHIFT);
+		if (pm->show_pfn)
+			frame = swp_type(entry) |
+				(swp_offset(entry) << MAX_SWAPFILES_SHIFT);
 		flags = PM_SWAP;
 		if (is_migration_entry(entry))
 			page = migration_entry_to_page(entry);

