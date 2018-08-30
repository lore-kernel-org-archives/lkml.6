Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCC1C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA202073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gj90RiSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA202073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbeH3SQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:16:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbeH3SQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:16:06 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 203912073D;
        Thu, 30 Aug 2018 14:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535638426;
        bh=FxrveT0+qffJSy79bnpM1I1zzHMUbP97R+hJ6OIbqTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gj90RiSO1ZZu+jV7GbDVQfcg8H47AxZwKiLHa9Erzo48KczB6HnrhNFpz3xfqmV4U
         R0s3c5CHQiZcfZHHnmylgyAVUTIIDDcollRf4ytydYdt07Qk4Lr8qKbek7WLuNvu36
         Ywyv3uaLqO80GnPwTicaes+5v0V/N1PD3cbmeXWc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/28] selftests/ftrace: Add --console hidden option
Date:   Thu, 30 Aug 2018 23:13:23 +0900
Message-Id: <153563840309.29700.18393382534653831079.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153563834333.29700.11242968505215651399.stgit@devbox>
References: <153563834333.29700.11242968505215651399.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add --console hidden option for debug test cases.

This option allows to put "sh" or something else
when the test case hits a bug.

For example, if you find a testcase which doesn't
pass, you can insert sh for interactive debug as below

  -----
  #!/bin/sh
  # description: sample test case

  good-command
  suspicious-wrong-command
  sh # <- add this for interactive debug
  -----

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
  Changes in v3
  - Add an example of this feature in the description
---
 tools/testing/selftests/ftrace/ftracetest |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index c9c7fa8dc440..8debd37038e4 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -60,11 +60,21 @@ parse_opts() { # opts
       shift 1
     ;;
     --verbose|-v|-vv|-vvv)
+      if [ $VERBOSE -eq -1 ]; then
+	usage "--console can not use with --verbose"
+      fi
       VERBOSE=$((VERBOSE + 1))
       [ $1 = '-vv' ] && VERBOSE=$((VERBOSE + 1))
       [ $1 = '-vvv' ] && VERBOSE=$((VERBOSE + 2))
       shift 1
     ;;
+    --console)
+      if [ $VERBOSE -ne 0 ]; then
+	usage "--console can not use with --verbose"
+      fi
+      VERBOSE=-1
+      shift 1
+    ;;
     --debug|-d)
       DEBUG=1
       shift 1
@@ -283,7 +293,9 @@ run_test() { # testfile
   testcase $1
   echo "execute$INSTANCE: "$1 > $testlog
   SIG_RESULT=0
-  if [ -z "$LOG_FILE" ]; then
+  if [ $VERBOSE -eq -1 ]; then
+    __run_test $1
+  elif [ -z "$LOG_FILE" ]; then
     __run_test $1 2>&1
   elif [ $VERBOSE -ge 3 ]; then
     __run_test $1 | tee -a $testlog 2>&1

