Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6032C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 22:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A58292086D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 22:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbeLOWuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 17:50:17 -0500
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:59104 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbeLOWuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 17:50:17 -0500
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1gYIl8-0001dl-00; Sat, 15 Dec 2018 22:50:10 +0000
Date:   Sat, 15 Dec 2018 17:50:10 -0500
From:   Rich Felker <dalias@libc.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        David Daney <david.daney@cavium.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Subject: Re: Fixing MIPS delay slot emulation weakness?
Message-ID: <20181215225009.GB23599@brightrain.aerifal.cx>
References: <CALCETrWaWTupSp6V=XXhvExtFdS6ewx_0A7hiGfStqpeuqZn8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWaWTupSp6V=XXhvExtFdS6ewx_0A7hiGfStqpeuqZn8g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 15, 2018 at 11:19:37AM -0800, Andy Lutomirski wrote:
> Hi all-
> 
> Some security researchers pointed out that writing to the delay slot
> emulation page is a great exploit technique on MIPS.  It was
> introduced in:
> 
> commit 432c6bacbd0c16ec210c43da411ccc3855c4c010
> Author: Paul Burton <paul.burton@imgtec.com>
> Date:   Fri Jul 8 11:06:19 2016 +0100
> 
>     MIPS: Use per-mm page to execute branch delay slot instructions
> 
> With my vDSO hat on, I hereby offer a couple of straightforward
> suggestions for fixing it.  The offending code is:
> 
>         base = mmap_region(NULL, STACK_TOP, PAGE_SIZE,
>                            VM_READ|VM_WRITE|VM_EXEC|
>                            VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
>                            0, NULL);
> 
> VM_WRITE | VM_EXEC is a big no-no, especially at a fixed address.
> 
> The really simple but possibly suboptimal fix is to get rid of
> VM_WRITE and to use get_user_pages(..., FOLL_FORCE) to write to it.
> 
> A possibly nicer way to accomplish more or less the same thing would
> be to allocate the area with _install_special_mapping() and arrange to
> keep a reference to the struct page around.
> 
> The really nice but less compatible fix would be to let processes or
> even the whole system opt out by promising not to put anything in FPU
> branch delay slots, of course.

As I noted on Twitter when Mudge brought this topic back up, there's a
much more compatible, elegant, and safe fix possible that does not
involve any W+X memory. Emulate the delay slot in kernel-space. This
is trivial to do safely for pretty much everything but loads/stores.
For loads/stores, where you want them to execute with user privilege
level, what you do is compute the effective address in kernel-space,
then return to a fixed instruction in the vdso page that performs a
generic load/store using the register the kernel put the effective
address result in, then restores registers off the stack and jumps to
the branch destination.

Rich
