Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889D5C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423B720834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPQ0LSC9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423B720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbeH3SSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:18:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:42120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728713AbeH3SSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:18:00 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15AF02073D;
        Thu, 30 Aug 2018 14:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535638539;
        bh=yCKZC8og7iXoXAdf/gqgxnuOI2XPOPNphxP9OPnnMTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kPQ0LSC9Va4hM9jqIIPbnZUzvwYLg8HKrK8VvG+G7eU+xzEAYlkKBtd6CIGbl7frn
         IPccasLCSEozNJzmd8dk8QDn5k6PlCqXR2izZsb9KpT6w1wREHYBmTaxEYzNnV1Ryr
         ZBtSRNDNRZq7DQh4T7XSwT2ZMw5y9mMDhl+b2q8o=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/28] selftests/ftrace: Cleanup ftrace after running test
Date:   Thu, 30 Aug 2018 23:15:16 +0900
Message-Id: <153563851616.29700.904736360142587564.stgit@devbox>
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

Cleanup ftrace by initialize_ftrace() after running
all test cases. This means we also don't need cleanup
ftrace on each test case, except for some special
options.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/testing/selftests/ftrace/ftracetest |    1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 3ca596255eff..5c71d58febb2 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -341,6 +341,7 @@ for t in $TEST_CASES; do
     exit 1
   fi
 done
+(cd $TRACING_DIR; initialize_ftrace) # for cleanup
 
 prlog ""
 prlog "# of passed: " `echo $PASSED_CASES | wc -w`

