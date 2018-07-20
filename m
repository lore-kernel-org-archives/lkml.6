Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399C8ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECAC2206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 21:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECAC2206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbeGTW1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 18:27:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:37400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727412AbeGTW1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 18:27:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DC5EEACFB;
        Fri, 20 Jul 2018 21:37:02 +0000 (UTC)
Date:   Fri, 20 Jul 2018 23:37:00 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH 1/3] perf/core: Make sure the ring-buffer is mapped in
 all page-tables
Message-ID: <20180720213700.gh6d2qd2ck6nt4ax@suse.de>
References: <1532103744-31902-1-git-send-email-joro@8bytes.org>
 <1532103744-31902-2-git-send-email-joro@8bytes.org>
 <CALCETrXJX8tPVgD=Ce41534uneAAobm-HyjeGwVYgJDJ_+-bDw@mail.gmail.com>
 <20180720174846.GF18541@8bytes.org>
 <CALCETrUj4cLpOKUbJUfLqKJFkjAgeraE=ORQ-e-bKU+AHda0=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUj4cLpOKUbJUfLqKJFkjAgeraE=ORQ-e-bKU+AHda0=Q@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 12:32:10PM -0700, Andy Lutomirski wrote:
> I'm just reading your changelog, and you said the PMDs are no longer
> shared between the page tables.  So this presumably means that
> vmalloc_fault() no longer actually works correctly on PTI systems.  I
> didn't read the code to figure out *why* it doesn't work, but throwing
> random vmalloc_sync_all() calls around is wrong.

Hmm, so the whole point of vmalloc_fault() fault is to sync changes from
swapper_pg_dir to process page-tables when the relevant parts of the
kernel page-table are not shared, no?

That is also the reason we don't see this on 64 bit, because there these
parts *are* shared.

So with that reasoning vmalloc_fault() works as designed, except that
a warning is issued when it's happens in the NMI path. That warning comes
from

	ebc8827f75954 x86: Barf when vmalloc and kmemcheck faults happen in NMI

which went into 2.6.37 and was added because the NMI handler were not
nesting-safe back then. Reason probably was that the handler on 64 bit
has to use an IST stack and a nested NMI would overwrite the stack of
the upper handler.  We don't have this problem on 32 bit as a nested NMI
will not do another stack-switch there.

I am not sure about 64 bit, but there is a lot of assembly magic to make
NMIs nesting-safe, so I guess the problem should be gone there too.


Regards,

	Joerg
