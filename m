Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751785AbeDEOod (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 10:44:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751540AbeDEOob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 10:44:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B754217DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Thu, 5 Apr 2018 10:44:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Joel Fernandes <joelaf@google.com>, Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] ring-buffer: Check if memory is available before allocation
Message-ID: <20180405104428.08ea9e08@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The ring buffer is made up of a link list of pages. When making the ring
buffer bigger, it will allocate all the pages it needs before adding to the
ring buffer, and if it fails, it frees them and returns an error. This makes
increasing the ring buffer size an all or nothing action. When this was
first created, the pages were allocated with "NORETRY". This was to not
cause any Out-Of-Memory (OOM) actions from allocating the ring buffer. But
NORETRY was too strict, as the ring buffer would fail to expand even when
there's memory available, but was taken up in the page cache.

Commit 848618857d253 ("tracing/ring_buffer: Try harder to allocate") changed
the allocating from NORETRY to RETRY_MAYFAIL. The RETRY_MAYFAIL would
allocate from the page cache, but if there was no memory available, it would
simple fail the allocation and not trigger an OOM.

This worked fine, but had one problem. As the ring buffer would allocate one
page at a time, it could take up all memory in the system before it failed
to allocate and free that memory. If the allocation is happening and the
ring buffer allocates all memory and then tries to take more than available,
its allocation will not trigger an OOM, but if there's any allocation that
happens someplace else, that could trigger an OOM, even though once the ring
buffer's allocation fails, it would free up all the previous memory it tried
to allocate, and allow other memory allocations to succeed.

Commit d02bd27bd33dd ("mm/page_alloc.c: calculate 'available' memory in a
separate function") separated out si_mem_availble() as a separate function
that could be used to see how much memory is available in the system. Using
this function to make sure that the ring buffer could be allocated before it
tries to allocate pages we can avoid allocating all memory in the system and
making it vulnerable to OOMs if other allocations are taking place.

Link: http://lkml.kernel.org/r/1522320104-6573-1-git-send-email-zhaoyang.huang@spreadtrum.com

CC: stable@vger.kernel.org
Cc: linux-mm@kvack.org
Fixes: 848618857d253 ("tracing/ring_buffer: Try harder to allocate")
Requires: d02bd27bd33dd ("mm/page_alloc.c: calculate 'available' memory in a separate function")
Reported-by: Zhaoyang Huang <huangzhaoyang@gmail.com>
Tested-by: Joel Fernandes <joelaf@google.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---

Note: Zhaoyang notified me that I never actually posted this patch to
the mailing list. And I plan on sending this to stable (to fix the
current triggering of OOMs even though it is an abuse of
si_mem_available()).

I also have the patch on top of this that uses set_current_oom_origin()
to kill this task if si_mem_available() advertises enough memory when
there is not. Should that be marked for stable as well?

 See http://lkml.kernel.org/r/20180404115310.6c69e7b9@gandalf.local.home

 kernel/trace/ring_buffer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 515be03e3009..966128f02121 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1164,6 +1164,11 @@ static int __rb_allocate_pages(long nr_pages, struct list_head *pages, int cpu)
 	struct buffer_page *bpage, *tmp;
 	long i;
 
+	/* Check if the available memory is there first */
+	i = si_mem_available();
+	if (i < nr_pages)
+		return -ENOMEM;
+
 	for (i = 0; i < nr_pages; i++) {
 		struct page *page;
 		/*
-- 
2.13.6
