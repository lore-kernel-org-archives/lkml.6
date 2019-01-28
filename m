Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460A5C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16BC62084C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694062;
	bh=qLnbqiT9riauDfqU+6LCamqrNi58n5MPx5SdsEi67lI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GBxoNHSbj8v2UUuu84behPOmv1lI2rjTcIg3hihe2cH0BHZv/VRUulhfIiO9viKAo
	 7eGArIdl6c3GPvtj2m+c2/pI5z87GNgmScrJIKFyypMk1h8Ubs7u1IiQT6dc1tlj+g
	 QADDrj6ULhrdem/tvum01pmYU1HniIyi9T58StjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389136AbfA1QWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:22:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:57822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389073AbfA1QVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:21:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26E912084A;
        Mon, 28 Jan 2019 16:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692515;
        bh=qLnbqiT9riauDfqU+6LCamqrNi58n5MPx5SdsEi67lI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UyzOnRhD0k0XNRB5IJ+v93yb5LqZ/u9h6RS+eCZjU9BfR/i3Jal4wNuTIsNlnLwUH
         hNV2IfTEobxVVBTSBS/fmQf+1Yu/ObBvxqv1cv+FkRftHEx+Fsj3ygHsFlesW6o84G
         It7JFJzVDRby47678Tcxrz1Tv3D89XlEA/zV1ibI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 046/107] tracing: Have trace_stack nr_entries compare not be so subtle
Date:   Mon, 28 Jan 2019 11:18:46 -0500
Message-Id: <20190128161947.57405-46-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
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
index 2a1abbaca10e..f9255740411e 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -290,7 +290,7 @@ __next(struct seq_file *m, loff_t *pos)
 {
 	long n = *pos - 1;
 
-	if (n > stack_trace_max.nr_entries || stack_dump_trace[n] == ULONG_MAX)
+	if (n >= stack_trace_max.nr_entries || stack_dump_trace[n] == ULONG_MAX)
 		return NULL;
 
 	m->private = (void *)n;
-- 
2.19.1

