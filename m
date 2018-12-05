Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2183C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99EE020851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 12:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99EE020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeLEMPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 07:15:25 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:55402 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbeLEMPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 07:15:24 -0500
Received: from 79.184.252.87.ipv4.supernova.orange.pl (79.184.252.87) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.157)
 id 445ed31fa8b29caa; Wed, 5 Dec 2018 13:15:22 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        x86 maintainers <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Linux 4.20-rc5: Lab setup broken by build-related x86 change
Date:   Wed, 05 Dec 2018 13:15:10 +0100
Message-ID: <1753172.TxHhsZQBsE@aspire.rjw.lan>
In-Reply-To: <CAHk-=wizcNrsoyCM1EXQqoswMCYsJaby2iAkZb9wBAzDEhvxNg@mail.gmail.com>
References: <CAHk-=wizcNrsoyCM1EXQqoswMCYsJaby2iAkZb9wBAzDEhvxNg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, December 3, 2018 12:30:24 AM CET Linus Torvalds wrote:
> Hmm.. I'd like to say it was a normal week, but I'd be lying. rc5 is
> the biggest rc so far (with the obvious exception of rc1), and it
> looks fairly unusual in the diffstat too, with almost a third being
> arch updates. Yes, another third is drivers (normal), but even there
> almost half is in sound. The rest is tooling, mm, core networking and
> some fs updates.
> 
> So it all looks a bit odd, although none of it is hugely _alarming_.
> One of the reasons the arch side is a bit bigger than usual at this
> stage is that we got the STIPB performance regression sorted out, for
> example.

One of the changes apparently related to this broke my lab setup in which
I build everything on a central machine, export the build directory over
NFS (read-only) to some other systems and run "make modules_install" on
them from there.

After commit

commit 4cd24de3a0980bf3100c9dcb08ef65ca7c31af48
Author: Zhenzhong Duan <zhenzhong.duan@oracle.com>
Date:   Fri Nov 2 01:45:41 2018 -0700

    x86/retpoline: Make CONFIG_RETPOLINE depend on compiler support
    
    Since retpoline capable compilers are widely available, make
    CONFIG_RETPOLINE hard depend on the compiler capability.
    
    Break the build when CONFIG_RETPOLINE is enabled and the compiler does not
    support it. Emit an error message in that case:
    
     "arch/x86/Makefile:226: *** You are building kernel with non-retpoline
      compiler, please update your compiler..  Stop."
    
    [dwmw: Fail the build with non-retpoline compiler]

which is new in -rc5, the "make modules_install" step fails with the above
message, which doesn't make sense even, because the compiler on the clients
is the same as on the central machine in the lab and it can do retpolines
just fine.

Obviously this is due to the RETPOLINE_CFLAGS check added by the commit above.
Annoying that. :-)

Cheers,
Rafael

