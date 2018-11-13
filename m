Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81A2C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C9892243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 02:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PDS5QUAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9892243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbeKML7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 06:59:32 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39214 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeKML7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 06:59:31 -0500
Received: by mail-pg1-f195.google.com with SMTP id r9-v6so4910442pgv.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 18:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:in-reply-to:references:cc:from:to;
        bh=bZJYbn5hPpp8YWyyd6FEL+2Z5S+AAcLENrPS0p1yRu8=;
        b=PDS5QUAchBznrXCUA0tNGKSEH5LXo7Ffvc+eQ/gsx+wsmG+PLKagLTYAamiANvJYi1
         dp0Zf4H5/oqfz4Tf4gy2DXxY9yBQ0L0jG/r8DNG0e48HCCQXUHscHnvrxr8AmXxT0wpq
         3s3pqdn27pw0/hVbjaa11VIirkYjC8Rqcbm96dmiQ4+PrcyNZDBQLSEO9efPyKVPPV+4
         hI3AqZXOSmBPItVMQKQ6bxDbG39DIpb6IdzsboLVJ20smUOeaJxdHnEp98ey+/raF9rl
         3I6egFkaQBEMZBcnZaULLrfvqqMrPbFSa+kWP2Kkzk3x4KyY5NFRWSWbY3KfTwx/EH5r
         Huww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :cc:from:to;
        bh=bZJYbn5hPpp8YWyyd6FEL+2Z5S+AAcLENrPS0p1yRu8=;
        b=Dw7o4ugckrYfutolXRAbiSsb/KwbhH3ZIhEeyK9BMKfQKZTFnoVOU4HsC/hmirbPz3
         NIwiFnfVgQe1xi0ClktY276ik83cqDjvVJ9MWlGZQVz4YvHuegElYhMlTEBqkCNhM3fl
         wDqfI5cGlTvzxC1OV1rJg+SRJmpCy1s8i/lS1G2FYMHeartuGWSf09l5jOa+HF8gJPuN
         XdJtbTZp8ymsZ1YI2lqJcOt0YDx9ozEv6XCyoTz/LzRObTvwd32D9okB57RUUlNMF1wP
         abmT5Ourc59sU7+Ft8XeVZGRM2PUlJkWJ5YZGF4ROHhHI/qP+h0nX8Yyb/YdT1zqQzpi
         /g7w==
X-Gm-Message-State: AGRZ1gLqM/gOmgl51iyz6CdIvZNW5WNT4V6hvpLxYK1OVmuJASZz1mDp
        urqBxe7U7h2M2Zm/HFrwTWmp8Q==
X-Google-Smtp-Source: AJdET5cKW7lfGpNAdyVIenlspuCsQtSk4IOvKW7k0LjklwB8ysnwoRcyEzag9vlwO0+5yuZ32U2KxA==
X-Received: by 2002:a65:64d5:: with SMTP id t21-v6mr3070692pgv.428.1542074618538;
        Mon, 12 Nov 2018 18:03:38 -0800 (PST)
Received: from localhost ([216.9.110.8])
        by smtp.gmail.com with ESMTPSA id o81-v6sm28369607pfa.170.2018.11.12.18.03.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 18:03:37 -0800 (PST)
Subject: [PATCH 1/7] doc: features-refresh.sh for csky
Date:   Mon, 12 Nov 2018 18:01:07 -0800
Message-Id: <20181113020113.29640-2-palmer@sifive.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181113020113.29640-1-palmer@sifive.com>
References: <20181113020113.29640-1-palmer@sifive.com>
Cc:     corbet@lwn.net, Palmer Dabbelt <palmer@sifive.com>,
        aou@eecs.berkeley.edu, ren_guo@c-sky.com,
        andrea.parri@amarulasolutions.com, Arnd Bergmann <arnd@arndb.de>,
        jhogan@kernel.org, dhowells@redhat.com, jcmvbkbc@gmail.com,
        keescook@chromium.org, yamada.masahiro@socionext.com,
        mathieu.desnoyers@efficios.com, mingo@kernel.org,
        rmk+kernel@armlinux.org.uk, Will Deacon <will.deacon@arm.com>,
        jglisse@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        david.abdurachmanov@gmail.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 Documentation/features/core/cBPF-JIT/arch-support.txt            | 1 +
 Documentation/features/core/eBPF-JIT/arch-support.txt            | 1 +
 Documentation/features/core/generic-idle-thread/arch-support.txt | 1 +
 Documentation/features/core/jump-labels/arch-support.txt         | 1 +
 Documentation/features/core/tracehook/arch-support.txt           | 1 +
 Documentation/features/debug/KASAN/arch-support.txt              | 1 +
 Documentation/features/debug/gcov-profile-all/arch-support.txt   | 1 +
 Documentation/features/debug/kgdb/arch-support.txt               | 1 +
 Documentation/features/debug/kprobes-on-ftrace/arch-support.txt  | 1 +
 Documentation/features/debug/kprobes/arch-support.txt            | 1 +
 Documentation/features/debug/kretprobes/arch-support.txt         | 1 +
 Documentation/features/debug/optprobes/arch-support.txt          | 1 +
 Documentation/features/debug/stackprotector/arch-support.txt     | 1 +
 Documentation/features/debug/uprobes/arch-support.txt            | 1 +
 Documentation/features/debug/user-ret-profiler/arch-support.txt  | 1 +
 Documentation/features/io/dma-contiguous/arch-support.txt        | 1 +
 Documentation/features/io/sg-chain/arch-support.txt              | 1 +
 Documentation/features/locking/cmpxchg-local/arch-support.txt    | 1 +
 Documentation/features/locking/lockdep/arch-support.txt          | 1 +
 Documentation/features/locking/queued-rwlocks/arch-support.txt   | 1 +
 Documentation/features/locking/queued-spinlocks/arch-support.txt | 1 +
 Documentation/features/locking/rwsem-optimized/arch-support.txt  | 1 +
 Documentation/features/perf/kprobes-event/arch-support.txt       | 1 +
 Documentation/features/perf/perf-regs/arch-support.txt           | 1 +
 Documentation/features/perf/perf-stackdump/arch-support.txt      | 1 +
 .../features/sched/membarrier-sync-core/arch-support.txt         | 1 +
 Documentation/features/sched/numa-balancing/arch-support.txt     | 1 +
 Documentation/features/seccomp/seccomp-filter/arch-support.txt   | 1 +
 Documentation/features/time/arch-tick-broadcast/arch-support.txt | 1 +
 Documentation/features/time/clockevents/arch-support.txt         | 1 +
 Documentation/features/time/context-tracking/arch-support.txt    | 1 +
 Documentation/features/time/irq-time-acct/arch-support.txt       | 1 +
 Documentation/features/time/modern-timekeeping/arch-support.txt  | 1 +
 Documentation/features/time/virt-cpuacct/arch-support.txt        | 1 +
 Documentation/features/vm/ELF-ASLR/arch-support.txt              | 1 +
 Documentation/features/vm/PG_uncached/arch-support.txt           | 1 +
 Documentation/features/vm/THP/arch-support.txt                   | 1 +
 Documentation/features/vm/TLB/arch-support.txt                   | 1 +
 Documentation/features/vm/huge-vmap/arch-support.txt             | 1 +
 Documentation/features/vm/ioremap_prot/arch-support.txt          | 1 +
 Documentation/features/vm/numa-memblock/arch-support.txt         | 1 +
 Documentation/features/vm/pte_special/arch-support.txt           | 1 +
 42 files changed, 42 insertions(+)

diff --git a/Documentation/features/core/cBPF-JIT/arch-support.txt b/Documentation/features/core/cBPF-JIT/arch-support.txt
index 90459cdde314..8620c38d4db0 100644
--- a/Documentation/features/core/cBPF-JIT/arch-support.txt
+++ b/Documentation/features/core/cBPF-JIT/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: | TODO |
     |       arm64: | TODO |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/core/eBPF-JIT/arch-support.txt b/Documentation/features/core/eBPF-JIT/arch-support.txt
index c90a0382fe66..9ae6e8d0d10d 100644
--- a/Documentation/features/core/eBPF-JIT/arch-support.txt
+++ b/Documentation/features/core/eBPF-JIT/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/core/generic-idle-thread/arch-support.txt b/Documentation/features/core/generic-idle-thread/arch-support.txt
index 0ef6acdb991c..365df2c2ff0b 100644
--- a/Documentation/features/core/generic-idle-thread/arch-support.txt
+++ b/Documentation/features/core/generic-idle-thread/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: |  ok  |
     |        ia64: |  ok  |
diff --git a/Documentation/features/core/jump-labels/arch-support.txt b/Documentation/features/core/jump-labels/arch-support.txt
index 27cbd63abfd2..c29146c5741e 100644
--- a/Documentation/features/core/jump-labels/arch-support.txt
+++ b/Documentation/features/core/jump-labels/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/core/tracehook/arch-support.txt b/Documentation/features/core/tracehook/arch-support.txt
index f44c274e40ed..d344b99aae1e 100644
--- a/Documentation/features/core/tracehook/arch-support.txt
+++ b/Documentation/features/core/tracehook/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: |  ok  |
+    |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: |  ok  |
     |        ia64: |  ok  |
diff --git a/Documentation/features/debug/KASAN/arch-support.txt b/Documentation/features/debug/KASAN/arch-support.txt
index 282ecc8ea1da..304dcd461795 100644
--- a/Documentation/features/debug/KASAN/arch-support.txt
+++ b/Documentation/features/debug/KASAN/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: | TODO |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/debug/gcov-profile-all/arch-support.txt b/Documentation/features/debug/gcov-profile-all/arch-support.txt
index 01b2b3004e0a..059d58a549c7 100644
--- a/Documentation/features/debug/gcov-profile-all/arch-support.txt
+++ b/Documentation/features/debug/gcov-profile-all/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/debug/kgdb/arch-support.txt b/Documentation/features/debug/kgdb/arch-support.txt
index 3b4dff22329f..3e6b8f07d5d0 100644
--- a/Documentation/features/debug/kgdb/arch-support.txt
+++ b/Documentation/features/debug/kgdb/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: |  ok  |
     |     hexagon: |  ok  |
     |        ia64: | TODO |
diff --git a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
index 7e963d0ae646..68f266944d5f 100644
--- a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
+++ b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: | TODO |
     |       arm64: | TODO |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/debug/kprobes/arch-support.txt b/Documentation/features/debug/kprobes/arch-support.txt
index 4ada027faf16..f4e45bd58fea 100644
--- a/Documentation/features/debug/kprobes/arch-support.txt
+++ b/Documentation/features/debug/kprobes/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: |  ok  |
diff --git a/Documentation/features/debug/kretprobes/arch-support.txt b/Documentation/features/debug/kretprobes/arch-support.txt
index 044e13fcca5d..1d5651ef11f8 100644
--- a/Documentation/features/debug/kretprobes/arch-support.txt
+++ b/Documentation/features/debug/kretprobes/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: |  ok  |
diff --git a/Documentation/features/debug/optprobes/arch-support.txt b/Documentation/features/debug/optprobes/arch-support.txt
index dce7669c918f..fb297a88f62c 100644
--- a/Documentation/features/debug/optprobes/arch-support.txt
+++ b/Documentation/features/debug/optprobes/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: | TODO |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/debug/stackprotector/arch-support.txt b/Documentation/features/debug/stackprotector/arch-support.txt
index 954ac1c95553..9999ea521f3e 100644
--- a/Documentation/features/debug/stackprotector/arch-support.txt
+++ b/Documentation/features/debug/stackprotector/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/debug/uprobes/arch-support.txt b/Documentation/features/debug/uprobes/arch-support.txt
index 1a3f9d3229bf..1c577d0cfc7f 100644
--- a/Documentation/features/debug/uprobes/arch-support.txt
+++ b/Documentation/features/debug/uprobes/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/debug/user-ret-profiler/arch-support.txt b/Documentation/features/debug/user-ret-profiler/arch-support.txt
index 1d78d1069a5f..6bfa36b0e017 100644
--- a/Documentation/features/debug/user-ret-profiler/arch-support.txt
+++ b/Documentation/features/debug/user-ret-profiler/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: | TODO |
     |       arm64: | TODO |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/io/dma-contiguous/arch-support.txt b/Documentation/features/io/dma-contiguous/arch-support.txt
index 30c072d2b67c..eb28b5c97ca6 100644
--- a/Documentation/features/io/dma-contiguous/arch-support.txt
+++ b/Documentation/features/io/dma-contiguous/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/io/sg-chain/arch-support.txt b/Documentation/features/io/sg-chain/arch-support.txt
index 6554f0372c3f..eac96f99174f 100644
--- a/Documentation/features/io/sg-chain/arch-support.txt
+++ b/Documentation/features/io/sg-chain/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: |  ok  |
diff --git a/Documentation/features/locking/cmpxchg-local/arch-support.txt b/Documentation/features/locking/cmpxchg-local/arch-support.txt
index 51704a2dc8d1..242ff5a6586e 100644
--- a/Documentation/features/locking/cmpxchg-local/arch-support.txt
+++ b/Documentation/features/locking/cmpxchg-local/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: | TODO |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/locking/lockdep/arch-support.txt b/Documentation/features/locking/lockdep/arch-support.txt
index bd39c5edd460..941fd5b1094d 100644
--- a/Documentation/features/locking/lockdep/arch-support.txt
+++ b/Documentation/features/locking/lockdep/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: |  ok  |
     |        ia64: | TODO |
diff --git a/Documentation/features/locking/queued-rwlocks/arch-support.txt b/Documentation/features/locking/queued-rwlocks/arch-support.txt
index da7aff3bee0b..c683da198f31 100644
--- a/Documentation/features/locking/queued-rwlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-rwlocks/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: | TODO |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: |  ok  |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/locking/queued-spinlocks/arch-support.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
index 478e9101322c..e3080b82aefd 100644
--- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: | TODO |
     |       arm64: | TODO |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/locking/rwsem-optimized/arch-support.txt b/Documentation/features/locking/rwsem-optimized/arch-support.txt
index e54b1f1a8091..7521d7500fbe 100644
--- a/Documentation/features/locking/rwsem-optimized/arch-support.txt
+++ b/Documentation/features/locking/rwsem-optimized/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: |  ok  |
diff --git a/Documentation/features/perf/kprobes-event/arch-support.txt b/Documentation/features/perf/kprobes-event/arch-support.txt
index 7331402d1887..d8278bf62b85 100644
--- a/Documentation/features/perf/kprobes-event/arch-support.txt
+++ b/Documentation/features/perf/kprobes-event/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: |  ok  |
     |        ia64: | TODO |
diff --git a/Documentation/features/perf/perf-regs/arch-support.txt b/Documentation/features/perf/perf-regs/arch-support.txt
index 53feeee6cdad..687d049d9cee 100644
--- a/Documentation/features/perf/perf-regs/arch-support.txt
+++ b/Documentation/features/perf/perf-regs/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/perf/perf-stackdump/arch-support.txt b/Documentation/features/perf/perf-stackdump/arch-support.txt
index 16164348e0ea..90996e3d18a8 100644
--- a/Documentation/features/perf/perf-stackdump/arch-support.txt
+++ b/Documentation/features/perf/perf-stackdump/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
index c7858dd1ea8f..8a521a622966 100644
--- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
+++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
@@ -34,6 +34,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/sched/numa-balancing/arch-support.txt b/Documentation/features/sched/numa-balancing/arch-support.txt
index c68bb2c2cb62..305601da4c05 100644
--- a/Documentation/features/sched/numa-balancing/arch-support.txt
+++ b/Documentation/features/sched/numa-balancing/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ..  |
     |       arm64: |  ok  |
     |         c6x: |  ..  |
+    |        csky: | TODO |
     |       h8300: |  ..  |
     |     hexagon: |  ..  |
     |        ia64: | TODO |
diff --git a/Documentation/features/seccomp/seccomp-filter/arch-support.txt b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
index d4271b493b41..4fe6c3c3be5c 100644
--- a/Documentation/features/seccomp/seccomp-filter/arch-support.txt
+++ b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/time/arch-tick-broadcast/arch-support.txt b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
index 83d9e68462bb..593536f7925b 100644
--- a/Documentation/features/time/arch-tick-broadcast/arch-support.txt
+++ b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/time/clockevents/arch-support.txt b/Documentation/features/time/clockevents/arch-support.txt
index 3d4908fce6da..7a27157da408 100644
--- a/Documentation/features/time/clockevents/arch-support.txt
+++ b/Documentation/features/time/clockevents/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: |  ok  |
+    |        csky: |  ok  |
     |       h8300: |  ok  |
     |     hexagon: |  ok  |
     |        ia64: | TODO |
diff --git a/Documentation/features/time/context-tracking/arch-support.txt b/Documentation/features/time/context-tracking/arch-support.txt
index c29974afffaa..048bfb6d3872 100644
--- a/Documentation/features/time/context-tracking/arch-support.txt
+++ b/Documentation/features/time/context-tracking/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/time/irq-time-acct/arch-support.txt b/Documentation/features/time/irq-time-acct/arch-support.txt
index 8d73c463ec27..a14bbad8e948 100644
--- a/Documentation/features/time/irq-time-acct/arch-support.txt
+++ b/Documentation/features/time/irq-time-acct/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: |  ..  |
diff --git a/Documentation/features/time/modern-timekeeping/arch-support.txt b/Documentation/features/time/modern-timekeeping/arch-support.txt
index e7c6ea6b8fb3..2855dfe2464d 100644
--- a/Documentation/features/time/modern-timekeeping/arch-support.txt
+++ b/Documentation/features/time/modern-timekeeping/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: | TODO |
     |       arm64: |  ok  |
     |         c6x: |  ok  |
+    |        csky: |  ok  |
     |       h8300: |  ok  |
     |     hexagon: |  ok  |
     |        ia64: |  ok  |
diff --git a/Documentation/features/time/virt-cpuacct/arch-support.txt b/Documentation/features/time/virt-cpuacct/arch-support.txt
index 4646457461cf..fb0d0cab9cab 100644
--- a/Documentation/features/time/virt-cpuacct/arch-support.txt
+++ b/Documentation/features/time/virt-cpuacct/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: |  ok  |
diff --git a/Documentation/features/vm/ELF-ASLR/arch-support.txt b/Documentation/features/vm/ELF-ASLR/arch-support.txt
index 1f71d090ff2c..adc25878d217 100644
--- a/Documentation/features/vm/ELF-ASLR/arch-support.txt
+++ b/Documentation/features/vm/ELF-ASLR/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/vm/PG_uncached/arch-support.txt b/Documentation/features/vm/PG_uncached/arch-support.txt
index fbd5aa463b0a..f05588f9e4b4 100644
--- a/Documentation/features/vm/PG_uncached/arch-support.txt
+++ b/Documentation/features/vm/PG_uncached/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: | TODO |
     |       arm64: | TODO |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: |  ok  |
diff --git a/Documentation/features/vm/THP/arch-support.txt b/Documentation/features/vm/THP/arch-support.txt
index 5d7ecc378f29..cf0393711cbe 100644
--- a/Documentation/features/vm/THP/arch-support.txt
+++ b/Documentation/features/vm/THP/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: |  ..  |
+    |        csky: | TODO |
     |       h8300: |  ..  |
     |     hexagon: |  ..  |
     |        ia64: | TODO |
diff --git a/Documentation/features/vm/TLB/arch-support.txt b/Documentation/features/vm/TLB/arch-support.txt
index f7af9678eb66..2bdd3b6cee3c 100644
--- a/Documentation/features/vm/TLB/arch-support.txt
+++ b/Documentation/features/vm/TLB/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: | TODO |
     |       arm64: | TODO |
     |         c6x: |  ..  |
+    |        csky: | TODO |
     |       h8300: |  ..  |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/vm/huge-vmap/arch-support.txt b/Documentation/features/vm/huge-vmap/arch-support.txt
index d0713ccc7117..019131c5acce 100644
--- a/Documentation/features/vm/huge-vmap/arch-support.txt
+++ b/Documentation/features/vm/huge-vmap/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: | TODO |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/vm/ioremap_prot/arch-support.txt b/Documentation/features/vm/ioremap_prot/arch-support.txt
index 8527601a3739..c6f3e4d68152 100644
--- a/Documentation/features/vm/ioremap_prot/arch-support.txt
+++ b/Documentation/features/vm/ioremap_prot/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: | TODO |
     |       arm64: | TODO |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/Documentation/features/vm/numa-memblock/arch-support.txt b/Documentation/features/vm/numa-memblock/arch-support.txt
index 1a988052cd24..e51cb9f7d166 100644
--- a/Documentation/features/vm/numa-memblock/arch-support.txt
+++ b/Documentation/features/vm/numa-memblock/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ..  |
     |       arm64: |  ok  |
     |         c6x: |  ..  |
+    |        csky: | TODO |
     |       h8300: |  ..  |
     |     hexagon: |  ..  |
     |        ia64: |  ok  |
diff --git a/Documentation/features/vm/pte_special/arch-support.txt b/Documentation/features/vm/pte_special/arch-support.txt
index a8378424bc98..2dc5df6a1cf5 100644
--- a/Documentation/features/vm/pte_special/arch-support.txt
+++ b/Documentation/features/vm/pte_special/arch-support.txt
@@ -11,6 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
+    |        csky: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-- 
2.18.1

