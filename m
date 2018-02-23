Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751469AbeBWHuD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 02:50:03 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55407 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbeBWHuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 02:50:02 -0500
X-Google-Smtp-Source: AG47ELuy8w/mtiv3gB8E4re6G6COymPoHvyQWLyXaMN38PlJMV7zFGuHK7YJc2IanqMX6Q6V5tL1dw==
Date: Fri, 23 Feb 2018 08:49:58 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Jan Beulich <JBeulich@suse.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc: mingo@elte.hu, tglx@linutronix.de,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        hpa@zytor.com, Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2] x86: consider effective protection attributes in W+X
 check
Message-ID: <20180223074958.m55bodw7hnzmj2yh@gmail.com>
References: <5A8D917302000078001AA055@prv-mh.provo.novell.com>
 <20180221165344.ioxrxbsd6kkrhr2v@gmail.com>
 <5A8EA5CD02000078001AA4CA@prv-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5A8EA5CD02000078001AA4CA@prv-mh.provo.novell.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jan Beulich <JBeulich@suse.com> wrote:

> >>> On 21.02.18 at 17:53, <mingo@kernel.org> wrote:
> 
> > * Jan Beulich <JBeulich@suse.com> wrote:
> > 
> >> Using just the leaf page table entry flags would cause a false warning
> >> in case _PAGE_RW is clear or _PAGE_NX is set in a higher level entry.
> >> Hand through both the current entry's flags as well as the accumulated
> >> effective value (the latter as pgprotval_t instead of pgprot_t, as it's
> >> not an actual entry's value).
> >> 
> >> This in particular eliminates the false W+X warning when running under
> >> Xen, as commit 2cc42bac1c ("x86-64/Xen: eliminate W+X mappings") has to
> >> make the necessary adjustment in L2 rather than L1 (the reason is
> >> explained there). I.e. _PAGE_RW is clear there in L1, but _PAGE_NX is
> >> set in L2.
> >> 
> >> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> >> Reviewed-by: Juergen Gross <jgross@suse.com>
> >> ---
> >> v2: Re-base onto tip tree. Add Xen related paragraph to description.
> >> ---
> >>  arch/x86/mm/dump_pagetables.c |   92 
> > ++++++++++++++++++++++++++----------------
> >>  1 file changed, 57 insertions(+), 35 deletions(-)
> > 
> > There's a build failure with CONFIG_KASAN=y enabled:
> > 
> >  arch/x86/mm/dump_pagetables.c: In function ‘kasan_page_table’:
> >  arch/x86/mm/dump_pagetables.c:365:3: error: too few arguments to function ‘note_page’
> >  arch/x86/mm/dump_pagetables.c:238:13: note: declared here
> 
> Oh, I see. Question though is what to pass as the extra argument:
> Do I need to pass in the caller's effective rights, or should I take
> kasan_page_table()'s checking against kasan_zero_p?d as an
> indication that the effective permission is zero here? I'm sorry for
> this probably trivial question, but I know nothing about how KASAN
> works.

I'm not sure either - but I've Cc:-ed the KASAN gents who might be able to
help us out here?

Thanks,

	Ingo
