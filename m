Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DDF96C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FFE320660
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sG8YSDcy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FFE320660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934756AbeFLQbo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:31:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:51590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933640AbeFLQbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:31:41 -0400
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76956208BA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 16:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528821100;
        bh=XEIlOvbbDQXqm/v1NOApDSTHjmyoqmcoPR8PlYxjRUU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sG8YSDcyBVhPHJkW8zk+n/AC15dWjLRY96+mYlXCw5weX3oYZ5ANjes8dTZXQlwWU
         w1Hobd7W7X10laXcC5CQv/jrTn+fpsah7jNDGEK6AFLMOvhrRTNrH3td0lUxHkrV2y
         jTMaj90bOPL4JllpHrZboyei7504ltK0SiLjoStw=
Received: by mail-wm0-f47.google.com with SMTP id p126-v6so141019wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 09:31:40 -0700 (PDT)
X-Gm-Message-State: APt69E2j5/BniKYEsMD6IlHnawrjQbebExRKifnld8ZQVkxwZNULqVLQ
        M7IrOZNnrtvBUrS53G2T7iRH0GOktouk55wp1fCjFw==
X-Google-Smtp-Source: ADUXVKI8ec2tDpifrvISSRkqauNfSV/MW6HtnKXHi2vfRWZjTiXay2apWw98YBrT/hxTPRRjNdk7hyEyVKw8jIscvK4=
X-Received: by 2002:a1c:f902:: with SMTP id x2-v6mr702631wmh.116.1528821098859;
 Tue, 12 Jun 2018 09:31:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143807.3611-1-yu-cheng.yu@intel.com> <bbfde1b3-5e1b-80e3-30e8-fd1e46a2ceb1@gmail.com>
 <1528815820.8271.16.camel@2b52.sc.intel.com> <CALCETrXK6hypCb5sXwxWRKr=J6_7XtS6s5GB1WPBiqi79q8-8g@mail.gmail.com>
 <1528820489.9324.14.camel@2b52.sc.intel.com>
In-Reply-To: <1528820489.9324.14.camel@2b52.sc.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 12 Jun 2018 09:31:26 -0700
X-Gmail-Original-Message-ID: <CALCETrVOyZz72RuoRB=z_EjFTqqctSLfX30GM+MSEVtbcd=PeQ@mail.gmail.com>
Message-ID: <CALCETrVOyZz72RuoRB=z_EjFTqqctSLfX30GM+MSEVtbcd=PeQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] Control Flow Enforcement - Part (3)
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>, bsingharora@gmail.com,
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

On Tue, Jun 12, 2018 at 9:24 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> On Tue, 2018-06-12 at 09:00 -0700, Andy Lutomirski wrote:
> > On Tue, Jun 12, 2018 at 8:06 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> > >
> > > On Tue, 2018-06-12 at 20:56 +1000, Balbir Singh wrote:
> > > >
> > > > On 08/06/18 00:37, Yu-cheng Yu wrote:
> > > > > This series introduces CET - Shadow stack
> > > > >
> > > > > At the high level, shadow stack is:
> > > > >
> > > > >     Allocated from a task's address space with vm_flags VM_SHSTK;
> > > > >     Its PTEs must be read-only and dirty;
> > > > >     Fixed sized, but the default size can be changed by sys admin.
> > > > >
> > > > > For a forked child, the shadow stack is duplicated when the next
> > > > > shadow stack access takes place.
> > > > >
> > > > > For a pthread child, a new shadow stack is allocated.
> > > > >
> > > > > The signal handler uses the same shadow stack as the main program.
> > > > >
> > > >
> > > > Even with sigaltstack()?
> > > >
> > > >
> > > > Balbir Singh.
> > >
> > > Yes.
> > >
> >
> > I think we're going to need some provision to add an alternate signal
> > stack to handle the case where the shadow stack overflows.
>
> The shadow stack stores only return addresses; its consumption will not
> exceed a percentage of (program stack size + sigaltstack size) before
> those overflow.  When that happens, there is usually very little we can
> do.  So we set a default shadow stack size that supports certain nested
> calls and allow sys admin to adjust it.
>

Of course there's something you can do: add a sigaltstack-like stack
switching mechanism.  Have a reserve shadow stack and, when a signal
is delivered (possibly guarded by other conditions like "did the
shadow stack overflow"), switch to a new shadow stack and maybe write
a special token to the new shadow stack that says "signal delivery
jumped here and will restore to the previous shadow stack and
such-and-such address on return".

Also, I have a couple of other questions after reading the
documentation some more:

1. Why on Earth does INCSSP only take an 8-bit number of frames to
skip?  It seems to me that code that calls setjmp() and then calls
longjmp() while nested more than 256 function call levels will crash.

2. The mnemonic RSTORSSP makes no sense to me.  RSTORSSP is a stack
*switch* operation not a stack *restore* operation, unless I'm
seriously misunderstanding.

3. Is there anything resembling clear documentation of the format of
the shadow stack?  That is, what types of values might be found on the
shadow stack and what do they all mean?

4. Usually Intel doesn't submit upstream Linux patches for ISA
extensions until the ISA is documented for real.  CET does not appear
to be documented for real.  Could Intel kindly release something that
at least claims to be authoritative documentation?

--Andy
