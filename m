Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751233AbeBTIWT convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 03:22:19 -0500
Received: from prv-mh.provo.novell.com ([137.65.248.74]:49654 "EHLO
        prv-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbeBTIWS (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:6:1>);
        Tue, 20 Feb 2018 03:22:18 -0500
Message-Id: <5A8BE8C602000078001A9729@prv-mh.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date: Tue, 20 Feb 2018 01:22:14 -0700
From: "Jan Beulich" <JBeulich@suse.com>
To: "Ingo Molnar" <mingo@kernel.org>
Cc: <mingo@elte.hu>, <tglx@linutronix.de>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Juergen Gross" <jgross@suse.com>, <linux-kernel@vger.kernel.org>,
        <hpa@zytor.com>
Subject: Re: [PATCH RESEND] x86: consider effective protection
 attributes in W+X check
References: <5A8BDF3602000078001A96CD@prv-mh.provo.novell.com>
 <20180220081042.wgriecqneizg3df7@gmail.com>
In-Reply-To: <20180220081042.wgriecqneizg3df7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> On 20.02.18 at 09:10, <mingo@kernel.org> wrote:
> * Jan Beulich <JBeulich@suse.com> wrote:
>> Using just the leaf page table entry flags would cause a false warning
>> in case _PAGE_RW is clear or _PAGE_NX is set in a higher level entry.
> 
> Under what circumstances did you see false positive warnings?

As explained in the 2-patch series this was originally part of, there
continues to be that W+X warning when running under Xen, as
commit 2cc42bac1c ("x86-64/Xen: eliminate W+X mappings") has
to make the necessary adjustment in L2 rather than L1 (the
reason is explained there). I.e. _PAGE_RW is clear there in L1,
but _PAGE_NX is set in L2.

>> Hand through both the current entry's flags as well as the accumulated
>> effective value (the latter as pgprotval_t instead of pgprot_t, as it's
>> not an actual entry's value).
>> 
>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>> Reviewed-by: Juergen Gross <jgross@suse.com>
>> ---
>>  arch/x86/mm/dump_pagetables.c |   92 ++++++++++++++++++++++++++----------------
>>  1 file changed, 57 insertions(+), 35 deletions(-)
> 
> Could you please rebase this on top of latest tip:master, which changed 
> arch/x86/mm/dump_pagetables.c non-trivially due the dynamic 5 level paging 
> changes?

I'll see what I can do; it's a pity that the change here, which had
been sent weeks ago and is a bug fix, hadn't gone in before that
other change (being more an improvement than a bug fix). At
least it doesn't look like the re-basing would be very difficult.

Jan
