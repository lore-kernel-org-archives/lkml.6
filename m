Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8A3C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7232148E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2v9U7y3f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7232148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392336AbeHPTcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:32:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392322AbeHPTcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:32:24 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ED882148E;
        Thu, 16 Aug 2018 16:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534437173;
        bh=yCKZC8og7iXoXAdf/gqgxnuOI2XPOPNphxP9OPnnMTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2v9U7y3fmXf4lpRwdsmwOxThP53AZu1Uus8L7mNr1VDq0PWgrtE/D5ppYN3b0QaGz
         nQBR/HEPZ1ePRgEcP9fYpMK9JM3jRatm79+6Qjab84C4Rakflz4Yqx85BSzkjc35Ga
         q3ggnnamHFOqVSFnNf/E8IYL+SA1yR5xTTG9lKeI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/32] selftests/ftrace: Cleanup ftrace after running test
Date:   Fri, 17 Aug 2018 01:32:30 +0900
Message-Id: <153443715007.23257.7438540516039987709.stgit@devbox>
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

