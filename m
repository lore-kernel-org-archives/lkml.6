Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FA4C67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F982084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 23:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F982084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mirbsd.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbeLKXj2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:39:28 -0500
Received: from static-87-79-237-121.netcologne.de ([87.79.237.121]:7619 "EHLO
        herc.mirbsd.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeLKXj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 18:39:28 -0500
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
        by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id wBBNZbgp028297
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 11 Dec 2018 23:35:38 GMT
Date:   Tue, 11 Dec 2018 23:35:36 +0000 (UTC)
From:   Thorsten Glaser <tg@mirbsd.de>
X-X-Sender: tg@herc.mirbsd.org
To:     Andy Lutomirski <luto@kernel.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Florian Weimer <fweimer@redhat.com>,
        Mike Frysinger <vapier@gentoo.org>,
        "H. J. Lu" <hjl.tools@gmail.com>, Rich Felker <dalias@libc.org>,
        x32@buildd.debian.org, Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: Can we drop upstream Linux x32 support?
In-Reply-To: <CALCETrWgpAX7FV23zHmid83SsgnwFMKD4a_-xSEgB6v0kJR5sA@mail.gmail.com>
Message-ID: <Pine.BSM.4.64L.1812112327500.21176@herc.mirbsd.org>
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
 <CAHk-=wi_Kp=3XmGDdzmadzFSPFvuL+aAJ6ZPAR=o4z=KwYT2vw@mail.gmail.com>
 <Pine.BSM.4.64L.1812112150480.21176@herc.mirbsd.org>
 <CALCETrWgpAX7FV23zHmid83SsgnwFMKD4a_-xSEgB6v0kJR5sA@mail.gmail.com>
Content-Language: de-DE-1901, en-GB
X-Message-Flag: Your mailer is broken. Get an update at http://www.washington.edu/pine/getpine/pcpine.html for free.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski dixit:

>What happens if someone adds a struct like:
>
>struct nasty_on_x32 {
>  __kernel_long_t a;
>  void * __user b;
>};
>
>On x86_64, that's two 8-byte fields.  On x86_32, it's two four-byte
>fields.  On x32, it's an 8-byte field and a 4-byte field.  Now what?

Yes, that’s indeed ugly. I understand. But don’t we already have
this problem with architectures which support multiple ABIs at the
same time? An amd64 kernel with i386 userspace comes to mind, or
the multiple MIPS ABIs.

>I'm sure we could have some magic gcc plugin or other nifty tool that
>gives us:
>
>copy_from_user(struct struct_name, kernel_ptr, user_ptr);

Something like that might be useful. Generate call stubs, which
then call the syscall implementation with the actual user-space
struct contents as arguments. Hm, that might be too generic to
be useful. Generate macros that can read from or write specific
structures to userspace?

I think something like this could solve other more general problems
as well, so it might be “nice to have anyway”. Of course it’s work,
and I’m not involved enough in Linux kernel programming to be able
to usefully help with it (doing too much elsewhere already).

>actually do this work.  Instead we get ad hoc fixes for each syscall,
>along the lines of preadv64v2(), which get done when somebody notices

Yes, that’s absolutely ugly and ridiculous and all kinds of bad.

On the other hand, from my current experience, someone (Arnd?) noticed
all the currently existing baddies for x32 already and fixed them.

New syscalls are indeed an issue, but perhaps something generating
copyinout stubs could help. This might allow other architectures
that could do with a new ABI but have until now feared the overhead
as well. (IIRC, m68k could do with a new ABI that reserves a register
for TLS, but Geert would know. At the same time, time_t and off_t could
be bumped to 64 bit. Something like that. If changing sizes of types
shared between kernel and user spaces is not something feared…)

Thanks for considering,
//mirabilos
-- 
„Cool, /usr/share/doc/mksh/examples/uhr.gz ist ja ein Grund,
mksh auf jedem System zu installieren.“
	-- XTaran auf der OpenRheinRuhr, ganz begeistert
(EN: “[…]uhr.gz is a reason to install mksh on every system.”)
