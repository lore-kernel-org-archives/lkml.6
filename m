Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F689C67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8D820664
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 14:54:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8D820664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeJVXNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 19:13:42 -0400
Received: from verein.lst.de ([213.95.11.211]:36907 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727702AbeJVXNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 19:13:42 -0400
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 3ADE168BDF; Mon, 22 Oct 2018 16:54:48 +0200 (CEST)
Date:   Mon, 22 Oct 2018 16:54:48 +0200
From:   Torsten Duwe <duwe@lst.de>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jessica Yu <jeyu@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org
Subject: Re: [PATCH v3 3/4] arm64: implement live patching
Message-ID: <20181022145448.GA22918@lst.de>
References: <20181001140910.086E768BC7@newverein.lst.de> <20181001141652.5478C68BE1@newverein.lst.de> <alpine.LSU.2.21.1810171051560.21847@pobox.suse.cz> <20181018125820.iw54zbirq74ulknj@linux-8ccs> <CAKv+Gu_yNBN+Rpw98MAZaxzSjm20qMYD7+fiJ1fBHoUeDr9fBA@mail.gmail.com> <alpine.LSU.2.21.1810191714540.4692@pobox.suse.cz> <CAKv+Gu8Vg9-CwvU-u9gNGmtB7gTapuCPHjU5v7FWnPsVy6vptA@mail.gmail.com> <alpine.LSU.2.21.1810221452070.13146@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1810221452070.13146@pobox.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 02:53:10PM +0200, Miroslav Benes wrote:
> On Sat, 20 Oct 2018, Ard Biesheuvel wrote:
> > So I suppose this could get interesting in cases where modules are far
> > away from the kernel (i.e., more than -/+ 128 MB). Fortunately, the
> > modules themselves are always placed in a 128 MB window, but this
> > window could be out of reach for branches into the kernel proper. If
> > we find ourselves in the situation where we need to patch calls into
> > the kernel proper to point into this module, this may get interesting,
> > since the PLT entries *must* be allocated along with the module that
> > contains the branch instruction, or the PLT entry itself may be out of
> > range, defeating the purpose.
> 
> Hm... Torsten, didn't you have to solve something similar in powerpc case? 

At address ranges: that was the TOC pointer issue, that is an array of
addresses and other 64-bit constants with a reference to it kept in a register,
whose value is local to any module. PPC64 needs 5 instructions to load a 64-bit
value immediate, arm has the ldr_l macro. So in short: no. We were discussing a
few nasty tricks to reconstruct the TOC value from the code addresses, but
ended up with a solution that is clean in that respect.

At PLTs: ppc64 uses, IIRC, a regular trampoline slot to get to all called
functions, including ftrace and friends. So for e.g. live patch kernels
the total number, as predetermined, is only incremented by 2. Only the
trampoline _code_ for ftrace was modified.
I assume with "branches" you mean "branch with link" a.k.a a subroutine call?
All references to external symbols are allocated a PLT entry, right?

ftrace / live patching calls are alway intercepted at the called function.
                                       ===========--------======---------
The interceptor then uses a special trampoline to go to ftrace_caller, which
does the rest.

Am I missing something?

	Torsten

