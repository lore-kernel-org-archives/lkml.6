Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1984C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740FF20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740FF20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbeLFOIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:08:41 -0500
Received: from foss.arm.com ([217.140.101.70]:51352 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727704AbeLFOIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:08:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F18FA78;
        Thu,  6 Dec 2018 06:08:40 -0800 (PST)
Received: from localhost (unknown [10.1.31.65])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0867A3F575;
        Thu,  6 Dec 2018 06:08:40 -0800 (PST)
Received: from cmarinas by localhost with local (Exim 4.89)
        (envelope-from <catalin.marinas@arm.com>)
        id 1gUuKT-0003cv-5H; Thu, 06 Dec 2018 14:08:37 +0000
Date:   Thu, 6 Dec 2018 14:08:36 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Shuah Khan <shuah@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Kostya Serebryany <kcc@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v8 0/8] arm64: untag user pointers passed to the kernel
Message-ID: <20181206140836.vhhfnv7hta6pzwd4@localhost>
References: <cover.1541687720.git.andreyknvl@google.com>
 <CAAeHK+w1Qv6owkdWfjbXMFqOA8BURDN5gviw8vpgi3eon1dWmA@mail.gmail.com>
 <20181129181650.GG22027@arrakis.emea.arm.com>
 <CAAeHK+x9CuqqgvP6pZEV1Gz5cFHNpwsuUDbWQFHFzTy8GBMPKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+x9CuqqgvP6pZEV1Gz5cFHNpwsuUDbWQFHFzTy8GBMPKA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 01:44:24PM +0100, Andrey Konovalov wrote:
> On Thu, Nov 29, 2018 at 7:16 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Thu, Nov 08, 2018 at 03:48:10PM +0100, Andrey Konovalov wrote:
> > > On Thu, Nov 8, 2018 at 3:36 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> > > > Changes in v8:
> > > > - Rebased onto 65102238 (4.20-rc1).
> > > > - Added a note to the cover letter on why syscall wrappers/shims that untag
> > > >   user pointers won't work.
> > > > - Added a note to the cover letter that this patchset has been merged into
> > > >   the Pixel 2 kernel tree.
> > > > - Documentation fixes, in particular added a list of syscalls that don't
> > > >   support tagged user pointers.
> > >
> > > I've changed the documentation to be more specific, please take a look.
> > >
> > > I haven't done anything about adding a way for the user to find out
> > > that the kernel supports this ABI extension. I don't know what would
> > > the the preferred way to do this, and we haven't received any comments
> > > on that from anybody else. Probing "on some innocuous syscall
> > > currently returning -EFAULT on tagged pointer arguments" works though,
> > > as you mentioned.
> >
> > We've had some internal discussions and also talked to some people at
> > Plumbers. I think the best option is to introduce an AT_FLAGS bit to
> > describe the ABI relaxation on tagged pointers. Vincenzo is going to
> > propose a patch on top of this series.
> 
> So should I wait for a patch from Vincenzo before posting v9 or post
> it as is? Or try to develop this patch myself?

The reason Vincenzo hasn't posted his patches yet is that we are still
debating internally how to document which syscalls accept non-zero
top-byte, what to do with future syscalls for which we don't know the
semantics.

Happy to take the discussion to the public list if Vincenzo posts his
patches. The conclusion of the ABI discussion may have an impact on the
actual implementation that you are proposing in this series.

-- 
Catalin
