Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751841AbeEDVtl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 17:49:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:14009 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751651AbeEDVtk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 17:49:40 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,363,1520924400";
   d="scan'208";a="38525640"
Date: Sat, 5 May 2018 00:49:36 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: Proof-of-concept: better(?) page-table manipulation API
Message-ID: <20180504214936.v62knybljdvcnifq@black.fi.intel.com>
References: <20180424154355.mfjgkf47kdp2by4e@black.fi.intel.com>
 <20180504211244.GD29829@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504211244.GD29829@bombadil.infradead.org>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 09:12:44PM +0000, Matthew Wilcox wrote:
> On Tue, Apr 24, 2018 at 06:43:56PM +0300, Kirill A. Shutemov wrote:
> > +struct pt_ptr {
> > +	unsigned long *ptr;
> > +	int lvl;
> > +};
> 
> On x86, you've got three kinds of paging scheme, referred to in the manual
> as 32-bit, PAE and 4-level.

You forgot 5-level :)

(although it's not in the manual yet, so fair enough)

> On 32-bit, you've got 3 levels (Directory, Table and Entry), and you can
> encode those three levels in the bottom two bits of the pointer.  With
> PAE and 4L, pointers are 64-bit aligned, so you can encode up to eight
> levels in the bottom three bits of the pointer.

I didn't thought about this. Thank you.

> > +struct pt_val {
> > +	unsigned long val;
> > +	int lvl;
> > +};
> 
> I don't think it's possible to shrink this down to a single ulong.
> _Maybe_ it is if you can squirm a single bit free from the !pte_present
> case.

I don't think it worth it. It gets tricky quickly.

> ... this is only for x86 4L and maybe 32 paging, right?  It'd need to
> use unsigned long val[2] for PAE.

I didn't look at 32-bit at all. But 4L and 5L [kinda] work.

> I'm going to think about this some more.  There's a lot of potential here.

Thanks for the input.

-- 
 Kirill A. Shutemov
