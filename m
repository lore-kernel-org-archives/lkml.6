Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C23C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0C0208AD
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ItTQXSjy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D0C0208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbeG0Ncz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:32:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730355AbeG0Ncz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:32:55 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07F58208AD;
        Fri, 27 Jul 2018 12:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532693477;
        bh=QxP50+tvqngiH6SO8geYnf48YgWulK4ZPL5qEmhn5rM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ItTQXSjyIRv1y00fBA6fddGFSD4BtnvnGQ2AD6Edh19YbdJ18CzRoVvD3aXGnM+IW
         JCp2yTxnKQfIshcwOIXlNO/cQVMOLLtb37sdFP1d1H/Qp6Ph4inTlHhcjRdwGfkmuX
         Q6k+OwwqgS8Ewp7BrgD81Xn+TtDSfnd6+BcYI/+U=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/25] selftests/ftrace: Add --stop-fail hidden option for debug
Date:   Fri, 27 Jul 2018 21:10:54 +0900
Message-Id: <153269345407.3084.11498352613507079445.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153269339575.3084.16279591141931053689.stgit@devbox>
References: <153269339575.3084.16279591141931053689.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add --stop-fail option for debugging the ftracetest.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/testing/selftests/ftrace/ftracetest |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index f9a9d424c980..c9c7fa8dc440 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -69,6 +69,10 @@ parse_opts() { # opts
       DEBUG=1
       shift 1
     ;;
+    --stop-fail)
+      STOP_FAILURE=1
+      shift 1
+    ;;
     --fail-unsupported)
       UNSUPPORTED_RESULT=1
       shift 1
@@ -117,6 +121,7 @@ KEEP_LOG=0
 DEBUG=0
 VERBOSE=0
 UNSUPPORTED_RESULT=0
+STOP_FAILURE=0
 # Parse command-line options
 parse_opts $*
 
@@ -304,6 +309,10 @@ run_test() { # testfile
 # Main loop
 for t in $TEST_CASES; do
   run_test $t
+  if [ $STOP_FAILURE -ne 0 -a $TOTAL_RESULT -ne 0 ]; then
+    echo "A failure detected. Stop test."
+    exit 1
+  fi
 done
 
 # Test on instance loop
@@ -315,6 +324,10 @@ for t in $TEST_CASES; do
   run_test $t
   rmdir $TRACING_DIR
   TRACING_DIR=$SAVED_TRACING_DIR
+  if [ $STOP_FAILURE -ne 0 -a $TOTAL_RESULT -ne 0 ]; then
+    echo "A failure detected. Stop test."
+    exit 1
+  fi
 done
 
 prlog ""

