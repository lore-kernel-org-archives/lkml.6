Return-Path: <kernel-hardening-return-11791-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224wDlq0IsjeEdgROK+Da/WOMHdRrOyM1Y6dSYkd6f7ZvKAlVkEqukl6Tr00ClxAEItEeLhX
ARC-Seal: i=1; a=rsa-sha256; t=1518642745; cv=none;
        d=google.com; s=arc-20160816;
        b=L1DktkAGSU3GxOD99pb/oPEDyaRI4QEGfWoCCyfqLj3bcDUN9ISe/4kxyz9qawfgEh
         Nu3Y0WR3pRHdWoc3hqWS0+GiUwPpCO1H+IQ4TaRvBcgmLv9FitNcpuOwmZfYO/k1OhNc
         ku8eh2lBFb5AJCL7e+YcsFkuunPBbM3NRUJSxrUTJIcIhsu0QM0xDvzqA7TCK/bkS9v2
         VQRuqTBQC7OSYXbNg2xWAiyxaBFSvpxbL2qGCWAKZK8oCuZGM06Bp8hdU5QD3/09QgRl
         4kbfvsj53NPG/60xvBBdwQZq1AvUJcq++4ebyy2rR3un+AmMhfV5QgxkvucxF02CeDep
         y8IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=nyuSuGbtvJS+QInSQWFhhBy9ufKTjWBnNeT4tWQf33s=;
        b=yLj04/XXFx+/Lb12J4YYhwfu6grxDn5GQijkMzFFqjxsQNcBOVpaxUJ/GL24WqQXb2
         0lr1PJEYTXB0dkT+SqGagGj0vg3eBLks4VG4fTfChh+dk2Ex3sy5ZXww4EATkpLdWUmG
         qbs1O7YFswfR5H7XHh0EHN9HOfb+9sb0orsh0PoF3dXHiI6/Vl1uNXX0c2YpLgAwzc97
         FAUVtKlSnqdrB9z5zvSVRzyMWrA0grmoE253gp8ksSmLNVH1yygBSoAIuJZY8/6yZTR1
         5QLok1XWXk3hBgWeLph5NrJVMwhcf9DMPWo6mODhtRAgYFlHGxVhqsHFUU85lh9em9MK
         jlsA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=p1+wRhSq;
       spf=pass (google.com: domain of kernel-hardening-return-11791-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11791-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=p1+wRhSq;
       spf=pass (google.com: domain of kernel-hardening-return-11791-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11791-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 14 Feb 2018 13:12:03 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <mawilcox@microsoft.com>, linux-mm@kvack.org,
	Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v2 2/8] mm: Add kvmalloc_ab_c and kvzalloc_struct
Message-ID: <20180214211203.GF20627@bombadil.infradead.org>
References: <20180214201154.10186-1-willy@infradead.org>
 <20180214201154.10186-3-willy@infradead.org>
 <1518641152.3678.28.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518641152.3678.28.camel@perches.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592408583578566616?=
X-GMAIL-MSGID: =?utf-8?q?1592412335346894289?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 12:45:52PM -0800, Joe Perches wrote:
> On Wed, 2018-02-14 at 12:11 -0800, Matthew Wilcox wrote:
> > We have kvmalloc_array in order to safely allocate an array with a
> > number of elements specified by userspace (avoiding arithmetic overflow
> > leading to a buffer overrun).  But it's fairly common to have a header
> > in front of that array (eg specifying the length of the array), so we
> > need a helper function for that situation.
> > 
> > kvmalloc_ab_c() is the workhorse that does the calculation, but in spite
> > of our best efforts to name the arguments, it's really hard to remember
> > which order to put the arguments in.  kvzalloc_struct() eliminates that
> > effort; you tell it about the struct you're allocating, and it puts the
> > arguments in the right order for you (and checks that the arguments
> > you've given are at least plausible).
> > 
> > For comparison between the three schemes:
> > 
> > 	sev = kvzalloc(sizeof(*sev) + sizeof(struct v4l2_kevent) * elems,
> > 			GFP_KERNEL);
> > 	sev = kvzalloc_ab_c(elems, sizeof(struct v4l2_kevent), sizeof(*sev),
> > 			GFP_KERNEL);
> > 	sev = kvzalloc_struct(sev, events, elems, GFP_KERNEL);
> 
> Perhaps kv[zm]alloc_buf_and_array is better naming.

I think that's actively misleading.  The programmer isn't allocating a
buf, they're allocating a struct.  kvzalloc_hdr_arr was the earlier name,
and that made some sense; they're allocating an array with a header.
But nobody thinks about it like that; they're allocating a structure
with a variably sized array at the end of it.

If C macros had decent introspection, I'd like it to be:

	sev = kvzalloc_struct(elems, GFP_KERNEL);

and have the macro examine the structure pointed to by 'sev', check
the last element was an array, calculate the size of the array element,
and call kvzalloc_ab_c.  But we don't live in that world, so I have to
get the programmer to tell me the structure and the name of the last
element in it.
