Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 2cOsDMlVGVtLOgAAmS7hNA
	; Thu, 07 Jun 2018 15:57:41 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BB9BA6089E; Thu,  7 Jun 2018 15:57:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2467160590;
	Thu,  7 Jun 2018 15:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2467160590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933944AbeFGP5Z (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:57:25 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39386 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932876AbeFGOJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:08 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb7-0005fJ-Q4; Thu, 07 Jun 2018 15:09:06 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb6-0002zw-6U; Thu, 07 Jun 2018 15:09:04 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        "Vegard Nossum" <vegard.nossum@oracle.com>,
        "Tetsuo Handa" <penguin-kernel@I-love.SAKURA.ne.jp>,
        "Jens Axboe" <axboe@fb.com>, "Willy Tarreau" <w@1wt.eu>,
        "Al Viro" <viro@zeniv.linux.org.uk>, "" <socketpair@gmail.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.867389047@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 206/410] pipe: cap initial pipe capacity according to
 pipe-max-size limit
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

From: "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>

commit 086e774a57fba4695f14383c0818994c0b31da7c upstream.

This is a patch that provides behavior that is more consistent, and
probably less surprising to users. I consider the change optional, and
welcome opinions about whether it should be applied.

By default, pipes are created with a capacity of 64 kiB.  However,
/proc/sys/fs/pipe-max-size may be set smaller than this value.  In this
scenario, an unprivileged user could thus create a pipe whose initial
capacity exceeds the limit. Therefore, it seems logical to cap the
initial pipe capacity according to the value of pipe-max-size.

The test program shown earlier in this patch series can be used to
demonstrate the effect of the change brought about with this patch:

    # cat /proc/sys/fs/pipe-max-size
    1048576
    # sudo -u mtk ./test_F_SETPIPE_SZ 1
    Initial pipe capacity: 65536
    # echo 10000 > /proc/sys/fs/pipe-max-size
    # cat /proc/sys/fs/pipe-max-size
    16384
    # sudo -u mtk ./test_F_SETPIPE_SZ 1
    Initial pipe capacity: 16384
    # ./test_F_SETPIPE_SZ 1
    Initial pipe capacity: 65536

The last two executions of 'test_F_SETPIPE_SZ' show that pipe-max-size
caps the initial allocation for a new pipe for unprivileged users, but
not for privileged users.

Link: http://lkml.kernel.org/r/31dc7064-2a17-9c5b-1df1-4e3012ee992c@gmail.com
Signed-off-by: Michael Kerrisk <mtk.manpages@gmail.com>
Reviewed-by: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Willy Tarreau <w@1wt.eu>
Cc: <socketpair@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Jens Axboe <axboe@fb.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/pipe.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -617,6 +617,9 @@ struct pipe_inode_info *alloc_pipe_info(
 	if (pipe == NULL)
 		goto out_free_uid;
 
+	if (pipe_bufs * PAGE_SIZE > pipe_max_size && !capable(CAP_SYS_RESOURCE))
+		pipe_bufs = pipe_max_size >> PAGE_SHIFT;
+
 	user_bufs = account_pipe_buffers(user, 0, pipe_bufs);
 
 	if (too_many_pipe_buffers_soft(user_bufs)) {
