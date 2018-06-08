Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ZIfkIWuaGlv3OAAAmS7hNA
	; Fri, 08 Jun 2018 15:02:03 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6D981607E4; Fri,  8 Jun 2018 15:02:03 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xI0dNiot"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D2D97601D2;
	Fri,  8 Jun 2018 15:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D2D97601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752805AbeFHPCA (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 11:02:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751905AbeFHPB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 11:01:58 -0400
Received: from mail-wm0-f53.google.com (mail-wm0-f53.google.com [74.125.82.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EB35208B1
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jun 2018 15:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528470117;
        bh=oPC86fbNyuCunakBiXdzs4ozNJN/bNwMdMGWPHNb150=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xI0dNiotMzCPNZPDpj/0DJ9Q/X8Sz02E8yHMaV6zKfk3KD53WLRFXkh90pIjXKcc6
         qDMglo/XAednt71wV4NsmnKjmh1CBCjw1xWYSE/9bhs7MU4AGijngrjD9Dc/2+yKSa
         hLmXJWseiPLJcIOObF+jrDQZXzi3v0HRgp4HhhKs=
Received: by mail-wm0-f53.google.com with SMTP id e16-v6so3893776wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 08:01:57 -0700 (PDT)
X-Gm-Message-State: APt69E1Ldt1gCorJoL1KBT8U+fBZ1L3wNOL+kRcPvYIHjtHOPPjYWfjv
        cwjwepEBhOmhLqmC637EuitfUo8phXjvPb8SlNVEaw==
X-Google-Smtp-Source: ADUXVKJGVKopITVyJftddJYgYLjZM0xr023R2eMHWBuya+yLL1g6NNia5jOuU/uBUwr4wTyg7cFwZLI2dkibGAJ9b2Q=
X-Received: by 2002:a1c:f902:: with SMTP id x2-v6mr1705545wmh.116.1528470115793;
 Fri, 08 Jun 2018 08:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-5-yu-cheng.yu@intel.com>
 <CALCETrUqXvh2FDXe6bveP10TFpzptEyQe2=mdfZFGKU0T+NXsA@mail.gmail.com>
 <3c1bdf85-0c52-39ed-a799-e26ac0e52391@redhat.com> <CALCETrWPDXpbVcuFK_1M5DtaCOW_LSf-XHFAD0vpc735oFWLPg@mail.gmail.com>
 <6ee29e8b-4a0a-3459-a1ee-03923ba4e15d@redhat.com>
In-Reply-To: <6ee29e8b-4a0a-3459-a1ee-03923ba4e15d@redhat.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Fri, 8 Jun 2018 08:01:43 -0700
X-Gmail-Original-Message-ID: <CALCETrV_V68nVhCpUSGXrwUKCu4utbdp01snmG=G=+_xAo0KJA@mail.gmail.com>
Message-ID: <CALCETrV_V68nVhCpUSGXrwUKCu4utbdp01snmG=G=+_xAo0KJA@mail.gmail.com>
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

On Fri, Jun 8, 2018 at 7:53 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> On 06/07/2018 10:53 PM, Andy Lutomirski wrote:
> > On Thu, Jun 7, 2018 at 12:47 PM Florian Weimer <fweimer@redhat.com> wro=
te:
> >>
> >> On 06/07/2018 08:21 PM, Andy Lutomirski wrote:
> >>> On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wr=
ote:
> >>>>
> >>>> When fork() specifies CLONE_VM but not CLONE_VFORK, the child
> >>>> needs a separate program stack and a separate shadow stack.
> >>>> This patch handles allocation and freeing of the thread shadow
> >>>> stack.
> >>>
> >>> Aha -- you're trying to make this automatic.  I'm not convinced this
> >>> is a good idea.  The Linux kernel has a long and storied history of
> >>> enabling new hardware features in ways that are almost entirely
> >>> useless for userspace.
> >>>
> >>> Florian, do you have any thoughts on how the user/kernel interaction
> >>> for the shadow stack should work?
> >>
> >> I have not looked at this in detail, have not played with the emulator=
,
> >> and have not been privy to any discussions before these patches have
> >> been posted, however =E2=80=A6
> >>
> >> I believe that we want as little code in userspace for shadow stack
> >> management as possible.  One concern I have is that even with the code
> >> we arguably need for various kinds of stack unwinding, we might have
> >> unwittingly built a generic trampoline that leads to full CET bypass.
> >
> > I was imagining an API like "allocate a shadow stack for the current
> > thread, fail if the current thread already has one, and turn on the
> > shadow stack".  glibc would call clone and then call this ABI pretty
> > much immediately (i.e. before making any calls from which it expects
> > to return).
>
> Ahh.  So you propose not to enable shadow stack enforcement on the new
> thread even if it is enabled for the current thread?  For the cases
> where CLONE_VM is involved?
>
> It will still need a new assembler wrapper which sets up the shadow
> stack, and it's probably required to disable signals.
>
> I think it should be reasonable safe and actually implementable.  But
> the benefits are not immediately obvious to me.

Doing it this way would have been my first incliniation.  It would
avoid all the oddities of the kernel magically creating a VMA when
clone() is called, guessing the shadow stack size, etc.  But I'm okay
with having the kernel do it automatically, too.  I think it would be
very nice to have a way for user code to find out the size of the
shadow stack and change it, though.  (And relocate it, but maybe
that's impossible.  The CET documentation doesn't have a clear
description of the shadow stack layout.)

>
> > We definitely want strong enough user control that tools like CRIU can
> > continue to work.  I haven't looked at the SDM recently enough to
> > remember for sure, but I'm reasonably confident that user code can
> > learn the address of its own shadow stack.  If nothing else, CRIU
> > needs to be able to restore from a context where there's a signal on
> > the stack and the signal frame contains a shadow stack pointer.
>
> CRIU also needs the shadow stack *contents*, which shouldn't be directly
> available to the process.  So it needs very special interfaces anyway.

True.  I proposed in a different email that ptrace() have full control
of the shadow stack (read, write, lock, unlock, etc).

>
> Does CRIU implement MPX support?

Dunno.  But given that MPX seems to be dying, I'm not sure it matters.

--Andy
