Return-Path: <kernel-hardening-return-11751-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x225R3X4R63QoG4ORoS8IEI3qnJYd1DjUUaCS3LZg2MMg5+cVlwCFQJ/zrlesDwNF3wfUehZT
ARC-Seal: i=1; a=rsa-sha256; t=1518616325; cv=none;
        d=google.com; s=arc-20160816;
        b=AqiG8nty/4VnpNk0FjttA9+Sx/A5gRGy+75Zj9MWr4JnB1UJUoIxbM7XcNjY1AEIRq
         FrgfjS/jMAvz1WYWLUoMAA2NAiGR2Y9TqIcbkrMx+R/v62S8AlqZtgIkKqVoAbqCxc2N
         g+VOQAtw30tx+eg9eoWc+SZyhFH622o8uEuyWot1O5/mld339a1yPHKYjVUSVdtaSe79
         gxTpLX82C8qcVL/FEMTyXxHoZVXDou1vkGGc1Te9xK5o+8WqYj6thgSmOxS9TSbpvJaU
         IMgtPwnccZ9wlJCO7s+2Lh9l7hFz8RDsBT9NLLA048WmX0Yhuyg85GGJ7YO6B1nEh2a7
         C4nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=GtzsWCwvSpEp7ccXruLU7xTKk0SP5pFXszMhBVd60Ds=;
        b=qF1GBW54r90vlOMygYU+U9VSaX+nJFM5l/+KCasHIWKt5pLOc6ibIgMpAyOwn4Mf6E
         /bpvLb+g7TR7Sjm6mzvUGu+W/OFZiQTELtSkYLTFCK8f2WI7ppdFx/uO1Bn2wpG6SLq0
         7P6VQXmuApsgpnCVp8xwtROB1r9LQJs7ee/UyyC8bW4hy7bjDrmEZeX5TozodjTvxQFd
         bHZa3dcfFpH/8iH5UUDmJMR6lDTWVNrX6jRfY0gHaCyFeTW9RsMWmo/d7GWZv1rmdZVN
         sgPa4DDSPn3IuRtercmYVU6BAswW7Ix4Q1MOhT9VTsXDt54RDJepvhV2p9DQv6F4mgY3
         gKCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=CdUqsTC0;
       spf=pass (google.com: domain of kernel-hardening-return-11751-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11751-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=CdUqsTC0;
       spf=pass (google.com: domain of kernel-hardening-return-11751-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11751-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 14 Feb 2018 05:51:41 -0800
From: Matthew Wilcox <willy@infradead.org>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Daniel Micay <danielmicay@gmail.com>, Jann Horn <jannh@google.com>,
	linux-mm@kvack.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	kernel list <linux-kernel@vger.kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC] Limit mappings to ten per page per process
Message-ID: <20180214135141.GA16215@bombadil.infradead.org>
References: <20180208021112.GB14918@bombadil.infradead.org>
 <CAG48ez2-MTJ2YrS5fPZi19RY6P_6NWuK1U5CcQpJ25=xrGSy_A@mail.gmail.com>
 <CA+DvKQLHDR0s=6r4uiHL8kw2_PnfJcwYfPxgQOmuLbc=5k39+g@mail.gmail.com>
 <20180208185648.GB9524@bombadil.infradead.org>
 <CA+DvKQLHcFc3+kW_SnD6hs53yyD5Zi+uAeSgDMm1tRzxqy-Opg@mail.gmail.com>
 <20180208194235.GA3424@bombadil.infradead.org>
 <CA+DvKQKba0iU+tydbmGkAJsxCxazORDnuoe32sy-2nggyagUxQ@mail.gmail.com>
 <20180208202100.GB3424@bombadil.infradead.org>
 <20180208213743.GC3424@bombadil.infradead.org>
 <20180209042609.wi6zho24wmmdkg6i@node.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180209042609.wi6zho24wmmdkg6i@node.shutemov.name>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591870366530801102?=
X-GMAIL-MSGID: =?utf-8?q?1592384632169369303?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 09, 2018 at 07:26:09AM +0300, Kirill A. Shutemov wrote:
> On Thu, Feb 08, 2018 at 01:37:43PM -0800, Matthew Wilcox wrote:
> > On Thu, Feb 08, 2018 at 12:21:00PM -0800, Matthew Wilcox wrote:
> > > Now that I think about it, though, perhaps the simplest solution is not
> > > to worry about checking whether _mapcount has saturated, and instead when
> > > adding a new mmap, check whether this task already has it mapped 10 times.
> > > If so, refuse the mapping.
> > 
> > That turns out to be quite easy.  Comments on this approach?
> 
> This *may* break some remap_file_pages() users.

We have some?!  ;-)  I don't understand the use case where they want to
map the same page of a file multiple times into the same process.  I mean,
yes, of course, they might ask for it, but I don't understand why they would.
Do you have any insight here?

> And it may be rather costly for popular binaries. Consider libc.so.

We already walk this tree to insert the mapping; this just adds a second
walk of the tree to check which overlapping mappings exist.  I would
expect it to just make the tree cache-hot.
