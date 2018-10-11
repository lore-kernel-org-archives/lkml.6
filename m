Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0819FC677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14012075B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 20:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IRnY2REQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B14012075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeJLEY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 00:24:56 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:40593 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbeJLEY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 00:24:56 -0400
Received: by mail-yb1-f195.google.com with SMTP id w7-v6so4159106ybm.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 13:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xhdlW9MnzJZrJ1pC8eL3uOGXJT7PaJJkKhL6cjwk868=;
        b=IRnY2REQEVvHG0GF+NWwi2s7Qi+NGGoNLq6dLtl23zuk5KMUBHbbtBzVSqdPkGI50y
         px3fz7ZtTPHWn9E8QmJO+zDQ95/u+8IvenOJTwBApdlxrTwERRCAMtabYD9eWMKDjhrx
         xc93H72UF3KaU/Aec9NWOHAvZdMZu65t67xGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xhdlW9MnzJZrJ1pC8eL3uOGXJT7PaJJkKhL6cjwk868=;
        b=jzkoxiklZmfhmLsaGqcDK13PCgYvpmZlGcmJpD2cg37vshG5lfzbhYvDPxA5068PZ6
         oz6aks6b5xR3YnWmp8jL4sAsiIT5ws2hKnIyjLymCumNkEkdCOATtnsQ47Yw7ck8Z1Ev
         vXzl+p8AR6h25nqi3lcRGiMOIRXuTTcO7ldjvf+l0Dl8pwmuBmtjegIc1yYllXXtJfuy
         AHW3+gVGQe+KOQ9H106SSlSNOuWnucd8ucIPtLZMec7VHgPxDZcHaGcGBVpKRGy7DtLP
         OXIKemte4PW5kZLwI9GvdEYHwnMWH/djk/0N8/G3meUwKHaPHQdaVhuL/9gxPcQvGm/E
         2TRA==
X-Gm-Message-State: ABuFfojqD82aqZ4iyurBNwytl4RGuzne99jz35uvV9kXSaZFgSN3nnCL
        xbxa4M4/ElE+HuQ8RdWdSSTkx9ce/fY=
X-Google-Smtp-Source: ACcGV60qlt5iMkLNATJ7lR6JXgF0gP1pFbgCRcLhrtTZ+iiO0HufF16WhA92grPBnkkhudgfuSlpQA==
X-Received: by 2002:a25:b306:: with SMTP id l6-v6mr1805157ybj.8.1539291355858;
        Thu, 11 Oct 2018 13:55:55 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id q6-v6sm5249860ywh.41.2018.10.11.13.55.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 13:55:54 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 5-v6so4168391ybf.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 13:55:54 -0700 (PDT)
X-Received: by 2002:a25:2395:: with SMTP id j143-v6mr1823975ybj.137.1539291353539;
 Thu, 11 Oct 2018 13:55:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 13:55:51
 -0700 (PDT)
In-Reply-To: <CALCETrVaZu2eq67ai0Oh=HWyZKg-OaoZx7yUT2AvStAhQ+rxyQ@mail.gmail.com>
References: <20181011185458.10186-1-kristen@linux.intel.com> <CALCETrVaZu2eq67ai0Oh=HWyZKg-OaoZx7yUT2AvStAhQ+rxyQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 11 Oct 2018 13:55:51 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLWO1StCz2ejBPW-p4B5XHEKdCGvOi1JKrKxg5UFSa3Ag@mail.gmail.com>
Message-ID: <CAGXu5jLWO1StCz2ejBPW-p4B5XHEKdCGvOi1JKrKxg5UFSa3Ag@mail.gmail.com>
Subject: Re: [PATCH] x86: entry: flush the cache if syscall error
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 1:48 PM, Andy Lutomirski <luto@kernel.org> wrote:
> On Thu, Oct 11, 2018 at 11:55 AM Kristen Carlson Accardi
> <kristen@linux.intel.com> wrote:
>>
>> This patch aims to make it harder to perform cache timing attacks on data
>> left behind by system calls. If we have an error returned from a syscall,
>> flush the L1 cache.
>>
>> It's important to note that this patch is not addressing any specific
>> exploit, nor is it intended to be a complete defense against anything.
>> It is intended to be a low cost way of eliminating some of side effects
>> of a failed system call.
>>
>> A performance test using sysbench on one hyperthread and a script which
>> attempts to repeatedly access files it does not have permission to access
>> on the other hyperthread found no significant performance impact.
>>
>> Suggested-by: Alan Cox <alan@linux.intel.com>
>> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
>> ---
>>  arch/x86/Kconfig        |  9 +++++++++
>>  arch/x86/entry/common.c | 18 ++++++++++++++++++
>>  2 files changed, 27 insertions(+)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 1a0be022f91d..bde978eb3b4e 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -445,6 +445,15 @@ config RETPOLINE
>>           code are eliminated. Since this includes the syscall entry path,
>>           it is not entirely pointless.
>>
>> +config SYSCALL_FLUSH
>> +       bool "Clear L1 Cache on syscall errors"
>> +       default n
>> +       help
>> +         Selecting 'y' allows the L1 cache to be cleared upon return of
>> +         an error code from a syscall if the CPU supports "flush_l1d".
>> +         This may reduce the likelyhood of speculative execution style
>> +         attacks on syscalls.
>> +
>>  config INTEL_RDT
>>         bool "Intel Resource Director Technology support"
>>         default n
>> diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
>> index 3b2490b81918..26de8ea71293 100644
>> --- a/arch/x86/entry/common.c
>> +++ b/arch/x86/entry/common.c
>> @@ -268,6 +268,20 @@ __visible inline void syscall_return_slowpath(struct pt_regs *regs)
>>         prepare_exit_to_usermode(regs);
>>  }
>>
>> +__visible inline void l1_cache_flush(struct pt_regs *regs)
>> +{
>> +       if (IS_ENABLED(CONFIG_SYSCALL_FLUSH) &&
>> +           static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
>> +               if (regs->ax == 0 || regs->ax == -EAGAIN ||
>> +                   regs->ax == -EEXIST || regs->ax == -ENOENT ||
>> +                   regs->ax == -EXDEV || regs->ax == -ETIMEDOUT ||
>> +                   regs->ax == -ENOTCONN || regs->ax == -EINPROGRESS)
>
> What about ax > 0?  (Or more generally, any ax outside the range of -1
> .. -4095 or whatever the error range is.)  As it stands, it looks like
> you'll flush on successful read(), write(), recv(), etc, and that
> could seriously hurt performance on real workloads.

Seems like just changing this with "ax == 0" into "ax >= 0" would solve that?

I think this looks like a good idea. It might be worth adding a
comment about the checks to explain why those errors are whitelisted.
It's a cheap and effective mitigation for "unknown future problems"
that doesn't degrade normal workloads.

>> +                       return;
>> +
>> +               wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);

What about CPUs without FLUSH_L1D? Could it be done manually with a
memcpy or something?

-Kees

>> +       }
>> +}
>> +
>>  #ifdef CONFIG_X86_64
>>  __visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
>>  {
>> @@ -290,6 +304,8 @@ __visible void do_syscall_64(unsigned long nr, struct pt_regs *regs)
>>                 regs->ax = sys_call_table[nr](regs);
>>         }
>>
>> +       l1_cache_flush(regs);
>> +
>>         syscall_return_slowpath(regs);
>>  }
>>  #endif
>> @@ -338,6 +354,8 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs)
>>  #endif /* CONFIG_IA32_EMULATION */
>>         }
>>
>> +       l1_cache_flush(regs);
>> +
>>         syscall_return_slowpath(regs);
>>  }
>>
>> --
>> 2.14.4
>>



-- 
Kees Cook
Pixel Security
