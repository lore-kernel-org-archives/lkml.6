Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E8FECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51B4620664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B4620664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cyphar.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbeKAAYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:24:32 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:34102 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728698AbeKAAYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:24:31 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id C97C740564;
        Wed, 31 Oct 2018 16:26:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id Wmb57fUIYHcm; Wed, 31 Oct 2018 16:25:58 +0100 (CET)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, Aleksa Sarai <asarai@suse.de>,
        Christian Brauner <christian@brauner.io>,
        Brendan Gregg <bgregg@netflix.com>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/2] kretprobe: produce sane stack traces
Date:   Thu,  1 Nov 2018 02:25:41 +1100
Message-Id: <20181031152543.12138-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Historically, kretprobe has always produced unusable stack traces
(kretprobe_trampoline is the only entry in most cases, because of the
funky stack pointer overwriting). This has caused quite a few annoyances
when using tracing to debug problems[1] -- since return values are only
available with kretprobes but stack traces were only usable for kprobes,
users had to probe both and then manually associate them.

This patch series stores the stack trace within kretprobe_instance on
the kprobe entry used to set up the kretprobe. This allows for
DTrace-style stack aggregation between function entry and exit with
tools like BPFtrace -- which would not really be doable if the stack
unwinder understood kretprobe_trampoline.

We also revert commit 76094a2cf46e ("ftrace: distinguish kretprobe'd
functions in trace logs") and any follow-up changes because that code is
no longer necessary now that stack traces are sane. *However* this patch
might be a bit contentious since the original usecase (that ftrace
returns shouldn't show kretprobe_trampoline) is arguably still an
issue. Feel free to drop it if you think it is wrong.

Patch changelog:
 v2:
   * documentation: mention kretprobe stack-stashing
   * ftrace: add self-test for fixed kretprobe stacktraces
   * ftrace: remove [unknown/kretprobe'd] handling
   * kprobe: remove needless EXPORT statements
   * kprobe: minor corrections to current_kretprobe_instance (switch
     away from hlist_for_each_entry_safe)
   * kprobe: make maximum stack size 127, which is the ftrace default

(I forgot to Cc the BPF folks in v1, I've added them now.)

Aleksa Sarai (2):
  kretprobe: produce sane stack traces
  trace: remove kretprobed checks

 Documentation/kprobes.txt                     |   6 +-
 include/linux/kprobes.h                       |  15 +++
 kernel/events/callchain.c                     |   8 +-
 kernel/kprobes.c                              | 101 +++++++++++++++++-
 kernel/trace/trace.c                          |  11 +-
 kernel/trace/trace_output.c                   |  34 +-----
 .../test.d/kprobe/kretprobe_stacktrace.tc     |  25 +++++
 7 files changed, 165 insertions(+), 35 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/kretprobe_stacktrace.tc

-- 
2.19.1

