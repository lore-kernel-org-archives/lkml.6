Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027E6C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7470C2087D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 21:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bTfdIjy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7470C2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbeH2Bpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 21:45:33 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41423 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeH2Bpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 21:45:32 -0400
Received: by mail-yw1-f67.google.com with SMTP id q129-v6so1206487ywg.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 14:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2mUO+6p71qJ47s6dAFSw2KyBYNl++qRtdxlrYSBrEq8=;
        b=bTfdIjy/CCSumSrxbYT6dO9diT7rS2SPLXPDBenY/fNypDnSosSftnd7L7AdJdTER1
         NNabcRLbz6vA/iKrP0kHBUQAZhg58tGmqsgf8M2swulo4u1HVDG2ho0fInWNYcVWupFT
         Ap8r6zCff+CKUZCnMQ0ukGvYBMqeDFSuzlcZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2mUO+6p71qJ47s6dAFSw2KyBYNl++qRtdxlrYSBrEq8=;
        b=RWPe97m9BGcKkpzmpHzr2x/tL6LnscL3t/U9AjgTfYSMqASCvR6EIBuzniBqYsg4eG
         jvqes9Adn8RjHFRj2n7PeFKQBfV8tKW9sF667JloqXHhM5hdnQLdaSHWoyYwjTmAuk5+
         mrGziH8+iKCBJ9hUbo4IHSKIAPa77e8k5cV7UjFK2X6XEO7VwPYZWx0PsX7+6bjHLIWg
         BYkKdjsOxVBqSGzOzyo82THsdyU11XAN+p+hRiaQzV+YCExZSap/bkw2weUm5PbA65ov
         qCaCHHoR3gLvl+uDaBb8Pkm/gPJtWcGMBs7+Rst1siUba8Z7nRcK9tAGp14KNnBlsHDY
         Kegw==
X-Gm-Message-State: APzg51AnhUPAk4d+kQEKnrUl9VJnGF8Sh9XGXaYO68LO+Vrxtw1ZG6z7
        JNmHRD/cQgtijR2lG0AaIRwIAcLXg48=
X-Google-Smtp-Source: ANB0VdY+pzS/0BuR33XPZMKF3bk0ISnQaSmCvn3sczlX9gN/BeUFbVCTf4KVhtftUg0ntYuYwx6fig==
X-Received: by 2002:a0d:df83:: with SMTP id i125-v6mr1882968ywe.151.1535493114887;
        Tue, 28 Aug 2018 14:51:54 -0700 (PDT)
Received: from mail-yb0-f181.google.com (mail-yb0-f181.google.com. [209.85.213.181])
        by smtp.gmail.com with ESMTPSA id t2-v6sm2469532ywd.99.2018.08.28.14.51.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 14:51:52 -0700 (PDT)
Received: by mail-yb0-f181.google.com with SMTP id f4-v6so1219405ybp.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 14:51:52 -0700 (PDT)
X-Received: by 2002:a25:f606:: with SMTP id t6-v6mr1914133ybd.141.1535493111817;
 Tue, 28 Aug 2018 14:51:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:2c11:0:0:0:0:0 with HTTP; Tue, 28 Aug 2018 14:51:51
 -0700 (PDT)
In-Reply-To: <20180828201421.157735-1-jannh@google.com>
References: <20180828201421.157735-1-jannh@google.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 28 Aug 2018 14:51:51 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLHRzMMbpUmcFP3hqXamUsWkCAwnoQgEp3xaZ-_R9yzXQ@mail.gmail.com>
Message-ID: <CAGXu5jLHRzMMbpUmcFP3hqXamUsWkCAwnoQgEp3xaZ-_R9yzXQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] x86: BUG() on #GP / kernel #PF in uaccess
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 1:14 PM, Jann Horn <jannh@google.com> wrote:
> This is the third version of "[RFC PATCH 1/2] x86: WARN() when uaccess
> helpers fault on kernel addresses".
>
> Changes since v2:
>  - patch 1: avoid unnecessary branch on return value and split up the
>    checks (Borislav Petkov)
>  - patch 5: really plumb the error code through to the handlers (Andy)
>  - patch 6: whitelist exact_copy_from_user(), at least for now - the
>    alternative would be a somewhat complicated refactor (Kees Cook)
>
> Expanding on the change in patch 6:
> I believe that for now, whitelisting exact_copy_from_user() is
> acceptable, since there aren't many places that call ksys_mount() under
> KERNEL_DS.
> I very much dislike copy_mount_options()/exact_copy_from_user() and want
> to do something about that code at some point - in particular because it
> currently silently truncates mount options, which seems like a bad idea
> security-wise
> (https://github.com/libfuse/libfuse/commit/34c62ee90c69) -, but I don't
> want to block this series on that.
>
> I hope that exact_copy_from_user() was the only place that does this
> kind of thing under KERNEL_DS - if there might be more places like this,
> it may be necessary for now to change the "return true;" in
> bogus_uaccess() to "WARN(1, ...); return false;" for now, and make it a
> "return true" later. Does anyone have opinions on this?
>
> This time I've actually also boot-tested a build with vmapped stack, not
> just a KASAN build. (It's annoying that those are mutually exclusive...)
> Kees, I hope you can cleanly boot with this series applied now?
>
>
> See patch 6/7 ("x86: BUG() when uaccess helpers fault on kernel
> addresses") for a description of the motivation for this series.
>
> Patches 1 and 2 are cleanups that I did while working on this
> series, but the series doesn't depend on them. (I first thought these
> cleanups were necessary for the rest of the series, then noticed that
> they actually aren't, but decided to keep them since cleanups are good
> anyway.)
>
> Patches 3, 4 and 5 are prep work; 4 and 5 are loosely based on code
> from the v1 patch. They've changed quite a bit though.
>
> Patch 6 is the main semantic change.
>
> Patch 7 is a small testcase for verifying that patch 6 works.
>
> Jann Horn (7):
>   x86: refactor kprobes_fault() like kprobe_exceptions_notify()
>   x86: inline kprobe_exceptions_notify() into do_general_protection()
>   x86: stop calling fixup_exception() from kprobe_fault_handler()
>   x86: introduce _ASM_EXTABLE_UA for uaccess fixups
>   x86: plumb error code and fault address through to fault handlers
>   x86: BUG() when uaccess helpers fault on kernel addresses
>   lkdtm: test copy_to_user() on bad kernel pointer under KERNEL_DS

I've done boot tests and tried probing it the earlier waitid() flaw
with the fix reverted and it correctly Oops when touching unmapped
kernel memory. Please consider the series:

Tested-by: Kees Cook <keescook@chromium.org>

-Kees

>
>  arch/x86/include/asm/asm.h          |  10 ++-
>  arch/x86/include/asm/extable.h      |   3 +-
>  arch/x86/include/asm/fpu/internal.h |   2 +-
>  arch/x86/include/asm/futex.h        |   6 +-
>  arch/x86/include/asm/ptrace.h       |   2 +
>  arch/x86/include/asm/uaccess.h      |  22 ++---
>  arch/x86/kernel/cpu/mcheck/mce.c    |   2 +-
>  arch/x86/kernel/kprobes/core.c      |  38 +--------
>  arch/x86/kernel/traps.c             |  16 +++-
>  arch/x86/lib/checksum_32.S          |   4 +-
>  arch/x86/lib/copy_user_64.S         |  90 ++++++++++----------
>  arch/x86/lib/csum-copy_64.S         |   8 +-
>  arch/x86/lib/getuser.S              |  12 +--
>  arch/x86/lib/putuser.S              |  10 +--
>  arch/x86/lib/usercopy_32.c          | 126 ++++++++++++++--------------
>  arch/x86/lib/usercopy_64.c          |   4 +-
>  arch/x86/mm/extable.c               | 114 +++++++++++++++++++++----
>  arch/x86/mm/fault.c                 |  26 +++---
>  drivers/misc/lkdtm/core.c           |   1 +
>  drivers/misc/lkdtm/lkdtm.h          |   1 +
>  drivers/misc/lkdtm/usercopy.c       |  13 +++
>  fs/namespace.c                      |   2 +
>  include/linux/sched.h               |   6 ++
>  mm/maccess.c                        |   6 ++
>  24 files changed, 314 insertions(+), 210 deletions(-)
>
> --
> 2.19.0.rc0.228.g281dcd1b4d0-goog
>



-- 
Kees Cook
Pixel Security
