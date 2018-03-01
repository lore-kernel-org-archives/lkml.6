Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031577AbeCAO3K (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 09:29:10 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51807 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031397AbeCAO3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 09:29:07 -0500
X-Google-Smtp-Source: AG47ELsOpyfsGDACTa9v6/LvQpMfTavxLx+f1NaVL/y7SJe2Swslv/yPzY3IWNCyLuPPRbdedNSCpQ==
Date: Thu, 1 Mar 2018 17:28:55 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Matthew Wilcox <mawilcox@microsoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] s390: Use _refcount for pgtables
Message-ID: <20180301142855.emaa5x65oj2hkwsm@node.shutemov.name>
References: <20180228223157.9281-1-willy@infradead.org>
 <20180228223157.9281-2-willy@infradead.org>
 <20180301125310.jx6c5dypk5axrmum@node.shutemov.name>
 <20180301150420.19a14fd3@mschwideX1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301150420.19a14fd3@mschwideX1>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 03:04:20PM +0100, Martin Schwidefsky wrote:
> On Thu, 1 Mar 2018 15:53:10 +0300
> "Kirill A. Shutemov" <kirill@shutemov.name> wrote:
> 
> > On Wed, Feb 28, 2018 at 02:31:54PM -0800, Matthew Wilcox wrote:
> > > From: Matthew Wilcox <mawilcox@microsoft.com>
> > > 
> > > s390 borrows the storage used for _mapcount in struct page in order to
> > > account whether the bottom or top half is being used for 2kB page
> > > tables.  I want to use that for something else, so use the top byte of
> > > _refcount instead of the bottom byte of _mapcount.  _refcount may
> > > temporarily be incremented by other CPUs that see a stale pointer to
> > > this page in the page cache, but each CPU can only increment it by one,
> > > and there are no systems with 2^24 CPUs today, so they will not change
> > > the upper byte of _refcount.  We do have to be a little careful not to
> > > lose any of their writes (as they will subsequently decrement the
> > > counter).  
> > 
> > Hm. I'm more worried about false-negative put_page_testzero().
> > Are you sure it won't lead to leaks. I cannot say from the code changes.
> > 
> > And for page-table pages should have planty space in other fields.
> > IIRC page->mapping is unused there.
>  
> 2^^24 put_page_testzero calls for page table pages? I don't think so.

No, I mean oposite: we don't free the page when we should. 2^24 is not
zero and page won't be freed if the acctual refcount (without the flag in
upper bits) drops to zero.

-- 
 Kirill A. Shutemov
