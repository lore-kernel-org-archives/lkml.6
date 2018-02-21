Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938667AbeBUQxt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:53:49 -0500
Received: from mail-wr0-f177.google.com ([209.85.128.177]:45098 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753335AbeBUQxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:53:47 -0500
X-Google-Smtp-Source: AH8x225f+C0npS1z6iBMB3tGx3AIjIEI0NKOo/A/Nk+3xtaHYQG70TF0axORhRn+8xSYsxcNi10DOA==
Date: Wed, 21 Feb 2018 17:53:44 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Jan Beulich <JBeulich@suse.com>
Cc: mingo@elte.hu, tglx@linutronix.de, hpa@zytor.com,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: consider effective protection attributes in W+X
 check
Message-ID: <20180221165344.ioxrxbsd6kkrhr2v@gmail.com>
References: <5A8D917302000078001AA055@prv-mh.provo.novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5A8D917302000078001AA055@prv-mh.provo.novell.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Jan Beulich <JBeulich@suse.com> wrote:

> Using just the leaf page table entry flags would cause a false warning
> in case _PAGE_RW is clear or _PAGE_NX is set in a higher level entry.
> Hand through both the current entry's flags as well as the accumulated
> effective value (the latter as pgprotval_t instead of pgprot_t, as it's
> not an actual entry's value).
> 
> This in particular eliminates the false W+X warning when running under
> Xen, as commit 2cc42bac1c ("x86-64/Xen: eliminate W+X mappings") has to
> make the necessary adjustment in L2 rather than L1 (the reason is
> explained there). I.e. _PAGE_RW is clear there in L1, but _PAGE_NX is
> set in L2.
> 
> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> Reviewed-by: Juergen Gross <jgross@suse.com>
> ---
> v2: Re-base onto tip tree. Add Xen related paragraph to description.
> ---
>  arch/x86/mm/dump_pagetables.c |   92 ++++++++++++++++++++++++++----------------
>  1 file changed, 57 insertions(+), 35 deletions(-)

There's a build failure with CONFIG_KASAN=y enabled:

 arch/x86/mm/dump_pagetables.c: In function ‘kasan_page_table’:
 arch/x86/mm/dump_pagetables.c:365:3: error: too few arguments to function ‘note_page’
 arch/x86/mm/dump_pagetables.c:238:13: note: declared here

Thanks,

	Ingo
