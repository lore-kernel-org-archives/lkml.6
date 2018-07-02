Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA59C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A052C25043
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A052C25043
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753196AbeGBUOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:14:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38597 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752309AbeGBUOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:14:10 -0400
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1fa5D5-0006Xd-Oo; Mon, 02 Jul 2018 20:14:07 +0000
Received: from kamal by fourier with local (Exim 4.86_2)
        (envelope-from <kamal@whence.com>)
        id 1fa5D2-0000Q0-Ts; Mon, 02 Jul 2018 13:14:04 -0700
Date:   Mon, 2 Jul 2018 13:14:03 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] security: CONFIG_HARDENED_USERCOPY does not need to
 select BUG
Message-ID: <20180702201402.GA16773@whence.com>
References: <1530302661-20953-1-git-send-email-kamal@canonical.com>
 <CAGXu5jKXtq75+HkziTT-8F0VHvvOiRrtfez60h8hKK1GaE64ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKXtq75+HkziTT-8F0VHvvOiRrtfez60h8hKK1GaE64ug@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 01:27:08PM -0700, Kees Cook wrote:
> On Fri, Jun 29, 2018 at 1:04 PM, Kamal Mostafa <kamal@canonical.com> wrote:
> > Allows for CONFIG_HARDENED_USERCOPY without CONFIG_BUG.
> >
> > Signed-off-by: Kamal Mostafa <kamal@canonical.com>
> > ---
> >  security/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/security/Kconfig b/security/Kconfig
> > index c430206..7667774 100644
> > --- a/security/Kconfig
> > +++ b/security/Kconfig
> > @@ -153,7 +153,6 @@ config HAVE_HARDENED_USERCOPY_ALLOCATOR
> >  config HARDENED_USERCOPY
> >         bool "Harden memory copies between kernel and userspace"
> >         depends on HAVE_HARDENED_USERCOPY_ALLOCATOR
> > -       select BUG
> >         imply STRICT_DEVMEM
> >         help
> >           This option checks for obviously wrong memory regions when
> 
> Do the lkdtm tests for usercopy correctly halt the kernel thread if
> CONFIG_BUG is removed?
> 

Yes, they do...

With this config (specifically disabling 'FALLBACK'):

    CONFIG_HARDENED_USERCOPY=y
    # CONFIG_HARDENED_USERCOPY_FALLBACK is not set
    # CONFIG_BUG is not set

I ran the usercopy tests as follows:

    modprobe lkdtm
    cd /sys/kernel/debug/provoke-crash
    cat DIRECT | grep USERCOPY | while read x ; do echo $x | tee DIRECT || echo $?; done

Resulting in this command line output:

    USERCOPY_HEAP_SIZE_TO
    139
    USERCOPY_HEAP_SIZE_FROM
    139
    USERCOPY_HEAP_WHITELIST_TO
    139
    USERCOPY_HEAP_WHITELIST_FROM
    139
    USERCOPY_STACK_FRAME_TO
    139
    USERCOPY_STACK_FRAME_FROM
    139
    USERCOPY_STACK_BEYOND
    139
    USERCOPY_KERNEL
    139

Each test case yields kernel log output like:

    lkdtm: Performing direct entry USERCOPY_HEAP_SIZE_TO
    lkdtm: attempting good copy_to_user of correct size
    lkdtm: attempting bad copy_to_user of too large size
    usercopy: Kernel memory exposure attempt detected from SLUB object 'kmalloc-1024' (offset 16, size 1024)!
    invalid opcode: 0000 [#17] SMP PTI
    ... {panic dump} ...

Each 'tee' gets terminated with SIGSEGV and no instances appear of the
lkdtm/usercopy.c warning "copy_{to/from}_user failed, but lacked Oops".

If I leave CONFIG_HARDENED_USERCOPY_FALLBACK=y then the pair of
WHITELIST tests don't trigger a panic or SIGSEGV, as expected.

 -Kamal
