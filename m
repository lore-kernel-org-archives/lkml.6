Return-Path: <kernel-hardening-return-12592-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuLBH4nzQgyXeDU38ggc3O6tt301rPv97QZhkU56emUkvTwYPaho4uHFbcOcS+xnNY5soUx
ARC-Seal: i=1; a=rsa-sha256; t=1521032682; cv=none;
        d=google.com; s=arc-20160816;
        b=Miu2ZGLEDEFtS/RrRqQV4MMc+B0a9pGeCRxNcYiaDoRhz22+QgR7qISmcdRh8LZt6h
         fMkhUaPh+eyXIxR/b4x4xpHbjt39iOjbsWnn8pSbjOAxACXuOMk/B6a/b8ejoi+svEWV
         2undDTnEAR9Pw4NV5ANZ4T0WdWNWrAtdo7b+nLPPiIvj4trQMDO1TMNrLe7QnDGOb0EH
         INH4O4+FNJAwKvoDzVGQEejN/fHKdYMaSKhcf2UPBY+1VLfG8dt5cur7ejirypbF9pKj
         IrOicLSS15/CZvaYH08brcalpaFKPgCPBP4sOyt103469ndjfNbrbjla8c0748jvU9/F
         0rlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=QhVouHk32COils2OdEPtfx8LbDqBXV/2W5v/r4KP5M0=;
        b=MqL6wx0PCZ6vIwDYiLWCJi/DIWdQ6Uociw0CVYYXNYX9AE6kX9EpjHxHI3BiwoZuTj
         nm8UUAjgeOLZ6qxUXEeJ1Pt09ZyxbNv4WoZ6ik/tjYN2QAs/jmrmYoYk3KazZkaRAbZ2
         3MOmPlmLY9bzsPhm1fUSNex3bEcQeZSdApEXfrtyCJ0HayRZ9tZlLGLhmQ2Q9bd5Zbi5
         z2xdKAJZtLefPT/9uAzagpZtDKIJedsKkQtuMF7hR5dxNoJIpEemyWXE5aeLq77Yf957
         9oFkz0J6uKclXSD3e7wLTW8MKdEfWgu/XGTYgyZsT6uR6LZ/h59bWC7SNJsJnPzM4A8Z
         nGpw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=rebk58gY;
       spf=pass (google.com: domain of kernel-hardening-return-12592-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12592-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=rebk58gY;
       spf=pass (google.com: domain of kernel-hardening-return-12592-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12592-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 14 Mar 2018 06:04:18 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: keescook@chromium.org, david@fromorbit.com, rppt@linux.vnet.ibm.com,
	mhocko@kernel.org, labbott@redhat.com,
	linux-security-module@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH v19 0/8] mm: security: ro protection for dynamic data
Message-ID: <20180314130418.GG29631@bombadil.infradead.org>
References: <20180313214554.28521-1-igor.stoppa@huawei.com>
 <a9bfc57f-1591-21b6-1676-b60341a2fadd@huawei.com>
 <20180314115653.GD29631@bombadil.infradead.org>
 <8623382b-cdbe-8862-8c2f-fa5bc6a1213a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8623382b-cdbe-8862-8c2f-fa5bc6a1213a@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594860649725336168?=
X-GMAIL-MSGID: =?utf-8?q?1594918365768531158?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 02:55:10PM +0200, Igor Stoppa wrote:
> >  The page_frag allocator seems like a much better place to
> > start than genalloc.  It has a significantly lower overhead and is
> > much more suited to the kind of probably-identical-lifespan that the
> > pmalloc API is going to persuade its users to have.
> 
> Could you please provide me a pointer?
> I did a quick search on 4.16-rc5 and found the definition of page_frag
> and sk_page_frag(). Is this what you are referring to?

It's a blink-and-you'll-miss-it allocator buried deep in mm/page_alloc.c:
void *page_frag_alloc(struct page_frag_cache *nc,
                      unsigned int fragsz, gfp_t gfp_mask)
void page_frag_free(void *addr)

I don't necessarily think you should use it as-is, but the principle it uses
seems like a better match to me than the rather complex genalloc.  Just
allocate some pages and track the offset within those pages that is the
current allocation point.  It's less than 100 lines of code!
