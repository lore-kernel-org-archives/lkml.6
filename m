Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A337C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1623D208B3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1O+hBSte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1623D208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388613AbeG0Nna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:43:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730970AbeG0Nna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:43:30 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7329208B3;
        Fri, 27 Jul 2018 12:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532694108;
        bh=4kuI0v96YRXOvssBQpRgnZo6fwZ/LVIytRx1YTKoWhE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1O+hBSteHx5RO8bs1U/mqatXrMEDL4+/SXLPVcazllsAfV9L7llx5z1EDHDW1YVZx
         ZPvdXpBbb2nbJDbASQ8fXn1CWI2ufAwzaCKwx/qzZdx1YW7Sl2rJM+kXzkOOgHI/8V
         UCcJsKSDdTOSY4UnJJxIAevSuWVzEIQi9BV3kG/Y=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 24/25] selftests/ftrace: Add function filter on module testcase
Date:   Fri, 27 Jul 2018 21:21:15 +0900
Message-Id: <153269407573.3084.7094692039202784902.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <153269339575.3084.16279591141931053689.stgit@devbox>
References: <153269339575.3084.16279591141931053689.stgit@devbox>
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

