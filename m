Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353FBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0070A2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 04:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547786719;
	bh=6AbVRu6vHAg103vdTRg9nvY30kWiuO0o6yv14fm75vQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a8Z83IJfvowwDTIPdLpWW+nRi2Hg6HVuWRqBhGPJQszjyYKb9kJmIQs2nURptAU6x
	 Gtpe6hhh8mF+InjUmW68Uz8pM7KsXhn0qeYMQEaL0/5WlVac+3wpijnxpEWi3HGUXE
	 9z/LKsfsWNQnh9L4nPRY20BXl/YRV554vdB0K1Lc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfAREpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 23:45:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:56584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbfAREpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 23:45:17 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3EED2086D;
        Fri, 18 Jan 2019 04:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547786716;
        bh=6AbVRu6vHAg103vdTRg9nvY30kWiuO0o6yv14fm75vQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XQ2/S2N6e0BzniZn9SrCahiRRT4ggt6S0TgM9XQi4wLd/vBg3Yw5T4il/OcWILBNz
         798U36n7G6F0a/OR3oz2bsBXk4GC/j2FIE7Mjrbz0m6jGSsBzh6zmOuT4K5oz7jdaM
         e/HQU2TsFWg8EWVJG8/paPS9PhtpWSuGJTRuD1z8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andreas Ziegler <andreas.ziegler@fau.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] tracing: probeevent: Do not accumulate on ret variable
Date:   Fri, 18 Jan 2019 13:44:54 +0900
Message-Id: <154778669389.19927.8802462599466946288.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <154778663676.19927.12774448308165809570.stgit@devbox>
References: <154778663676.19927.12774448308165809570.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not accumulate strlen result on "ret" local variable, because
it is accumulated on "total" local variable for array case.

Fixes: 40b53b771806 ("tracing: probeevent: Add array type support")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_probe_tmpl.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 5c56afc17cf8..e69b05a9f57c 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -88,7 +88,7 @@ process_fetch_insn_bottom(struct fetch_insn *code, unsigned long val,
 	/* 3rd stage: store value to buffer */
 	if (unlikely(!dest)) {
 		if (code->op == FETCH_OP_ST_STRING) {
-			ret += fetch_store_strlen(val + code->offset);
+			ret = fetch_store_strlen(val + code->offset);
 			code++;
 			goto array;
 		} else

