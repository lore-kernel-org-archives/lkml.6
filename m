Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAF6C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20A8217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 14:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551278563;
	bh=frJZ9v7U+XZvjKug5yAmWZdJ1YQRFH3A2Rgll3cM3uI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=R5iJQ7RWVmuEh6ooXTJ1ciwjkGEf69kwXyDpedcT7Y8db3wZs2jOnJ54/t/e4R4ON
	 YmACSVyRIm/jyzTZiyaY+TqoKA7w3nrqdI1CI3S4UjqkXhCMNVC4USs2t3+3DzpS0O
	 5vqH1omBCnjA4/1YLiNchR2jgisFgMrpmrfRP4vk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbfB0Oml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 09:42:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:51900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfB0Oml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 09:42:41 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D16F52083D;
        Wed, 27 Feb 2019 14:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551278559;
        bh=frJZ9v7U+XZvjKug5yAmWZdJ1YQRFH3A2Rgll3cM3uI=;
        h=From:To:Cc:Subject:Date:From;
        b=m542Py4JGIBJURe6gnkTxcFkU6C6VUtc8xPR+5ifIYxp5/DgAcP1ULLcYb/wQXABh
         q0ga2vmNfqdLzWm03hWWV+2moXOFDIE4IVupYAv1PoBhZKsZnHBFnFnuTsHwOSQJXj
         MyfeRGlKSf9ciXDnKL9+pRL5Dd63ZR0Kd37ySsDs=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 0/5] tracing/probes: uaccess: Add support user-space access
Date:   Wed, 27 Feb 2019 23:42:15 +0900
Message-Id: <155127853496.32576.3705994926675037747.stgit@devbox>
X-Mailer: git-send-email 2.13.6
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the v3 series of probe-event to support user-space access.
In this version I removed unneeded kernel_uaccess_faults_ok patch,
included PeterZ's user_access_ok(), and simplifies non-pagefault
user-space read functions according to the discussion on the
previous sereis.

 https://lkml.kernel.org/r/155110348217.21156.3874419272673328527.stgit@devbox

- [1/5]: New: introduce user_access_ok
- [2/5]: New: user user_access_ok() in user_access_begin()
- [3/5]: Simplify implementation using strncpy_from_user
- [4/5]: Simplify implementation using strnlen_user
- [5/5]: Update documentation

PeterZ, I imported your patch in this series, and add a short
description. If there is any misundrestanding, please tell me.

====
Kprobe event user-space memory access features:

For user-space access extension, this series adds 2 features,
"ustring" type and user-space dereference syntax. "ustring" is
used for recording a null-terminated string in user-space from
kprobe events.

"ustring" type is easy, it is able to use instead of "string"
type, so if you want to record a user-space string via
"__user char *", you can use ustring type instead of string.
For example,

echo 'p do_sys_open path=+0($arg2):ustring' >> kprobe_events

will record the path string from user-space.

The user-space dereference syntax is also simple. Thi just
adds 'u' prefix before an offset value.

   +|-u<OFFSET>(<FETCHARG>)

e.g. +u8(%ax), +u0(+0(%si))

This is more generic. If you want to refer the variable in user-
space from its address or access a field in data structure in
user-space, you need to use this.

For example, if you probe do_sched_setscheduler(pid, policy,
param) and record param->sched_priority, you can add new
probe as below;
    
   p do_sched_setscheduler priority=+u0($arg3)

Actually, with this feature, "ustring" type is not absolutely
necessary, because these are same meanings.

  +0($arg2):ustring == +u0($arg2):string

Note that kprobe event provides these methods, but it doesn't
change it from kernel to user automatically because we do not
know whether the given address is in userspace or kernel on
some arch.

For perf-probe, we can add some attribute for each argument
which indicate that the variable in user space. But still
we can not decide it automatically by DWARF since __user attribute
is not transrated to DWARF attribute.

Thank you,

---

Masami Hiramatsu (4):
      uaccess: Use user_access_ok() in user_access_begin()
      uaccess: Add non-pagefault user-space read functions
      tracing/probe: Add ustring type for user-space string
      tracing/probe: Support user-space dereference

Peter Zijlstra (1):
      uaccess: Add user_access_ok()


 Documentation/trace/kprobetrace.rst  |   26 ++++++++-
 Documentation/trace/uprobetracer.rst |    9 ++-
 arch/x86/include/asm/uaccess.h       |   10 +++-
 include/linux/uaccess.h              |   33 ++++++++++++
 kernel/trace/trace.c                 |    7 +--
 kernel/trace/trace_kprobe.c          |   43 ++++++++++++++++
 kernel/trace/trace_probe.c           |   39 +++++++++++---
 kernel/trace/trace_probe.h           |    3 +
 kernel/trace/trace_probe_tmpl.h      |   37 +++++++++++--
 kernel/trace/trace_uprobe.c          |   19 +++++++
 mm/maccess.c                         |   94 ++++++++++++++++++++++++++++++++--
 11 files changed, 287 insertions(+), 33 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
