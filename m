Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F23AC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0631020848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVaQpTed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0631020848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbeJZHfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 03:35:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727179AbeJZHfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 03:35:23 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E7452085A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 23:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540508448;
        bh=TSi/HvAB3IHeN7eIzpproCcQ9Us3ENvQqFJb5ze9KLs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EVaQpTedSKJAKgwJzRAL+xEsXrVWTRILju0um6+62WxSwbtNQ1KOCWlnclyDZf0S0
         j9fSmL6YK+YEvboM5eaUiuv9hRHL2a5cjU02nVflFbm3YpsXomQykBrfmIQ7CxKanf
         4gaRTL/vc+mB/3sshIjrbAh1T2aNdLiYV2aNzMGk=
Received: by mail-wr1-f44.google.com with SMTP id n5-v6so7167469wrw.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 16:00:48 -0700 (PDT)
X-Gm-Message-State: AGRZ1gIwyWAcstWP1orFZdGp09g6zdhuXih067Pdz2RJBVkft6yXGdbs
        HueetWtN2Nsj2IK/I3XlX4NQoc841S/ElZESokOljg==
X-Google-Smtp-Source: AJdET5c7ts9T9XK1ktDZE9sM9d+gjeXyBTKdQ16uzMdrWKkscXVrGff+YPHaVn+JZcGbRb5/2QzswdiZzzeW1w/jI28=
X-Received: by 2002:adf:82c9:: with SMTP id 67-v6mr3460785wrc.131.1540508446827;
 Thu, 25 Oct 2018 16:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <20181023184234.14025-1-chang.seok.bae@intel.com>
 <20181023184234.14025-5-chang.seok.bae@intel.com> <CALCETrVcJ08c6yf6y3ruOA_Hx_7srkHw5iYfx1c2p8_ySiL2WA@mail.gmail.com>
 <1EE75BE7-12C6-4BD9-9D31-E9C396D2015B@intel.com>
In-Reply-To: <1EE75BE7-12C6-4BD9-9D31-E9C396D2015B@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 25 Oct 2018 16:00:35 -0700
X-Gmail-Original-Message-ID: <CALCETrVdxKsSgU8zeyn7DO-1toO770yZbEAPTGOtF0FvPfQOXg@mail.gmail.com>
Message-ID: <CALCETrVdxKsSgU8zeyn7DO-1toO770yZbEAPTGOtF0FvPfQOXg@mail.gmail.com>
Subject: Re: [v3 04/12] x86/fsgsbase/64: Enable FSGSBASE instructions in the
 helper functions
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 12:32 AM Bae, Chang Seok
<chang.seok.bae@intel.com> wrote:
>
>
> > On Oct 24, 2018, at 12:16, Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Tue, Oct 23, 2018 at 11:43 AM Chang S. Bae <chang.seok.bae@intel.com=
> wrote:
> >> void x86_fsbase_write_cpu(unsigned long fsbase)
> >> {
> >> -       /*
> >> -        * Set the selector to 0 as a notion, that the segment base is
> >> -        * overwritten, which will be checked for skipping the segment=
 load
> >> -        * during context switch.
> >> -        */
> >> -       loadseg(FS, 0);
> >> -       wrmsrl(MSR_FS_BASE, fsbase);
> >> +       if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
> >> +               wrfsbase(fsbase);
> >> +       } else {
> >> +               /*
> >> +                * Set the selector to 0 as a notion, that the segment=
 base is
> >> +                * overwritten, which will be checked for skipping the=
 segment load
> >> +                * during context switch.
> >> +                */
> >> +               loadseg(FS, 0);
> >> +               wrmsrl(MSR_FS_BASE, fsbase);
> >> +       }
> >> }
> >>
> >> void x86_gsbase_write_cpu_inactive(unsigned long gsbase)
> >> {
> >> -       /* Set the selector to 0 for the same reason as %fs above. */
> >> -       loadseg(GS, 0);
> >> -       wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
> >> +       if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
> >> +               wr_inactive_gsbase(gsbase);
> >> +       } else {
> >> +               /* Set the selector to 0 for the same reason as %fs ab=
ove. */
> >> +               loadseg(GS, 0);
> >> +               wrmsrl(MSR_KERNEL_GS_BASE, gsbase);
> >
> > I still don't get what this code is trying to do.  See other email.  I
> > think it will straight up crash the kernel on some CPUs, since writing
> > 0 to %%gs will zero out the *active* base on some CPUs.
> >
>
> On those CPUs, how the old do_arch_prctl_64() worked?
> loadseg(GS, 0) eventually hits the native_load_gs_index entry, where actu=
al
> mov =E2=80=A6, %gs is wrapped by two SWAPGSes. So, it won=E2=80=99t cause=
 the side effect
> of overwriting the *active* base, I think.
>
> > I think that, if you really want some fancy optimization for the
> > non-FSGSBASE case, you need to pull that out into the callers of these
> > helpers.
>

I was thinking of loadsegment, not loadseg.  Sorry!
