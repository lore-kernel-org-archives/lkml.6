Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EF2ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F0920835
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="qKDo7gx2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F0920835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeJJBUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 21:20:34 -0400
Received: from mail.efficios.com ([167.114.142.138]:52918 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJJBUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 21:20:34 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id C56A91820CC;
        Tue,  9 Oct 2018 14:02:22 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id EPwpKQGEK3Au; Tue,  9 Oct 2018 14:02:21 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 831681820AF;
        Tue,  9 Oct 2018 14:02:21 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 831681820AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1539108141;
        bh=BoT6LLksZATeGuY3lyqXLpd18GhnQiTYHPM6CFPEzKQ=;
        h=From:To:Date:Message-Id;
        b=qKDo7gx2aKTY3ZlZDsgUooij/3J7uxQ6GX5Xgtzk32XKBxakiGsKfNP8tUJZUmTMv
         W9o7+B09TPAH7nfwJNocyGd99ml0LFusg6Ao7ZbQgwVK2ds2m1CCIvfO2xabb4NVL0
         K9ZeIPvSFH5mmraaVv/jlMPa+GN9jjmOHaPuZSckolBWQx8cvPRRIqeloKBzPZoDl3
         kxdOkpwrBXf3eVTZp/O67vgWpZ3ZnlwuuSKvZCJUrVye8GGPOH/IhbbACG6cXhhKTJ
         ZN3VIg9Z28xAKtR2cx+DHyjqGBGG2N1G79zqyusNgx6QOt4Y8A5sBEyE6Qcxw6DA9h
         x9atL/3YaYWkg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id HQXlbVaUWK2Z; Tue,  9 Oct 2018 14:02:21 -0400 (EDT)
Received: from localhost.localdomain (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 2BFB71820AA;
        Tue,  9 Oct 2018 14:02:21 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        libc-alpha@sourceware.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [RFC PATCH v2] glibc: Perform rseq(2) registration at nptl init and thread creation (v2)
Date:   Tue,  9 Oct 2018 14:02:15 -0400
Message-Id: <20181009180215.28258-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a second round of prototype registering rseq(2) TLS for each
thread (including main), and unregistering for each thread (excluding
main). "rseq" stands for Restartable Sequences.

Remaining open questions:

- How early do we want to register rseq and how late do we want to
  unregister it ? It's important to consider if we expect rseq to
  be used by the memory allocator and within destructor callbacks.
  However, we want to be sure the TLS (__thread) area is properly
  allocated across its entire use by rseq.

- We do not need an atomic increment/decrement for the refcount per
  se. Just being atomic with respect to the current thread (and nested
  signals) would be enough. What is the proper API to use there ?

- Should we expose struct rseq_lib in a public glibc header ?

See the rseq(2) man page proposed here:
  https://lkml.org/lkml/2018/9/19/647

This patch is based on glibc 2.28.

To try it out, refer to the following kernel and librseq development
branches:

* rseq and cpu_opv:
  https://github.com/compudj/linux-percpu-dev branch: rseq/dev-local

* librseq:
  https://github.com/compudj/librseq branch: master

TODO:

- Add documentation, tests and a NEWS entry.
- Update ABI test baselines.
- Update abilist for non-x86-64 architectures.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Carlos O'Donell <carlos@redhat.com>
CC: Florian Weimer <fweimer@redhat.com>
CC: Joseph Myers <joseph@codesourcery.com>
CC: Szabolcs Nagy <szabolcs.nagy@arm.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ben Maurer <bmaurer@fb.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Dave Watson <davejwatson@fb.com>
CC: Paul Turner <pjt@google.com>
CC: libc-alpha@sourceware.org
CC: linux-kernel@vger.kernel.org
CC: linux-api@vger.kernel.org
---
Changes since v1:
- Move __rseq_refcount to an extra field at the end of __rseq_abi to
  eliminate one symbol.

  All libraries/programs which try to register rseq (glibc,
  early-adopter applications, early-adopter libraries) should use the
  rseq refcount. It becomes part of the ABI within a user-space
  process, but it's not part of the ABI shared with the kernel per se.

- Restructure how this code is organized so glibc keeps building on
  non-Linux targets.

- Use non-weak symbol for __rseq_abi.

- Move rseq registration/unregistration implementation into its own
  nptl/rseq.c compile unit.

- Move __rseq_abi symbol under GLIBC_2.29.
---
 nptl/Makefile                                 |  2 +-
 nptl/Versions                                 |  4 ++
 nptl/nptl-init.c                              |  3 +
 nptl/pthreadP.h                               |  3 +
 nptl/pthread_create.c                         |  8 +++
 nptl/rseq.c                                   | 62 +++++++++++++++++
 sysdeps/nptl/rseq-internal.h                  | 34 ++++++++++
 sysdeps/unix/sysv/linux/rseq-internal.h       | 68 +++++++++++++++++++
 .../sysv/linux/x86_64/64/libpthread.abilist   |  1 +
 9 files changed, 184 insertions(+), 1 deletion(-)
 create mode 100644 nptl/rseq.c
 create mode 100644 sysdeps/nptl/rseq-internal.h
 create mode 100644 sysdeps/unix/sysv/linux/rseq-internal.h

diff --git a/nptl/Makefile b/nptl/Makefile
index be8066524c..9def8b3f13 100644
--- a/nptl/Makefile
+++ b/nptl/Makefile
@@ -145,7 +145,7 @@ libpthread-routines = nptl-init nptlfreeres vars events version pt-interp \
 		      mtx_destroy mtx_init mtx_lock mtx_timedlock \
 		      mtx_trylock mtx_unlock call_once cnd_broadcast \
 		      cnd_destroy cnd_init cnd_signal cnd_timedwait cnd_wait \
-		      tss_create tss_delete tss_get tss_set
+		      tss_create tss_delete tss_get tss_set rseq
 #		      pthread_setuid pthread_seteuid pthread_setreuid \
 #		      pthread_setresuid \
 #		      pthread_setgid pthread_setegid pthread_setregid \
diff --git a/nptl/Versions b/nptl/Versions
index e7f691da7a..f6e645c624 100644
--- a/nptl/Versions
+++ b/nptl/Versions
@@ -277,6 +277,10 @@ libpthread {
     cnd_timedwait; cnd_wait; tss_create; tss_delete; tss_get; tss_set;
   }
 
+  GLIBC_2.29 {
+    __rseq_abi;
+  }
+
   GLIBC_PRIVATE {
     __pthread_initialize_minimal;
     __pthread_clock_gettime; __pthread_clock_settime;
diff --git a/nptl/nptl-init.c b/nptl/nptl-init.c
index 907411d5bc..ab17bbb6e4 100644
--- a/nptl/nptl-init.c
+++ b/nptl/nptl-init.c
@@ -279,6 +279,9 @@ __pthread_initialize_minimal_internal (void)
   THREAD_SETMEM (pd, cpuclock_offset, GL(dl_cpuclock_offset));
 #endif
 
+  /* Register rseq ABI to the kernel. */
+  (void) __rseq_register_current_thread ();
+
   /* Initialize the robust mutex data.  */
   {
 #if __PTHREAD_MUTEX_HAVE_PREV
diff --git a/nptl/pthreadP.h b/nptl/pthreadP.h
index 13bdb11133..aba641c170 100644
--- a/nptl/pthreadP.h
+++ b/nptl/pthreadP.h
@@ -605,6 +605,9 @@ extern void __shm_directory_freeres (void) attribute_hidden;
 
 extern void __wait_lookup_done (void) attribute_hidden;
 
+extern int __rseq_register_current_thread (void) attribute_hidden;
+extern int __rseq_unregister_current_thread (void) attribute_hidden;
+
 #ifdef SHARED
 # define PTHREAD_STATIC_FN_REQUIRE(name)
 #else
diff --git a/nptl/pthread_create.c b/nptl/pthread_create.c
index fe75d04113..a5233cdf2f 100644
--- a/nptl/pthread_create.c
+++ b/nptl/pthread_create.c
@@ -378,6 +378,7 @@ __free_tcb (struct pthread *pd)
 START_THREAD_DEFN
 {
   struct pthread *pd = START_THREAD_SELF;
+  bool has_rseq = false;
 
 #if HP_TIMING_AVAIL
   /* Remember the time when the thread was started.  */
@@ -396,6 +397,9 @@ START_THREAD_DEFN
   if (__glibc_unlikely (atomic_exchange_acq (&pd->setxid_futex, 0) == -2))
     futex_wake (&pd->setxid_futex, 1, FUTEX_PRIVATE);
 
+  /* Register rseq TLS to the kernel. */
+  has_rseq = !__rseq_register_current_thread ();
+
 #ifdef __NR_set_robust_list
 # ifndef __ASSUME_SET_ROBUST_LIST
   if (__set_robust_list_avail >= 0)
@@ -573,6 +577,10 @@ START_THREAD_DEFN
     }
 #endif
 
+  /* Unregister rseq TLS from kernel. */
+  if (has_rseq && __rseq_unregister_current_thread ())
+    abort();
+
   advise_stack_range (pd->stackblock, pd->stackblock_size, (uintptr_t) pd,
 		      pd->guardsize);
 
diff --git a/nptl/rseq.c b/nptl/rseq.c
new file mode 100644
index 0000000000..81ad62e1d3
--- /dev/null
+++ b/nptl/rseq.c
@@ -0,0 +1,62 @@
+/* Copyright (C) 2018 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+   Contributed by Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 2018.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <http://www.gnu.org/licenses/>.  */
+
+#include "pthreadP.h"
+
+enum libc_rseq_cpu_id_state {
+  LIBC_RSEQ_CPU_ID_UNINITIALIZED = -1,
+  LIBC_RSEQ_CPU_ID_REGISTRATION_FAILED = -2,
+};
+
+/* linux/rseq.h defines struct rseq as aligned on 32 bytes. The kernel ABI
+   size is 20 bytes. For support of multiple rseq users within a process,
+   user-space defines an extra 4 bytes field as a reference count, for a
+   total of 24 bytes.  */
+struct libc_rseq {
+  /* kernel-userspace ABI. */
+  uint32_t cpu_id_start;
+  uint32_t cpu_id;
+  uint64_t rseq_cs;
+  uint32_t flags;
+  /* user-space ABI. */
+  uint32_t refcount;
+} __attribute__((aligned(4 * sizeof(uint64_t))));
+
+__thread volatile struct libc_rseq __rseq_abi = {
+  .cpu_id = LIBC_RSEQ_CPU_ID_UNINITIALIZED,
+};
+
+#ifdef __NR_rseq
+#include <sysdeps/unix/sysv/linux/rseq-internal.h>
+#else
+#include <sysdeps/nptl/rseq-internal.h>
+#endif  /* __NR_rseq.  */
+
+int
+attribute_hidden
+__rseq_register_current_thread (void)
+{
+  return sysdep_rseq_register_current_thread ();
+}
+
+int
+attribute_hidden
+__rseq_unregister_current_thread (void)
+{
+  return sysdep_rseq_register_current_thread ();
+}
diff --git a/sysdeps/nptl/rseq-internal.h b/sysdeps/nptl/rseq-internal.h
new file mode 100644
index 0000000000..96422ebd57
--- /dev/null
+++ b/sysdeps/nptl/rseq-internal.h
@@ -0,0 +1,34 @@
+/* Copyright (C) 2018 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+   Contributed by Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 2018.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <http://www.gnu.org/licenses/>.  */
+
+#ifndef RSEQ_INTERNAL_H
+#define RSEQ_INTERNAL_H
+
+static inline int
+sysdep_rseq_register_current_thread (void)
+{
+  return -1;
+}
+
+static inline int
+sysdep_rseq_unregister_current_thread (void)
+{
+  return -1;
+}
+
+#endif	/* rseq-internal.h */
diff --git a/sysdeps/unix/sysv/linux/rseq-internal.h b/sysdeps/unix/sysv/linux/rseq-internal.h
new file mode 100644
index 0000000000..b744aca648
--- /dev/null
+++ b/sysdeps/unix/sysv/linux/rseq-internal.h
@@ -0,0 +1,68 @@
+/* Copyright (C) 2018 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+   Contributed by Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 2018.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <http://www.gnu.org/licenses/>.  */
+
+#ifndef RSEQ_INTERNAL_H
+#define RSEQ_INTERNAL_H
+
+#include <linux/rseq.h>
+
+#define RSEQ_SIG 0x53053053
+
+extern __thread volatile struct libc_rseq __rseq_abi
+__attribute__ ((tls_model ("initial-exec")));
+
+static inline int
+sysdep_rseq_register_current_thread (void)
+{
+  int rc, ret = 0;
+  INTERNAL_SYSCALL_DECL (err);
+
+  if (__rseq_abi.cpu_id == LIBC_RSEQ_CPU_ID_REGISTRATION_FAILED)
+    return -1;
+  if (atomic_increment_val (&__rseq_abi.refcount) - 1)
+    goto end;
+  rc = INTERNAL_SYSCALL_CALL (rseq, err, &__rseq_abi, sizeof (struct rseq),
+                              0, RSEQ_SIG);
+  if (!rc)
+    goto end;
+  if (INTERNAL_SYSCALL_ERRNO (rc, err) != EBUSY)
+    __rseq_abi.cpu_id = LIBC_RSEQ_CPU_ID_REGISTRATION_FAILED;
+  ret = -1;
+  atomic_decrement (&__rseq_abi.refcount);
+end:
+  return ret;
+}
+
+static inline int
+sysdep_rseq_unregister_current_thread (void)
+{
+  int rc, ret = 0;
+  INTERNAL_SYSCALL_DECL (err);
+
+  if (atomic_decrement_val (&__rseq_abi.refcount))
+    goto end;
+  rc = INTERNAL_SYSCALL_CALL (rseq, err, &__rseq_abi, sizeof (struct rseq),
+                              RSEQ_FLAG_UNREGISTER, RSEQ_SIG);
+  if (!rc)
+    goto end;
+  ret = -1;
+end:
+  return ret;
+}
+
+#endif	/* rseq-internal.h */
diff --git a/sysdeps/unix/sysv/linux/x86_64/64/libpthread.abilist b/sysdeps/unix/sysv/linux/x86_64/64/libpthread.abilist
index 931c8277a8..6d3ef80031 100644
--- a/sysdeps/unix/sysv/linux/x86_64/64/libpthread.abilist
+++ b/sysdeps/unix/sysv/linux/x86_64/64/libpthread.abilist
@@ -219,6 +219,7 @@ GLIBC_2.28 tss_create F
 GLIBC_2.28 tss_delete F
 GLIBC_2.28 tss_get F
 GLIBC_2.28 tss_set F
+GLIBC_2.29 __rseq_abi D
 GLIBC_2.3.2 pthread_cond_broadcast F
 GLIBC_2.3.2 pthread_cond_destroy F
 GLIBC_2.3.2 pthread_cond_init F
-- 
2.17.1

