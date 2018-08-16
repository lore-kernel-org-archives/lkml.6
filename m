Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6B8C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF6A208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 16:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vxQRgqXY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AF6A208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392572AbeHPTlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 15:41:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:53722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727949AbeHPTk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 15:40:57 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09DCC208E9;
        Thu, 16 Aug 2018 16:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534437682;
        bh=4kuI0v96YRXOvssBQpRgnZo6fwZ/LVIytRx1YTKoWhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vxQRgqXY8h0FoKtvc8/sfUelIPqHRQnOukRFe1wQav29xd1CzesxVJSXL3yQsPcN7
         nmiPL79qMLuzdu5d/Du5wxNFsvNPiz8SK1kWbv2KLDJWxQ7CCFCUrdZHMUlGHITJmd
         comnn7K8szqi+nvIG3lWA5by8V7vzygHGcijvad4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 25/32] selftests/ftrace: Add function filter on module testcase
Date:   Fri, 17 Aug 2018 01:40:59 +0900
Message-Id: <153443765894.23257.13622063956539869338.stgit@devbox>
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

Add a testcase for function filter on module.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ftrace/test.d/ftrace/func_mod_trace.tc         |   24 ++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
new file mode 100644
index 000000000000..359380c3834f
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
@@ -0,0 +1,24 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: ftrace - function trace on module
+
+[ ! -f set_ftrace_filter ] && exit_unsupported
+
+: "mod: allows to filter a non exist function"
+echo 'non_exist_func:mod:non_exist_module' > set_ftrace_filter
+grep -q "non_exist_func" set_ftrace_filter
+
+: "mod: on exist module"
+echo '*:mod:trace_printk' > set_ftrace_filter
+if ! modprobe trace-printk.ko ; then
+  echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=
+m"
+  exit_unresolved;
+fi
+
+: "Wildcard should be resolved after loading module"
+grep -q "trace_printk_irq_work" set_ftrace_filter
+
+: "After removing the filter becomes empty"
+rmmod trace_printk
+test `cat set_ftrace_filter | wc -l` -eq 0

