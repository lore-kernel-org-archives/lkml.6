Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B1AC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 06:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB8020843
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 06:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mfwSAJuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB8020843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeJ0OrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 10:47:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39839 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbeJ0OrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 10:47:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id c25-v6so1540840pfe.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 23:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=sczwW8B+pPyBZ1qmKbBegzuoM/j/WmamFwZgX+JMnh4=;
        b=mfwSAJufxxxk2JwgmZCJ7dz+U/ydiEEjkTeVKMqCjJVau5RJTOyv4v+sRohbCx3evZ
         nmZ/X9PB0H2zr+LBYsMYVAPxNvGYimifgq6qAFnSZ69gELuqUL7Kaa2mRViZJm+uxB9A
         4tKVLAMPh8ji+7k3v1UTMjnKSYZRlp+tQ4z72yKrsKUz2Crtd8fhDic1+sHd8pWBnGg0
         RwgvkMDupHawRhGbOf9oU71W4aVYiMu+dJQdvXCgeRZxURHG2roSNNSJyUcSngWXPg69
         m3xCBpANF5CzOtawt3WYzPF8C9I/k+Ec6ao1ajYC7EN42IhuGu2ZJTi1lJV/OaxjLM2g
         5edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=sczwW8B+pPyBZ1qmKbBegzuoM/j/WmamFwZgX+JMnh4=;
        b=DclQ1Jjk+TWidTebZ+cc/8O9sM4/6ggtMbIFKmAM3xkavWaP6DRURBo9hmp8I2za3+
         Slyo4zf/0M8TrtdJTLyHGTXqLNdgnsHV2cutopQshm21X48LKCXLqsPo6YCq5iUb6GYK
         12eZnGG1UzKZ7DJD2L0p8DCKBC3hTKhxOQOfZ1iwDoJtMmBgr0tZcBJhjiCYM5lJOEcc
         D7rc/qQ5mUWdU0eavcvsskmWLoJ0jeWU6xk496d8ACdF/Fs0+octain7Zj+mTOoGuPNW
         /ef+wT1r/DNOp5DHxtZ/zswo3OVlZMHVbT/YMHT0FodmKdU5zKNGKki9OFNksO5zSLsf
         UQdg==
X-Gm-Message-State: AGRZ1gLNsfc3uV61CeCTtFp4wBGsXR4KoPcxshSMWPgx7gScY9kkpM3z
        D4JAddC7RwgKJKN54BFPwLfaEQ==
X-Google-Smtp-Source: AJdET5cIVAgYokGIFLWsNTg3FsQjU7PS2j4cEJDDNiaSmvMiH/5WxFtqkvOi3fAY6pL7rreaGZXYWw==
X-Received: by 2002:a63:77ce:: with SMTP id s197mr6093007pgc.89.1540620432916;
        Fri, 26 Oct 2018 23:07:12 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
        by smtp.gmail.com with ESMTPSA id e9-v6sm15800833pgl.44.2018.10.26.23.07.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:07:11 -0700 (PDT)
Date:   Fri, 26 Oct 2018 23:07:11 -0700 (PDT)
X-Google-Original-Date: Fri, 26 Oct 2018 22:53:14 PDT (-0700)
Subject:     Re: [PATCH 2/2] RISC-V: Add support for SECCOMP
In-Reply-To: <CAEn-LTovzRncSKCGv8wUTL6FkzcC+Hw1EBGe+Rc4GQyEgcK1uA@mail.gmail.com>
CC:     linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu,
        paul@paul-moore.com, eparis@redhat.com, keescook@chromium.org,
        luto@amacapital.net, wad@chromium.org,
        Wesley Terpstra <wesley@sifive.com>, dhowells@redhat.com,
        tglx@linutronix.de, pombredanne@nexb.com,
        Greg KH <gregkh@linuxfoundation.org>,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     david.abdurachmanov@gmail.com
Message-ID: <mhng-4bae5431-dfdc-4376-9f7a-6c75b91c1eaa@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2018 11:31:30 PDT (-0700), david.abdurachmanov@gmail.com wrote:
> On Wed, Oct 24, 2018 at 10:40 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> From: "Wesley W. Terpstra" <wesley@sifive.com>
>>
>> This is a fairly straight-forward implementation of seccomp for RISC-V
>> systems.
>>
>> Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>> ---
>>  arch/riscv/Kconfig                   | 18 ++++++++++++++++++
>>  arch/riscv/include/asm/seccomp.h     | 10 ++++++++++
>>  arch/riscv/include/asm/syscall.h     |  6 ++++++
>>  arch/riscv/include/asm/thread_info.h |  1 +
>>  include/uapi/linux/audit.h           |  1 +
>>  5 files changed, 36 insertions(+)
>>  create mode 100644 arch/riscv/include/asm/seccomp.h
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index a344980287a5..28abe47602a1 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -28,6 +28,7 @@ config RISCV
>>         select GENERIC_STRNLEN_USER
>>         select GENERIC_SMP_IDLE_THREAD
>>         select GENERIC_ATOMIC64 if !64BIT || !RISCV_ISA_A
>> +       select HAVE_ARCH_SECCOMP_FILTER
>>         select HAVE_MEMBLOCK
>>         select HAVE_MEMBLOCK_NODE_MAP
>>         select HAVE_DMA_CONTIGUOUS
>> @@ -214,6 +215,22 @@ menu "Kernel type"
>>
>>  source "kernel/Kconfig.hz"
>>
>> +config SECCOMP
>> +       bool "Enable seccomp to safely compute untrusted bytecode"
>> +
>> +       help
>> +         This kernel feature is useful for number crunching applications
>> +         that may need to compute untrusted bytecode during their
>> +         execution. By using pipes or other transports made available to
>> +         the process as file descriptors supporting the read/write
>> +         syscalls, it's possible to isolate those applications in
>> +         their own address space using seccomp. Once seccomp is
>> +         enabled via prctl(PR_SET_SECCOMP), it cannot be disabled
>> +         and the task is only allowed to execute a few safe syscalls
>> +         defined by each seccomp mode.
>> +
>> +         If unsure, say Y. Only embedded should say N here.
>> +
>>  endmenu
>>
>>  menu "Bus support"
>> @@ -243,3 +260,4 @@ menu "Power management options"
>>  source kernel/power/Kconfig
>>
>>  endmenu
>> +
>> diff --git a/arch/riscv/include/asm/seccomp.h b/arch/riscv/include/asm/seccomp.h
>> new file mode 100644
>> index 000000000000..c1b4407f1038
>> --- /dev/null
>> +++ b/arch/riscv/include/asm/seccomp.h
>> @@ -0,0 +1,10 @@
>> +/* Copyright 2018 SiFive, Inc. */
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _ASM_RISCV_SECCOMP_H
>> +#define _ASM_RISCV_SECCOMP_H
>> +
>> +#include <asm/unistd.h>
>> +
>> +#include <asm-generic/seccomp.h>
>> +
>> +#endif /* _ASM_RISCV_SECCOMP_H */
>> diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
>> index 8d25f8904c00..d24f774f39df 100644
>> --- a/arch/riscv/include/asm/syscall.h
>> +++ b/arch/riscv/include/asm/syscall.h
>> @@ -19,6 +19,7 @@
>>  #define _ASM_RISCV_SYSCALL_H
>>
>>  #include <linux/sched.h>
>> +#include <uapi/linux/audit.h>
>>  #include <linux/err.h>
>>
>>  /* The array of function pointers for syscalls. */
>> @@ -99,4 +100,9 @@ static inline void syscall_set_arguments(struct task_struct *task,
>>         memcpy(&regs->a1 + i * sizeof(regs->a1), args, n * sizeof(regs->a0));
>>  }
>>
>> +static inline int syscall_get_arch(void)
>> +{
>> +       return AUDIT_ARCH_RISCV;
>> +}
>> +
>>  #endif /* _ASM_RISCV_SYSCALL_H */
>> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
>> index f8fa1cd2dad9..374973dc05c6 100644
>> --- a/arch/riscv/include/asm/thread_info.h
>> +++ b/arch/riscv/include/asm/thread_info.h
>> @@ -80,6 +80,7 @@ struct thread_info {
>>  #define TIF_RESTORE_SIGMASK    4       /* restore signal mask in do_signal() */
>>  #define TIF_MEMDIE             5       /* is terminating due to OOM killer */
>>  #define TIF_SYSCALL_TRACEPOINT  6       /* syscall tracepoint instrumentation */
>> +#define TIF_SECCOMP            7       /* seccomp syscall filtering active */
>>
>>  #define _TIF_SYSCALL_TRACE     (1 << TIF_SYSCALL_TRACE)
>>  #define _TIF_NOTIFY_RESUME     (1 << TIF_NOTIFY_RESUME)
>> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
>> index 818ae690ab79..c16fa1a76659 100644
>> --- a/include/uapi/linux/audit.h
>> +++ b/include/uapi/linux/audit.h
>> @@ -399,6 +399,7 @@ enum {
>>  /* do not define AUDIT_ARCH_PPCLE since it is not supported by audit */
>>  #define AUDIT_ARCH_PPC64       (EM_PPC64|__AUDIT_ARCH_64BIT)
>>  #define AUDIT_ARCH_PPC64LE     (EM_PPC64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
>> +#define AUDIT_ARCH_RISCV       (EM_RISCV)
>>  #define AUDIT_ARCH_S390                (EM_S390)
>>  #define AUDIT_ARCH_S390X       (EM_S390|__AUDIT_ARCH_64BIT)
>>  #define AUDIT_ARCH_SH          (EM_SH)
>
> Palmer,
>
> Half of the patch seems to touch audit parts. I started working on audit
> support this morning, and I can boot Fedora with audit traces.
>
> [root@fedora-riscv ~]# dmesg | grep audit
> [    0.312000] audit: initializing netlink subsys (disabled)
> [    0.316000] audit: type=2000 audit(0.316:1): state=initialized
> audit_enabled=0 res=1
> [    7.288000] audit: type=1130 audit(1529665913.772:2): pid=1 uid=0
> auid=4294967295 ses=4294967295 msg='unit=systemd-remount-fs
> comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=?
> terminal=? res=success'
> [    7.684000] audit: type=1130 audit(1529665914.176:3): pid=1 uid=0
> auid=4294967295 ses=4294967295 msg='unit=systemd-sysctl comm="systemd"
> exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=?
> res=success'
> [..]
>
> I am still working on audit user-space support for better testing.
>
> I suggest we first implement audit and then seccomp.

Works for me.  I'll drop my patch set for now.

Thanks!
