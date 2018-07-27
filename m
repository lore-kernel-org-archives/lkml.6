Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6747C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524EC208B0
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 12:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qy+tliMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 524EC208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387611AbeG0Nl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:41:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729493AbeG0Nl0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:41:26 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D248C208B1;
        Fri, 27 Jul 2018 12:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532693985;
        bh=NMiVqWg9TiVgvKvrbki+jDkO7dAgk00wkR1kHDRgqN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qy+tliMiK5kmBD5Prn500kD3CIY08vE8S/HYzE/iWp5wYZKbKq3kuRBaxjFmzkf5W
         pMdyrPS8gka68cJBIptiOoBbvhw7j0bHzp7kYuEOaJrfHqj+rr7i8IrOzQbxrLHrl4
         VIN7CbHPDOD73sALSMTDtPyQuiDlDuHVRn8dG0Dw=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 20/25] selftests/ftrace: Add trace_printk sample module test
Date:   Fri, 27 Jul 2018 21:19:23 +0900
Message-Id: <153269396287.3084.11779871423388811593.stgit@devbox>
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

Add trace_printk sample module test. This requires to
enable trace_printk.ko module for test.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../selftests/ftrace/test.d/event/trace_printk.tc  |   27 ++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/event/trace_printk.tc

diff --git a/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc b/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
new file mode 100644
index 000000000000..4da4d739f03d
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
@@ -0,0 +1,27 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test trace_printk from module
+
+rmmod trace-printk ||:
+if ! modprobe trace-printk.ko ; then
+  echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=m"
+  exit_unresolved;
+fi
+
+echo "Waiting for irq work"
+sleep 1
+
+grep -q ": This .* trace_bputs" trace
+grep -q ": This .* trace_puts" trace
+grep -q ": This .* trace_bprintk" trace
+grep -q ": This .* trace_printk" trace
+
+grep -q ": (irq) .* trace_bputs" trace
+grep -q ": (irq) .* trace_puts" trace
+grep -q ": (irq) .* trace_bprintk" trace
+grep -q ": (irq) .* trace_printk" trace
+
+grep -q "This is a %s that will use trace_bprintk" printk_formats
+grep -q "(irq) This is a static string that will use trace_bputs" printk_formats
+
+rmmod trace-printk ||:

