Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8CAC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 00:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDCE220820
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 00:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qq2MP7Ie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDCE220820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407963AbeKWLZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 06:25:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:54952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392723AbeKWLZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 06:25:04 -0500
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEAC120820
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 00:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542933786;
        bh=0zrxw6/g7MAbvpMIvgphAIXOPf2qEjruzIahoKcTIxg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qq2MP7IeFmc/i70Fshl4E938hYcQ5G9jzDBrEeF33rpjCUDsoGPW1GNY/60txRLXg
         jZNZo7jZr3KHFWY1lglwgYTJpGdNPfIgbRdL//REVesPVR7b2oELHStirQ5+oQarmt
         cD2643v5911ulaDAMhUceURVxxnVxHNsFPkDxXY4=
Received: by mail-wm1-f43.google.com with SMTP id j207so3311262wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 16:43:05 -0800 (PST)
X-Gm-Message-State: AA+aEWZuF4NmybhBvxtXbIM6Cb3ijxHffY/6zmNQkFlmgdUQVW/3Cd9O
        BQF4sssrgA2DthaXYYJz+FFiGIavLzBb12OxkpvwLw==
X-Google-Smtp-Source: AJdET5fMGUAFdmY7SyMhknl1LAr4qUQaZdrcBnR7ijOIWKdbT2bxnYO+y0K2NBVlQ72MAH2sWTsQsiLhv9I3tfLdrmk=
X-Received: by 2002:a1c:b1d5:: with SMTP id a204mr11383336wmf.32.1542933784425;
 Thu, 22 Nov 2018 16:43:04 -0800 (PST)
MIME-Version: 1.0
References: <20181116232728.23538-1-chang.seok.bae@intel.com>
 <CALCETrVtnkrr+t7-oXXrGDsei1Q0nudh8JstkuaE+dka4FHPEA@mail.gmail.com> <20181122205645.GA36550@gmail.com>
In-Reply-To: <20181122205645.GA36550@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 22 Nov 2018 16:42:52 -0800
X-Gmail-Original-Message-ID: <CALCETrVHtjXFskx5VesHnzv=BnUx=t3qC_RRWsp96RgT5CN2VQ@mail.gmail.com>
Message-ID: <CALCETrVHtjXFskx5VesHnzv=BnUx=t3qC_RRWsp96RgT5CN2VQ@mail.gmail.com>
Subject: Re: [PATCH v5] x86/fsgsbase/64: Fix the base write helper functions
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 12:56 PM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Andy Lutomirski <luto@kernel.org> wrote:
>
> > On Fri, Nov 16, 2018 at 3:27 PM Chang S. Bae <chang.seok.bae@intel.com> wrote:
> > >
> > > The helper functions that purport to write the base should just write it
> > > only. It shouldn't have magic optimizations to change the index.
> > >
> > > Make the index explicitly changed from the caller, instead of including
> > > the code in the helpers.
> > >
> > > Subsequently, the task write helpers do not handle for the current task
> > > anymore. The range check for a base value is also factored out, to
> > > minimize code redundancy from the caller.
> > >
> > > v2: Fix further on the task write functions. Revert the changes on the
> > > task read helpers.
> > >
> > > v3: Fix putreg(). Edit the changelog.
> > >
> > > v4: Update the task write helper functions and do_arch_prctl_64(). Fix
> > > the comment in putreg().
> > >
> > > v5: Fix preempt_disable() calls in do_arch_prctl_64()
> >
> > Reviewed-by: Andy Lutomirski <luto@kernel.org>
> >
> > Ingo, Thomas: can we get this in x86/urgent, please?
>
> Sadly this commit introduced a boot failure on both an Intel and an AMD
> 64-bit testbox.
>
> Symptoms range from silent bootup hang in early userspace to segfaults
> like this:
>
> [   21.885741] random: systemd: uninitialized urandom read (16 bytes read)
> [   21.964778] systemd[1]: segfault at 28 ip 00005584d8d8247d sp 00007ffc7a05aed0 error 4 in systemd[5584d8d0d000+137000]
> [   21.977664] Code: c3 4c 89 ff e8 94 78 fa ff eb bb 48 89 c3 eb f1 00 00 00 00 00 00 00 00 00 00 00 00 00 41 55 41 54 55 53 48 89 fd 48 83 ec 28 <64> 48 8b 04 25 28 00 00 00 48 89 44 24 18 31 c0 48 85 ff 74 6e 48
> [   22.000004] systemd[1]: segfault at 28 ip 00005584d8db0a3d sp 00007ffc7a05a7e0 error 4 in systemd[5584d8d0d000+137000]
> [   22.012869] Code: 49 89 e9 ba 67 01 00 00 bf 04 00 00 00 31 c0 e8 c9 1c 03 00 59 31 c0 5e e9 ff fa ff ff 41 54 55 53 89 fb 48 81 ec 40 01 00 00 <64> 48 8b 04 25 28 00 00 00 48 89 84 24 38 01 00 00 31 c0 e8 fb 92
>
> I've zapped the commit from x86/urgent because it's clearly not ready
> yet.
>
> I used a fairly regular distro .config and a fairly regular distro -
> nothing fancy.
>

I can reproduce it.  Off the top of my head, maybe 0day is using a
different, weird glibc configuration?  I think it runs some ancient
version of Yocto.

And I think I've almost root-caused the problem, and I think it's a
preexisting bug exposed by this patch.  Lemme double-check and I'll
send a fix.
