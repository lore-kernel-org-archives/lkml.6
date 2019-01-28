Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA158C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BD8E21741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694842;
	bh=n78tYJZsbdBlH2198GJIAs7H6OgPTbUCcAIb+5i47CQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WOeVEGbwHCW7f6Z8epqUxfx2RK1PuJ2ktQQwuIn7HuVjnJWFZ/X8IWQICSP4ry858
	 s8c/1+jbgSzzjE3+Gr2+FGP/MoyoMcIa784hehxVELPhH0Kw2MHAAMuMAgU5XCG9Zv
	 58VCMsC+LDUxsYXFIAwTME+2wV2DoxntfawRmbNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388148AbfA1RAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:00:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:45588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733059AbfA1QP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:15:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FA252177E;
        Mon, 28 Jan 2019 16:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692128;
        bh=n78tYJZsbdBlH2198GJIAs7H6OgPTbUCcAIb+5i47CQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pTmeUra6MzG2PyHJRqkMbrvfqicyB5AYaRvgRR6d+itEQLTw/qLbfLh44VwVknjtk
         NSRrGHdFTQLL7rDzx3ZxaJmf07C64pPVlhGLB556S2MwuJriCYzKpRckRYsb1lovNm
         Gm0/iIB2WoE1HCM+Ecty2I3JIUKqf3mAsBw3DFOg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 080/170] tracing: Have trace_stack nr_entries compare not be so subtle
Date:   Mon, 28 Jan 2019 11:10:30 -0500
Message-Id: <20190128161200.55107-80-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

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
index 719a52a4064a..ba662010542c 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -282,7 +282,7 @@ __next(struct seq_file *m, loff_t *pos)
 {
 	long n = *pos - 1;
 
-	if (n > stack_trace_max.nr_entries || stack_dump_trace[n] == ULONG_MAX)
+	if (n >= stack_trace_max.nr_entries || stack_dump_trace[n] == ULONG_MAX)
 		return NULL;
 
 	m->private = (void *)n;
-- 
2.19.1

