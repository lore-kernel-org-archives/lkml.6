Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030594AbeCAMxZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 07:53:25 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35392 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030504AbeCAMxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 07:53:23 -0500
X-Google-Smtp-Source: AG47ELsEdfIUk9H8b3k6g/hlE0bUoM4NxVe6PHODat4pA6hYSl2eBK2Q/S9IV+yqCWiD4iZRM0AJgA==
Date: Thu, 1 Mar 2018 15:53:10 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] s390: Use _refcount for pgtables
Message-ID: <20180301125310.jx6c5dypk5axrmum@node.shutemov.name>
References: <20180228223157.9281-1-willy@infradead.org>
 <20180228223157.9281-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228223157.9281-2-willy@infradead.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 02:31:54PM -0800, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> s390 borrows the storage used for _mapcount in struct page in order to
> account whether the bottom or top half is being used for 2kB page
> tables.  I want to use that for something else, so use the top byte of
> _refcount instead of the bottom byte of _mapcount.  _refcount may
> temporarily be incremented by other CPUs that see a stale pointer to
> this page in the page cache, but each CPU can only increment it by one,
> and there are no systems with 2^24 CPUs today, so they will not change
> the upper byte of _refcount.  We do have to be a little careful not to
> lose any of their writes (as they will subsequently decrement the
> counter).

Hm. I'm more worried about false-negative put_page_testzero().
Are you sure it won't lead to leaks. I cannot say from the code changes.

And for page-table pages should have planty space in other fields.
IIRC page->mapping is unused there.

-- 
 Kirill A. Shutemov
