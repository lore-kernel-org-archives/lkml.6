Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6E6C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 20:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D70A20870
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 20:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W+14hTBO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="TUldIjr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D70A20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbeIIBOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 21:14:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44790 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbeIIBOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 21:14:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E48286085F; Sat,  8 Sep 2018 20:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536438462;
        bh=6wg8erjEDFTQdNJQq7AYxQxvFvLfpTfESTfr62YI+Ec=;
        h=From:To:Cc:Subject:Date:From;
        b=W+14hTBOjPdBMK8ArZNBnwfXdOKKysUq9vRP95XSOtnzer5Eikx0jBRdhTWzdeQ8W
         wHdkUr3EOtDa2psBUYqBux/psOhmwo/8uBTKO+RlNJ/YJVkOCY66OTP5uC1A7vNgd1
         kybhSOfJcMT2v8qReGvjTmzyBq+LFoRqPF3rZyaU=
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BF0A16029D;
        Sat,  8 Sep 2018 20:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536438460;
        bh=6wg8erjEDFTQdNJQq7AYxQxvFvLfpTfESTfr62YI+Ec=;
        h=From:To:Cc:Subject:Date:From;
        b=TUldIjr5q93Osn75MmX0VLTKVNm6oBGXlNBRtVYRvw2Ok6KZFxC6aq8EWJs5F/hl2
         FU8EjmnW2A9s+ZmeyNG4AmAqmrAO41TNeM05rbwJ+mbimH6p0D2REFf7C1hps0CDvL
         gbBmxIZTR3uR20ApU7DQZVFJs8gVjiS+kT0IFqI8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BF0A16029D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Colin Cross <ccross@android.com>,
        Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Jim Cromie <jim.cromie@gmail.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        tsoni@codeaurora.org, Bryan Huntsman <bryanh@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH 0/6] Tracing register accesses with pstore and dynamic debug
Date:   Sun,  9 Sep 2018 01:57:01 +0530
Message-Id: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series adds Event tracing support to pstore and is continuation
to the RFC patch introduced to add a new tracing facility for register
accesses called Register Trace Buffer(RTB). Since we decided to not introduce
a separate framework to trace register accesses and use existing framework
like tracepoints, I have moved from RFC. Details of the RFC in link below:

Link: https://lore.kernel.org/lkml/cover.1535119710.git.saiprakash.ranjan@codeaurora.org/

MSR tracing example given by Steven was helpful in using tracepoints for
register accesses instead of using separate trace. But just having these
IO traces would not help much unless we could have them in some persistent
ram buffer for debugging unclocked access or some kind of bus hang or an
unexpected reset caused by some buggy driver which happens a lot during
initial development stages. By analyzing the last few entries of this buffer,
we could identify the register access which is causing the issue.

But again, adding pstore support for just one such event would be unacceptable.
Instead, add pstore support for all events since event tracing is widely used
across the kernel to debug variety of issues and adding this support would be
really useful for such purposes.

In addition to this, provide dynamic debug support to filter out unwanted logs
and limit trace to only specific files or directories since there can be
aweful lot of register trace events and we will be interested only in specific
drivers or subsystems which we will be working on. So introduce a new flag "e"
to filter these event tracing to specified input. Currently only register
access trace for arm64 will have this support but this could be expanded later
to other events also if required.

First example below shows the use of tracing events with pstore support. Here
we trace sched events:

  # trace_event=sched tp_pstore in command line
  # reboot -f
  # mount -t pstore pstore /sys/fs/pstore/
  # tail /sys/fs/pstore/event-ramoops-0
  sched_switch: prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=rcu_preempt next_pid=10 next_prio=120
  sched_switch: prev_comm=rcu_preempt prev_pid=10 prev_prio=120 prev_state=R+ ==> next_comm=swapper/1 next_pid=0 next_prio=120
  sched_waking: comm=rcu_sched pid=11 prio=120 target_cpu=002
  sched_wakeup: comm=rcu_sched pid=11 prio=120 target_cpu=002
  sched_switch: prev_comm=swapper/2 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=rcu_sched next_pid=11 next_prio=120
  sched_switch: prev_comm=rcu_sched prev_pid=11 prev_prio=120 prev_state=R+ ==> next_comm=swapper/2 next_pid=0 next_prio=120
  sched_waking: comm=reboot pid=1867 prio=120 target_cpu=000
  sched_wakeup: comm=reboot pid=1867 prio=120 target_cpu=000
  sched_switch: prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=S ==> next_comm=reboot next_pid=1867 next_prio=120

We can get more details for debugging as we can see from the above pstore
output.

Below is the second example for identifying the root cause of bus hang in
qcom mdp tested on db410c. This hang was intentionally introduced just to
show the usecase of tracing with pstore. The module used can be found here:
 https://github.com/saiprakash-ranjan/Bus-Hang
This does an unclocked access and will reset db410c and later logs can be
viewed through pstore. Here we manually specify the path to trace in kernel
command line.

Note: For testing purpose, I just copied bus_hang.c to drivers/soc/qcom and built it.

1) Set command line with dyndbg, trace_event and tp_pstore parameter as below:

   # dyndbg="file drivers/soc/qcom/* +e" trace_event=io tp_pstore

2) Bus hang by reading below debugfs entry with bus_hang module.

   # cat /sys/kernel/debug/hang/bus_hang

3) After restart, we can find the cause in last entry i.e. (bus_hang_mdp+0xa4/0xb8)

   # cat /sys/fs/pstore/event-ramoops-0
   io_write: type=writel cpu=0 ts:1423426774 data=0xffff00000d5065a4 caller=qcom_smsm_probe+0x52c/0x678
   io_write: type=writel cpu=0 ts:1423649847 data=0xffff00000d506608 caller=qcom_smsm_probe+0x52c/0x678
   io_read: type=readl cpu=1 ts:53095994171 data=0xffff00000a51d040 caller=bus_hang_mdp+0xa4/0xb8

4) Offending register access found as below:

   # (gdb)
   # (gdb) list *(bus_hang_mdp+0xa4)
   # 0xffff00000867cdc8 is in bus_hang_mdp (drivers/soc/qcom/bus_hang.c:10).
   # 5       static int bus_hang_mdp(void *data, u64 *val)
   # 6       {
   # 7               void *p = ioremap(0x01a01000, SZ_4K);
   # 8               unsigned int a;
   # 9
   # 10              a = __raw_readl((void *)((unsigned long)p + 0x40));  <----
   # 11
   # 12              *val = a;
   # 13
   # 14              return 0;
   # (gdb)

Patchwise oneline description is given below:

Patch 1 adds event-size property to dt-bindings of ramoops.

Patch 2 adds generic event tracing support to pstore.

Patch 3 adds tp_pstore cmdline to have tracepoints go to pstore.

Patch 4 adds tracepoint for register accesses, i.e. for (read/write{b,w,l,q}).

Patch 5 adds new header for instrumentation of io operations.

Patch 6 adds new flag for dynamic event tracing.

Sai Prakash Ranjan (6):
  dt-bindings: ramoops: Add event-size property
  pstore: Add event tracing support
  tracing: Add tp_pstore cmdline to have tracepoints go to pstore
  arm64/io: Add tracepoint for register accesses
  arm64/io: Add header for instrumentation of io operations
  dynamic_debug: Add flag for dynamic event tracing

 .../admin-guide/kernel-parameters.txt         | 21 ++++++
 .../bindings/reserved-memory/ramoops.txt      |  7 +-
 arch/arm64/include/asm/io.h                   | 25 +++----
 arch/arm64/kernel/io.c                        | 22 ++++++
 fs/pstore/Kconfig                             |  2 +-
 fs/pstore/ftrace.c                            | 55 +++++++++++++++
 fs/pstore/inode.c                             |  4 ++
 fs/pstore/ram.c                               | 44 +++++++++++-
 include/asm-generic/io-instrumented.h         | 69 ++++++++++++++++++
 include/asm-generic/io-trace.h                | 70 +++++++++++++++++++
 include/linux/dynamic_debug.h                 |  1 +
 include/linux/ftrace.h                        |  6 +-
 include/linux/pstore.h                        |  2 +
 include/linux/pstore_ram.h                    |  1 +
 kernel/sysctl.c                               |  7 ++
 kernel/trace/Kconfig                          | 22 +++++-
 kernel/trace/trace.c                          | 51 ++++++++++++++
 kernel/trace/trace.h                          |  7 ++
 lib/dynamic_debug.c                           |  1 +
 19 files changed, 393 insertions(+), 24 deletions(-)
 create mode 100644 include/asm-generic/io-instrumented.h
 create mode 100644 include/asm-generic/io-trace.h

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

