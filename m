Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C04FC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5DD2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694413;
	bh=vwyx7JbQxCLjaBAxrpCUsJgYcw/gILGrPJiiEeZeyJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G9povFiESpwcZUgVbqx/REejcPO0XVZTtixtl4V9uBLUsJgctRoqN7o8ruPMTLJ/J
	 gZRr1e5CmUleqNGtdtZuCiz68olUVzzLFXp1848c9uv0uWZZcOHm+nLq+D6WYUn0id
	 gdefWGjFHMtTZSM7ETO9PYVhQKrDOF6mFGbU8Cqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388639AbfA1Qxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:53:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:52518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388379AbfA1QSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:18:16 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C47C020879;
        Mon, 28 Jan 2019 16:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692295;
        bh=vwyx7JbQxCLjaBAxrpCUsJgYcw/gILGrPJiiEeZeyJA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ml3OCN0rAM3DIugYW4RTQVDW99TcoQXrAJdldQnSPTHPMi4jtFFYFMLZDHF2B1pGx
         BRuKIemyFOP5SPOjI2KNwO5FNGcBwbaIezsUJE88vi+NTNJ7OUQJQaUiqMiKvM04Ox
         Dyvo5SCwFnhTZjaVfQ7wYxlSPx9XMHTqawPbZz74=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 143/170] seq_buf: Make seq_buf_puts() null-terminate the buffer
Date:   Mon, 28 Jan 2019 11:11:33 -0500
Message-Id: <20190128161200.55107-143-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

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
index 11f2ae0f9099..6aabb609dd87 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -144,9 +144,13 @@ int seq_buf_puts(struct seq_buf *s, const char *str)
 
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

