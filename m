Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id iWyPEmdIGVt9SAAAmS7hNA
	; Thu, 07 Jun 2018 15:00:14 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 759D7608B8; Thu,  7 Jun 2018 15:00:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CA328606DD;
	Thu,  7 Jun 2018 15:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CA328606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935790AbeFGPAL (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 11:00:11 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41327 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935764AbeFGPAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 11:00:07 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbg-0005Zq-P9; Thu, 07 Jun 2018 15:09:40 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb6-00031m-K9; Thu, 07 Jun 2018 15:09:04 +0100
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
        "Joe Lawrence" <joe.lawrence@redhat.com>,
        "Willy Tarreau" <w@1wt.eu>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.645665231@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 214/410] pipe: reject F_SETPIPE_SZ with size over
 UINT_MAX
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

commit 96e99be40e4cff870a83233731121ec0f7f95075 upstream.

A pipe's size is represented as an 'unsigned int'.  As expected, writing a
value greater than UINT_MAX to /proc/sys/fs/pipe-max-size fails with
EINVAL.  However, the F_SETPIPE_SZ fcntl silently truncates such values to
32 bits, rather than failing with EINVAL as expected.  (It *does* fail
with EINVAL for values above (1 << 31) but <= UINT_MAX.)

Fix this by moving the check against UINT_MAX into round_pipe_size() which
is called in both cases.

Link: http://lkml.kernel.org/r/20180111052902.14409-6-ebiggers3@gmail.com
Signed-off-by: Eric Biggers <ebiggers@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: "Luis R . Rodriguez" <mcgrof@kernel.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Willy Tarreau <w@1wt.eu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/pipe.c                 | 5 ++++-
 include/linux/pipe_fs_i.h | 2 +-
 kernel/sysctl.c           | 3 ---
 3 files changed, 5 insertions(+), 5 deletions(-)

--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1008,10 +1008,13 @@ const struct file_operations pipefifo_fo
  * Currently we rely on the pipe array holding a power-of-2 number
  * of pages. Returns 0 on error.
  */
-unsigned int round_pipe_size(unsigned int size)
+unsigned int round_pipe_size(unsigned long size)
 {
 	unsigned long nr_pages;
 
+	if (size > UINT_MAX)
+		return 0;
+
 	/* Minimum pipe size, as required by POSIX */
 	if (size < PAGE_SIZE)
 		size = PAGE_SIZE;
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -148,6 +148,6 @@ long pipe_fcntl(struct file *, unsigned
 struct pipe_inode_info *get_pipe_info(struct file *file);
 
 int create_pipe_files(struct file **, int);
-unsigned int round_pipe_size(unsigned int size);
+unsigned int round_pipe_size(unsigned long size);
 
 #endif
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2230,9 +2230,6 @@ static int do_proc_dopipe_max_size_conv(
 	if (write) {
 		unsigned int val;
 
-		if (*lvalp > UINT_MAX)
-			return -EINVAL;
-
 		val = round_pipe_size(*lvalp);
 		if (*negp || val == 0)
 			return -EINVAL;
