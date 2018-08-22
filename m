Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317B2C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68E9208CC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 20:50:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D68E9208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbeHWARD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 20:17:03 -0400
Received: from smtprelay0222.hostedemail.com ([216.40.44.222]:48757 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726581AbeHWARC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 20:17:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id BFB055B3B;
        Wed, 22 Aug 2018 20:50:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: birds46_4dd97befa159
X-Filterd-Recvd-Size: 4313
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Wed, 22 Aug 2018 20:50:33 +0000 (UTC)
Message-ID: <39b6242771fd80fe19104c8a057bcc6afc0e41e5.camel@perches.com>
Subject: Re: [PATCH] compiler-gcc: get back Clang build
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>, asmadeus@codewreck.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, dwmw@amazon.co.uk,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Wed, 22 Aug 2018 13:50:32 -0700
In-Reply-To: <CAKwvOdm+BwvDxAw-A_1v5xO2EjDff1axAttHVz5QnBSxSbKo=g@mail.gmail.com>
References: <1534834088-15835-1-git-send-email-yamada.masahiro@socionext.com>
         <20180821123832.GA19034@nautica>
         <CAKwvOdmLQen+TWF_F3e5-66vtF3FEnoxjEgZbjmOZ9cv6YrEpA@mail.gmail.com>
         <acb93bae0086447c7cbe0eec05907335ebae7788.camel@perches.com>
         <CAKwvOdkLGhdQxx3oV=R2kv290NOv_w8qQ_yHWCVpvmofp7+ivQ@mail.gmail.com>
         <20180822041646.GA21716@nautica>
         <78396ba82562326f4b3a395a63e3e8dc38d608b2.camel@perches.com>
         <20180822043230.GA26654@nautica>
         <CAKwvOdm+BwvDxAw-A_1v5xO2EjDff1axAttHVz5QnBSxSbKo=g@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-08-22 at 11:31 -0700, Nick Desaulniers wrote:
> On Tue, Aug 21, 2018 at 9:32 PM Dominique Martinet
> <asmadeus@codewreck.org> wrote:
> > 
> > Joe Perches wrote on Tue, Aug 21, 2018:
> > > On Wed, 2018-08-22 at 06:16 +0200, Dominique Martinet wrote:
> > > > I think that could work, but at the point making a separate
> > > > compiler-common.h and not including compiler-gcc.h for clang sounds
> > > > better to me... More importantly here, either solution sound complex
> > > > enough to require more than a few days and proper testing for all archs
> > > > etc when compared to the partial revert we have here.
> > > 
> > > The immediate need for a partial revert seems unnecessary as
> > > clang hasn't really worked for a couple releases now.
> > 
> > Sorry for repeating myself, clang is used by bcc for compiling BPF
> > programs (e.g. bpf_module_create_c_from_string() or any similar function
> > will use the clang libs to compile the bpf program with linux headers),
> > and this has always been working because it's not using our makefiles.
> > 
> > This broke today in master and I only joined this thread after looking
> > at why the build started failing today and noticing this patch, it
> > definitely hasn't been broken for two releases, or I wouldn't be here
> > with this timing :)
> > 
> > 
> > > The separate compiler file changes are much more sensible,
> > > even if it takes a few days.
> > 
> > A few days are fine, but I think some form of fix in 4.19-rc1 would be
> > good.
> > 
> > I'll stop taking your time now, but I think you are/were underestimating
> > how many people use clang with the linux kernel headers indirectly.
> > BPF is a well-used tool :)
> 
> Hi Dominique,
> I'm currently testing a fix in
> https://github.com/ClangBuiltLinux/linux/commit/1f89ae7622c26b8131f42f3a362d6ef41b88a595,
> can you please share with me your steps to test/verify that the patch
> fixes the issue for eBPF?  I'll go talk to a co-worker who know more
> about eBPF, but I've not yet done anything with it.

A mild suggestion about the patch would be to break it up into
2 patches to improve how people read and review them.

1 include/linux/compiler-*
2 everything else

Yes, some kernel configs might not build properly between 1 and 2
but that likely doesn't matter as those configs probably don't
build before 1 either.

Perhaps the test in arch/arm/kernel/asm-offsets.c for incompatible
gcc compiler versions from 4.8.0 to 4.8.2 should be moved to
compiler-gcc.h.

> Also, does anyone know who I should talk to about ICC testing?

No clue
