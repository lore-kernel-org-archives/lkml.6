Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DC7C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F99214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895240;
	bh=b/Qpnc0gIvV/cTfCFf7FN74x4ySbEsUadgh6ZDIt7r4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VsZnw8UywmwRsyjADJ9vKl9ad/68MsZEA0XGVGM6GOjAKLQHv6Z3nBYYluI+3TUDx
	 kKV0jV21480yRaMoGoLJnUjUvYM2fOK5BgYna/k0F9tZqsO9jbo+bz7LaHA+tLHH7a
	 Qo188RUkHIQEUikzXM74exYMh2JXavTV7Q9UDiNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbfBKO1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:27:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:33030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729689AbfBKO1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:27:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C0362075C;
        Mon, 11 Feb 2019 14:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895235;
        bh=b/Qpnc0gIvV/cTfCFf7FN74x4ySbEsUadgh6ZDIt7r4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oETDPQRdaVvtUP6HiaCK7EgIqyM1g/t/GIpNCQVznD3w5+fb5J6E93Wo00SaNINIs
         YMHafm1nDwmx//qSNtORDLFXUNBOP6mbf2xrhTsvi6GavoYixswho1TsRGHVDUfNx1
         CR8LDD3K5fkNBoKICWWIiLJjzEexIJjd0xDfSClY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 138/352] tracing: Have trace_stack nr_entries compare not be so subtle
Date:   Mon, 11 Feb 2019 15:16:05 +0100
Message-Id: <20190211141855.296924278@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ca16b0fbb05242f18da9d810c07d3882ffed831c ]

Dan Carpenter reviewed the trace_stack.c code and figured he found an off by
one bug.

 "From reviewing the code, it seems possible for
  stack_trace_max.nr_entries to be set to .max_entries and in that case we
  would be reading one element beyond the end of the stack_dump_trace[]
  array.  If it's not set to .max_entries then the bug doesn't affect
  runtime."

Although it looks to be the case, it is not. Because we have:

 static unsigned long stack_dump_trace[STACK_TRACE_ENTRIES+1] =
	 { [0 ... (STACK_TRACE_ENTRIES)] = ULONG_MAX };

 struct stack_trace stack_trace_max = {
	.max_entries		= STACK_TRACE_ENTRIES - 1,
	.entries		= &stack_dump_trace[0],
 };

And:

	stack_trace_max.nr_entries = x;
	for (; x < i; x++)
		stack_dump_trace[x] = ULONG_MAX;

Even if nr_entries equals max_entries, indexing with it into the
stack_dump_trace[] array will not overflow the array. But if it is the case,
the second part of the conditional that tests stack_dump_trace[nr_entries]
to ULONG_MAX will always be true.

By applying Dan's patch, it removes the subtle aspect of it and makes the if
conditional slightly more efficient.

Link: http://lkml.kernel.org/r/20180620110758.crunhd5bfep7zuiz@kili.mountain

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_stack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 2b0d1ee3241c..e2a153fc1afc 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -286,7 +286,7 @@ __next(struct seq_file *m, loff_t *pos)
 {
 	long n = *pos - 1;
 
-	if (n > stack_trace_max.nr_entries || stack_dump_trace[n] == ULONG_MAX)
+	if (n >= stack_trace_max.nr_entries || stack_dump_trace[n] == ULONG_MAX)
 		return NULL;
 
 	m->private = (void *)n;
-- 
2.19.1



