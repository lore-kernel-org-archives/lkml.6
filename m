Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A0AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC1720834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="g33yG2/C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC1720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbeH3S20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:28:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729084AbeH3S20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:28:26 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCA3A205C9;
        Thu, 30 Aug 2018 14:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535639161;
        bh=jkymEHeINqmqgzid9I7H3Mh74/vPTp4SdM1CedNkG28=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g33yG2/C8nWSkxLloUFEmrbu3VGJeYQh+V3QwFVzyJujGLk9turLAL8BxCbWKuWKO
         /29zdtqVEfTkgpim/iU8yv3eiPnBn+PvrYDFLsucIGJI+eo72jaHMvmj4K9AO5t0zK
         3iSZ1IAHypDyri16B6pfSUpSmS+pchlLKxCe/aP4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 28/28] selftests/ftrace: Add ftrace cpumask testcase
Date:   Thu, 30 Aug 2018 23:25:39 +0900
Message-Id: <153563913896.29700.6147067496062109284.stgit@devbox>
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

Add a testcase for tracing_cpumask with function tracer.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v3:
 - Use nproc instead of /proc/cpuinfo
 - If nproc doesn't exist, use /sys/devices/cpu/cpu*.
 - Save and restore the original cpumask
---
 .../selftests/ftrace/test.d/ftrace/func_cpumask.tc |   42 ++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
new file mode 100644
index 000000000000..0e6810743576
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_cpumask.tc
@@ -0,0 +1,42 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL2.0
+# description: ftrace - function trace with cpumask
+
+if ! which nproc ; then
+  nproc() {
+    ls -d /sys/devices/system/cpu/cpu[0-9]* | wc -l
+  }
+fi
+
+NP=`nproc`
+
+if [ $NP -eq 1 ] ;then
+  echo "We can not test cpumask on UP environment"
+  exit_unresolved
+fi
+
+ORIG_CPUMASK=`cat tracing_cpumask`
+
+do_reset() {
+  echo $ORIG_CPUMASK > tracing_cpumask
+}
+
+echo 0 > tracing_on
+echo > trace
+: "Bitmask only record on CPU1"
+echo 2 > tracing_cpumask
+MASK=0x`cat tracing_cpumask`
+test `printf "%d" $MASK` -eq 2 || do_reset
+
+echo function > current_tracer
+echo 1 > tracing_on
+(echo "forked")
+echo 0 > tracing_on
+
+: "Check CPU1 events are recorded"
+grep -q -e "\[001\]" trace || do_reset
+
+: "There should be No other cpu events"
+! grep -qv -e "\[001\]" -e "^#" trace || do_reset
+
+do_reset

