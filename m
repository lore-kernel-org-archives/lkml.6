Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751825AbeEDVMs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 17:12:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55670 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751760AbeEDVMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 17:12:47 -0400
Date: Fri, 4 May 2018 14:12:44 -0700
From: Matthew Wilcox <willy@infradead.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Proof-of-concept: better(?) page-table manipulation API
Message-ID: <20180504211244.GD29829@bombadil.infradead.org>
References: <20180424154355.mfjgkf47kdp2by4e@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424154355.mfjgkf47kdp2by4e@black.fi.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 06:43:56PM +0300, Kirill A. Shutemov wrote:
> +struct pt_ptr {
> +	unsigned long *ptr;
> +	int lvl;
> +};

On x86, you've got three kinds of paging scheme, referred to in the manual
as 32-bit, PAE and 4-level.  On 32-bit, you've got 3 levels (Directory,
Table and Entry), and you can encode those three levels in the bottom
two bits of the pointer.  With PAE and 4L, pointers are 64-bit aligned,
so you can encode up to eight levels in the bottom three bits of the
pointer.

> +struct pt_val {
> +	unsigned long val;
> +	int lvl;
> +};

I don't think it's possible to shrink this down to a single ulong.
_Maybe_ it is if you can squirm a single bit free from the !pte_present
case.

... this is only for x86 4L and maybe 32 paging, right?  It'd need to
use unsigned long val[2] for PAE.

I'm going to think about this some more.  There's a lot of potential here.
