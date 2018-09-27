Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D75C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5612721533
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5612721533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbeI0PnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:43:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56814 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbeI0PnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:43:18 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7B50A1133;
        Thu, 27 Sep 2018 09:25:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Behmer <jbehmer@google.com>,
        Vaibhav Nagarnaik <vnagarnaik@google.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH 4.9 17/44] ring-buffer: Allow for rescheduling when removing pages
Date:   Thu, 27 Sep 2018 11:04:06 +0200
Message-Id: <20180927090120.301391611@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090117.997362691@linuxfoundation.org>
References: <20180927090117.997362691@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vaibhav Nagarnaik <vnagarnaik@google.com>

commit 83f365554e47997ec68dc4eca3f5dce525cd15c3 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/trace/ring_buffer.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1504,6 +1504,8 @@ rb_remove_pages(struct ring_buffer_per_c
 	tmp_iter_page = first_page;
 
 	do {
+		cond_resched();
+
 		to_remove_page = tmp_iter_page;
 		rb_inc_page(cpu_buffer, &tmp_iter_page);
 


