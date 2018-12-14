Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA69C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121E021479
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544789195;
	bh=rS5n5GehT27IPORQnonKcJSb9DyQHfRnLocOPWADnIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kbIAfe0AHtl1C0mZ7UOhw26d6qvJL+2Jf80IxcdiP6LfS5ca1RPAMx4LPsQiJmBxE
	 EfYqdmJUMUpO0Jk13v7ZnH1c3NmFexD0VpbFOjReTv100FZtX+92NSoZTTAF475jHK
	 UQVMrKeurEtUOHZ42F2fG/qUxpVP29AAyT4HNPHE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121E021479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730948AbeLNMGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:06:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:51608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730434AbeLNMGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:06:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 895B62147D;
        Fri, 14 Dec 2018 12:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789192;
        bh=rS5n5GehT27IPORQnonKcJSb9DyQHfRnLocOPWADnIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q/F7eZGcMcKc/RXe5iFCmnzyvoX1LlG1raShUD59rPGZlqWzf//cnDR2zNBMK/Ya8
         gCwIdTk4W4dmN6PXsZCfdxGG3VS4/wQbOkpPi4t0VXPB2p2FsK+1Zd6C5KMJfHknTP
         hV15yZBaSOdzfyRe+RJxtZR5lyc8YLl+jZaQbNq4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@elte.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 4.19 130/142] kernel/kcov.c: mark funcs in __sanitizer_cov_trace_pc() as notrace
Date:   Fri, 14 Dec 2018 13:00:15 +0100
Message-Id: <20181214115752.240888094@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 903e8ff86753e6f327bb92166a0665e4ecb8e2e7 ]

Since __sanitizer_cov_trace_pc() is marked as notrace, function calls in
__sanitizer_cov_trace_pc() shouldn't be traced either.
ftrace_graph_caller() gets called for each function that isn't marked
'notrace', like canonicalize_ip().  This is the call trace from a run:

[  139.644550]  ftrace_graph_caller+0x1c/0x24
[  139.648352]  canonicalize_ip+0x18/0x28
[  139.652313]  __sanitizer_cov_trace_pc+0x14/0x58
[  139.656184]  sched_clock+0x34/0x1e8
[  139.659759]  trace_clock_local+0x40/0x88
[  139.663722]  ftrace_push_return_trace+0x8c/0x1f0
[  139.667767]  prepare_ftrace_return+0xa8/0x100
[  139.671709]  ftrace_graph_caller+0x1c/0x24

Rework so that check_kcov_mode() and canonicalize_ip() that are called
from __sanitizer_cov_trace_pc() are also marked as notrace.

Link: http://lkml.kernel.org/r/20181128081239.18317-1-anders.roxell@linaro.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signen-off-by: Anders Roxell <anders.roxell@linaro.org>
Co-developed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/kcov.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 3ebd09efe72a..97959d7b77e2 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -56,7 +56,7 @@ struct kcov {
 	struct task_struct	*t;
 };
 
-static bool check_kcov_mode(enum kcov_mode needed_mode, struct task_struct *t)
+static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_struct *t)
 {
 	unsigned int mode;
 
@@ -78,7 +78,7 @@ static bool check_kcov_mode(enum kcov_mode needed_mode, struct task_struct *t)
 	return mode == needed_mode;
 }
 
-static unsigned long canonicalize_ip(unsigned long ip)
+static notrace unsigned long canonicalize_ip(unsigned long ip)
 {
 #ifdef CONFIG_RANDOMIZE_BASE
 	ip -= kaslr_offset();
-- 
2.19.1



