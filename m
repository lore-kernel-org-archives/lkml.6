Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id EiVvFn1MGVvPYQAAmS7hNA
	; Thu, 07 Jun 2018 15:18:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 700A4607E7; Thu,  7 Jun 2018 15:18:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C63A6601B4;
	Thu,  7 Jun 2018 15:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C63A6601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935877AbeFGPSL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:18:11 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41298 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935720AbeFGO7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:59:41 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbe-0005hJ-EC; Thu, 07 Jun 2018 15:09:38 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb6-00031u-MQ; Thu, 07 Jun 2018 15:09:04 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Michael Kerrisk" <mtk.manpages@gmail.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Mikulas Patocka" <mpatocka@redhat.com>,
        "Eric Biggers" <ebiggers@google.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Willy Tarreau" <w@1wt.eu>,
        "Joe Lawrence" <joe.lawrence@redhat.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.615608833@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 216/410] pipe: read buffer limits atomically
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

From: Eric Biggers <ebiggers@google.com>

commit f7340761812fc10313e6fcc115e0bc4f7a799112 upstream.

The pipe buffer limits are accessed without any locking, and may be
changed at any time by the sysctl handlers.  In theory this could cause
problems for expressions like the following:

    pipe_user_pages_hard && user_bufs > pipe_user_pages_hard

...  since the assembly code might reference the 'pipe_user_pages_hard'
memory location multiple times, and if the admin removes the limit by
setting it to 0, there is a very brief window where processes could
incorrectly observe the limit to be exceeded.

Fix this by loading the limits with READ_ONCE() prior to use.

Link: http://lkml.kernel.org/r/20180111052902.14409-8-ebiggers3@gmail.com
Signed-off-by: Eric Biggers <ebiggers@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Willy Tarreau <w@1wt.eu>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: "Luis R . Rodriguez" <mcgrof@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16:
 - Use ACCESS_ONCE() instead of READ_ONCE()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/pipe.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -593,12 +593,16 @@ static unsigned long account_pipe_buffer
 
 static bool too_many_pipe_buffers_soft(unsigned long user_bufs)
 {
-	return pipe_user_pages_soft && user_bufs > pipe_user_pages_soft;
+	unsigned long soft_limit = ACCESS_ONCE(pipe_user_pages_soft);
+
+	return soft_limit && user_bufs > soft_limit;
 }
 
 static bool too_many_pipe_buffers_hard(unsigned long user_bufs)
 {
-	return pipe_user_pages_hard && user_bufs > pipe_user_pages_hard;
+	unsigned long hard_limit = ACCESS_ONCE(pipe_user_pages_hard);
+
+	return hard_limit && user_bufs > hard_limit;
 }
 
 static bool is_unprivileged_user(void)
@@ -612,13 +616,14 @@ struct pipe_inode_info *alloc_pipe_info(
 	unsigned long pipe_bufs = PIPE_DEF_BUFFERS;
 	struct user_struct *user = get_current_user();
 	unsigned long user_bufs;
+	unsigned int max_size = ACCESS_ONCE(pipe_max_size);
 
 	pipe = kzalloc(sizeof(struct pipe_inode_info), GFP_KERNEL);
 	if (pipe == NULL)
 		goto out_free_uid;
 
-	if (pipe_bufs * PAGE_SIZE > pipe_max_size && !capable(CAP_SYS_RESOURCE))
-		pipe_bufs = pipe_max_size >> PAGE_SHIFT;
+	if (pipe_bufs * PAGE_SIZE > max_size && !capable(CAP_SYS_RESOURCE))
+		pipe_bufs = max_size >> PAGE_SHIFT;
 
 	user_bufs = account_pipe_buffers(user, 0, pipe_bufs);
 
