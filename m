Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id qBd9Ht1HGVsBQQAAmS7hNA
	; Thu, 07 Jun 2018 14:57:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AABAE607E7; Thu,  7 Jun 2018 14:57:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6767D606DD;
	Thu,  7 Jun 2018 14:57:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6767D606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933799AbeFGO5m (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:57:42 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41128 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933308AbeFGO5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:57:39 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbg-0005Zl-FG; Thu, 07 Jun 2018 15:09:40 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb6-000303-8O; Thu, 07 Jun 2018 15:09:04 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Josh Poimboeuf" <jpoimboe@redhat.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Jens Axboe" <axboe@kernel.dk>,
        "Mikulas Patocka" <mpatocka@redhat.com>,
        "Joe Lawrence" <joe.lawrence@redhat.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Michael Kerrisk" <mtk.manpages@gmail.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.307254981@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 207/410] pipe: avoid round_pipe_size() nr_pages
 overflow on 32-bit
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Joe Lawrence <joe.lawrence@redhat.com>

commit d3f14c485867cfb2e0c48aa88c41d0ef4bf5209c upstream.

round_pipe_size() contains a right-bit-shift expression which may
overflow, which would cause undefined results in a subsequent
roundup_pow_of_two() call.

  static inline unsigned int round_pipe_size(unsigned int size)
  {
          unsigned long nr_pages;

          nr_pages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
          return roundup_pow_of_two(nr_pages) << PAGE_SHIFT;
  }

PAGE_SIZE is defined as (1UL << PAGE_SHIFT), so:
  - 4 bytes wide on 32-bit (0 to 0xffffffff)
  - 8 bytes wide on 64-bit (0 to 0xffffffffffffffff)

That means that 32-bit round_pipe_size(), nr_pages may overflow to 0:

  size=0x00000000    nr_pages=0x0
  size=0x00000001    nr_pages=0x1
  size=0xfffff000    nr_pages=0xfffff
  size=0xfffff001    nr_pages=0x0         << !
  size=0xffffffff    nr_pages=0x0         << !

This is bad because roundup_pow_of_two(n) is undefined when n == 0!

64-bit is not a problem as the unsigned int size is 4 bytes wide
(similar to 32-bit) and the larger, 8 byte wide unsigned long, is
sufficient to handle the largest value of the bit shift expression:

  size=0xffffffff    nr_pages=100000

Modify round_pipe_size() to return 0 if n == 0 and updates its callers to
handle accordingly.

Link: http://lkml.kernel.org/r/1507658689-11669-3-git-send-email-joe.lawrence@redhat.com
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
Reported-by: Mikulas Patocka <mpatocka@redhat.com>
Reviewed-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/pipe.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1006,13 +1006,19 @@ const struct file_operations pipefifo_fo
 
 /*
  * Currently we rely on the pipe array holding a power-of-2 number
- * of pages.
+ * of pages. Returns 0 on error.
  */
 static inline unsigned int round_pipe_size(unsigned int size)
 {
 	unsigned long nr_pages;
 
+	if (size < pipe_min_size)
+		size = pipe_min_size;
+
 	nr_pages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	if (nr_pages == 0)
+		return 0;
+
 	return roundup_pow_of_two(nr_pages) << PAGE_SHIFT;
 }
 
@@ -1028,6 +1034,8 @@ static long pipe_set_size(struct pipe_in
 	long ret = 0;
 
 	size = round_pipe_size(arg);
+	if (size == 0)
+		return -EINVAL;
 	nr_pages = size >> PAGE_SHIFT;
 
 	if (!nr_pages)
@@ -1110,13 +1118,18 @@ out_revert_acct:
 int pipe_proc_fn(struct ctl_table *table, int write, void __user *buf,
 		 size_t *lenp, loff_t *ppos)
 {
+	unsigned int rounded_pipe_max_size;
 	int ret;
 
 	ret = proc_dointvec_minmax(table, write, buf, lenp, ppos);
 	if (ret < 0 || !write)
 		return ret;
 
-	pipe_max_size = round_pipe_size(pipe_max_size);
+	rounded_pipe_max_size = round_pipe_size(pipe_max_size);
+	if (rounded_pipe_max_size == 0)
+		return -EINVAL;
+
+	pipe_max_size = rounded_pipe_max_size;
 	return ret;
 }
 
