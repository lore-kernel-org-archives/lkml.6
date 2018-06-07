Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0cNbBotHGVsCPgAAmS7hNA
	; Thu, 07 Jun 2018 14:56:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EF44B608B8; Thu,  7 Jun 2018 14:56:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 499F1601C3;
	Thu,  7 Jun 2018 14:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 499F1601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935481AbeFGO4K (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:56:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41079 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935497AbeFGOzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:55:51 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbe-0005hK-E3; Thu, 07 Jun 2018 15:09:38 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb6-00031q-LH; Thu, 07 Jun 2018 15:09:04 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Joe Lawrence" <joe.lawrence@redhat.com>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Willy Tarreau" <w@1wt.eu>,
        "Mikulas Patocka" <mpatocka@redhat.com>,
        "Eric Biggers" <ebiggers@google.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Michael Kerrisk" <mtk.manpages@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.959380922@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 215/410] pipe: simplify round_pipe_size()
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

commit c4fed5a91fadc8a277b1eda474317b501651dd3e upstream.

round_pipe_size() calculates the number of pages the requested size
corresponds to, then rounds the page count up to the next power of 2.

However, it also rounds everything < PAGE_SIZE up to PAGE_SIZE.
Therefore, there's no need to actually translate the size into a page
count; we just need to round the size up to the next power of 2.

We do need to verify the size isn't greater than (1 << 31), since on
32-bit systems roundup_pow_of_two() would be undefined in that case.  But
that can just be combined with the UINT_MAX check which we need anyway
now.

Finally, update pipe_set_size() to not redundantly check the return value
of round_pipe_size() for the "invalid size" case twice.

Link: http://lkml.kernel.org/r/20180111052902.14409-7-ebiggers3@gmail.com
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
 fs/pipe.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1010,20 +1010,14 @@ const struct file_operations pipefifo_fo
  */
 unsigned int round_pipe_size(unsigned long size)
 {
-	unsigned long nr_pages;
-
-	if (size > UINT_MAX)
+	if (size > (1U << 31))
 		return 0;
 
 	/* Minimum pipe size, as required by POSIX */
 	if (size < PAGE_SIZE)
-		size = PAGE_SIZE;
-
-	nr_pages = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	if (nr_pages == 0)
-		return 0;
+		return PAGE_SIZE;
 
-	return roundup_pow_of_two(nr_pages) << PAGE_SHIFT;
+	return roundup_pow_of_two(size);
 }
 
 /*
@@ -1038,8 +1032,6 @@ static long pipe_set_size(struct pipe_in
 	long ret = 0;
 
 	size = round_pipe_size(arg);
-	if (size == 0)
-		return -EINVAL;
 	nr_pages = size >> PAGE_SHIFT;
 
 	if (!nr_pages)
