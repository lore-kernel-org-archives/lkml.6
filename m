Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F099AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB27720C0D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="omuLhtk/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB27720C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392406AbeHPThJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:37:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728011AbeHPThJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:37:09 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F333720C0D;
        Thu, 16 Aug 2018 16:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534437455;
        bh=O/+SbskgjjMqrkUMzVz4VUFTaIlh1ZLET76LWZUZfec=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=omuLhtk/Rbnhs9+te85ap1Jpt3Fg4DuROcLb0uwz1G28Ylq+ansOOQCzMsKJwEUGU
         AxuTtEoWj0oKuZ4X20yUCIX39//ZZ+SA/2WL75AxO8wQ7lrRKnkqOfdMdtqF/zWV2M
         4G3b6yAh1h6q8ySHpx5PaXORLMLYF47q0uixlIYU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/32] selftests/ftrace: Add kprobe event with $comm argument testcase
Date:   Fri, 17 Aug 2018 01:37:13 +0900
Message-Id: <153443743305.23257.15090529854978913091.stgit@devbox>
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

Add kprobe-event with $comm argument testcase to
ftracetest. This not only checks syntax but
also checks log file.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ftrace/test.d/kprobe/kprobe_args_comm.tc       |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_comm.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_comm.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_comm.tc
new file mode 100644
index 000000000000..15c1f70fcaf9
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_comm.tc
@@ -0,0 +1,17 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Kprobe event with comm arguments
+
+[ -f kprobe_events ] || exit_unsupported # this is configurable
+
+grep -A1 "fetcharg:" README | grep -q "\$comm" || exit_unsupported # this is too old
+
+echo 'p:testprobe _do_fork comm=$comm ' > kprobe_events
+grep testprobe kprobe_events | grep -q 'comm=$comm'
+test -d events/kprobes/testprobe
+
+echo 1 > events/kprobes/testprobe/enable
+( echo "forked")
+grep testprobe trace | grep -q 'comm=".*"'
+
+exit 0

