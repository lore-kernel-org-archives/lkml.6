Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62386C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CE84208F7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoWaLYZX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CE84208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392510AbeHPTjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:39:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727518AbeHPTjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:39:31 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2835A208F7;
        Thu, 16 Aug 2018 16:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534437597;
        bh=Kwlus8ZQa18cYrqcLANOMH8B8887TrdwrE2zZM7wYjw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CoWaLYZXcf7B37gkVWzK7/gQ9gIxalXzKRaDqrBLO1RVmQY8yozodDSSmOvxfWYdP
         VTPJYggWHHLDfnAIxU0+ejw+3/cY3MEDqh1B1uQ+4avbOCmrH69R7AMh7SJuZ+kHTE
         ruMf26mCknPNKmUJo8Mf3wysjRWhTm4hKfTtk8ks=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/32] selftests/ftrace: Add ringbuffer size changing testcase
Date:   Fri, 17 Aug 2018 01:39:34 +0900
Message-Id: <153443757416.23257.9284862385646039929.stgit@devbox>
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

Add a testcase for changing ringbuffer size. This tests
not only ringbuffer size but also tests the imbalance
per-cpu buffer size change too.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ftrace/test.d/00basic/ringbuffer_size.tc       |   21 ++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_size.tc

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_size.tc b/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_size.tc
new file mode 100644
index 000000000000..9224f33b3194
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_size.tc
@@ -0,0 +1,21 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Change the ringbuffer size
+
+rb_size_test() {
+ORIG=`cat buffer_size_kb`
+
+expr $ORIG / 2 > buffer_size_kb
+
+expr $ORIG \* 2 > buffer_size_kb
+
+echo $ORIG > buffer_size_kb
+}
+
+rb_size_test
+
+: "If per-cpu buffer is supported, imbalance it"
+if [ -d per_cpu/cpu0 ]; then
+  cd per_cpu/cpu0
+  rb_size_test
+fi

