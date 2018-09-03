Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F228C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024472077C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 024472077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbeICVjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:39:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42966 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728154AbeICVjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:39:07 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BCF3FD09;
        Mon,  3 Sep 2018 17:18:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tom Zanussi <tom.zanussi@linux.intel.com>,
        Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 054/165] selftests/ftrace: Add snapshot and tracing_on test case
Date:   Mon,  3 Sep 2018 18:55:40 +0200
Message-Id: <20180903165657.845228106@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

[ Upstream commit 82f4f3e69c5c29bce940dd87a2c0f16c51d48d17 ]

Add a testcase for checking snapshot and tracing_on
relationship. This ensures that the snapshotting doesn't
affect current tracing on/off settings.

Link: http://lkml.kernel.org/r/153149932412.11274.15289227592627901488.stgit@devbox

Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/ftrace/test.d/00basic/snapshot.tc |   28 ++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/snapshot.tc

--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/00basic/snapshot.tc
@@ -0,0 +1,28 @@
+#!/bin/sh
+# description: Snapshot and tracing setting
+# flags: instance
+
+[ ! -f snapshot ] && exit_unsupported
+
+echo "Set tracing off"
+echo 0 > tracing_on
+
+echo "Allocate and take a snapshot"
+echo 1 > snapshot
+
+# Since trace buffer is empty, snapshot is also empty, but allocated
+grep -q "Snapshot is allocated" snapshot
+
+echo "Ensure keep tracing off"
+test `cat tracing_on` -eq 0
+
+echo "Set tracing on"
+echo 1 > tracing_on
+
+echo "Take a snapshot again"
+echo 1 > snapshot
+
+echo "Ensure keep tracing on"
+test `cat tracing_on` -eq 1
+
+exit 0


