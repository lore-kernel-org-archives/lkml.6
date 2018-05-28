Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164490AbeE1MyO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:54:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164371AbeE1KzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:55:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maninder Singh <maninder1.s@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@techadventures.net>,
        Ayush Mittal <ayush.m@samsung.com>,
        Prakash Gupta <guptap@codeaurora.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Vasyl Gomonovych <gomonovych@gmail.com>,
        Amit Sahrawat <a.sahrawat@samsung.com>, pankaj.m@samsung.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 309/496] mm/page_owner: fix recursion bug after changing skip entries
Date: Mon, 28 May 2018 12:01:34 +0200
Message-Id: <20180528100332.819628897@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maninder Singh <maninder1.s@samsung.com>

[ Upstream commit 299815a4fba9f3c7a81434dba0072148f1690608 ]

This patch fixes commit 5f48f0bd4e36 ("mm, page_owner: skip unnecessary
stack_trace entries").

Because if we skip first two entries then logic of checking count value
as 2 for recursion is broken and code will go in one depth recursion.

so we need to check only one call of _RET_IP(__set_page_owner) while
checking for recursion.

Current Backtrace while checking for recursion:-

  (save_stack)             from (__set_page_owner)  // (But recursion returns true here)
  (__set_page_owner)       from (get_page_from_freelist)
  (get_page_from_freelist) from (__alloc_pages_nodemask)
  (__alloc_pages_nodemask) from (depot_save_stack)
  (depot_save_stack)       from (save_stack)       // recursion should return true here
  (save_stack)             from (__set_page_owner)
  (__set_page_owner)       from (get_page_from_freelist)
  (get_page_from_freelist) from (__alloc_pages_nodemask+)
  (__alloc_pages_nodemask) from (depot_save_stack)
  (depot_save_stack)       from (save_stack)
  (save_stack)             from (__set_page_owner)
  (__set_page_owner)       from (get_page_from_freelist)

Correct Backtrace with fix:

  (save_stack)             from (__set_page_owner) // recursion returned true here
  (__set_page_owner)       from (get_page_from_freelist)
  (get_page_from_freelist) from (__alloc_pages_nodemask+)
  (__alloc_pages_nodemask) from (depot_save_stack)
  (depot_save_stack)       from (save_stack)
  (save_stack)             from (__set_page_owner)
  (__set_page_owner)       from (get_page_from_freelist)

Link: http://lkml.kernel.org/r/1521607043-34670-1-git-send-email-maninder1.s@samsung.com
Fixes: 5f48f0bd4e36 ("mm, page_owner: skip unnecessary stack_trace entries")
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
Signed-off-by: Vaneet Narang <v.narang@samsung.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@techadventures.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ayush Mittal <ayush.m@samsung.com>
Cc: Prakash Gupta <guptap@codeaurora.org>
Cc: Vinayak Menon <vinmenon@codeaurora.org>
Cc: Vasyl Gomonovych <gomonovych@gmail.com>
Cc: Amit Sahrawat <a.sahrawat@samsung.com>
Cc: <pankaj.m@samsung.com>
Cc: Vaneet Narang <v.narang@samsung.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/page_owner.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -123,13 +123,13 @@ void __reset_page_owner(struct page *pag
 static inline bool check_recursive_alloc(struct stack_trace *trace,
 					unsigned long ip)
 {
-	int i, count;
+	int i;
 
 	if (!trace->nr_entries)
 		return false;
 
-	for (i = 0, count = 0; i < trace->nr_entries; i++) {
-		if (trace->entries[i] == ip && ++count == 2)
+	for (i = 0; i < trace->nr_entries; i++) {
+		if (trace->entries[i] == ip)
 			return true;
 	}
 
