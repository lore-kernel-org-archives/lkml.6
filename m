Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD5FECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445CC21526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 14:48:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445CC21526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbeJQWob convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 18:44:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbeJQWob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 18:44:31 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA09B2151D;
        Wed, 17 Oct 2018 14:48:28 +0000 (UTC)
Date:   Wed, 17 Oct 2018 10:48:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH] seq_buf: Make seq_buf_puts() NULL terminate the buffer
Message-ID: <20181017104826.7f6fb605@gandalf.local.home>
In-Reply-To: <20181017121000.30240-1-mpe@ellerman.id.au>
References: <20181017121000.30240-1-mpe@ellerman.id.au>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018 23:10:00 +1100
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Currently seq_buf_puts() will happily create a non NULL terminated
> string for you in the buffer. This is particularly dangerous if the
> buffer is on the stack.
> 
> For example:
> 
>   char buf[8];
>   char secret = "secret";
>   struct seq_buf s;
> 
>   seq_buf_init(&s, buf, sizeof(buf));
>   seq_buf_puts(&s, "foo");
>   printk("Message is %s\n", buf);
> 
> Can result in:
> 
>   Message is fooªªªªªsecret
> 
> We could require all users to memset() their buffer to NULL before
> use. But that seems likely to be forgotten and lead to bugs.
> 
> Instead we can change seq_buf_puts() to always leave the buffer in a
> NULL terminated state.
> 
> The only downside is that this makes the buffer 1 character smaller
> for seq_buf_puts(), but that seems like a good trade off.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>

It's been on my todo list for some time, and that was to add this
(trace-cmd had this for years). Would this be useful?

Instead of always writing a nul pointer, just terminate it when you are
done.


-- Steve


diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 11f2ae0f9099..46f2a8b3e733 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -175,6 +175,29 @@ int seq_buf_putc(struct seq_buf *s, unsigned char c)
 }
 
 /**
+ * seq_buf_terminate - force the buffer to end in a nul character
+ * @s: seq_buf descriptor
+ *
+ * Make sure the current buffer terminates with a nul '\0' character.
+ * This does not increment the length of the buffer.
+ *
+ * Returns 0 if there was room to add the nul character.
+ *        -1 if there was not room. But a nul character was
+ *           still added, overwriting the last character in the buffer.
+ */
+int seq_buf_terminate(struct seq_buf *s)
+{
+	WARN_ON(s->size == 0);
+
+	if (seq_buf_can_fit(s, 1)) {
+		s->buffer[s->len] = '\0';
+		return 0;
+	}
+	s->buffer[--s->len] = '\0';
+	return -1;
+}
+
+/**
  * seq_buf_putmem - write raw data into the sequenc buffer
  * @s: seq_buf descriptor
  * @mem: The raw memory to copy into the buffer
