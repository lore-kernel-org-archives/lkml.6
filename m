Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0050DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2D1C2082B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 19:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="VUdPWg0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D1C2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeJKCnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 22:43:32 -0400
Received: from mail.efficios.com ([167.114.142.138]:60850 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbeJKCnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 22:43:32 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 53342183B08;
        Wed, 10 Oct 2018 15:19:58 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id umeA5F604wE5; Wed, 10 Oct 2018 15:19:57 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 89394183B04;
        Wed, 10 Oct 2018 15:19:57 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 89394183B04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1539199197;
        bh=avL0yVyyGmG9lD2qDm/egAoOKdIR8VZqXdzDwquWtkk=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=VUdPWg0ZD9JL6hrLESP15q8JuPRPAIH26BKRPUaw+Mai+wTGuq51tD+arDEuVJ5y1
         z3zYQmoMJ93/SsaWdHRLQZNrxT/bFFaNUdbIbf2yRLgFiIVa7MYfXX5bGq+l2P6kxS
         Mg2/7n48KtpPZfICvVvEjSl7x2L85QzA55XFUxZ3F8tibBGrqjPXtnruLNb6RiQsWN
         dS8MeHt05+Eu6++q/9IlYcr9oofXP21hBeh4o/9Kn2qmLFVNk7lSdUpRmo/ZHFgCIn
         dHvlUpmztmxhsJu4ZO1lWtwIbve+iHv5EqQ+K+CehZx2sZ4BjAb58qZcUtwmxJ1pn2
         NecB1ZT4BfLug==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id PKK1HMOKqWSQ; Wed, 10 Oct 2018 15:19:57 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id F0021183AFF;
        Wed, 10 Oct 2018 15:19:55 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH for 4.21 00/16] rseq updates, new cpu_opv system call
Date:   Wed, 10 Oct 2018 15:19:20 -0400
Message-Id: <20181010191936.7495-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Considering it's already late in the 4.19 rc cycle, I'm submitting this
patchset as RFC for 4.21 to give everyone plenty of time to provide
feedback.

This series contain:

- rseq selftests (this could be 4.20 material):
  - Added reference counter within user-space __rseq_abi structure, for
    integration of rseq application/libraries with future use by glibc,
  - Adapt number of threads to the number of online cpus.

- cpu_opv (4.21 material):
  - Implement push_task_to_cpu() (scheduler),
  - Introduce vm_map_user_ram()/vm_unmap_user_ram() (mm),
  - Provide is_vma_noncached() (mm),
  - Introduce cpu_opv system call, with vmap space limiting,
    - Wire up cpu_opv on x86, powerpc, arm,
  - Provide cpu_opv selftests.

The cpu_opv system call covers the use-cases that rseq does not handle,
namely single-stepping with debuggers, moving data between per-cpu data
structures without interfering with cpu affinity masks, and using rseq
from signal handlers nested between thread creation and rseq
registration by glibc, or between rseq unregistration by glibc and
thread teardown.

Thanks,

Mathieu

Mathieu Desnoyers (16):
  rseq/selftests: Add reference counter to coexist with glibc
  rseq/selftests: Adapt number of threads to the number of detected cpus
  sched: Implement push_task_to_cpu (v2)
  mm: Introduce vm_map_user_ram, vm_unmap_user_ram
  mm: Provide is_vma_noncached
  cpu_opv: Provide cpu_opv system call (v8)
  cpu_opv: limit amount of virtual address space used by cpu_opv
  x86: Wire up cpu_opv system call
  powerpc: Wire up cpu_opv system call
  arm: Wire up cpu_opv system call
  cpu-opv/selftests: Provide cpu-op library
  cpu-opv/selftests: Provide basic test
  cpu-opv/selftests: Provide percpu_op API
  cpu-opv/selftests: Provide basic percpu ops test
  cpu-opv/selftests: Provide parametrized tests
  cpu-opv/selftests: Provide Makefile, scripts, gitignore

 MAINTAINERS                                        |    8 +
 arch/arm/tools/syscall.tbl                         |    1 +
 arch/powerpc/include/asm/systbl.h                  |    1 +
 arch/powerpc/include/uapi/asm/unistd.h             |    1 +
 arch/x86/entry/syscalls/syscall_32.tbl             |    1 +
 arch/x86/entry/syscalls/syscall_64.tbl             |    1 +
 include/linux/mm.h                                 |   24 +
 include/linux/syscalls.h                           |    3 +
 include/linux/vmalloc.h                            |    4 +
 include/uapi/linux/cpu_opv.h                       |  114 ++
 init/Kconfig                                       |   17 +
 kernel/Makefile                                    |    1 +
 kernel/cpu_opv.c                                   | 1190 ++++++++++++++=
+++
 kernel/sched/core.c                                |   42 +
 kernel/sched/sched.h                               |    9 +
 kernel/sys_ni.c                                    |    1 +
 kernel/sysctl.c                                    |   15 +
 mm/vmalloc.c                                       |   64 +
 tools/testing/selftests/Makefile                   |    1 +
 tools/testing/selftests/cpu-opv/.gitignore         |    6 +
 tools/testing/selftests/cpu-opv/Makefile           |   39 +
 .../testing/selftests/cpu-opv/basic_cpu_opv_test.c | 1362 ++++++++++++++=
++++++
 .../selftests/cpu-opv/basic_percpu_ops_test.c      |  295 +++++
 tools/testing/selftests/cpu-opv/cpu-op.c           |  353 +++++
 tools/testing/selftests/cpu-opv/cpu-op.h           |   42 +
 tools/testing/selftests/cpu-opv/param_test.c       | 1187 ++++++++++++++=
+++
 tools/testing/selftests/cpu-opv/percpu-op.h        |  151 +++
 tools/testing/selftests/cpu-opv/run_param_test.sh  |  134 ++
 tools/testing/selftests/rseq/rseq.c                |   32 +-
 tools/testing/selftests/rseq/run_param_test.sh     |    7 +-
 30 files changed, 5096 insertions(+), 10 deletions(-)
 create mode 100644 include/uapi/linux/cpu_opv.h
 create mode 100644 kernel/cpu_opv.c
 create mode 100644 tools/testing/selftests/cpu-opv/.gitignore
 create mode 100644 tools/testing/selftests/cpu-opv/Makefile
 create mode 100644 tools/testing/selftests/cpu-opv/basic_cpu_opv_test.c
 create mode 100644 tools/testing/selftests/cpu-opv/basic_percpu_ops_test=
.c
 create mode 100644 tools/testing/selftests/cpu-opv/cpu-op.c
 create mode 100644 tools/testing/selftests/cpu-opv/cpu-op.h
 create mode 100644 tools/testing/selftests/cpu-opv/param_test.c
 create mode 100644 tools/testing/selftests/cpu-opv/percpu-op.h
 create mode 100755 tools/testing/selftests/cpu-opv/run_param_test.sh

--=20
2.11.0

