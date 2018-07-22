Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE0CECDE5F
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 03:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429DC20863
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 03:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxTof6J3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429DC20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbeGVEMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 00:12:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbeGVEMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 00:12:41 -0400
Received: from devnote (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5548320856;
        Sun, 22 Jul 2018 03:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532229458;
        bh=NWZqgztxLEZcmPvCdFlF/n+nsElqCdlDMrT8HLtGwBI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qxTof6J3TCVMPvVJ02dNVFq2LeYqZNpH+1IXQ3xA4BDEd11o7l5CO9Lf2JgOvnR5v
         bRGqKhCJb2fmbIRq1d/FAIGwH7YkWqaO+ZC6Q6sSVvwBdRvSzi9vmO8BlBSTW0UXuK
         0zJn/t6h74jFYFR/VTRL6RE3gsb8NiXjXWoLy8i4=
Date:   Sun, 22 Jul 2018 12:17:34 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Francis Deslauriers <francis.deslauriers@efficios.com>,
        rostedt@goodmis.org, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        lkp@01.org
Subject: Re: [lkp-robot] [tracing]  ecadccb31b:
 kernel_selftests.ftrace.ftracetest.fail
Message-Id: <20180722121734.9fc08975427d9d4ff31ba0ce@kernel.org>
In-Reply-To: <20180721184032.01b1b6d70e0dd3b0f32aac95@kernel.org>
References: <20180721024113.GI12513@shao2-debian>
        <20180721184032.01b1b6d70e0dd3b0f32aac95@kernel.org>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Jul 2018 18:40:32 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> OK, I'll handle this.
> The reason why this error is that kprobe event tests probe ftrace itself for test.

So one possible fix is below patch.

Another possible way to fix is to allow instrumentation on trace_kprobe.c as
same as trace_selftest_dynamic.c .

Thank you,

-----
selftests/ftrace: Fix kprobe string testcase to not probe notrace function

From: Masami Hiramatsu <mhiramat@kernel.org>

Fix kprobe string argument testcase to not probe notrace
function. Instead, it probes tracefs function which must
be available with ftrace.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |   30 ++++++++------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
index a000256..1ad70cd 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
@@ -9,28 +9,22 @@ echo > kprobe_events
 
 case `uname -m` in
 x86_64)
-  ARG2=%si
-  OFFS=8
+  ARG1=%di
 ;;
 i[3456]86)
-  ARG2=%cx
-  OFFS=4
+  ARG1=%ax
 ;;
 aarch64)
-  ARG2=%x1
-  OFFS=8
+  ARG1=%x0
 ;;
 arm*)
-  ARG2=%r1
-  OFFS=4
+  ARG1=%r0
 ;;
 ppc64*)
-  ARG2=%r4
-  OFFS=8
+  ARG1=%r3
 ;;
 ppc*)
-  ARG2=%r4
-  OFFS=4
+  ARG1=%r3
 ;;
 *)
   echo "Please implement other architecture here"
@@ -38,17 +32,17 @@ ppc*)
 esac
 
 : "Test get argument (1)"
-echo "p:testprobe create_trace_kprobe arg1=+0(+0(${ARG2})):string" > kprobe_events
+echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):string" > kprobe_events
 echo 1 > events/kprobes/testprobe/enable
-! echo test >> kprobe_events
-tail -n 1 trace | grep -qe "testprobe.* arg1=\"test\""
+echo "p:test _do_fork" >> kprobe_events
+grep -qe "testprobe.* arg1=\"test\"" trace
 
 echo 0 > events/kprobes/testprobe/enable
 : "Test get argument (2)"
-echo "p:testprobe create_trace_kprobe arg1=+0(+0(${ARG2})):string arg2=+0(+${OFFS}(${ARG2})):string" > kprobe_events
+echo "p:testprobe tracefs_create_dir arg1=+0(${ARG1}):string arg2=+0(${ARG1}):string" > kprobe_events
 echo 1 > events/kprobes/testprobe/enable
-! echo test1 test2 >> kprobe_events
-tail -n 1 trace | grep -qe "testprobe.* arg1=\"test1\" arg2=\"test2\""
+echo "p:test _do_fork" >> kprobe_events
+grep -qe "testprobe.* arg1=\"test\" arg2=\"test\"" trace
 
 echo 0 > events/enable
 echo > kprobe_events
