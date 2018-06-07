Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vNWeLRlDGVvVBAAAmS7hNA
	; Thu, 07 Jun 2018 14:40:59 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 37A40608C9; Thu,  7 Jun 2018 14:40:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A846A607DC;
	Thu,  7 Jun 2018 14:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A846A607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934578AbeFGOk4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:40:56 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40570 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934559AbeFGOkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:40:53 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbg-0005Zv-DK; Thu, 07 Jun 2018 15:09:40 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb6-00031f-GX; Thu, 07 Jun 2018 15:09:04 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Michael Kerrisk" <mtk.manpages@gmail.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Eric Biggers" <ebiggers@google.com>,
        "Mikulas Patocka" <mpatocka@redhat.com>,
        "Willy Tarreau" <w@1wt.eu>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "Joe Lawrence" <joe.lawrence@redhat.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.310937469@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 213/410] pipe: fix off-by-one error when checking
 buffer limits
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

commit 9903a91c763ecdae333a04a9d89d79d2b8966503 upstream.

With pipe-user-pages-hard set to 'N', users were actually only allowed up
to 'N - 1' buffers; and likewise for pipe-user-pages-soft.

Fix this to allow up to 'N' buffers, as would be expected.

Link: http://lkml.kernel.org/r/20180111052902.14409-5-ebiggers3@gmail.com
Fixes: b0b91d18e2e9 ("pipe: fix limit checking in pipe_set_size()")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Acked-by: Willy Tarreau <w@1wt.eu>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: "Luis R . Rodriguez" <mcgrof@kernel.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/pipe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -593,12 +593,12 @@ static unsigned long account_pipe_buffer
 
 static bool too_many_pipe_buffers_soft(unsigned long user_bufs)
 {
-	return pipe_user_pages_soft && user_bufs >= pipe_user_pages_soft;
+	return pipe_user_pages_soft && user_bufs > pipe_user_pages_soft;
 }
 
 static bool too_many_pipe_buffers_hard(unsigned long user_bufs)
 {
-	return pipe_user_pages_hard && user_bufs >= pipe_user_pages_hard;
+	return pipe_user_pages_hard && user_bufs > pipe_user_pages_hard;
 }
 
 static bool is_unprivileged_user(void)
