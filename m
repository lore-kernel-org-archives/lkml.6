Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E8DECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330272084A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 00:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEvme0aJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 330272084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeJZIor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 04:44:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbeJZIor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 04:44:47 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B59002086B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 00:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540512603;
        bh=YrCOeniY4jBv0QJbPQc0CmtuUaB9K7OS6as1l8/MyEU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JEvme0aJetAZhweHii7Cv8Oe/2/rPHC6ZVceJ2qggGFndKBMyEGlgyE3nwuwyKTYk
         AON/saOQgfqQcRVROwFburgWvujTnDIe5X9JFESPqhDeQINM1OjZLR1drfJwg6wCm7
         RV+MLucs8TTeq+jfCQYO4F3DvQMkARAS3sOIWn7w=
Received: by mail-wr1-f46.google.com with SMTP id q6-v6so11033406wrw.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 17:10:02 -0700 (PDT)
X-Gm-Message-State: AGRZ1gITDyih5lEPcBlCdPL581GDTZlZe9i7bgFu8+Otd/h3hdS4HjZ2
        fBhC/VFz2pJBg/YXUkbu8ytAmXhgCaNR6Pc3aZK5ig==
X-Google-Smtp-Source: AJdET5dLtab+9bAMMC987YPcfdgrd32muJcL9R9ZH9KSEAnDgBmBG+ag8AvEMGr5tNUvHoU8qgo2gH5Bb0fRpB+X2s4=
X-Received: by 2002:adf:e50f:: with SMTP id j15-v6mr3796664wrm.94.1540512601146;
 Thu, 25 Oct 2018 17:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20181023184234.14025-1-chang.seok.bae@intel.com>
 <20181023184234.14025-4-chang.seok.bae@intel.com> <CALCETrWWBYgaJfPykTpJ9=TsptVL_ieOR3JdYVVW02=O9CM17Q@mail.gmail.com>
 <20181024192137.GI6218@tassilo.jf.intel.com> <CALCETrUmD0jAzVMAUJ=9Vpih56Q4t9U5DJLnUxQdeMwZ3RAECA@mail.gmail.com>
 <CAHk-=wjHs_wff==pT=auhC4dzNYu1e+DfgN7WGWpr-Vsfv-d8w@mail.gmail.com>
In-Reply-To: <CAHk-=wjHs_wff==pT=auhC4dzNYu1e+DfgN7WGWpr-Vsfv-d8w@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 25 Oct 2018 17:09:48 -0700
X-Gmail-Original-Message-ID: <CALCETrVnQ8cNDYyaFxLUyFQA6xmwv3G2=smA0T4F2ntjqAvAjw@mail.gmail.com>
Message-ID: <CALCETrVnQ8cNDYyaFxLUyFQA6xmwv3G2=smA0T4F2ntjqAvAjw@mail.gmail.com>
Subject: Re: [v3 03/12] x86/fsgsbase/64: Add intrinsics/macros for FSGSBASE instructions
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
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

On Thu, Oct 25, 2018 at 4:31 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Oct 25, 2018 at 4:14 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Wed, Oct 24, 2018 at 12:21 PM Andi Kleen <ak@linux.intel.com> wrote:
> > >
> > > BTW the other option would be to update the min-binutils requirement
> > > to 2.21 (currently it is 2.20) and then write it directly without .byte.
> > > I believe 2.21 added support for these instructions.
> > >
> > > (It's only a binutils requirement, don't need gcc support)
> >
> > I'd personally be fine with this.  Linus? Thomas? Ingo?
>
> I always vote for "require modern tools" as long as it doesn't cause problems.
>
> binutils-2.21 is something like seven years old by now, but the real
> issue would be what versions distros are actually shipping. I don't
> want people to have to build their own binutils just to build a
> kernel.
>
> It's usually some ancient enterprise distro that is stuck on old
> versions. Anybody have any idea?
>

With some basic Googling:

CentOS 6 is binutils 2.23.  CentOS 5 is EOL.  RHEL 5 has "extended
life", which means that it's officially zombified and paying customers
can still download (unsupported) packages.

SLES 11 is binutils 2.19, which is already unsupported.  SLES 12 is 2.24.

So I would guess we're okay and we can bump the requirement to 2.21.
