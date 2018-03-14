Return-Path: <kernel-hardening-return-12584-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuXx4R5ZzLmw4H2Oz5me8pLpmDKQ8CjmgNCbYdEeOMLgwbou55WizIlZ5+MlkyCoO/6vWmX
ARC-Seal: i=1; a=rsa-sha256; t=1521028636; cv=none;
        d=google.com; s=arc-20160816;
        b=QaR4odERpMt/1dB5TZqgRG+fCEaJZHq2H7EyFk0t6lvn9UDIhXMPhZGZXYQ55nr7HI
         CLygncEyNy++vpu0YIwYI8Yl0BTlc6QUEBVmvr/S12zzEUphB2fecu4W/B80+3SnJHEU
         HEbovHiE1Nk3h/kiCOQ7z6UwDVWOpftnzYrRkhHCPMmvCKaFSu0FntguWTsrwN1lB8q6
         PBr3uyu7RYQ4X0L91mbjGfs8Dt5LOH+ppplXjtFOc2eG0ZxDMw/VSRMzs290HdMQqZ4s
         ohVxFQZQbsl2/yP/ouDRjnuQtWyfG9rqhXUi9qy12yViUkUMQ32SlQrE6h+MNki7E9OC
         rujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=QXbi5fMFGL2Qnzz3nvyOXER4TOYgO1s1IwYOibtNGpA=;
        b=vM0e4SxxLpMHT4gccEVz8VtjlMqWAMjP9+GsSuxjlthUpvYTpI+n/26E7Cry1P0SDv
         n7e2vi7IqofvrScSs7xEMyXUEljgnYrF+o+/Ka1u/zoHQByNGiO9CWbyO9Ns6WTISLJL
         5gE1rGqQjpF1/6ej/zQJX71nsC8UO2eY76KO+qbaiins8D1X0drXOQZt6tA17FI8xPmb
         jSk4WUCkxpjbrUGqJrX/qunDYa+GR+bt/K7ap6RrFuQYs1lQfBGc5GH7lWxO0mnQvD6I
         /IXcrDc8NijKieDEjTk6Ivn+9HpuoamRzFVZWQFI/H0Rb3iAXjM9MYc60VFUmgKtmksD
         sifA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=WcREc6Od;
       spf=pass (google.com: domain of kernel-hardening-return-12584-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12584-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=WcREc6Od;
       spf=pass (google.com: domain of kernel-hardening-return-12584-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12584-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 14 Mar 2018 04:56:53 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: keescook@chromium.org, david@fromorbit.com, rppt@linux.vnet.ibm.com,
	mhocko@kernel.org, labbott@redhat.com,
	linux-security-module@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH v19 0/8] mm: security: ro protection for dynamic data
Message-ID: <20180314115653.GD29631@bombadil.infradead.org>
References: <20180313214554.28521-1-igor.stoppa@huawei.com>
 <a9bfc57f-1591-21b6-1676-b60341a2fadd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9bfc57f-1591-21b6-1676-b60341a2fadd@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594860649725336168?=
X-GMAIL-MSGID: =?utf-8?q?1594914123900266264?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 01:21:54PM +0200, Igor Stoppa wrote:
> > * @Kees Cook proposed to turn the self testing into modules.
> >   My answer was that the functionality is intentionally tested very early
> >   in the boot phase, to prevent unexplainable errors, should the feature
> >   really fail.
> 
> This could be workable, if it's acceptable that the early testing is
> performed only when the module is compiled in.
> I do not expect the module-based testing to bring much value, but it
> doesn't do harm. Is this acceptable?

Something I've been doing recently is building tests in both userspace and
kernel space.  Here's an example:
http://git.infradead.org/users/willy/linux-dax.git/commitdiff/717f2aa1d4040f65966bb9dab64035962576b0f9

Essentially, tools/ contains a reasonably good set of functions which
emulate kernel functions.  So you write your test suite as a kernel module
and then build it in userspace as well.

> > * @Matthew Wilcox proposed to use a different mechanism for the genalloc
> >   bitmap: 2 bitmaps, one for occupation and one for start.
> >   And possibly use an rbtree for the starts.
> >   My answer was that this solution is less optimized, because it scatters
> >   the data of one allocation across multiple words/pages, plus is not
> >   a transaction anymore. And the particular distribution of sizes of
> >   allocation is likely to eat up much more memory than the bitmap.
> 
> I think I can describe a scenario where the split bitmaps would not work
> (based on my understanding of the proposal), but I would appreciate a
> review. Here it is:

You misread my proposal.  I did not suggest storing the 'start', but the
'end'.

> * One allocation (let's call it allocation A) is already present in both
> bitmaps:
>   - its units of allocation are marked in the "space" bitmap
>   - its starting bit is marked in the "starts" bitmap
> 
> * Another allocation (let's call it allocation B) is undergoing:
>   - some of its units of allocation (starting from the beginning) are
>     marked in the "space" bitmap
>   - the starting bit is *not* yet marked in the "starts" bitmap
> 
> * B occupies the space immediately after A
> 
> * While B is being written, A is freed
> 
> * Having to determine the length of A, the "space" bitmap will be
>   searched, then the "starts" bitmap
> 
> 
> The space initially allocated for B will be wrongly accounted for A,
> because there is no empty gap in-between and the beginning of B is not
> yet marked.
> 
> The implementation which interleaves "space" and "start" does not suffer
> from this sort of races, because the alteration of the interleaved
> bitmaps is atomic.

This would be a bug in the allocator implementation.  Obviously it has to
maintain the integrity of its own data structures.

> Does this justification for the use of interleaved bitmaps (iow the
> current implementation) make sense?

I think you're making a mistake by basing the pmalloc allocator on
genalloc.  The page_frag allocator seems like a much better place to
start than genalloc.  It has a significantly lower overhead and is
much more suited to the kind of probably-identical-lifespan that the
pmalloc API is going to persuade its users to have.
