Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938571AbeE1MEL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423236AbeE1LGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:06:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Abraham <tabraham@suse.com>,
        Mark.Landis@Teradata.com, Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 057/272] swap: divide-by-zero when zero length swap file on ssd
Date: Mon, 28 May 2018 12:01:30 +0200
Message-Id: <20180528100245.688926999@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tom Abraham <tabraham@suse.com>

[ Upstream commit a06ad633a37c64a0cd4c229fc605cee8725d376e ]

Calling swapon() on a zero length swap file on SSD can lead to a
divide-by-zero.

Although creating such files isn't possible with mkswap and they woud be
considered invalid, it would be better for the swapon code to be more
robust and handle this condition gracefully (return -EINVAL).
Especially since the fix is small and straightforward.

To help with wear leveling on SSD, the swapon syscall calculates a
random position in the swap file using modulo p->highest_bit, which is
set to maxpages - 1 in read_swap_header.

If the swap file is zero length, read_swap_header sets maxpages=1 and
last_page=0, resulting in p->highest_bit=0 and we divide-by-zero when we
modulo p->highest_bit in swapon syscall.

This can be prevented by having read_swap_header return zero if
last_page is zero.

Link: http://lkml.kernel.org/r/5AC747C1020000A7001FA82C@prv-mh.provo.novell.com
Signed-off-by: Thomas Abraham <tabraham@suse.com>
Reported-by: <Mark.Landis@Teradata.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/swapfile.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2961,6 +2961,10 @@ static unsigned long read_swap_header(st
 	maxpages = swp_offset(pte_to_swp_entry(
 			swp_entry_to_pte(swp_entry(0, ~0UL)))) + 1;
 	last_page = swap_header->info.last_page;
+	if (!last_page) {
+		pr_warn("Empty swap-file\n");
+		return 0;
+	}
 	if (last_page > maxpages) {
 		pr_warn("Truncating oversized swap area, only using %luk out of %luk\n",
 			maxpages << (PAGE_SHIFT - 10),
