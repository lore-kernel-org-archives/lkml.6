Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC7DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0F7222B5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897787;
	bh=ght+1KwTDVZNBxf9/3+ucoLEUIfLIETi+M8eMrMqcHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uxN6YtG+QASlXswU66PglHkZACQUo4u3dqwk2KHNvLaTqKWQZzwxa4S8Rtw9+NoPS
	 KeP0JgkPqsAlsvpP3coeD/dVHr5CaRZKJyDFcJzMzd7H3DyJfi/9fRocuZEExRCR/g
	 RkL0d56jzq137LA2D+MdUHqI65Efe8XLoO3RQBFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391714AbfBKPJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:09:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:59678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391675AbfBKPJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:09:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B71FB222B2;
        Mon, 11 Feb 2019 15:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897782;
        bh=ght+1KwTDVZNBxf9/3+ucoLEUIfLIETi+M8eMrMqcHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y6ZJh1mYn4/+42RhIbkineB4BJ6rY+X9hnQq0VWs/DRKTHpeT8p2kn24OIKen7UfK
         pwVf/9/rx+YO7XQEwiC3Zc0tBjjxgdLSHjIPQTEYSLqn770X7D8fDkw8OfPl5qqC0R
         5S0KeRFut5F469Yu/r1AEIYCW0Sz1M9SpwXvC7Zc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 083/137] seq_buf: Make seq_buf_puts() null-terminate the buffer
Date:   Mon, 11 Feb 2019 15:19:24 +0100
Message-Id: <20190211141819.700407025@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 0464ed24380905d640030d368cd84a4e4d1e15e2 ]

Currently seq_buf_puts() will happily create a non null-terminated
string for you in the buffer. This is particularly dangerous if the
buffer is on the stack.

For example:

  char buf[8];
  char secret = "secret";
  struct seq_buf s;

  seq_buf_init(&s, buf, sizeof(buf));
  seq_buf_puts(&s, "foo");
  printk("Message is %s\n", buf);

Can result in:

  Message is fooªªªªªsecret

We could require all users to memset() their buffer to zero before
use. But that seems likely to be forgotten and lead to bugs.

Instead we can change seq_buf_puts() to always leave the buffer in a
null-terminated state.

The only downside is that this makes the buffer 1 character smaller
for seq_buf_puts(), but that seems like a good trade off.

Link: http://lkml.kernel.org/r/20181019042109.8064-1-mpe@ellerman.id.au

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/seq_buf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index cb18469e1f49..5954f9fb6675 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -143,9 +143,13 @@ int seq_buf_puts(struct seq_buf *s, const char *str)
 
 	WARN_ON(s->size == 0);
 
+	/* Add 1 to len for the trailing null byte which must be there */
+	len += 1;
+
 	if (seq_buf_can_fit(s, len)) {
 		memcpy(s->buffer + s->len, str, len);
-		s->len += len;
+		/* Don't count the trailing null byte against the capacity */
+		s->len += len - 1;
 		return 0;
 	}
 	seq_buf_set_overflow(s);
-- 
2.19.1



