Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5912BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2253120842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbfBYVIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:08:04 -0500
Received: from smtprelay0228.hostedemail.com ([216.40.44.228]:59686 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726602AbfBYVIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:08:04 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id EF9D0181D33FB;
        Mon, 25 Feb 2019 21:08:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ball08_8042e3de7ac5d
X-Filterd-Recvd-Size: 2416
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Feb 2019 21:08:01 +0000 (UTC)
Message-ID: <4c48dea49377612eb85a699de8a52ee12eef3de3.camel@perches.com>
Subject: Re: [PATCH] x86/uaccess: Remove unused __addr_ok() macro
From:   Joe Perches <joe@perches.com>
To:     Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Tobin C. Harding" <tobin@kernel.org>
Date:   Mon, 25 Feb 2019 13:08:00 -0800
In-Reply-To: <20190225194203.GI26145@zn.tnic>
References: <20190225191109.7671-1-bp@alien8.de>
         <CAHk-=wjOtNqb98XxYks0PMdhqgNiu97_hDxqOKG8Sz3F8H=VcQ@mail.gmail.com>
         <20190225194203.GI26145@zn.tnic>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-25 at 20:42 +0100, Borislav Petkov wrote:
> On Mon, Feb 25, 2019 at 11:20:42AM -0800, Linus Torvalds wrote:
> > On Mon, Feb 25, 2019 at 11:11 AM Borislav Petkov <bp@alien8.de> wrote:
> > > This was caught while staring at the whole {set,get}_fs() machinery.
> > 
> > Heh.
> > 
> > You should probably have researched _when_ it became unused.
> > 
> > That seems to have happened in commit 5723aa993d83 ("x86: use the new
> > generic strnlen_user() function") which removed the single user from
> > the x86-32 version of strnlen_user(), which used to have
> > 
> >         unsigned long mask = -__addr_ok(s);
> 
> Yap, found it. I still have
> 
> $ git log -p -G__addr_ok --pickaxe-all
> 
> in one of the shells' history here.
> 
> I'll add that to the commit message.
> 
> Thx.

Looks like it's not used in several arches

$ git grep -w __addr_ok
arch/arm/include/asm/uaccess.h:#define __addr_ok(addr)          ((void)(addr), 1)
arch/csky/include/asm/uaccess.h:#define __addr_ok(addr) (access_ok(addr, 0))
arch/openrisc/include/asm/uaccess.h:#define __addr_ok(addr) ((unsigned long) addr < get_fs())
arch/sh/include/asm/uaccess.h:#define __addr_ok(addr) \
arch/sh/include/asm/uaccess.h:  __ao_end >= __ao_a && __addr_ok(__ao_end); })
arch/x86/include/asm/uaccess.h:#define __addr_ok(addr)  \


