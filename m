Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8412BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E31420C0D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1ZlpaLod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E31420C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392423AbeHPThi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:37:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392409AbeHPThh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:37:37 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33ECB20C0D;
        Thu, 16 Aug 2018 16:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534437484;
        bh=odrEvC5ZlRwgUG+Eg9lRIpdQ5GsduICihXcxMsnb5HM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1ZlpaLodJpfsKpDG1SW8Htyy1+sOOnQPz2EEFXYEsfRfz+FoCnXmtM+jSvRF1Oc8C
         L+FtGkapBUMbT1FIbjjx/rpLgMau+heJqj0TGYi7wKMBaqOHSdJjbxvGjvN9roCWWO
         yYLKKZVBl/5/xQrpP0eAQgwW6ICVRve0VmR/X/3s=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 18/32] selftests/ftrace: Add kprobe profile testcase
Date:   Fri, 17 Aug 2018 01:37:41 +0900
Message-Id: <153443746121.23257.10702848396185197484.stgit@devbox>
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

Add a testcase for testing kprobe_profile interface
which provides per-kprobe event hit/misshit counts.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../selftests/ftrace/test.d/kprobe/profile.tc      |   15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/profile.tc

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc b/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc
new file mode 100644
index 000000000000..0384b525cdee
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc
@@ -0,0 +1,15 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Kprobe dynamic event - adding and removing
+
+[ -f kprobe_events ] || exit_unsupported # this is configurable
+
+! grep -q 'myevent' kprobe_profile
+echo p:myevent _do_fork > kprobe_events
+grep -q 'myevent[[:space:]]*0[[:space:]]*0$' kprobe_profile
+echo 1 > events/kprobes/myevent/enable
+( echo "forked" )
+grep -q 'myevent[[:space:]]*[[:digit:]]*[[:space:]]*0$' kprobe_profile
+echo 0 > events/kprobes/myevent/enable
+echo > kprobe_events
+! grep -q 'myevent' kprobe_profile

