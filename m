Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EEAECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6162082F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgzSWweZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C6162082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbeJYDvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 23:51:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbeJYDvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 23:51:54 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6859D20847
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 19:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540408955;
        bh=+D0NPno23QPTrut13tNKvapz6jIT//vFuUtH9HAymDY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bgzSWweZKq+gzl+hhJkIStyJFVEWeu+DIx62VoKaKz0K4ibx6EN90F/Zps5fZdgiw
         81cCo/fdbZZ9ujnoRqq9bWB/xE1rucpsi0qRUfsmlmCwjDliOhqYJQMaogzj9Abk74
         dEfdQAO33ij22nT28fj+JVv3MkgSPYiYeJwbX55s=
Received: by mail-wr1-f48.google.com with SMTP id n5-v6so3014426wrw.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 12:22:35 -0700 (PDT)
X-Gm-Message-State: AGRZ1gLzIOaKX8UfBBtvBxfaaRo32RoySRB0BNeDTt3Kvkv2PlLEpU2r
        rlvGnVk2YsWC3SQAsL57E2+vGq7gcjemJQT2lygMEA==
X-Google-Smtp-Source: AJdET5fpWrD3HC/tmL+4gvJNfSv5jqF/uoPDbH48XyR6gW+vgYA3YJYIQhz1kaaViQssQyDGRfILt+gXkMtlBHGnqbk=
X-Received: by 2002:adf:97d3:: with SMTP id t19-v6mr1088158wrb.283.1540408953883;
 Wed, 24 Oct 2018 12:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <1537312139-5580-1-git-send-email-chang.seok.bae@intel.com>
 <1537312139-5580-3-git-send-email-chang.seok.bae@intel.com>
 <CALCETrUr3DGwW8y6y_cffEKWO_KQs1J2_UvTBZsbdAzES_f-Ag@mail.gmail.com> <C9BB696F3A938947B10DCAD29FAB8FFA66CCBBE3@CRSMSX101.amr.corp.intel.com>
In-Reply-To: <C9BB696F3A938947B10DCAD29FAB8FFA66CCBBE3@CRSMSX101.amr.corp.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 24 Oct 2018 12:22:22 -0700
X-Gmail-Original-Message-ID: <CALCETrWMMQDa4T0m34GfkkYBxqwGUOg96aeWgiANRv9tCvQVRw@mail.gmail.com>
Message-ID: <CALCETrWMMQDa4T0m34GfkkYBxqwGUOg96aeWgiANRv9tCvQVRw@mail.gmail.com>
Subject: Re: [regression in -rc1] Re: [PATCH v6 2/8] x86/fsgsbase/64:
 Introduce FS/GS base helper functions
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 12:13 PM Bae, Chang Seok
<chang.seok.bae@intel.com> wrote:
>
> On Tue, Sep 18, 2018 at 12:02 PM Andy Lutomirski <luto@kernel.org>
> > On Tue, Sep 18, 2018 at 4:09 PM Chang S. Bae <chang.seok.bae@intel.com>
> > wrote:
> > >
> > > With new helpers, FS/GS base access is centralized.
> > > Eventually, when FSGSBASE instruction enabled, it will be faster.
> >
> > Sorry for not catching this during review, but:
> >
> > > +void x86_fsbase_write_cpu(unsigned long fsbase) {
> > > +       /*
> > > +        * Set the selector to 0 as a notion, that the segment base is
> > > +        * overwritten, which will be checked for skipping the segment load
> > > +        * during context switch.
> > > +        */
> > > +       loadseg(FS, 0);
> >
> > ^^^
> >
> > what?
> >
> > > +       wrmsrl(MSR_FS_BASE, fsbase);
> > > +}
> >
> > I don't understand what the comment is trying to say, but the sole caller so far
> > of this function is x86_gsbase_write_task(), and the code looks incorrect.
> >
> > Ingo, I think we need to address this during this merge window, probably by
> > removing the comment and the loadseg() call (and the same for
> > gsbase...inactive).  But first, Chang, can you explain what exactly your intent is
> > here?
>
> It's coming from do_arch_prctl_64(). If you think it really makes confusion in
> x86_fsbase_write_cpu(), how about moving it to x86_fsbase_write_task()?

Why should ..write_task() magically change the index but only if it's
writing current?

I think you should move it all the way out to the caller
(do_arch_prctl_64()?) and we can see if it makes sense there.

>
> Chang
