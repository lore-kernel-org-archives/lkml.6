Return-Path: <kernel-hardening-return-12106-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtgA3rYVnsC1n/7ygMXHvSOQDrjK0Z5z3hJwd4cAM+mV6mRt3WFjQBxaZKAiWtpCs0N3UQB
ARC-Seal: i=1; a=rsa-sha256; t=1520267049; cv=none;
        d=google.com; s=arc-20160816;
        b=y7h5ugQKovi/Kpv8vNQpZTGHPYfUsq1jGgsMMTmGg5evxtXp1N6hzes7FsY6sPiKPc
         bSxytpcDgQQ0Y8lgLDyucELiXPF0MVWXpYmKFmuGEX92Dby5vPDOlTMsqTomF1571R84
         YhXX4J2D3gO/ZebdSJ3lcT4x3ZUnhfzF4GUcNkMRhbIv8C8Lr03eYujYHKfqavB7s3mP
         IdIdY11ocKlH0prfOzTClwfl/gqFnx06ANBAhARuW0vt0fchQGygdyMj7hxl7MUS9FgU
         a8KJGQ+BeWHjm/3O6A3I8/sLxRnZBH8GkuWVOKAcL3/i5zNNJRapDE3kPBW3WCmFJW85
         UGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=apZaAkEhz5c1aXOSvECczVllYwmhd3LNsi00W8NR9Dg=;
        b=I6tZX8t82/y2mfDxO8QdEVPinjQd6YoKVspwz8agdOcpFsizeUlKhE77+zVsxgdTXO
         e7ny8Fyd2c1yUIjOct2eWCsw4kkC2ROna06IpnrqJXI3WUYezPBwquzMKLDSzYPL2IoR
         pjFiXcVPZECJgSqlobmkXd/vNZCrpppdBtz3rGEYnkx/ogeGb+z4mkfIUWyLqmBmQefs
         XZ4ClPdAg3n6O+roGFEJdXj4bv+1EkoykosNIIpMP5c9D2ytZ3JLuyAt1Zui7NGyTAup
         DPkeK63uyp8NqmFtApblUWIH8YJVWUY/xNFfu7f76wbHNiYBrxE4fsxENKEM38NiEv1o
         M+pg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=RXiK4kQb;
       spf=pass (google.com: domain of kernel-hardening-return-12106-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12106-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=RXiK4kQb;
       spf=pass (google.com: domain of kernel-hardening-return-12106-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12106-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Mon, 5 Mar 2018 08:23:43 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Ilya Smith <blackzert@gmail.com>
Cc: Daniel Micay <danielmicay@gmail.com>, Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michal Hocko <mhocko@suse.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Jan Kara <jack@suse.cz>, Jerome Glisse <jglisse@redhat.com>,
	Hugh Dickins <hughd@google.com>, Helge Deller <deller@gmx.de>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Oleg Nesterov <oleg@redhat.com>, Linux-MM <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Subject: Re: [RFC PATCH] Randomization of address chosen by mmap.
Message-ID: <20180305162343.GA8230@bombadil.infradead.org>
References: <20180227131338.3699-1-blackzert@gmail.com>
 <CAGXu5jKF7ysJqj57ZktrcVL4G2NWOFHCud8dtXFHLs=tvVLXnQ@mail.gmail.com>
 <55C92196-5398-4C19-B7A7-6C122CD78F32@gmail.com>
 <20180228183349.GA16336@bombadil.infradead.org>
 <CA+DvKQKoo1U7T_iOOLhfEf9c+K1pzD068au+kGtx0RokFFNKHw@mail.gmail.com>
 <2CF957C6-53F2-4B00-920F-245BEF3CA1F6@gmail.com>
 <CA+DvKQ+mrnm4WX+3cBPuoSLFHmx2Zwz8=FsEx51fH-7yQMAd9w@mail.gmail.com>
 <20180304034704.GB20725@bombadil.infradead.org>
 <20180304205614.GC23816@bombadil.infradead.org>
 <7FA6631B-951F-42F4-A7BF-8E5BB734D709@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7FA6631B-951F-42F4-A7BF-8E5BB734D709@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593560218941631465?=
X-GMAIL-MSGID: =?utf-8?q?1594115542182509105?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 04:09:31PM +0300, Ilya Smith wrote:
> > On 4 Mar 2018, at 23:56, Matthew Wilcox <willy@infradead.org> wrote:
> > Thinking about this more ...
> > 
> > - When you call munmap, if you pass in the same (addr, length) that were
> >   used for mmap, then it should unmap the guard pages as well (that
> >   wasn't part of the patch, so it would have to be added)
> > - If 'addr' is higher than the mapped address, and length at least
> >   reaches the end of the mapping, then I would expect the guard pages to
> >   "move down" and be after the end of the newly-shortened mapping.
> > - If 'addr' is higher than the mapped address, and the length doesn't
> >   reach the end of the old mapping, we split the old mapping into two.
> >   I would expect the guard pages to apply to both mappings, insofar as
> >   they'll fit.  For an example, suppose we have a five-page mapping with
> >   two guard pages (MMMMMGG), and then we unmap the fourth page.  Now we
> >   have a three-page mapping with one guard page followed immediately
> >   by a one-page mapping with two guard pages (MMMGMGG).
> 
> I’m analysing that approach and see much more problems:
> - each time you call mmap like this, you still  increase count of vmas as my 
> patch did

Umm ... yes, each time you call mmap, you get a VMA.  I'm not sure why
that's a problem with my patch.  I was trying to solve the problem Daniel
pointed out, that mapping a guard region after each mmap cost twice as
many VMAs, and it solves that problem.

> - now feature vma_merge shouldn’t work at all, until MAP_FIXED is set or
> PROT_GUARD(0)

That's true.

> - the entropy you provide is like 16 bit, that is really not so hard to brute

It's 16 bits per mapping.  I think that'll make enough attacks harder
to be worthwhile.

> - in your patch you don’t use vm_guard at address searching, I see many roots 
> of bugs here

Don't need to.  vm_end includes the guard pages.

> - if you unmap/remap one page inside region, field vma_guard will show head 
> or tail pages for vma, not both; kernel don’t know how to handle it

There are no head pages.  The guard pages are only placed after the real end.

> - user mode now choose entropy with PROT_GUARD macro, where did he gets it? 
> User mode shouldn’t be responsible for entropy at all

I can't agree with that.  The user has plenty of opportunities to get
randomness; from /dev/random is the easiest, but you could also do timing
attacks on your own cachelines, for example.
