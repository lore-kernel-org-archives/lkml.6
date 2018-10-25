Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4C8C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED4C20848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="liZ/JfMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED4C20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbeJZHtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 03:49:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbeJZHtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 03:49:04 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C9F120848
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 23:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540509268;
        bh=sanClo23U4iow7KnRInfHdOX9E10uWIJM4CLFB2TFQI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=liZ/JfMVoH3OAHXN5gszAlwN/FG0CwFu40LQe+MH1Y4X6YG1UyuTWkt7FYNm2CuvE
         4N+LdeOLmwCgyGsVR0QYp+tbHgS8dzHSK0jn+42DRiGkylVNJZdCcUhFWpxwCxRMEP
         azHt/Q+rEcEvCqNvYfG92tZZRW+kvyo+zDTZfREg=
Received: by mail-wr1-f48.google.com with SMTP id w5-v6so10974550wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 16:14:28 -0700 (PDT)
X-Gm-Message-State: AGRZ1gIiv1DBkagKkMA7HuSCoRlJL6b12BU6Usxlhyl3SqFU65R5DugX
        DfQvXZZp/bI4R+UrVY08Hu0vWxvIFp7Ax11kaawrmg==
X-Google-Smtp-Source: AJdET5dPeBOCfb2x/JZqPr3+Qvv9y7qkD24QjyU9J2wDs9g+fINqXPmQLuXO0jSz0dconRqAELyAWYjekS7mJxshoFM=
X-Received: by 2002:adf:82c9:: with SMTP id 67-v6mr3488291wrc.131.1540509267132;
 Thu, 25 Oct 2018 16:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <20181023184234.14025-1-chang.seok.bae@intel.com>
 <20181023184234.14025-4-chang.seok.bae@intel.com> <CALCETrWWBYgaJfPykTpJ9=TsptVL_ieOR3JdYVVW02=O9CM17Q@mail.gmail.com>
 <20181024192137.GI6218@tassilo.jf.intel.com>
In-Reply-To: <20181024192137.GI6218@tassilo.jf.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 25 Oct 2018 16:14:15 -0700
X-Gmail-Original-Message-ID: <CALCETrUmD0jAzVMAUJ=9Vpih56Q4t9U5DJLnUxQdeMwZ3RAECA@mail.gmail.com>
Message-ID: <CALCETrUmD0jAzVMAUJ=9Vpih56Q4t9U5DJLnUxQdeMwZ3RAECA@mail.gmail.com>
Subject: Re: [v3 03/12] x86/fsgsbase/64: Add intrinsics/macros for FSGSBASE instructions
To:     Andi Kleen <ak@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 12:21 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> On Wed, Oct 24, 2018 at 11:53:54AM -0700, Andy Lutomirski wrote:
> > On Tue, Oct 23, 2018 at 11:43 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
> > >
> > > From: Andi Kleen <ak@linux.intel.com>
> > >
> > > Add C intrinsics and assembler macros for the new FSBASE and GSBASE
> > > instructions.
> > >
> > > Very straight forward. Used in followon patches.
> > >
> > > [ luto: Rename the variables from FS and GS to FSBASE and GSBASE and
> > >   make <asm/fsgsbase.h> safe to include on 32-bit kernels. ]
> > >
> > > v2: Use __always_inline
> > >
> > > [ chang: Revise the changelog. Place them in <asm/fsgsbase.h>. Replace
> > >   the macros with GAS-compatible ones. ]
> > >
> > > If GCC supports it, we can add -mfsgsbase to CFLAGS and use the builtins
> > > here for extra performance.
> >
> > Reviewed-by: Andy Lutomirski <luto@kernel.org> # C parts only
> >
> > With the caveat that I'm not convinced that the memory clobbers are
> > needed.  The __force_order trick in special_insns.h would probably be
> > more appropriate.
> >
> > I don't feel qualified to review the asm part without some research.
> > Whereas hpa or Boris could probably review it with their eyes closed.
>
> BTW the other option would be to update the min-binutils requirement
> to 2.21 (currently it is 2.20) and then write it directly without .byte.
> I believe 2.21 added support for these instructions.
>
> (It's only a binutils requirement, don't need gcc support)
>

I'd personally be fine with this.  Linus? Thomas? Ingo?
