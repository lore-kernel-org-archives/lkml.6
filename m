Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11E8C6778A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9C324011
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 01:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B9C324011
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932582AbeGFBGr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 21:06:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932363AbeGFBGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 21:06:39 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F28C240C2;
        Fri,  6 Jul 2018 01:06:39 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1fbFCo-0007In-G4; Thu, 05 Jul 2018 21:06:38 -0400
Message-Id: <20180706010638.398309689@goodmis.org>
User-Agent: quilt/0.65
Date:   Thu, 05 Jul 2018 21:06:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        yuan linyu <Linyu.Yuan@alcatel-sbell.com.cn>
Subject: [PATCH 3/6] tracing: Optimize trace_buffer_iter() logic
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yuan linyu <Linyu.Yuan@alcatel-sbell.com.cn>

Simplify and optimize the logic in trace_buffer_iter() to use a conditional
operation instead of an if conditional.

Link: http://lkml.kernel.org/r/20180408113631.3947-1-cugyly@163.com

Signed-off-by: yuan linyu <Linyu.Yuan@alcatel-sbell.com.cn>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 630c5a24b2b2..f8f86231ad90 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -583,9 +583,7 @@ static __always_inline void trace_clear_recursion(int bit)
 static inline struct ring_buffer_iter *
 trace_buffer_iter(struct trace_iterator *iter, int cpu)
 {
-	if (iter->buffer_iter && iter->buffer_iter[cpu])
-		return iter->buffer_iter[cpu];
-	return NULL;
+	return iter->buffer_iter ? iter->buffer_iter[cpu] : NULL;
 }
 
 int tracer_init(struct tracer *t, struct trace_array *tr);
-- 
2.17.1


