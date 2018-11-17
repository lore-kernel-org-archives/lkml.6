Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 141AAC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 17:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC2C2080D
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 17:03:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAC2C2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbeKRDVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 22:21:07 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:23856
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726311AbeKRDVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 22:21:07 -0500
X-IronPort-AV: E=Sophos;i="5.56,245,1539640800"; 
   d="scan'208";a="285848619"
Received: from abo-186-120-68.mrs.modulonet.fr (HELO hadrien) ([85.68.120.186])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Nov 2018 18:03:46 +0100
Date:   Sat, 17 Nov 2018 09:03:46 -0800 (PST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Rob Herring <robherring2@gmail.com>
cc:     Joe Perches <joe@perches.com>, Jani Nikula <jani.nikula@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        vishal.l.verma@intel.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        stfrench@microsoft.com, "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [Ksummit-discuss] [RFC PATCH 2/3] MAINTAINERS, Handbook: Subsystem
 Profile
In-Reply-To: <CAL_Jsq+4FbB=wj3L67=KEPb_5e8GinMJaXoB2cW6c23yazeNiw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1811170902330.2558@hadrien>
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com> <154225760492.2499188.14152986544451112930.stgit@dwillia2-desk3.amr.corp.intel.com> <alpine.DEB.2.21.1811142146230.9620@hadrien>
 <CAMuHMdVmvCOX6gF0BskQ1NBUpdMZHSBQXpxkx085B9ZKGm0wiA@mail.gmail.com> <alpine.DEB.2.21.1811150544090.2354@hadrien> <878t1tgpk8.fsf@intel.com> <f08820b05467cc95cc195a2639595c0274c95d69.camel@perches.com>
 <CAL_Jsq+4FbB=wj3L67=KEPb_5e8GinMJaXoB2cW6c23yazeNiw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 17 Nov 2018, Rob Herring wrote:

> On Fri, Nov 16, 2018 at 11:57 AM Joe Perches <joe@perches.com> wrote:
> >
> > On Fri, 2018-11-16 at 14:44 +0200, Jani Nikula wrote:
> > > I quickly cooked up this script to produce the top-5 commit prefixes for
> > > the given files over the arbitrary last 200 commits. It'll give you a
> > > pretty good idea if you're even close.
> > >
> > > ---
> > > #!/bin/sh
> > > # usage: subject-prefix FILE [...]
> > > # show top 5 subject prefixes for FILEs
> > >
> > > git log --format=%s -n 200 -- "$@" |\
> > >       grep -v "^Merge " |\
>
> --no-merges in git log can replace this line.
>
> > >       sed 's/\(.*\):.*/\1/' |\
> > >       sort | uniq -c | sort -nr | sed 's/ *[0-9]\+ //' |\
> > >       head -n 5
> > > ---
> > >
> > > Someone who knows perl could turn that into a checkpatch check: See if
> > > the patch subject prefix is one of the top-5 for all files changed by
> > > the patch, and ask the user to double check if it isn't. Or some
> > > heuristics thereof.
> >
> > This won't work when a patch contains multiple files
> > from different paths, or even multiple files from a
> > single driver.
>
> Different paths is often, but not always a sign that patches may need
> to be split up. Maybe that is something checkpatch should point out.

Between v4.0 and v4.19, 18% of commits touch multiple .c files.  35% of
commits touch multiple files in general.

julia

>
> > Perhaps it's better to use a generic mechanism like
> >
> >         basename $(dirname $filename):
> >
> > with some exceptions and add an override patch subject
> > grammar to appropriate various sections of MAINTAINERS.
>
> Perhaps just use the script as a starting point to populate
> MAINTAINERS as it may never be that accurate.
>
> > I also think it's better to use a separate script like
> > scripts/spdxcheck.py and tie any necessary checkpatch
> > use to that script.
>
> Yes, checkpatch is getting pretty unwieldy.
>
> Rob
>
