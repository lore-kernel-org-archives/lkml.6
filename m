Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AB9C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E23420C07
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nnjg2yhm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E23420C07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404533AbeHPTny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:43:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:54402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729169AbeHPTns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:43:48 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9ACD208E9;
        Thu, 16 Aug 2018 16:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534437852;
        bh=2Km1pLSPBcTAtF/6tYi64YTnSCEi/qYp5Wy43bZaYx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nnjg2yhmHj6JzisyfD/4jw9B5Y9bWkpWEUwUHZ7rqDX1v0P4TLd5H/5QVOD2L5O34
         gbPbDOg1RKeNFfgqkw4mBKfBm5Kg/xaMlxPz2199cNo/ahp6PZhuVHOFuqsdRzx7zh
         2DrVc4QxqYCYizoXYmqdmUDU1lvuWZk1AzktnyDc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 31/32] selftests/ftrace: Add output format testcase
Date:   Fri, 17 Aug 2018 01:43:49 +0900
Message-Id: <153443782973.23257.16320326555688796000.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153443695002.23257.13628220023468200991.stgit@devbox>
References: <153443695002.23257.13628220023468200991.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a testcase for tracing output format using trace_marker.
This tests raw, hex and bin format output.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ftrace/test.d/00basic/print_format.tc          |   51 ++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/print_format.tc

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/print_format.tc b/tools/testing/selftests/ftrace/test.d/00basic/print_format.tc
new file mode 100644
index 000000000000..55feb542e83e
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/00basic/print_format.tc
@@ -0,0 +1,51 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL2.0
+# description: Change print trace format
+
+if [ ! -f trace_marker ]; then
+  echo "trace_marker is not supported, can not continue testing"
+  exit_unresolved
+fi
+
+do_reset() {
+  if [ `cat options/bin` -eq 1 ]; then
+    grep -v "^#" trace | od -h | cut -f 2- -d " " | xargs echo
+  fi
+  echo 0 > options/hex
+  echo 0 > options/raw
+  echo 0 > options/bin
+  cat trace
+  exit 1
+}
+
+echo > trace
+echo "abcdefgh" > trace_marker
+echo 0 > tracing_on
+
+: "Get the pid and cpu#"
+IDS=`grep -v "^#" trace | sed -e 's/[[:space:]]*.*-\([[:digit:]]*\)[[:space:]]*\[\([[:digit:]]*\)\].*/\1 \2/'`
+
+read_pid_cpu() {
+  _PID=$1
+  _CPU=`printf "%d" $2`
+}
+
+read_pid_cpu $IDS
+
+: "Test raw output format"
+echo 1 > options/raw
+grep -v "^#" trace | grep "^$_PID $_CPU" || do_reset
+echo 0 > options/raw
+
+: "Test hex output format"
+echo 1 > options/hex
+PAT=`printf "%08x %08x" $_PID $_CPU`
+grep -v "^#" trace | grep "^$PAT" || do_reset
+echo 0 > options/hex
+
+: "Test bin output format"
+echo 1 > options/bin
+PAT=`printf "%04x [[:xdigit:]]* [[:xdigit:]]*%02x" $_PID $_CPU`
+# Make a stream of hexdump
+grep -v "^#" trace | od -h | cut -f 2- -d " " | xargs echo | grep "$PAT" || do_reset
+echo 0 > options/bin

