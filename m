Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB14ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6805520854
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 16:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WB1pxx/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6805520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731960AbeGMQo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 12:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729786AbeGMQo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 12:44:28 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23CE620854;
        Fri, 13 Jul 2018 16:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531499347;
        bh=epyEAuJWYz/jXg07Seh8VWPa2Y9OW1WOXz7waOVAYoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WB1pxx/jYyNnEwi1oowpgH6Moc+QJ8u9o6gkFugnqiLRguqYh598p69dsk9nH4UKG
         wtBep/ccOV6VvTAD1qbz2R69Pw7ef3AWKGIwISh3fQ/UO66JpbXoxnytb3pJUIhCNT
         CkMOdams5BruXFaW3r1d2vyWZgmJfg06UT5AS4sE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Hiraku Toyooka <hiraku.toyooka@cybertrust.co.jp>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 3/3] selftests/ftrace: Add snapshot and tracing_on test case
Date:   Sat, 14 Jul 2018 01:28:44 +0900
Message-Id: <153149932412.11274.15289227592627901488.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153149923649.11274.14970833360963898112.stgit@devbox>
References: <153149923649.11274.14970833360963898112.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a testcase for checking snapshot and tracing_on
relationship. This ensures that the snapshotting doesn't
affect current tracing on/off settings.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 .../selftests/ftrace/test.d/00basic/snapshot.tc    |   28 ++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/snapshot.tc

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/snapshot.tc b/tools/testing/selftests/ftrace/test.d/00basic/snapshot.tc
new file mode 100644
index 000000000000..3b1f45e13a2e
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

