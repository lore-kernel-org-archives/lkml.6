Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753323AbeBVKNU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 05:13:20 -0500
Received: from prv-mh.provo.novell.com ([137.65.248.74]:46965 "EHLO
        prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752961AbeBVKNT (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:6:1>);
        Thu, 22 Feb 2018 05:13:19 -0500
Message-Id: <5A8EA5CD02000078001AA4CA@prv-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Thu, 22 Feb 2018 03:13:17 -0700
From: "Jan Beulich" <JBeulich@suse.com>
To: "Ingo Molnar" <mingo@kernel.org>
Cc: <mingo@elte.hu>, <tglx@linutronix.de>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>,
        <hpa@zytor.com>
Subject: Re: [PATCH v2] x86: consider effective protection attributes
 in W+X check
References: <5A8D917302000078001AA055@prv-mh.provo.novell.com>
 <20180221165344.ioxrxbsd6kkrhr2v@gmail.com>
In-Reply-To: <20180221165344.ioxrxbsd6kkrhr2v@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 21.02.18 at 17:53, <mingo@kernel.org> wrote:

> * Jan Beulich <JBeulich@suse.com> wrote:
> 
>> Using just the leaf page table entry flags would cause a false warning
>> in case _PAGE_RW is clear or _PAGE_NX is set in a higher level entry.
>> Hand through both the current entry's flags as well as the accumulated
>> effective value (the latter as pgprotval_t instead of pgprot_t, as it's
>> not an actual entry's value).
>> 
>> This in particular eliminates the false W+X warning when running under
>> Xen, as commit 2cc42bac1c ("x86-64/Xen: eliminate W+X mappings") has to
>> make the necessary adjustment in L2 rather than L1 (the reason is
>> explained there). I.e. _PAGE_RW is clear there in L1, but _PAGE_NX is
>> set in L2.
>> 
>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>> Reviewed-by: Juergen Gross <jgross@suse.com>
>> ---
>> v2: Re-base onto tip tree. Add Xen related paragraph to description.
>> ---
>>  arch/x86/mm/dump_pagetables.c |   92 
> ++++++++++++++++++++++++++----------------
>>  1 file changed, 57 insertions(+), 35 deletions(-)
> 
> There's a build failure with CONFIG_KASAN=y enabled:
> 
>  arch/x86/mm/dump_pagetables.c: In function ‘kasan_page_table’:
>  arch/x86/mm/dump_pagetables.c:365:3: error: too few arguments to function ‘note_page’
>  arch/x86/mm/dump_pagetables.c:238:13: note: declared here

Oh, I see. Question though is what to pass as the extra argument:
Do I need to pass in the caller's effective rights, or should I take
kasan_page_table()'s checking against kasan_zero_p?d as an
indication that the effective permission is zero here? I'm sorry for
this probably trivial question, but I know nothing about how KASAN
works.

Jan
