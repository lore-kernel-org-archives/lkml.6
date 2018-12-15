Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EDDC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE34208C1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbeLODA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 22:00:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:38484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbeLODA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 22:00:58 -0500
Received: from vmware.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB3AD2086D;
        Sat, 15 Dec 2018 03:00:56 +0000 (UTC)
Date:   Fri, 14 Dec 2018 22:00:54 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     James Morse <james.morse@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 6/6] arm64: Use ftrace_graph_get_ret_stack() instead of
 curr_ret_stack
Message-ID: <20181214220054.101f9e4c@vmware.local.home>
In-Reply-To: <f0613902-80ac-5865-26ee-f0aac4d3b906@arm.com>
References: <20181210193007.655970639@goodmis.org>
        <20181210193335.417173167@goodmis.org>
        <f0613902-80ac-5865-26ee-f0aac4d3b906@arm.com>
X-Mailer: Claws Mail 3.15.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 17:09:35 +0000
James Morse <james.morse@arm.com> wrote:

> Hi Steven,
> 

> I gave this branch a spin, but I hit the WARN_ON() fairly easily:

Thanks for testing!

Can you see if this patch fixes it for you?

-- Steve

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index d4f04f0ca646..8dfd5021b933 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -246,10 +246,10 @@ unsigned long ftrace_return_to_handler(unsigned long frame_pointer)
 struct ftrace_ret_stack *
 ftrace_graph_get_ret_stack(struct task_struct *task, int idx)
 {
-	idx = current->curr_ret_stack - idx;
+	idx = task->curr_ret_stack - idx;
 
 	if (idx >= 0 && idx <= task->curr_ret_stack)
-		return &current->ret_stack[idx];
+		return &task->ret_stack[idx];
 
 	return NULL;
 }

