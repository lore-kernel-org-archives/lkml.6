Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FDFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B1E20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 15:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SU2YYGUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B1E20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbeK3CNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:13:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:33160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728528AbeK3CNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 21:13:46 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4493F20868;
        Thu, 29 Nov 2018 15:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543504086;
        bh=XAkdElZIosJC3P7YxxyOKkdxABvSoAcvfYVUrQixZ/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=SU2YYGUBm9wyYT8vHtuI3666MxLcoKYvgH1GCG5t0AQ2onupMKXRD8QAnWvwaVuuJ
         nVo+e9xm4mQTw8PImIHyGmCnn8mrsQNFrKVd0CIW9zb9dY1/eAFmquBEoBOsZxLUjs
         82IiSmgibiSUynFYAzwvrSXA7F/5+x2M7QDMAIYM=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, Tom Zanussi <zanussi@kernel.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>
Subject: [PATCH] sefltests/ftrace: Use /bin/echo for output with options
Date:   Fri, 30 Nov 2018 00:07:43 +0900
Message-Id: <154350406317.4422.7595059658374071660.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181129235407.9788e718a4ae7830f9e5d225@kernel.org>
References: <20181129235407.9788e718a4ae7830f9e5d225@kernel.org>
In-Reply-To: <20181129235407.9788e718a4ae7830f9e5d225@kernel.org>
References: <20181129235407.9788e718a4ae7830f9e5d225@kernel.org>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use /bin/echo for console output with options like non
newline (-n) and/or backslash escape (-e).

Tom Zanussi reported that when he tested ftracetest, it
shows "-e" and "-n" options on the console, since a system
which uses dash as the alias of /bin/sh, uses dash built-in
echo command which doesn't accept "-e".

To avoid this issue, use /bin/echo instead of echo for
the output with options.

Fixes: 8f381ac4d321 ("selftests/ftrace: Add color to the PASS / FAIL results")
Link: http://lkml.kernel.org/r/cover.1542221862.git.tom.zanussi@linux.intel.com
Reported-by: Tom Zanussi <zanussi@kernel.org>
Suggested-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/testing/selftests/ftrace/ftracetest |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 75244db70331..ba670b452bdb 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -173,8 +173,8 @@ strip_esc() {
 }
 
 prlog() { # messages
-  echo -e "$@"
-  [ "$LOG_FILE" ] && echo -e "$@" | strip_esc >> $LOG_FILE
+  /bin/echo -e "$@"
+  [ "$LOG_FILE" ] && /bin/echo -e "$@" | strip_esc >> $LOG_FILE
 }
 catlog() { #file
   cat $1

