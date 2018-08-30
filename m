Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D023C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4077205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UW/wJTrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4077205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbeH3S1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:27:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728980AbeH3S1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:27:03 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48156205C9;
        Thu, 30 Aug 2018 14:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535639077;
        bh=gWXsfmi/YRAVTa4Y8G5TVPM+dIFVQiOny1N9riMAEEA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UW/wJTrgAapArZ37Q3EFawkWDAmtphENGjnMuQ/xeRFtgUN+SodV3M+0onoBUFkqU
         6cpO+1W6aZz7kPzG6kxxybYEWzuXgUPeELWCqWd1W+qCn+EePdt3pViU2vFxFR1/YX
         9lYXWoV9ZAIFZgCgXKR/5HI1l87C1i+W4v2RQqyk=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 25/28] selftests/ftrace: Add stacktrace ftrace filter command testcase
Date:   Thu, 30 Aug 2018 23:24:14 +0900
Message-Id: <153563905428.29700.15538326679607667577.stgit@devbox>
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

Add a test case for stacktrace filter command for ftrace.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v3:
 - Remove the last extra line.
 - Run this on an instance too.
---
 .../ftrace/test.d/ftrace/func-filter-stacktrace.tc |   12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
new file mode 100644
index 000000000000..bf72e783d014
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-stacktrace.tc
@@ -0,0 +1,12 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL2.0
+# description: ftrace - stacktrace filter command
+# flags: instance
+
+echo _do_fork:stacktrace >> set_ftrace_filter
+
+grep -q "_do_fork:stacktrace:unlimited" set_ftrace_filter
+
+(echo "forked"; sleep 1)
+
+grep -q "<stack trace>" trace

