Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752491AbeBIEda (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 23:33:30 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51936 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752154AbeBIEd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 23:33:28 -0500
X-Google-Smtp-Source: AH8x225L1w1adbtzkdvfeIUjhg4rfbbtZqrb9r/y+mnVSi7Pmiieo4iTcUIWt25+irf0Mqv9h66y/w==
Date: Fri, 9 Feb 2018 07:33:25 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yang Shi <yang.shi@linux.alibaba.com>, kirill.shutemov@linux.intel.com,
        gavin.dg@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: thp: fix potential clearing to referenced flag in
 page_idle_clear_pte_refs_one()
Message-ID: <20180209043325.l6b6hwgeomqldeb6@node.shutemov.name>
References: <1517875596-76350-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180208143926.5484e8fd75a56ff35b778bcc@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208143926.5484e8fd75a56ff35b778bcc@linux-foundation.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 02:39:26PM -0800, Andrew Morton wrote:
> On Tue,  6 Feb 2018 08:06:36 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:
> 
> > For PTE-mapped THP, the compound THP has not been split to normal 4K
> > pages yet, the whole THP is considered referenced if any one of sub
> > page is referenced.
> > 
> > When walking PTE-mapped THP by pvmw, all relevant PTEs will be checked
> > to retrieve referenced bit. But, the current code just returns the
> > result of the last PTE. If the last PTE has not referenced, the
> > referenced flag will be cleared.
> > 
> > So, here just break pvmw walk once referenced PTE is found if the page
> > is a part of THP.
> > 
> > ...
> >
> > --- a/mm/page_idle.c
> > +++ b/mm/page_idle.c
> > @@ -67,6 +67,14 @@ static bool page_idle_clear_pte_refs_one(struct page *page,
> >  		if (pvmw.pte) {
> >  			referenced = ptep_clear_young_notify(vma, addr,
> >  					pvmw.pte);
> > +			/*
> > +			 * For PTE-mapped THP, one sub page is referenced,
> > +			 * the whole THP is referenced.
> > +			 */
> > +			if (referenced && PageTransCompound(pvmw.page)) {
> > +				page_vma_mapped_walk_done(&pvmw);
> > +				break;
> > +			}
> 
> This means that the function will no longer clear the referenced bits
> in all the ptes.  What effect does this have and should we document
> this in some fashion?

Yeah, the patch is wrong. We need to get all ptes for THP cleared.

What about something like this instead (untested):

diff --git a/mm/page_idle.c b/mm/page_idle.c
index 0a49374e6931..6876522c9dce 100644
--- a/mm/page_idle.c
+++ b/mm/page_idle.c
@@ -65,10 +65,10 @@ static bool page_idle_clear_pte_refs_one(struct page *page,
        while (page_vma_mapped_walk(&pvmw)) {
                addr = pvmw.address;
                if (pvmw.pte) {
-                       referenced = ptep_clear_young_notify(vma, addr,
+                       referenced |= ptep_clear_young_notify(vma, addr,
                                        pvmw.pte);
                } else if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
-                       referenced = pmdp_clear_young_notify(vma, addr,
+                       referenced |= pmdp_clear_young_notify(vma, addr,
                                        pvmw.pmd);
                } else {
                        /* unexpected pmd-mapped page? */
-- 
 Kirill A. Shutemov
