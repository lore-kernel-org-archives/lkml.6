Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B88ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7333A2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 12:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7333A2150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbeJQUFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 16:05:34 -0400
Received: from ozlabs.org ([203.11.71.1]:51815 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbeJQUFe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 16:05:34 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42ZrbM2MTlz9sC2; Wed, 17 Oct 2018 23:10:07 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: [PATCH] seq_buf: Make seq_buf_puts() NULL terminate the buffer
Date:   Wed, 17 Oct 2018 23:10:00 +1100
Message-Id: <20181017121000.30240-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently seq_buf_puts() will happily create a non NULL terminated
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

We could require all users to memset() their buffer to NULL before
use. But that seems likely to be forgotten and lead to bugs.

Instead we can change seq_buf_puts() to always leave the buffer in a
NULL terminated state.

The only downside is that this makes the buffer 1 character smaller
for seq_buf_puts(), but that seems like a good trade off.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 lib/seq_buf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

I recently merged a patch which actually hit this behaviour. I worked
around it by using seq_buf_printf(), but it would be good to fix the
problem at the source.

diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 11f2ae0f9099..b1570204cde3 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -144,9 +144,13 @@ int seq_buf_puts(struct seq_buf *s, const char *str)
 
 	WARN_ON(s->size == 0);
 
+	/* Add 1 to len for the trailing NULL which must be there */
+	len += 1;
+
 	if (seq_buf_can_fit(s, len)) {
 		memcpy(s->buffer + s->len, str, len);
-		s->len += len;
+		/* Don't count the trailing NULL against the capacity */
+		s->len += len - 1;
 		return 0;
 	}
 	seq_buf_set_overflow(s);
-- 
2.17.1

