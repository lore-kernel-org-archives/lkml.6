Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751412AbeBWH5t (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 02:57:49 -0500
Received: from prv-mh.provo.novell.com ([137.65.248.74]:53672 "EHLO
        prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751283AbeBWH5s (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:9:1>);
        Fri, 23 Feb 2018 02:57:48 -0500
Message-Id: <5A8FD78902000078001AAB7B@prv-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Fri, 23 Feb 2018 00:57:45 -0700
From: "Jan Beulich" <JBeulich@suse.com>
To: "Ingo Molnar" <mingo@kernel.org>
Cc: "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <a.p.zijlstra@chello.nl>, <mingo@elte.hu>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        "Alexander Potapenko" <glider@google.com>, <tglx@linutronix.de>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>,
        "Andrey Ryabinin" <aryabinin@virtuozzo.com>, <hpa@zytor.com>
Subject: Re: [PATCH v2] x86: consider effective protection attributes
 in W+X check
References: <5A8D917302000078001AA055@prv-mh.provo.novell.com>
 <20180221165344.ioxrxbsd6kkrhr2v@gmail.com>
 <5A8EA5CD02000078001AA4CA@prv-mh.provo.novell.com>
 <20180223074958.m55bodw7hnzmj2yh@gmail.com>
In-Reply-To: <20180223074958.m55bodw7hnzmj2yh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 23.02.18 at 08:49, <mingo@kernel.org> wrote:

> * Jan Beulich <JBeulich@suse.com> wrote:
> 
>> >>> On 21.02.18 at 17:53, <mingo@kernel.org> wrote:
>> 
>> > * Jan Beulich <JBeulich@suse.com> wrote:
>> > 
>> >> Using just the leaf page table entry flags would cause a false warning
>> >> in case _PAGE_RW is clear or _PAGE_NX is set in a higher level entry.
>> >> Hand through both the current entry's flags as well as the accumulated
>> >> effective value (the latter as pgprotval_t instead of pgprot_t, as it's
>> >> not an actual entry's value).
>> >> 
>> >> This in particular eliminates the false W+X warning when running under
>> >> Xen, as commit 2cc42bac1c ("x86-64/Xen: eliminate W+X mappings") has to
>> >> make the necessary adjustment in L2 rather than L1 (the reason is
>> >> explained there). I.e. _PAGE_RW is clear there in L1, but _PAGE_NX is
>> >> set in L2.
>> >> 
>> >> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>> >> Reviewed-by: Juergen Gross <jgross@suse.com>
>> >> ---
>> >> v2: Re-base onto tip tree. Add Xen related paragraph to description.
>> >> ---
>> >>  arch/x86/mm/dump_pagetables.c |   92 
>> > ++++++++++++++++++++++++++----------------
>> >>  1 file changed, 57 insertions(+), 35 deletions(-)
>> > 
>> > There's a build failure with CONFIG_KASAN=y enabled:
>> > 
>> >  arch/x86/mm/dump_pagetables.c: In function ‘kasan_page_table’:
>> >  arch/x86/mm/dump_pagetables.c:365:3: error: too few arguments to function ‘note_page’
>> >  arch/x86/mm/dump_pagetables.c:238:13: note: declared here
>> 
>> Oh, I see. Question though is what to pass as the extra argument:
>> Do I need to pass in the caller's effective rights, or should I take
>> kasan_page_table()'s checking against kasan_zero_p?d as an
>> indication that the effective permission is zero here? I'm sorry for
>> this probably trivial question, but I know nothing about how KASAN
>> works.
> 
> I'm not sure either - but I've Cc:-ed the KASAN gents who might be able to
> help us out here?

Actually, the "zero" in the names of the symbols meanwhile makes
me be pretty sure passing 0 for the effective permissions here is
exactly what is wanted. I'm about to produce v3.

Jan
