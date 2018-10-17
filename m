Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185D8C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA6E214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 03:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ry1RUljP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAA6E214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeJQL1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 07:27:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbeJQL1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 07:27:22 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32247214AB;
        Wed, 17 Oct 2018 03:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539747227;
        bh=Yqg1wtbt+ubKWzxlH7q6eVRTkxCWxTILtpzo5SIRBzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ry1RUljPZv1U2DmQ4JB+GA2u9OBnau95kawDEu22Vo4LmraL07vTm/ZqgwMHxjw6+
         U1UOkin5AKFANDfV/erraJSxpPeCkn4lULsKdeEtl3RnRCw1o1p98AsMFj92iJF9vi
         uVl64S5g8H6HmToFdIYSjQlpJ8xPWGEWXg1A0qxc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     shuah@kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc:     =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>,
        linux-kselftest@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] selftests/ftrace: Strip escape sequences for log file
Date:   Wed, 17 Oct 2018 12:33:23 +0900
Message-Id: <153974720272.17748.17439079576533415951.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20181017100305.0b3c03461b098f8943805455@gmail.com>
References: <20181017100305.0b3c03461b098f8943805455@gmail.com>
In-Reply-To: <20181017100305.0b3c03461b098f8943805455@gmail.com>
References: <20181017100305.0b3c03461b098f8943805455@gmail.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Strip escape sequences from the stream to the ftracetest
summary log file. Note that all test-case results are
dumped raw in each file.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/testing/selftests/ftrace/ftracetest |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index d987bbec675f..75244db70331 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -167,11 +167,18 @@ if [ -t 1 -a "$ncolors" -a "$ncolors" -ge 8 ]; then
   color_blue="\e[34m"
 fi
 
+strip_esc() {
+  # busybox sed implementation doesn't accept "\x1B", so use [:cntrl:] instead.
+  sed -E "s/[[:cntrl:]]\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"
+}
+
 prlog() { # messages
-  [ -z "$LOG_FILE" ] && echo -e "$@" || echo -e "$@" | tee -a $LOG_FILE
+  echo -e "$@"
+  [ "$LOG_FILE" ] && echo -e "$@" | strip_esc >> $LOG_FILE
 }
 catlog() { #file
-  [ -z "$LOG_FILE" ] && cat $1 || cat $1 | tee -a $LOG_FILE
+  cat $1
+  [ "$LOG_FILE" ] && cat $1 | strip_esc >> $LOG_FILE
 }
 prlog "=== Ftrace unit tests ==="
 

