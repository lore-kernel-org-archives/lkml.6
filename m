Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752944AbeA3W2F (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:28:05 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36504 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751678AbeA3W2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:28:03 -0500
X-Google-Smtp-Source: AH8x2260InH2rjPMLo9sWHkhytT2TjzJ6bQavwezYjPvEPrTLgQq8r1gvBURHp6+EQdLenI/koHRyQ==
Date: Wed, 31 Jan 2018 01:28:00 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/3] x86/mm/encrypt: Move page table helpers into
 separate translation unit
Message-ID: <20180130222800.7hrnzpy56fb6jwnn@node.shutemov.name>
References: <20180124163623.61765-1-kirill.shutemov@linux.intel.com>
 <20180124163623.61765-2-kirill.shutemov@linux.intel.com>
 <f1005ed5-c245-b64f-fe4b-64fff5790172@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1005ed5-c245-b64f-fe4b-64fff5790172@amd.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 04:26:03PM -0600, Tom Lendacky wrote:
> On 1/24/2018 10:36 AM, Kirill A. Shutemov wrote:
> > There are bunch of functions in mem_encrypt.c that operate on the
> > identity mapping, which means they want virtual addresses to be equal to
> > physical one, without PAGE_OFFSET shift.
> > 
> > We also need to avoid paravirtualizaion call there.
> > 
> > Getting this done is tricky. We cannot use usual page table helpers.
> > It forces us to open-code a lot of things. It makes code ugly and hard
> > to modify.
> > 
> > We can get it work with the page table helpers, but it requires few
> > preprocessor tricks. These tricks may have side effects for the rest of
> > the file.
> > 
> > Let's isolate such functions into own translation unit.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> Just one minor comment at the end.  With that change:
> 
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> 
> > ---
> >  arch/x86/mm/Makefile               |  14 +-
> >  arch/x86/mm/mem_encrypt.c          | 578 +----------------------------------
> >  arch/x86/mm/mem_encrypt_identity.c | 596 +++++++++++++++++++++++++++++++++++++
> >  arch/x86/mm/mm_internal.h          |   1 +
> >  4 files changed, 607 insertions(+), 582 deletions(-)
> >  create mode 100644 arch/x86/mm/mem_encrypt_identity.c
> > 
> 
> ...
> 
> > diff --git a/arch/x86/mm/mm_internal.h b/arch/x86/mm/mm_internal.h
> > index 4e1f6e1b8159..7b4fc4386d90 100644
> > --- a/arch/x86/mm/mm_internal.h
> > +++ b/arch/x86/mm/mm_internal.h
> > @@ -19,4 +19,5 @@ extern int after_bootmem;
> >  
> >  void update_cache_mode_entry(unsigned entry, enum page_cache_mode cache);
> >  
> > +extern bool sev_enabled __section(.data);
> 
> Lets move this into arch/x86/include/asm/mem_encrypt.h and then add
> #include <linux/mem_encrypt.h> to mem_encrypt_identity.c.

Why? Will we need it beyond arch/x86/mm/ in the future?

-- 
 Kirill A. Shutemov
