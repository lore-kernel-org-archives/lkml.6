Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47633C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFCD621471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 23:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFCD621471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeISEtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 00:49:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:35312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbeISEtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 00:49:08 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A830F20C0E;
        Tue, 18 Sep 2018 23:14:14 +0000 (UTC)
Date:   Tue, 18 Sep 2018 19:14:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vaibhav Nagarnaik <vnagarnaik@google.com>,
        Jason Behmer <jbehmer@google.com>, stable@vger.kernel.org
Subject: [GIT PULL] ring-buffer: Allow for rescheduling when removing pages
Message-ID: <20180918191413.4426aef4@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus (aka Greg),

Vaibhav Nagarnaik found that modifying the ring buffer size could cause
a huge latency in the system because it does a while loop to free pages
without releasing the CPU (on non preempt kernels). In a case where there
are hundreds of thousands of pages to free it could actually cause a system
stall. A properly place cond_resched() solves this issue.


Please pull the latest trace-v4.19-rc4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v4.19-rc4

Tag SHA1: 977e4fb3741e24151a255ee13bd4a1224545ae4e
Head SHA1: 83f365554e47997ec68dc4eca3f5dce525cd15c3


Vaibhav Nagarnaik (1):
      ring-buffer: Allow for rescheduling when removing pages

----
 kernel/trace/ring_buffer.c | 2 ++
 1 file changed, 2 insertions(+)
---------------------------
commit 83f365554e47997ec68dc4eca3f5dce525cd15c3
Author: Vaibhav Nagarnaik <vnagarnaik@google.com>
Date:   Fri Sep 7 15:31:29 2018 -0700

    ring-buffer: Allow for rescheduling when removing pages
    
    When reducing ring buffer size, pages are removed by scheduling a work
    item on each CPU for the corresponding CPU ring buffer. After the pages
    are removed from ring buffer linked list, the pages are free()d in a
    tight loop. The loop does not give up CPU until all pages are removed.
    In a worst case behavior, when lot of pages are to be freed, it can
    cause system stall.
    
    After the pages are removed from the list, the free() can happen while
    the work is rescheduled. Call cond_resched() in the loop to prevent the
    system hangup.
    
    Link: http://lkml.kernel.org/r/20180907223129.71994-1-vnagarnaik@google.com
    
    Cc: stable@vger.kernel.org
    Fixes: 83f40318dab00 ("ring-buffer: Make removal of ring buffer pages atomic")
    Reported-by: Jason Behmer <jbehmer@google.com>
    Signed-off-by: Vaibhav Nagarnaik <vnagarnaik@google.com>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1d92d4a982fd..65bd4616220d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1546,6 +1546,8 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 	tmp_iter_page = first_page;
 
 	do {
+		cond_resched();
+
 		to_remove_page = tmp_iter_page;
 		rb_inc_page(cpu_buffer, &tmp_iter_page);
 
