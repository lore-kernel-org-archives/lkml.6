Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B969C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3921218E0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391330AbeLUR6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:58:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:56082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391146AbeLUR46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:56:58 -0500
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B6B221903;
        Fri, 21 Dec 2018 17:56:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.91)
        (envelope-from <rostedt@goodmis.org>)
        id 1gaP2f-0002Lm-3F; Fri, 21 Dec 2018 12:56:57 -0500
Message-Id: <20181221175656.992792400@goodmis.org>
User-Agent: quilt/0.65
Date:   Fri, 21 Dec 2018 12:56:28 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jann Horn <jannh@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [for-next][PATCH 10/24] seq_buf: Use size_t for len in seq_buf_puts()
References: <20181221175618.968519903@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

Jann Horn points out that we're using unsigned int for len in
seq_buf_puts(), which could potentially overflow if we're passed a
UINT_MAX sized string.

The rest of the code already uses size_t, so we should also use that
in seq_buf_puts() to avoid any issues.

Link: http://lkml.kernel.org/r/20181019042109.8064-2-mpe@ellerman.id.au

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 lib/seq_buf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/seq_buf.c b/lib/seq_buf.c
index 6aabb609dd87..bd807f545a9d 100644
--- a/lib/seq_buf.c
+++ b/lib/seq_buf.c
@@ -140,7 +140,7 @@ int seq_buf_bprintf(struct seq_buf *s, const char *fmt, const u32 *binary)
  */
 int seq_buf_puts(struct seq_buf *s, const char *str)
 {
-	unsigned int len = strlen(str);
+	size_t len = strlen(str);
 
 	WARN_ON(s->size == 0);
 
-- 
2.19.2


