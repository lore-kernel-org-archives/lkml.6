Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0DAECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4BBE20652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="ThGLCYxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4BBE20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388454AbeGTSiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:38:07 -0400
Received: from 8bytes.org ([81.169.241.247]:38372 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388126AbeGTSiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:38:07 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5F13A450; Fri, 20 Jul 2018 19:48:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=8bytes.org; s=mail-1;
        t=1532108926; bh=85PPMjOMK5DOxznIfBJl+ArmoPBZQJXSuXzoGltc1Fw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ThGLCYxoEck0Z+Xro96+rPC2t1h3F0z3dSacDbzK5HeRwPTtU08f4OsV/hqF6Avui
         6uRk1L9APGnYsUgJ7x/xjiMMqPZOo+t8fRcLr9A1SeZdWg2Q8/1rb9y3WoL+RgItpg
         MZKMx8t9SPnC4/AGHIA7VTQtW+nSgx1OupDipsBkdkgAMTyl+bLpugCO58amAu2Dn9
         ds/iGFeVfvVYL3m7JfXWBOgL8FX3qNA5k016LJf1I4pFWnRCHBeWiVKJZknUoSFhnT
         LbKY2bFOGBmJ9cDzC3gb8iGQ+/0no3kxKyRcct8af8OOq7TcfRhR8ZSm2q0p8fh4Wm
         IOLMLUwGyr/9w==
Date:   Fri, 20 Jul 2018 19:48:46 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Brian Gerst <brgerst@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Liguori, Anthony" <aliguori@amazon.com>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Hugh Dickins <hughd@google.com>,
        Kees Cook <keescook@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        "David H . Gutteridge" <dhgutteridge@sympatico.ca>,
        Joerg Roedel <jroedel@suse.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 1/3] perf/core: Make sure the ring-buffer is mapped in
 all page-tables
Message-ID: <20180720174846.GF18541@8bytes.org>
References: <1532103744-31902-1-git-send-email-joro@8bytes.org>
 <1532103744-31902-2-git-send-email-joro@8bytes.org>
 <CALCETrXJX8tPVgD=Ce41534uneAAobm-HyjeGwVYgJDJ_+-bDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXJX8tPVgD=Ce41534uneAAobm-HyjeGwVYgJDJ_+-bDw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 10:06:54AM -0700, Andy Lutomirski wrote:
> > On Jul 20, 2018, at 6:22 AM, Joerg Roedel <joro@8bytes.org> wrote:
> >
> > From: Joerg Roedel <jroedel@suse.de>
> >
> > The ring-buffer is accessed in the NMI handler, so we better
> > avoid faulting on it. Sync the vmalloc range with all
> > page-tables in system to make sure everyone has it mapped.
> >
> > This fixes a WARN_ON_ONCE() that can be triggered with PTI
> > enabled on x86-32:
> >
> >    WARNING: CPU: 4 PID: 0 at arch/x86/mm/fault.c:320 vmalloc_fault+0x220/0x230
> >
> > This triggers because with PTI enabled on an PAE kernel the
> > PMDs are no longer shared between the page-tables, so the
> > vmalloc changes do not propagate automatically.
> 
> It seems like it would be much more robust to fix the vmalloc_fault()
> code instead.

The question is whether the NMI path is nesting-safe, then we can remove
the WARN_ON_ONCE(in_nmi()) in the vmalloc_fault path. It should be
nesting-safe on x86-32 because of the way the stack-switch happens
there. If its also nesting-safe on x86-64 the warning there can be
removed.

Or did you think of something else to fix there?


Thanks,

	Joerg

