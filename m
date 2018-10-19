Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B1EECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 04:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 043D02145D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 04:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043D02145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbeJSMZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 08:25:33 -0400
Received: from ozlabs.org ([203.11.71.1]:57327 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727017AbeJSMZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 08:25:32 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 42bt5Q3J4Rz9sDK; Fri, 19 Oct 2018 15:21:14 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        jannh@google.com, keescook@chromium.org
Subject: [PATCH v2 2/2] seq_buf: Use size_t for len in seq_buf_puts()
Date:   Fri, 19 Oct 2018 15:21:09 +1100
Message-Id: <20181019042109.8064-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181019042109.8064-1-mpe@ellerman.id.au>
References: <20181019042109.8064-1-mpe@ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jann Horn points out that we're using unsigned int for len in
seq_buf_puts(), which could potentially overflow if we're passed a
UINT_MAX sized string.

The rest of the code already uses size_t, so we should also use that
in seq_buf_puts() to avoid any issues.

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 lib/seq_buf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

v2: New in v2.

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
2.17.2

