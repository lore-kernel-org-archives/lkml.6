Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935767AbeBLN64 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 08:58:56 -0500
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:46615 "EHLO
        forwardcorp1g.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934880AbeBLN6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 08:58:54 -0500
Authentication-Results: smtpcorp1p.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: [PATCH v3 1/2] mm/page_ref: use atomic_set_release in
 page_ref_unfreeze
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc: Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nicholas Piggin <npiggin@gmail.com>
Date: Mon, 12 Feb 2018 16:58:50 +0300
Message-ID: <151844393004.210639.4672319312617954272.stgit@buzz>
In-Reply-To: <4f64569f-b8ce-54f8-33d9-0e67216bb54c@yandex-team.ru>
References: <4f64569f-b8ce-54f8-33d9-0e67216bb54c@yandex-team.ru>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page_ref_unfreeze() has exactly that semantic. No functional
changes: just minus one barrier and proper handling of PPro errata.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 include/linux/page_ref.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/page_ref.h b/include/linux/page_ref.h
index 760d74a0e9a9..14d14beb1f7f 100644
--- a/include/linux/page_ref.h
+++ b/include/linux/page_ref.h
@@ -175,8 +175,7 @@ static inline void page_ref_unfreeze(struct page *page, int count)
 	VM_BUG_ON_PAGE(page_count(page) != 0, page);
 	VM_BUG_ON(count == 0);
 
-	smp_mb();
-	atomic_set(&page->_refcount, count);
+	atomic_set_release(&page->_refcount, count);
 	if (page_ref_tracepoint_active(__tracepoint_page_ref_unfreeze))
 		__page_ref_unfreeze(page, count);
 }
