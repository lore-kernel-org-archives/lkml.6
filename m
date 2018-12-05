Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C8FC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E02920878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nd61+pK5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E02920878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbeLEJml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:42:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:47210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728038AbeLEJmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:42:38 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31FAA2084C;
        Wed,  5 Dec 2018 09:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002957;
        bh=XrjACaW2SbwXiwPnkNZKwG2V44abROTSNb64Vc0wWYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nd61+pK5673DpIccWRf2cPMuU9oTP+6HGsl4B6ycLRlGt4AqO2ToxYet44PZZPAmd
         s9oeZ2nhoBAQ0YNnPlvHzh0wbP99Km4AyGrhxpgNkgaYt3SymqDDgrLoynlGW95wvC
         kzaelc5pdpLf+Xe+Bb9Qbaj5CDygNvCBZnY+jutU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@elte.hu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 121/123] kernel/kcov.c: mark funcs in __sanitizer_cov_trace_pc() as notrace
Date:   Wed,  5 Dec 2018 04:35:53 -0500
Message-Id: <20181205093555.5386-121-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anders Roxell <anders.roxell@linaro.org>

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
2.17.1

