Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E33CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A593021582
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 17:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="VJ7Dm0WB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A593021582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732331AbeKOD5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 22:57:50 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42282 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeKOD5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 22:57:50 -0500
Received: by mail-pl1-f194.google.com with SMTP id x21-v6so5409377pln.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 09:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=dteW8bxQfEJqrpEosvTBzHpQTsd0xkuxcAyNNvwqN9A=;
        b=VJ7Dm0WBXSUIqArh4bFM5A7h6n+1S5AmP77BmD1NYMcUwCW+BM2KOP8NRQ7OZVWpEN
         cDOCsGsu88sCFhzWq/bV8pe9Dq3+lUhuYuHviXaEPFY72bDZZZ4i/X4nXKss4yQhXuu9
         I2pqV1/9tKH4ARuaUV8faQO2Wh1Xij62nraaQLKQALLjb15o6hFjHv9kWenf8oaf67Ml
         hVfW9PVeL4Wt7UWh8ppa+wl/5MSEmZLROd2O5WUr/JR9JXhNu0cjQ3SdNznETZJ+kbcC
         ElmSYjj2hKkBjZCtyX3nhSsXUlJHbY7TPiQP4qh04ysMWXAvq39h5TT2nF9auOcM4Rr4
         YYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=dteW8bxQfEJqrpEosvTBzHpQTsd0xkuxcAyNNvwqN9A=;
        b=a7MDHcdkfLXy+vdV1tWUhYHwfoDjrycbwE0xii0gZdcYvB6eDJAs4XQhLUmrCf74k2
         C/nMG8j5RMDbI6PaXRkJozpawQOmdYDNtRKz3pUz5pHrcqz/PXjH/opx2oCFWNJQ8v5G
         Rlj/wTOJweVjrbTInsOp8ziwMvqFXRr1eOL1O9o4rL6zYCk34PsQcQ7iBdc7eJJKrbwt
         xpKe2MlanwuwHXGXZiBytIJ/RE3MbtNzSKR8dl2HMhMkPOPn9xRNJ0iOC+lXvW46we+V
         Ub+Pv02MqmrIuurj/4d2FLLYRkVMlSxH2zmU2D9lWe/dn9dvggBBgM7tBOOzBBJvkhHV
         mqyg==
X-Gm-Message-State: AGRZ1gJif+nxFrbtkp7E01sYTOzMvQuFsontg79wFCyPScI/igFTXGCa
        jpw90LRxr2LV/9yK9Xu17jKV9Q==
X-Google-Smtp-Source: AJdET5celzUP12/pL5GAD3EmRBGIAH3aK8LY+4Jqavw5aBEifoOJ78ONxwPFIOtERpwlmZ3AyYIGqg==
X-Received: by 2002:a17:902:64:: with SMTP id 91-v6mr2877078pla.161.1542218018661;
        Wed, 14 Nov 2018 09:53:38 -0800 (PST)
Received: from localhost ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id e126-v6sm14694702pfe.67.2018.11.14.09.53.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 09:53:37 -0800 (PST)
Date:   Wed, 14 Nov 2018 09:53:37 -0800 (PST)
X-Google-Original-Date: Wed, 14 Nov 2018 08:39:22 PST (-0800)
Subject:     Re: [PATCH] Documentation/features: Refresh the features list to v4.20-rc2
In-Reply-To: <20181113112507.GA14028@gmail.com>
CC:     corbet@lwn.net, linux-kernel@vger.kernel.org, corbet@lwn.net,
        aou@eecs.berkeley.edu, ren_guo@c-sky.com,
        andrea.parri@amarulasolutions.com, Arnd Bergmann <arnd@arndb.de>,
        jhogan@kernel.org, dhowells@redhat.com, jcmvbkbc@gmail.com,
        keescook@chromium.org, yamada.masahiro@socionext.com,
        mathieu.desnoyers@efficios.com, rmk+kernel@armlinux.org.uk,
        Will Deacon <will.deacon@arm.com>, jglisse@redhat.com,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        david.abdurachmanov@gmail.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     mingo@kernel.org
Message-ID: <mhng-0a49153a-3f84-4939-98ac-4d68b7cec647@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018 03:25:07 PST (-0800), mingo@kernel.org wrote:
>
> * Palmer Dabbelt <palmer@sifive.com> wrote:
>
>> I didn't even know this existed until David submitted a patch set that
>> included updates to the documentation as a result of some features he
>> added to RISC-V.  It looks like there may be a handful of other people
>> who don't know this exists either, so I figured I'd just mail out a
>> patch set containing all the updates split out as well as I can.
>>
>> This smells like something that sholud be automatic, so if I'm jumping
>> the gun here then feel free to drop this.  If nobody says anything then
>> I guess I'll submit this as a separate PR to Linus from my personal
>> tree, as it's not really a RISC-V thing but it seems like it's worth
>> having docs that match the code where it's trivial -- I assume that's
>> what this does, I didn't actually read anything but the diff because I
>> never trust documentation to be up to date...
>>
>> I feel compelled to say something like "maybe this should be part of
>> checkpatch?", but I'm definately not looking to learn perl :)
>
> I don't think it should be automated or part of checkpatch, but I
> (obviously) agree with the changes, except that I think it should be a
> single patch (combined patch attached below).

I'm happy with a single patch.  Does this mean you own it, or do you want me to 
PR it?

> Thanks,
>
> 	Ingo
>
> Subject: Documentation/features: Refresh the features list to v4.20-rc2
> From: Palmer Dabbelt <palmer@sifive.com>
>
> Run Documentation/features/scripts/feature-refresh.sh to refresh the
> kernel features support matrix list:
>
>  - The new 'csky' architecture was added
>  - s390    now supports KASAN
>  - powerpc now supports stackprotector
>  - xtensa  now supports sg-chain
>  - arm64   now supports queued-spinlocks
>  - parisc  now supports kprobes-events
>  - RISC-V  now supports pte_special
>
> [ mingo: combined the patches and the changelogs. ]
>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>
>  Documentation/features/core/cBPF-JIT/arch-support.txt              | 1 +
>  Documentation/features/core/eBPF-JIT/arch-support.txt              | 1 +
>  Documentation/features/core/generic-idle-thread/arch-support.txt   | 1 +
>  Documentation/features/core/jump-labels/arch-support.txt           | 1 +
>  Documentation/features/core/tracehook/arch-support.txt             | 1 +
>  Documentation/features/debug/KASAN/arch-support.txt                | 3 ++-
>  Documentation/features/debug/gcov-profile-all/arch-support.txt     | 1 +
>  Documentation/features/debug/kgdb/arch-support.txt                 | 1 +
>  Documentation/features/debug/kprobes-on-ftrace/arch-support.txt    | 1 +
>  Documentation/features/debug/kprobes/arch-support.txt              | 1 +
>  Documentation/features/debug/kretprobes/arch-support.txt           | 1 +
>  Documentation/features/debug/optprobes/arch-support.txt            | 1 +
>  Documentation/features/debug/stackprotector/arch-support.txt       | 3 ++-
>  Documentation/features/debug/uprobes/arch-support.txt              | 1 +
>  Documentation/features/debug/user-ret-profiler/arch-support.txt    | 1 +
>  Documentation/features/io/dma-contiguous/arch-support.txt          | 1 +
>  Documentation/features/io/sg-chain/arch-support.txt                | 3 ++-
>  Documentation/features/locking/cmpxchg-local/arch-support.txt      | 1 +
>  Documentation/features/locking/lockdep/arch-support.txt            | 1 +
>  Documentation/features/locking/queued-rwlocks/arch-support.txt     | 1 +
>  Documentation/features/locking/queued-spinlocks/arch-support.txt   | 3 ++-
>  Documentation/features/locking/rwsem-optimized/arch-support.txt    | 1 +
>  Documentation/features/perf/kprobes-event/arch-support.txt         | 3 ++-
>  Documentation/features/perf/perf-regs/arch-support.txt             | 1 +
>  Documentation/features/perf/perf-stackdump/arch-support.txt        | 1 +
>  Documentation/features/sched/membarrier-sync-core/arch-support.txt | 1 +
>  Documentation/features/sched/numa-balancing/arch-support.txt       | 1 +
>  Documentation/features/seccomp/seccomp-filter/arch-support.txt     | 1 +
>  Documentation/features/time/arch-tick-broadcast/arch-support.txt   | 1 +
>  Documentation/features/time/clockevents/arch-support.txt           | 1 +
>  Documentation/features/time/context-tracking/arch-support.txt      | 1 +
>  Documentation/features/time/irq-time-acct/arch-support.txt         | 1 +
>  Documentation/features/time/modern-timekeeping/arch-support.txt    | 1 +
>  Documentation/features/time/virt-cpuacct/arch-support.txt          | 1 +
>  Documentation/features/vm/ELF-ASLR/arch-support.txt                | 1 +
>  Documentation/features/vm/PG_uncached/arch-support.txt             | 1 +
>  Documentation/features/vm/THP/arch-support.txt                     | 1 +
>  Documentation/features/vm/TLB/arch-support.txt                     | 1 +
>  Documentation/features/vm/huge-vmap/arch-support.txt               | 1 +
>  Documentation/features/vm/ioremap_prot/arch-support.txt            | 1 +
>  Documentation/features/vm/numa-memblock/arch-support.txt           | 1 +
>  Documentation/features/vm/pte_special/arch-support.txt             | 3 ++-
>  42 files changed, 48 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/features/core/cBPF-JIT/arch-support.txt b/Documentation/features/core/cBPF-JIT/arch-support.txt
> index 90459cdde314..8620c38d4db0 100644
> --- a/Documentation/features/core/cBPF-JIT/arch-support.txt
> +++ b/Documentation/features/core/cBPF-JIT/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: | TODO |
>      |       arm64: | TODO |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: | TODO |
> diff --git a/Documentation/features/core/eBPF-JIT/arch-support.txt b/Documentation/features/core/eBPF-JIT/arch-support.txt
> index c90a0382fe66..9ae6e8d0d10d 100644
> --- a/Documentation/features/core/eBPF-JIT/arch-support.txt
> +++ b/Documentation/features/core/eBPF-JIT/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: | TODO |
> diff --git a/Documentation/features/core/generic-idle-thread/arch-support.txt b/Documentation/features/core/generic-idle-thread/arch-support.txt
> index 0ef6acdb991c..365df2c2ff0b 100644
> --- a/Documentation/features/core/generic-idle-thread/arch-support.txt
> +++ b/Documentation/features/core/generic-idle-thread/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
>      |         c6x: | TODO |
> +    |        csky: |  ok  |
>      |       h8300: | TODO |
>      |     hexagon: |  ok  |
>      |        ia64: |  ok  |
> diff --git a/Documentation/features/core/jump-labels/arch-support.txt b/Documentation/features/core/jump-labels/arch-support.txt
> index 27cbd63abfd2..c29146c5741e 100644
> --- a/Documentation/features/core/jump-labels/arch-support.txt
> +++ b/Documentation/features/core/jump-labels/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: | TODO |
> diff --git a/Documentation/features/core/tracehook/arch-support.txt b/Documentation/features/core/tracehook/arch-support.txt
> index f44c274e40ed..d344b99aae1e 100644
> --- a/Documentation/features/core/tracehook/arch-support.txt
> +++ b/Documentation/features/core/tracehook/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
>      |         c6x: |  ok  |
> +    |        csky: |  ok  |
>      |       h8300: | TODO |
>      |     hexagon: |  ok  |
>      |        ia64: |  ok  |
> diff --git a/Documentation/features/debug/KASAN/arch-support.txt b/Documentation/features/debug/KASAN/arch-support.txt
> index 282ecc8ea1da..c68adfc1db0e 100644
> --- a/Documentation/features/debug/KASAN/arch-support.txt
> +++ b/Documentation/features/debug/KASAN/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: | TODO |
>      |       arm64: |  ok  |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: | TODO |
> @@ -23,7 +24,7 @@
>      |      parisc: | TODO |
>      |     powerpc: | TODO |
>      |       riscv: | TODO |
> -    |        s390: | TODO |
> +    |        s390: |  ok  |
>      |          sh: | TODO |
>      |       sparc: | TODO |
>      |          um: | TODO |
> diff --git a/Documentation/features/debug/gcov-profile-all/arch-support.txt b/Documentation/features/debug/gcov-profile-all/arch-support.txt
> index 01b2b3004e0a..059d58a549c7 100644
> --- a/Documentation/features/debug/gcov-profile-all/arch-support.txt
> +++ b/Documentation/features/debug/gcov-profile-all/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: | TODO |
> diff --git a/Documentation/features/debug/kgdb/arch-support.txt b/Documentation/features/debug/kgdb/arch-support.txt
> index 3b4dff22329f..3e6b8f07d5d0 100644
> --- a/Documentation/features/debug/kgdb/arch-support.txt
> +++ b/Documentation/features/debug/kgdb/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: |  ok  |
>      |     hexagon: |  ok  |
>      |        ia64: | TODO |
> diff --git a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
> index 7e963d0ae646..68f266944d5f 100644
> --- a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
> +++ b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: | TODO |
>      |       arm64: | TODO |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: | TODO |
> diff --git a/Documentation/features/debug/kprobes/arch-support.txt b/Documentation/features/debug/kprobes/arch-support.txt
> index 4ada027faf16..f4e45bd58fea 100644
> --- a/Documentation/features/debug/kprobes/arch-support.txt
> +++ b/Documentation/features/debug/kprobes/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: |  ok  |
> diff --git a/Documentation/features/debug/kretprobes/arch-support.txt b/Documentation/features/debug/kretprobes/arch-support.txt
> index 044e13fcca5d..1d5651ef11f8 100644
> --- a/Documentation/features/debug/kretprobes/arch-support.txt
> +++ b/Documentation/features/debug/kretprobes/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: |  ok  |
> diff --git a/Documentation/features/debug/optprobes/arch-support.txt b/Documentation/features/debug/optprobes/arch-support.txt
> index dce7669c918f..fb297a88f62c 100644
> --- a/Documentation/features/debug/optprobes/arch-support.txt
> +++ b/Documentation/features/debug/optprobes/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: |  ok  |
>      |       arm64: | TODO |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: | TODO |
> diff --git a/Documentation/features/debug/stackprotector/arch-support.txt b/Documentation/features/debug/stackprotector/arch-support.txt
> index 954ac1c95553..32bbdfc64c32 100644
> --- a/Documentation/features/debug/stackprotector/arch-support.txt
> +++ b/Documentation/features/debug/stackprotector/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: | TODO |
> @@ -21,7 +22,7 @@
>      |       nios2: | TODO |
>      |    openrisc: | TODO |
>      |      parisc: | TODO |
> -    |     powerpc: | TODO |
> +    |     powerpc: |  ok  |
>      |       riscv: | TODO |
>      |        s390: | TODO |
>      |          sh: |  ok  |
> diff --git a/Documentation/features/debug/uprobes/arch-support.txt b/Documentation/features/debug/uprobes/arch-support.txt
> index 1a3f9d3229bf..1c577d0cfc7f 100644
> --- a/Documentation/features/debug/uprobes/arch-support.txt
> +++ b/Documentation/features/debug/uprobes/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: | TODO |
> diff --git a/Documentation/features/debug/user-ret-profiler/arch-support.txt b/Documentation/features/debug/user-ret-profiler/arch-support.txt
> index 1d78d1069a5f..6bfa36b0e017 100644
> --- a/Documentation/features/debug/user-ret-profiler/arch-support.txt
> +++ b/Documentation/features/debug/user-ret-profiler/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: | TODO |
>      |       arm64: | TODO |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: | TODO |
> diff --git a/Documentation/features/io/dma-contiguous/arch-support.txt b/Documentation/features/io/dma-contiguous/arch-support.txt
> index 30c072d2b67c..eb28b5c97ca6 100644
> --- a/Documentation/features/io/dma-contiguous/arch-support.txt
> +++ b/Documentation/features/io/dma-contiguous/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
>      |         c6x: | TODO |
> +    |        csky: |  ok  |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: | TODO |
> diff --git a/Documentation/features/io/sg-chain/arch-support.txt b/Documentation/features/io/sg-chain/arch-support.txt
> index 6554f0372c3f..3c85efb8bc8d 100644
> --- a/Documentation/features/io/sg-chain/arch-support.txt
> +++ b/Documentation/features/io/sg-chain/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: |  ok  |
> @@ -29,5 +30,5 @@
>      |          um: | TODO |
>      |   unicore32: | TODO |
>      |         x86: |  ok  |
> -    |      xtensa: | TODO |
> +    |      xtensa: |  ok  |
>      -----------------------
> diff --git a/Documentation/features/locking/cmpxchg-local/arch-support.txt b/Documentation/features/locking/cmpxchg-local/arch-support.txt
> index 51704a2dc8d1..242ff5a6586e 100644
> --- a/Documentation/features/locking/cmpxchg-local/arch-support.txt
> +++ b/Documentation/features/locking/cmpxchg-local/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: | TODO |
>      |       arm64: |  ok  |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: | TODO |
> diff --git a/Documentation/features/locking/lockdep/arch-support.txt b/Documentation/features/locking/lockdep/arch-support.txt
> index bd39c5edd460..941fd5b1094d 100644
> --- a/Documentation/features/locking/lockdep/arch-support.txt
> +++ b/Documentation/features/locking/lockdep/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: |  ok  |
>      |        ia64: | TODO |
> diff --git a/Documentation/features/locking/queued-rwlocks/arch-support.txt b/Documentation/features/locking/queued-rwlocks/arch-support.txt
> index da7aff3bee0b..c683da198f31 100644
> --- a/Documentation/features/locking/queued-rwlocks/arch-support.txt
> +++ b/Documentation/features/locking/queued-rwlocks/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: | TODO |
>      |       arm64: |  ok  |
>      |         c6x: | TODO |
> +    |        csky: |  ok  |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: | TODO |
> diff --git a/Documentation/features/locking/queued-spinlocks/arch-support.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
> index 478e9101322c..743aa6691715 100644
> --- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
> +++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
> @@ -9,8 +9,9 @@
>      |       alpha: | TODO |
>      |         arc: | TODO |
>      |         arm: | TODO |
> -    |       arm64: | TODO |
> +    |       arm64: |  ok  |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: | TODO |
> diff --git a/Documentation/features/locking/rwsem-optimized/arch-support.txt b/Documentation/features/locking/rwsem-optimized/arch-support.txt
> index e54b1f1a8091..7521d7500fbe 100644
> --- a/Documentation/features/locking/rwsem-optimized/arch-support.txt
> +++ b/Documentation/features/locking/rwsem-optimized/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: |  ok  |
> diff --git a/Documentation/features/perf/kprobes-event/arch-support.txt b/Documentation/features/perf/kprobes-event/arch-support.txt
> index 7331402d1887..86ae33c70475 100644
> --- a/Documentation/features/perf/kprobes-event/arch-support.txt
> +++ b/Documentation/features/perf/kprobes-event/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: |  ok  |
>      |        ia64: | TODO |
> @@ -20,7 +21,7 @@
>      |       nds32: |  ok  |
>      |       nios2: | TODO |
>      |    openrisc: | TODO |
> -    |      parisc: | TODO |
> +    |      parisc: |  ok  |
>      |     powerpc: |  ok  |
>      |       riscv: | TODO |
>      |        s390: |  ok  |
> diff --git a/Documentation/features/perf/perf-regs/arch-support.txt b/Documentation/features/perf/perf-regs/arch-support.txt
> index 53feeee6cdad..687d049d9cee 100644
> --- a/Documentation/features/perf/perf-regs/arch-support.txt
> +++ b/Documentation/features/perf/perf-regs/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: | TODO |
> diff --git a/Documentation/features/perf/perf-stackdump/arch-support.txt b/Documentation/features/perf/perf-stackdump/arch-support.txt
> index 16164348e0ea..90996e3d18a8 100644
> --- a/Documentation/features/perf/perf-stackdump/arch-support.txt
> +++ b/Documentation/features/perf/perf-stackdump/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: | TODO |
> diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> index c7858dd1ea8f..8a521a622966 100644
> --- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> +++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
> @@ -34,6 +34,7 @@
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: | TODO |
> diff --git a/Documentation/features/sched/numa-balancing/arch-support.txt b/Documentation/features/sched/numa-balancing/arch-support.txt
> index c68bb2c2cb62..305601da4c05 100644
> --- a/Documentation/features/sched/numa-balancing/arch-support.txt
> +++ b/Documentation/features/sched/numa-balancing/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: |  ..  |
>      |       arm64: |  ok  |
>      |         c6x: |  ..  |
> +    |        csky: | TODO |
>      |       h8300: |  ..  |
>      |     hexagon: |  ..  |
>      |        ia64: | TODO |
> diff --git a/Documentation/features/seccomp/seccomp-filter/arch-support.txt b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
> index d4271b493b41..4fe6c3c3be5c 100644
> --- a/Documentation/features/seccomp/seccomp-filter/arch-support.txt
> +++ b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: | TODO |
> diff --git a/Documentation/features/time/arch-tick-broadcast/arch-support.txt b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
> index 83d9e68462bb..593536f7925b 100644
> --- a/Documentation/features/time/arch-tick-broadcast/arch-support.txt
> +++ b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: | TODO |
> diff --git a/Documentation/features/time/clockevents/arch-support.txt b/Documentation/features/time/clockevents/arch-support.txt
> index 3d4908fce6da..7a27157da408 100644
> --- a/Documentation/features/time/clockevents/arch-support.txt
> +++ b/Documentation/features/time/clockevents/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
>      |         c6x: |  ok  |
> +    |        csky: |  ok  |
>      |       h8300: |  ok  |
>      |     hexagon: |  ok  |
>      |        ia64: | TODO |
> diff --git a/Documentation/features/time/context-tracking/arch-support.txt b/Documentation/features/time/context-tracking/arch-support.txt
> index c29974afffaa..048bfb6d3872 100644
> --- a/Documentation/features/time/context-tracking/arch-support.txt
> +++ b/Documentation/features/time/context-tracking/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: | TODO |
> diff --git a/Documentation/features/time/irq-time-acct/arch-support.txt b/Documentation/features/time/irq-time-acct/arch-support.txt
> index 8d73c463ec27..a14bbad8e948 100644
> --- a/Documentation/features/time/irq-time-acct/arch-support.txt
> +++ b/Documentation/features/time/irq-time-acct/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: |  ..  |
> diff --git a/Documentation/features/time/modern-timekeeping/arch-support.txt b/Documentation/features/time/modern-timekeeping/arch-support.txt
> index e7c6ea6b8fb3..2855dfe2464d 100644
> --- a/Documentation/features/time/modern-timekeeping/arch-support.txt
> +++ b/Documentation/features/time/modern-timekeeping/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: | TODO |
>      |       arm64: |  ok  |
>      |         c6x: |  ok  |
> +    |        csky: |  ok  |
>      |       h8300: |  ok  |
>      |     hexagon: |  ok  |
>      |        ia64: |  ok  |
> diff --git a/Documentation/features/time/virt-cpuacct/arch-support.txt b/Documentation/features/time/virt-cpuacct/arch-support.txt
> index 4646457461cf..fb0d0cab9cab 100644
> --- a/Documentation/features/time/virt-cpuacct/arch-support.txt
> +++ b/Documentation/features/time/virt-cpuacct/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: |  ok  |
> diff --git a/Documentation/features/vm/ELF-ASLR/arch-support.txt b/Documentation/features/vm/ELF-ASLR/arch-support.txt
> index 1f71d090ff2c..adc25878d217 100644
> --- a/Documentation/features/vm/ELF-ASLR/arch-support.txt
> +++ b/Documentation/features/vm/ELF-ASLR/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: | TODO |
> diff --git a/Documentation/features/vm/PG_uncached/arch-support.txt b/Documentation/features/vm/PG_uncached/arch-support.txt
> index fbd5aa463b0a..f05588f9e4b4 100644
> --- a/Documentation/features/vm/PG_uncached/arch-support.txt
> +++ b/Documentation/features/vm/PG_uncached/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: | TODO |
>      |       arm64: | TODO |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: |  ok  |
> diff --git a/Documentation/features/vm/THP/arch-support.txt b/Documentation/features/vm/THP/arch-support.txt
> index 5d7ecc378f29..cf0393711cbe 100644
> --- a/Documentation/features/vm/THP/arch-support.txt
> +++ b/Documentation/features/vm/THP/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
>      |         c6x: |  ..  |
> +    |        csky: | TODO |
>      |       h8300: |  ..  |
>      |     hexagon: |  ..  |
>      |        ia64: | TODO |
> diff --git a/Documentation/features/vm/TLB/arch-support.txt b/Documentation/features/vm/TLB/arch-support.txt
> index f7af9678eb66..2bdd3b6cee3c 100644
> --- a/Documentation/features/vm/TLB/arch-support.txt
> +++ b/Documentation/features/vm/TLB/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: | TODO |
>      |       arm64: | TODO |
>      |         c6x: |  ..  |
> +    |        csky: | TODO |
>      |       h8300: |  ..  |
>      |     hexagon: | TODO |
>      |        ia64: | TODO |
> diff --git a/Documentation/features/vm/huge-vmap/arch-support.txt b/Documentation/features/vm/huge-vmap/arch-support.txt
> index d0713ccc7117..019131c5acce 100644
> --- a/Documentation/features/vm/huge-vmap/arch-support.txt
> +++ b/Documentation/features/vm/huge-vmap/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: | TODO |
>      |       arm64: |  ok  |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: | TODO |
> diff --git a/Documentation/features/vm/ioremap_prot/arch-support.txt b/Documentation/features/vm/ioremap_prot/arch-support.txt
> index 8527601a3739..c6f3e4d68152 100644
> --- a/Documentation/features/vm/ioremap_prot/arch-support.txt
> +++ b/Documentation/features/vm/ioremap_prot/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: | TODO |
>      |       arm64: | TODO |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: | TODO |
> diff --git a/Documentation/features/vm/numa-memblock/arch-support.txt b/Documentation/features/vm/numa-memblock/arch-support.txt
> index 1a988052cd24..e51cb9f7d166 100644
> --- a/Documentation/features/vm/numa-memblock/arch-support.txt
> +++ b/Documentation/features/vm/numa-memblock/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: |  ..  |
>      |       arm64: |  ok  |
>      |         c6x: |  ..  |
> +    |        csky: | TODO |
>      |       h8300: |  ..  |
>      |     hexagon: |  ..  |
>      |        ia64: |  ok  |
> diff --git a/Documentation/features/vm/pte_special/arch-support.txt b/Documentation/features/vm/pte_special/arch-support.txt
> index a8378424bc98..3d492a34c8ee 100644
> --- a/Documentation/features/vm/pte_special/arch-support.txt
> +++ b/Documentation/features/vm/pte_special/arch-support.txt
> @@ -11,6 +11,7 @@
>      |         arm: |  ok  |
>      |       arm64: |  ok  |
>      |         c6x: | TODO |
> +    |        csky: | TODO |
>      |       h8300: | TODO |
>      |     hexagon: | TODO |
>      |        ia64: | TODO |
> @@ -22,7 +23,7 @@
>      |    openrisc: | TODO |
>      |      parisc: | TODO |
>      |     powerpc: |  ok  |
> -    |       riscv: | TODO |
> +    |       riscv: |  ok  |
>      |        s390: |  ok  |
>      |          sh: |  ok  |
>      |       sparc: |  ok  |
