Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F5FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 598EF2184E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 16:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549988159;
	bh=DYYuFTFbws882p5tVP8bYyLy2Iu9FrDbZAXtF45aXSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vKG61FlqXZJjvuJKg85ZMntbSpvNf4BXnnLvqwy3uE2rrcCvKt3zM7WdXkE/NQumb
	 r45jnxaWIJxwXdKCGQDLLx8aPYdi9hTudKsw5Z3VgTmV3A6KRQ7/N01P2IIcZArb3E
	 Tr0uFbR6i4GJea39wJSyACKQYM15wWZ6i6jKTR2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbfBLQP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 11:15:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:45202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728869AbfBLQP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 11:15:57 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 162FE21773;
        Tue, 12 Feb 2019 16:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549988157;
        bh=DYYuFTFbws882p5tVP8bYyLy2Iu9FrDbZAXtF45aXSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RFt1SS6vRamDdRG55Io9eT0q1xQO2pHfkP3vzTC7Mt5hwWp4O/ORVfunbCsDP5i0o
         sdS02sQK8RRcxUvyK1kVFXFwKMlSfrQlf+aapBTdWRM68EyLZqbi55WgieWdqzqhAf
         OiMP1UKzsCXY91ELl6cyTIk4yAkhv7cSFN80WJL4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH -tip v3 10/10] kprobes: Prohibit probing on bsearch()
Date:   Wed, 13 Feb 2019 01:15:34 +0900
Message-Id: <154998813406.31052.8791425358974650922.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154998785011.31052.1475728497912659748.stgit@devbox>
References: <154998785011.31052.1475728497912659748.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Righi <righi.andrea@gmail.com>

Since kprobe breakpoing handler is using bsearch(), probing on this
routine can cause recursive breakpoint problem.

int3
 ->do_int3()
   ->ftrace_int3_handler()
     ->ftrace_location()
       ->ftrace_location_range()
         ->bsearch() -> int3

Prohibit probing on bsearch().

Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 lib/bsearch.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bsearch.c b/lib/bsearch.c
index 18b445b010c3..82512fe7b33c 100644
--- a/lib/bsearch.c
+++ b/lib/bsearch.c
@@ -11,6 +11,7 @@
 
 #include <linux/export.h>
 #include <linux/bsearch.h>
+#include <linux/kprobes.h>
 
 /*
  * bsearch - binary search an array of elements
@@ -53,3 +54,4 @@ void *bsearch(const void *key, const void *base, size_t num, size_t size,
 	return NULL;
 }
 EXPORT_SYMBOL(bsearch);
+NOKPROBE_SYMBOL(bsearch);

