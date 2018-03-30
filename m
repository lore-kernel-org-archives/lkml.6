Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752538AbeC3VmO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 17:42:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751180AbeC3VmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 17:42:13 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F446217A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Fri, 30 Mar 2018 17:42:09 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-patch-test@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joelaf@google.com>, Michal Hocko <mhocko@suse.com>,
        linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v1] kernel/trace:check the val against the available mem
Message-ID: <20180330174209.4cb77003@gandalf.local.home>
In-Reply-To: <20180330173031.257a491a@gandalf.local.home>
References: <1522320104-6573-1-git-send-email-zhaoyang.huang@spreadtrum.com>
        <20180330102038.2378925b@gandalf.local.home>
        <20180330205356.GA13332@bombadil.infradead.org>
        <20180330173031.257a491a@gandalf.local.home>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Mar 2018 17:30:31 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I'll take a look at si_mem_available() that Joel suggested and see if
> we can make that work.

Wow, this appears to work great! Joel and Zhaoyang, can you test this?

-- Steve

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index a2fd3893cc02..32a803626ee2 100644
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
