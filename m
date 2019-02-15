Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BD4C10F02
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 23:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB8721927
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 23:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="xvDByweJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389318AbfBOXvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 18:51:25 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35194 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389159AbfBOXvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 18:51:24 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so5545363pgs.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 15:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ljixEpW0gZ8q1YnHTlPoWk2Eh6L0TwTEsaT4eyagjQw=;
        b=xvDByweJXb4S3gbnUsg1x8G0ebkQreu0doW/40wRxbCl4W9TvMhu7njueHX+hzh4An
         PCdBB2+7t7ekjpOPHOmM71kZwmNbROXZWObcWD8wUt0zGJTfWKqSYkZNk9oPt7p7wRQy
         k8gDUHq9kH0KwPDQd9H6MrkIoNv88JzvZVPyVCBknBIYP6W5EljiM3vfiQMOAxD48tgU
         8V0nzOuPxw51PT/6yXDN6+YJG6y5N6pkRdJc58voOxHPqTSM/kN56sek5XlIjVZCNNNz
         dahnCsSbUBOlOAo+Vqe77m7yaE/9vMdAdPJgLd96CmJKhM7ZofhvO0wdubU2WS/np13h
         ZEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ljixEpW0gZ8q1YnHTlPoWk2Eh6L0TwTEsaT4eyagjQw=;
        b=I40NVp1yJL35i9icEON0wXitLiih89b3ycu94HkOXMPs75lNBeC8CV2mP0zeHOqPOG
         8ZTxu/AGyrSkn25l0xoHOlH/kfPSEBtaWN5iDqGmtq7ahVtYvRfkwLGSMeKc046TEOTT
         v/7WLQZ7oU0MpzH1WcTELGU/ydXp5GmdI5vFDqVXyHzylpmNn81FLgncCorI3/qLvPk3
         74vhSY15PW7YC9SsCBC7pOyrYto+nJwOOCc1HjmusY2iMrwXLqDIVcoZ3ydnbMJD9xFB
         KbaDVYzBvQumEWZG32G6RCJuXBxXkVZzcUZ9Yr/J2AovLE4Oqmn1oMViSNiPt0uY23/Z
         ESVg==
X-Gm-Message-State: AHQUAub/eZ9rLtGybEnWX504jYePJ+e4mCI/NSIvQkCTR9yltcXiRitE
        ty08fMsrbc5d2yXgvkf3QlWxVw==
X-Google-Smtp-Source: AHgI3Ib1lisosKADuwdrCaJ6HEQATIuNGDHQ//zLlNpJMjnpB7//vjYDsCaZmHxiucgct84LFnsiNw==
X-Received: by 2002:a62:5287:: with SMTP id g129mr12499257pfb.22.1550274683518;
        Fri, 15 Feb 2019 15:51:23 -0800 (PST)
Received: from ?IPv6:2600:1010:b061:1c16:6868:625e:8d68:5c84? ([2600:1010:b061:1c16:6868:625e:8d68:5c84])
        by smtp.gmail.com with ESMTPSA id s2sm14664206pfa.167.2019.02.15.15.51.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 15:51:22 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access kernel memory that can fault
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <20190215171539.4682f0b4@gandalf.local.home>
Date:   Fri, 15 Feb 2019 15:49:35 -0800
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <300C4516-A093-43AE-8707-1C42486807A4@amacapital.net>
References: <20190215174712.372898450@goodmis.org> <20190215174945.557218316@goodmis.org> <CAHk-=wjP4bEYCFaKZVG4kLWmYBctyfsW9jjhC91tiTk9WwB8Rg@mail.gmail.com> <20190215171539.4682f0b4@gandalf.local.home>
To:     Steven Rostedt <rostedt@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 15, 2019, at 2:15 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Fri, 15 Feb 2019 09:55:32 -0800
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>=20
>>> On Fri, Feb 15, 2019 at 9:49 AM Steven Rostedt <rostedt@goodmis.org> wro=
te:
>>>=20
>>> From: Changbin Du <changbin.du@gmail.com>
>>>=20
>>> The userspace can ask kprobe to intercept strings at any memory address,=

>>> including invalid kernel address. =20
>>=20
>> Again, this is not about a "kernel address" at all.
>>=20
>> It's neither a kernel address _nor_ a user address.  It's an invalid
>> address entirely, and there is nothing that makes it "kernel".
>>=20
>> Please don't talk about "invalid kernel addresses" when it is no such thi=
ng.
>>=20
>=20
> Ah, I see what you are saying. The example of the bug that the patch
> fixed used a non-canonical address, which is "garbage", and not kernel
> or user space. Point taken.
>=20
> But the issue is deeper than that. This code never bugged until the
> following commit was added:
>=20
> 9da3f2b7405 "x86/fault: BUG() when uaccess helpers fault on kernel address=
es"
>=20
> Before that commit, this worked fine.
>=20
> In fact, we can trigger the same bug (with a slightly different
> message), if we use a kernel space address.
>=20
> To test this, I added the following variable somewhere in the code:
>=20
> void *sdr_ptr =3D 0xffffffff70112200;
>=20
> And then did the following:
>=20
> # echo 'p:fault do_sys_open arg=3D+0(@sdr_ptr):string' > /debug/tracing/kp=
robe_events
>=20
> Which will read the sdr_ptr variable just like the example did with +0(+0(=
%si)):string.
> But this time I control the what address it is triggered on.
>=20
> And it crashed with:
>=20
> [ 1447.876799] BUG: pagefault on kernel address 0xffffffff70112200 in non-=
whitelisted uaccess
>=20
> The above message in the bug in the patch was:
> "BUG: GPF in non-whitelisted uaccess (non-canonical address?)"
>=20
> [ 1447.885053] BUG: unable to handle kernel paging request at ffffffff7011=
2200
> [ 1447.891997] #PF error: [normal kernel read fault]
> [ 1447.896695] PGD 8a212067 P4D 8a212067 PUD 0=20
> [ 1447.900679] BUG: pagefault on kernel address 0xffffffff70112200 in non-=
whitelisted uaccess
> [ 1447.900967] Oops: 0000 [#1] PREEMPT SMP PTI
> [ 1447.913394] CPU: 7 PID: 1688 Comm: cat Not tainted 5.0.0-rc5-test+ #28
> [ 1447.919905] Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A,=
 BIOS K01 v03.03 07/14/2016
> [ 1447.928843] RIP: 0010:process_fetch_insn+0x1a0/0x470
> [ 1447.933804] Code: ff f0 80 48 03 80 83 80 18 1a 00 00 01 31 c9 eb 10 48=
 83 c2 01 85 c0 75 1f 81 f9 ff 0f 00 00 7f 17 0f 1f 00 0f ae e8 44 89 e0 <40=
> 8a 32 0f 1f 00 83 c1 01 40 84 f6 75 d9 65 48 8b 14 25 00 5c 01
> [ 1447.952520] RSP: 0018:ffffb77b80673d08 EFLAGS: 00010246
> [ 1447.957736] RAX: 0000000000000000 RBX: ffff91bfb7ab2c30 RCX: 0000000000=
000000
> [ 1447.964857] RDX: ffffffff70112200 RSI: ffffffff97267a80 RDI: 00007fffff=
fff000
> [ 1447.971981] RBP: 0000000000000000 R08: ffffffff70112200 R09: ffff91c014=
518000
> [ 1447.979105] R10: ffff91c01451801c R11: ffff91c0185e5800 R12: 0000000000=
000000
> [ 1447.986226] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000=
000000
> [ 1447.993342] FS:  0000000000000000(0000) GS:ffff91c01a9c0000(0000) knlGS=
:0000000000000000
> [ 1448.001417] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1448.007157] CR2: ffffffff70112200 CR3: 00000000b3f32004 CR4: 0000000000=
1606e0
> [ 1448.014280] Call Trace:
> [ 1448.016737]  kprobe_trace_func+0x278/0x360
> [ 1448.020834]  ? preempt_count_sub+0x98/0xe0
> [ 1448.024931]  ? do_sys_open+0x5/0x220
> [ 1448.028503]  kprobe_dispatcher+0x36/0x50
> [ 1448.032426]  ? do_sys_open+0x1/0x220
> [ 1448.036002]  kprobe_ftrace_handler+0xb5/0x120
> [ 1448.040356]  ftrace_ops_assist_func+0x87/0x110
> [ 1448.044797]  0xffffffffc06a30bf
> [ 1448.047939]  ? __ia32_sys_open+0x20/0x20
> [ 1448.051860]  ? do_syscall_64+0x1c/0x160
> [ 1448.055694]  ? do_sys_open+0x1/0x220
> [ 1448.059268]  do_sys_open+0x5/0x220
> [ 1448.062672]  do_syscall_64+0x60/0x160
> [ 1448.066335]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>=20
> Which triggered on the address: 0xffffffff70112200
>=20
> Which is perfectly canonical.
>=20
> The reason I use "kernel address" is because this became an issue after
> "x86/fault: BUG() when uaccess helpers fault on kernel addresses" was
> added and that explicitly states "kernel address".
>=20
> That patch added:
>=20
> +       /*
> +        * This is a faulting memory access in kernel space, on a kernel
> +        * address, in a usercopy function. This can e.g. be caused by imp=
roper
> +        * use of helpers like __put_user and by improper attempts to acce=
ss
> +        * userspace addresses in KERNEL_DS regions.
> +        * The one (semi-)legitimate exception are probe_kernel_{read,writ=
e}(),
> +        * which can be invoked from places like kgdb, /dev/mem (for readi=
ng)
> +        * and privileged BPF code (for reading).
> +        * The probe_kernel_*() functions set the kernel_uaccess_faults_ok=
 flag
> +        * to tell us that faulting on kernel addresses, and even noncanon=
ical
> +        * addresses, in a userspace accessor does not necessarily imply a=

> +        * kernel bug, root might just be doing weird stuff.
> +        */
> +       if (current->kernel_uaccess_faults_ok)
> +               return false;
> +
> +       /* This is bad. Refuse the fixup so that we go into die(). */
> +       if (trapnr =3D=3D X86_TRAP_PF) {
> +               pr_emerg("BUG: pagefault on kernel address 0x%lx in non-wh=
itelisted uaccess\n",
> +                        fault_addr);
> +       } else {
> +               pr_emerg("BUG: GPF in non-whitelisted uaccess (non-canonic=
al address?)\n");
> +       }
>=20
> Where this path triggered by the kprobe using copy_from_user(). So
> yeah, it can happen if it triggered on a non-canonical address (which is
> just garbage), but it can also trigger if it's a kernel address that
> isn't mapped either.
>=20
> So the comment in the code is not 100% accurate, because it isn't just
> a kernel address, but also a non-canonical one. Something tells me that
> the change log of the commit that checks this isn't written well
> either. What exactly can't be done now with uaccess code? I'm guessing
> that it should only be allowed to fault on user space addresses? So
> should I change this commit log to:
>=20
> kprobe: Do not use uaccess function to access non-user address that can fa=
ult
>=20
> And change all the "kernel address" mentions to "non-user address" as
> non-user covers both kernel address and non-canonical?
>=20
>=20
> -- Steve
>=20
> This patch allows me to modify the sdr_ptr as well from the tracing direct=
ory:
>=20
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 2cf3c747a357..292fe2ef0a45 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -7928,6 +7928,45 @@ static const struct file_operations buffer_percent_=
fops =3D {
>    .llseek        =3D default_llseek,
> };
>=20
> +void *sdr_ptr =3D 0xffffffff70112200;
> +
> +static ssize_t
> +sdr_ptr_read(struct file *filp, char __user *ubuf,
> +           size_t cnt, loff_t *ppos)
> +{
> +    char buf[64];
> +    int r;
> +
> +    r =3D sprintf(buf, "%px\n", sdr_ptr);
> +
> +    return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
> +}
> +
> +static ssize_t
> +sdr_ptr_write(struct file *filp, const char __user *ubuf,
> +        size_t cnt, loff_t *ppos)
> +{
> +    unsigned long val;
> +    int ret;
> +
> +    ret =3D kstrtoul_from_user(ubuf, cnt, 0, &val);
> +    if (ret)
> +        return ret;
> +
> +    sdr_ptr =3D val;
> +
> +    (*ppos)++;
> +
> +    return cnt;
> +}
> +
> +static const struct file_operations sdr_ptr_fops =3D {
> +    .open        =3D tracing_open_generic,
> +    .read        =3D sdr_ptr_read,
> +    .write        =3D sdr_ptr_write,
> +    .llseek        =3D default_llseek,
> +};
> +
> struct dentry *trace_instance_dir;
>=20
> static void
> @@ -8188,6 +8227,9 @@ init_tracer_tracefs(struct trace_array *tr, struct d=
entry *d_tracer)
>    struct trace_event_file *file;
>    int cpu;
>=20
> +    trace_create_file("sdr_ptr", 0644, d_tracer,
> +            NULL, &sdr_ptr_fops);
> +
>    trace_create_file("available_tracers", 0444, d_tracer,
>            tr, &show_traces_fops);
>=20


I=E2=80=99m missing most of the context here, but even probe_kernel_...() is=
 unwise for a totally untrustworthy address. It could be MMIO, for example.

If needed, we could come up with a safe-ish helper for tracing.  For direct-=
map addresses, probe_kernel_...() is probably okay.  Same for the current st=
ack. Otherwise we could walk the page tables and check that the address is c=
acheable, I suppose, although this is slightly dubious if we don=E2=80=99t a=
lso check MTRRs. We could also check that the PA is in main memory, I suppos=
e, although this may have unfortunate interactions with the MCE code.=
