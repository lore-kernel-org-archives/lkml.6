Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79967C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483182146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551103509;
	bh=sUWe+HImqXKFVGfeYJ1vpyFKjg4r11QQr4LMc0u4oyg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=x95NG/G3S9txGw3PSCj7iXlDniAZj2oYo47EPR8GyHNnerBL3BrEDZaUDcLwLyAtB
	 6yuPgXo6T5P5QJq8Kdl10vOCsea7bawQ5ZS4CM3BZZS8yToF06OCRwPYU2n/bw2dXN
	 U9hmXLRKMnRNIqd5384NBt45ueSHz1n7yQe1v6p4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfBYOFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:05:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:51160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfBYOFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:05:07 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8115920663;
        Mon, 25 Feb 2019 14:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551103506;
        bh=sUWe+HImqXKFVGfeYJ1vpyFKjg4r11QQr4LMc0u4oyg=;
        h=From:To:Cc:Subject:Date:From;
        b=KO3rvTjNQOFjaggw3AM7am7l0ckBWFezdkjQJoG2fqh1JiDYlafe/tVbsBCRU90ae
         krSEbd6jnxlp6VPyRsh/nfBTc3yyqENMvvykTfom2qCGNVA5q0+1MLvw8LxonLDvQq
         Xrn+fs7xcZJMHW21ONxL4D9cXbJPMw7iMrvlf/1s=
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
Subject: [RFC PATCH 0/4] tracing/probes: uaccess: Add support user-space access
Date:   Mon, 25 Feb 2019 23:04:42 +0900
Message-Id: <155110348217.21156.3874419272673328527.stgit@devbox>
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

Here is an RFC series of probe-event to support user-space access
methods, which we discussed in previous thread.

https://lkml.kernel.org/r/20190220171019.5e81a4946b56982f324f7c45@kernel.org

So in this thread, it is clear that current probe_kernel_read()
and strncpy_from_unsafe() are not enough to access user-space
variables from kprobe events on some arch. On such arch, user
address space and kernel address space can overlap so we have
to change the memory segment to user-mode before copying.
But probe_kernel_read() is designed to access primarily kernel
memory, it may fail to get, or get unexpected value on such
arch. So we need to expand kprobe fetcharg to support new options
for such case.

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

Perhups, we may be better removing "ustring" and just introducing
this user-space dereference syntax...

Note that kprobe event provides these methods, but it doesn't
change it from kernel to user automatically because we do not
know whether the given address is in userspace or kernel on
some arch.
Moreover, from perf-probe, at this moment it is not able to
switch. Since __user is not for compiler but checker, we have
no clue which data structure is in user-space, in debuginfo.

BTW, according to Linus's comment, I implemented probe_user_read()
and strncpy_from_unsafe_user() APIs. And since those use
"access_ok()" inside it, if CONFIG_DEBUG_ATOMIC_SLEEP=y on x86,
it will get a warn message at once. It should be solved before
merging this series.

Thank you,

---

Masami Hiramatsu (4):
      uaccess: Make sure kernel_uaccess_faults_ok is updated before pagefault
      uaccess: Add non-pagefault user-space read functions
      tracing/probe: Add ustring type for user-space string
      tracing/probe: Support user-space dereference


 Documentation/trace/kprobetrace.rst  |   13 ++-
 Documentation/trace/uprobetracer.rst |    9 +-
 fs/namespace.c                       |    2 
 include/linux/uaccess.h              |   13 +++
 kernel/trace/trace.c                 |    7 +-
 kernel/trace/trace_kprobe.c          |   65 ++++++++++++++++
 kernel/trace/trace_probe.c           |   39 ++++++++--
 kernel/trace/trace_probe.h           |    3 +
 kernel/trace/trace_probe_tmpl.h      |   36 +++++++--
 kernel/trace/trace_uprobe.c          |   19 +++++
 mm/maccess.c                         |  138 ++++++++++++++++++++++++++++++----
 11 files changed, 302 insertions(+), 42 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
