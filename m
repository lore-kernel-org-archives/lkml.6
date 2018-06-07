Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id TxFvGR6bGVteLwAAmS7hNA
	; Thu, 07 Jun 2018 20:54:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EAD65608BA; Thu,  7 Jun 2018 20:54:00 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cP6MLTon"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5AF74605A2;
	Thu,  7 Jun 2018 20:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5AF74605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932514AbeFGUx6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:53:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753260AbeFGUx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:53:56 -0400
Received: from mail-wr0-f178.google.com (mail-wr0-f178.google.com [209.85.128.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90A76208B2
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jun 2018 20:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528404835;
        bh=kIDoHe33oqzBtjUlSVvhJ4ihMwGu5pSiq6i65T1FsKg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cP6MLTonwjWllFuTqgglaTDFopBrXji1V36oapxPoHSZnnQzU9agXTdPOVkUDalOq
         FBrn+VzNCBHds2T4Pk8UWxptDIhj3KyP8/ibsQhGRBLRYKcswxVQde8C8tLuA6wkWP
         nzBd7LPhd5geDvpmTwJZ4V3gzEH5+GZ5YJBcag/A=
Received: by mail-wr0-f178.google.com with SMTP id h10-v6so11183584wrq.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 13:53:55 -0700 (PDT)
X-Gm-Message-State: APt69E1HH0IYSyURzy5+7I61anUBLoM6ZNzW7DIh+5FrCKuPoCmppNZ8
        4cMFWgje3DxePfGb0C1xe/dGFH+zcW03ojV/MroImw==
X-Google-Smtp-Source: ADUXVKLb27aOdI3cXj/aiBarJeE7VxabjGgMyFbwvVO2fXh+uCsbeFGBHedIKvyNC98F8bMWLI1bgFvofpIZOP0KTWI=
X-Received: by 2002:adf:b445:: with SMTP id v5-v6mr2780352wrd.67.1528404833918;
 Thu, 07 Jun 2018 13:53:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-5-yu-cheng.yu@intel.com>
 <CALCETrUqXvh2FDXe6bveP10TFpzptEyQe2=mdfZFGKU0T+NXsA@mail.gmail.com> <3c1bdf85-0c52-39ed-a799-e26ac0e52391@redhat.com>
In-Reply-To: <3c1bdf85-0c52-39ed-a799-e26ac0e52391@redhat.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 7 Jun 2018 13:53:41 -0700
X-Gmail-Original-Message-ID: <CALCETrWPDXpbVcuFK_1M5DtaCOW_LSf-XHFAD0vpc735oFWLPg@mail.gmail.com>
Message-ID: <CALCETrWPDXpbVcuFK_1M5DtaCOW_LSf-XHFAD0vpc735oFWLPg@mail.gmail.com>
Subject: Re: [PATCH 04/10] x86/cet: Handle thread shadow stack
To: Florian Weimer <fweimer@redhat.com>
Cc: Andrew Lutomirski <luto@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 12:47 PM Florian Weimer <fweimer@redhat.com> wrote:
>
> On 06/07/2018 08:21 PM, Andy Lutomirski wrote:
> > On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrot=
e:
> >>
> >> When fork() specifies CLONE_VM but not CLONE_VFORK, the child
> >> needs a separate program stack and a separate shadow stack.
> >> This patch handles allocation and freeing of the thread shadow
> >> stack.
> >
> > Aha -- you're trying to make this automatic.  I'm not convinced this
> > is a good idea.  The Linux kernel has a long and storied history of
> > enabling new hardware features in ways that are almost entirely
> > useless for userspace.
> >
> > Florian, do you have any thoughts on how the user/kernel interaction
> > for the shadow stack should work?
>
> I have not looked at this in detail, have not played with the emulator,
> and have not been privy to any discussions before these patches have
> been posted, however =E2=80=A6
>
> I believe that we want as little code in userspace for shadow stack
> management as possible.  One concern I have is that even with the code
> we arguably need for various kinds of stack unwinding, we might have
> unwittingly built a generic trampoline that leads to full CET bypass.

I was imagining an API like "allocate a shadow stack for the current
thread, fail if the current thread already has one, and turn on the
shadow stack".  glibc would call clone and then call this ABI pretty
much immediately (i.e. before making any calls from which it expects
to return).

We definitely want strong enough user control that tools like CRIU can
continue to work.  I haven't looked at the SDM recently enough to
remember for sure, but I'm reasonably confident that user code can
learn the address of its own shadow stack.  If nothing else, CRIU
needs to be able to restore from a context where there's a signal on
the stack and the signal frame contains a shadow stack pointer.


>
> I also expect that we'd only have donor mappings in userspace anyway,
> and that the memory is not actually accessible from userspace if it is
> used for a shadow stack.
>
> > My intuition would be that all
> > shadow stack management should be entirely controlled by userspace --
> > newly cloned threads (with CLONE_VM) should have no shadow stack
> > initially, and newly started processes should have no shadow stack
> > until they ask for one.
>
> If the new thread doesn't have a shadow stack, we need to disable
> signals around clone, and we are very likely forced to rewrite the early
> thread setup in assembler, to avoid spurious calls (including calls to
> thunks to get EIP on i386).  I wouldn't want to do this If we can avoid
> it.  Just using C and hoping to get away with it doesn't sound greater,
> either.  And obviously there is the matter that the initial thread setup
> code ends up being that universal trampoline.
>

Only if the trampoline works if the shadow stack is already enabled.

I could very easily be convinced that automatic shadow stack setup is
a good idea, but I still think we need manual control for CRIU and
such.
