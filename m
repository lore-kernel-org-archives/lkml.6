Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DF4ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 06:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 151B52085B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 06:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BOuWSG/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 151B52085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbeJ0OrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 10:47:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41750 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbeJ0OrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 10:47:13 -0400
Received: by mail-pl1-f193.google.com with SMTP id p5-v6so1432768plq.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 23:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=4MgGyHpaFljNUU/NS+lIwkQShtcjMjXMnCBswOpfcyA=;
        b=BOuWSG/bJyfqcClS6UEIDrOy0bZ7Go4PKrerBjvaIyECq0wv7GW3AnTOvTp4dk+081
         GvIm0h09dRsBsnjJhx/ejMwSJPVTS1D4dcUxmM4cIYHfyEKzO9+ZoWDqkbLC/i/n6cxG
         0f+sUBXkErdo8K9tDyTyozaS6gt+Sc60fY/klpyrB0StMFxiasfPXSKYv2zim1bmKZCE
         A0fNxaFdoV3v+UJacQzgufaJ3b23+mMI48H9WO6iHfZWzg+jARN/e/WGDG7f4D4IbzJD
         UT7aOc5i136a/67pHqlEvKNrFHpY9VDYs4ubMzzY3g06fxFvyzKgh14k5dUAdKDEQvQn
         /Tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=4MgGyHpaFljNUU/NS+lIwkQShtcjMjXMnCBswOpfcyA=;
        b=tuYzQ8/IR7g33qWxzlW9BUL20c8wmFDmfftwKAzZNnW2YYL3WvSNqi8LEfvMRnc+cn
         00OUzMLbUxGDE+U0tvmaiv38W6uPUw+GMRVkU/m+LyiMckZ2u8ccdtkNvM1F4FQlc6DZ
         jlWmVB0C/Ff/39fl+MXPLDv43dh5P2svyLFg/nxlf+ri8ctU/cSiP9jfr+Gm7OEcssCO
         datPH1zWmEfwEifomiNEz9E13rAsY20pkvjKLsewF7BXDaPSd+FK01ly3r6sHfCELlYY
         PjeVzpZsR3L99eOgfDrR+OSC3cDANtpSic/BhBeRIeVzMtF/piBvKDV4MJdbUT9FrTDL
         VIFA==
X-Gm-Message-State: AGRZ1gJnqJjql+NHE0sSqIxAt8OX7BD5zwtezFYQ863cpRf+M3OZ36kw
        0zew/ApPIidWUl0h/y2YfbyhLA==
X-Google-Smtp-Source: AJdET5fQ+cjgrmKRWKK5AJZeON3QZshDMwNsZ57mE66nZhv8tR27WOvlvam+15+pDGF1MMCQDCE8ag==
X-Received: by 2002:a17:902:a584:: with SMTP id az4-v6mr4124547plb.46.1540620442018;
        Fri, 26 Oct 2018 23:07:22 -0700 (PDT)
Received: from localhost (c-67-161-15-180.hsd1.ca.comcast.net. [67.161.15.180])
        by smtp.gmail.com with ESMTPSA id m12-v6sm7313307pgd.81.2018.10.26.23.07.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 23:07:20 -0700 (PDT)
Date:   Fri, 26 Oct 2018 23:07:20 -0700 (PDT)
X-Google-Original-Date: Fri, 26 Oct 2018 23:00:34 PDT (-0700)
Subject:     Re: [PATCH 2/2] RISC-V: Add support for SECCOMP
In-Reply-To: <CALCETrUSvugnh1JiLgn49c4_dw6F8bXiO52jdqiAKEn-CgzoXA@mail.gmail.com>
CC:     keescook@chromium.org, linux-riscv@lists.infradead.org,
        aou@eecs.berkeley.edu, paul@paul-moore.com, eparis@redhat.com,
        wad@chromium.org, Wesley Terpstra <wesley@sifive.com>,
        dhowells@redhat.com, tglx@linutronix.de, pombredanne@nexb.com,
        Greg KH <gregkh@linuxfoundation.org>,
        kstewart@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com, david.abdurachmanov@gmail.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     luto@amacapital.net
Message-ID: <mhng-d334eb95-7c80-4070-a053-d04e9b564b74@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2018 14:02:20 PDT (-0700), luto@amacapital.net wrote:
> On Wed, Oct 24, 2018 at 2:42 PM Kees Cook <keescook@chromium.org> wrote:
>>
>> On Wed, Oct 24, 2018 at 1:40 PM, Palmer Dabbelt <palmer@sifive.com> wrote:
>> > From: "Wesley W. Terpstra" <wesley@sifive.com>
>> >
>> > This is a fairly straight-forward implementation of seccomp for RISC-V
>> > systems.
>> >
>> > Signed-off-by: Wesley W. Terpstra <wesley@sifive.com>
>> > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>> > ---
>> >  arch/riscv/Kconfig                   | 18 ++++++++++++++++++
>> >  arch/riscv/include/asm/seccomp.h     | 10 ++++++++++
>> >  arch/riscv/include/asm/syscall.h     |  6 ++++++
>> >  arch/riscv/include/asm/thread_info.h |  1 +
>> >  include/uapi/linux/audit.h           |  1 +
>> >  5 files changed, 36 insertions(+)
>> >  create mode 100644 arch/riscv/include/asm/seccomp.h
>> >
>> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> > index a344980287a5..28abe47602a1 100644
>> > --- a/arch/riscv/Kconfig
>> > +++ b/arch/riscv/Kconfig
>> > @@ -28,6 +28,7 @@ config RISCV
>> >         select GENERIC_STRNLEN_USER
>> >         select GENERIC_SMP_IDLE_THREAD
>> >         select GENERIC_ATOMIC64 if !64BIT || !RISCV_ISA_A
>> > +       select HAVE_ARCH_SECCOMP_FILTER
>>
>> I think this patch is missing most of the actual seccomp glue?
>>
>> config HAVE_ARCH_SECCOMP_FILTER
>>         bool
>>         help
>>           An arch should select this symbol if it provides all of these things:
>>           - syscall_get_arch()
>>           - syscall_get_arguments()
>>           - syscall_rollback()
>>           - syscall_set_return_value()
>>           - SIGSYS siginfo_t support
>>           - secure_computing is called from a ptrace_event()-safe context
>>           - secure_computing return value is checked and a return value of -1
>>             results in the system call being skipped immediately.
>>           - seccomp syscall wired up
>>
>> I only see syscall_get_arch(). Nothing is using TIF_SECCOMP (I'd
>> expect a masked check in entry.S -- it seems like tracepoints are
>> getting missed too? I see it handled in ptrace.c but not checked in
>> entry.S?) There's no checking for seccomp in ptrace.c, etc.
>
> Hi RISC-V people:
>
> I strongly, strongly suggest that you rewrite your asm to work the way
> that x86's does: have a function called prepare_exit_to_usermode() and
> make it work more or less like x86's.  Doing all the exit work in asm
> like you are is just setting you up for a world of pain.

OK, thanks for the suggestion.  Next time we have to change it I'll try to take 
a look and figure out something sane.
