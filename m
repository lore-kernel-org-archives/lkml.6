Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38CB0C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CA52148E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRRO+pZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CA52148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392439AbeHPTiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:38:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728011AbeHPTiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:38:06 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6012D20C0D;
        Thu, 16 Aug 2018 16:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534437512;
        bh=2KPmnuGrjaCtGamcyKB0pHqRshE5pKlcvcRAScFpe3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DRRO+pZQM/r72A0fSvHeCL/0bJoyiR2T9gw1M3YW0FP0xwshCD4zaId4EhKtMxIv8
         mnVqGueaX/oZqn1VXs/RV4Aq2XFbVZq95GWzY6yyHd8mLIASlfciAws9yMum7i0S68
         IY33WZ6khNW76npMAw4oR/O4dfL8tOXM+92VAF1k=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/32] selftests/ftrace: Add a testcase for nop tracer
Date:   Fri, 17 Aug 2018 01:38:09 +0900
Message-Id: <153443748943.23257.13855745627496095446.stgit@devbox>
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

Add a testcase for nop tracer. This tracer has 2 test
options, so check it too.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../testing/selftests/ftrace/test.d/tracer/nop.tc  |   22 ++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/tracer/nop.tc

diff --git a/tools/testing/selftests/ftrace/test.d/tracer/nop.tc b/tools/testing/selftests/ftrace/test.d/tracer/nop.tc
new file mode 100644
index 000000000000..ca63e316e0f5
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/tracer/nop.tc
@@ -0,0 +1,22 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test nop tracer
+
+# nop must be supported always
+grep -q "nop" available_tracers
+
+echo "nop" > current_tracer
+
+# nop provides 2 test options
+grep -q "test_nop_accept" trace_options
+grep -q "test_nop_refuse" trace_options
+
+# nop_accept always success
+echo "test_nop_accept" > trace_options
+echo "notest_nop_accept" > trace_options
+
+# nop_refuse always failed
+! echo "test_nop_refuse" > trace_options
+! echo "notest_nop_refuse" > trace_options
+
+exit 0

