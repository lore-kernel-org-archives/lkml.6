Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id V7/SF0ucGVuXOwAAmS7hNA
	; Thu, 07 Jun 2018 20:58:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7D843606FA; Thu,  7 Jun 2018 20:58:16 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nh9WlCmN"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EE762601C3;
	Thu,  7 Jun 2018 20:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE762601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933195AbeFGU5a (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:57:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933175AbeFGU5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:57:22 -0400
Received: from mail-wr0-f173.google.com (mail-wr0-f173.google.com [209.85.128.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56C20208AC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jun 2018 20:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528405036;
        bh=wQ17FDLYtNka0RhI4z8H8Sf+ZZ7xe/5gI0D7GKp659M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nh9WlCmNEEeRNt0Z61dRG4ibhoHXhfgKUh/eLdxMar9q0q8CQfkPLoC01v5bl0Ato
         7EV2uYQAoUEt59pqcsDow94ID1IhBd57/7g81wNbCtpGwQGUAHtpTM6c47WhCWAzQ3
         FKBaMig67nD776ylOLCvMpH3PoWmuBReNnDoM3KI=
Received: by mail-wr0-f173.google.com with SMTP id v13-v6so11199942wrp.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 13:57:16 -0700 (PDT)
X-Gm-Message-State: APt69E2jjNdbtZeKrbE2Nt7RMzmMPzFX7LcaAteDdPNiMsv+PCa3mJce
        y64ZIfBWwIEEWPUlhD62FHLNYbIER+37MFI8C899iw==
X-Google-Smtp-Source: ADUXVKIrychLOtP7/QzH5MGxP3n2teQOKye/aMNSQ3UbTU49znGLRY8fIyvHKqedZXPO6n+wb0ktpLiuCpc2puNMd48=
X-Received: by 2002:adf:85ec:: with SMTP id 41-v6mr2909360wru.120.1528405034780;
 Thu, 07 Jun 2018 13:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <20180607143807.3611-4-yu-cheng.yu@intel.com>
 <CALCETrWo77RS_wOzskw5OG-LdC1S-b_NY=uPWUmPbQEnNwANgQ@mail.gmail.com> <20180607200714.GA2525@uranus>
In-Reply-To: <20180607200714.GA2525@uranus>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 7 Jun 2018 13:57:03 -0700
X-Gmail-Original-Message-ID: <CALCETrXAoPsHK49c1Dpa8N0ccsxjwnVOTktKVaY++xjHxdmUzg@mail.gmail.com>
Message-ID: <CALCETrXAoPsHK49c1Dpa8N0ccsxjwnVOTktKVaY++xjHxdmUzg@mail.gmail.com>
Subject: Re: [PATCH 03/10] x86/cet: Signal handling for shadow stack
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Florian Weimer <fweimer@redhat.com>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 1:07 PM Cyrill Gorcunov <gorcunov@gmail.com> wrote:
>
> On Thu, Jun 07, 2018 at 11:30:34AM -0700, Andy Lutomirski wrote:
> > On Thu, Jun 7, 2018 at 7:41 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> > >
> > > Set and restore shadow stack pointer for signals.
> >
> > How does this interact with siglongjmp()?
> >
> > This patch makes me extremely nervous due to the possibility of ABI
> > issues and CRIU breakage.
> >
> > > diff --git a/arch/x86/include/uapi/asm/sigcontext.h b/arch/x86/include/uapi/asm/sigcontext.h
> > > index 844d60eb1882..6c8997a0156a 100644
> > > --- a/arch/x86/include/uapi/asm/sigcontext.h
> > > +++ b/arch/x86/include/uapi/asm/sigcontext.h
> > > @@ -230,6 +230,7 @@ struct sigcontext_32 {
> > >         __u32                           fpstate; /* Zero when no FPU/extended context */
> > >         __u32                           oldmask;
> > >         __u32                           cr2;
> > > +       __u32                           ssp;
> > >  };
> > >
> > >  /*
> > > @@ -262,6 +263,7 @@ struct sigcontext_64 {
> > >         __u64                           trapno;
> > >         __u64                           oldmask;
> > >         __u64                           cr2;
> > > +       __u64                           ssp;
> > >
> > >         /*
> > >          * fpstate is really (struct _fpstate *) or (struct _xstate *)
> > > @@ -320,6 +322,7 @@ struct sigcontext {
> > >         struct _fpstate __user          *fpstate;
> > >         __u32                           oldmask;
> > >         __u32                           cr2;
> > > +       __u32                           ssp;
> >
> > Is it actually okay to modify these structures like this?  They're
> > part of the user ABI, and I don't know whether any user code relies on
> > the size being constant.
>
> For sure it might cause problems for CRIU since we have
> similar definitions for this structure inside our code.
> That said if kernel is about to modify the structures it
> should keep backward compatibility at least if a user
> passes previous version of a structure @ssp should be
> set to something safe by the kernel itself.
>
> I didn't read the whole series of patches in details
> yet, hopefully will be able tomorrow. Thanks Andy for
> CC'ing!

We have uc_flags.  It might be useful to carve out some of the flag
space (24 bits?) to indicate something like the *size* of sigcontext
and teach the kernel that new sigcontext fields should only be parsed
on sigreturn() if the size is large enough.
