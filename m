Return-Path: <kernel-hardening-return-11710-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226aYKBBTtYnbeMVUlIwCQy7D3S4M0FnRlE2OYd1SUdXSNT6iBWD7SPaOi4cZGpeHrajZZO/
ARC-Seal: i=1; a=rsa-sha256; t=1518383911; cv=none;
        d=google.com; s=arc-20160816;
        b=P3YJcK7aUjN0LSy7ntP3LLW/99ua7FrUrYInsZm+GTJ/1wVoMK2zk/GRkdzr3gjrH5
         e5MnK911FrUWfQDxPsr0m1b48nQ3J2P1bk+SV+rLaPg08d2PX3SNstbfitNGZZccZKSy
         drXWIm6uh3z65aCWS1r7IInzXHwpx7mJqdJDC8D9+8ZAj4WX3FXfGbjutMvn1cdc+Jcf
         PkqDGRvdv2Zz7vhtL4aNmgazYYWYdXFyT7OedspnUsjx+i9P1VxSdwUxLfqRmY37j6zY
         ShTMyVu9gqUVxbxCI3Yd4y/S35iWRreOuNe9pN8FkCugcWfMdLwvxaLB9t4hr0Qju4qy
         dWVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=mBpc17LLwiDNwRgABOvWpiJUFe13nXutLLBAQmp+5yI=;
        b=nLoCKFrrJ+7UA64YuiZLx+eVbQHQxTdrJzGm4ofdnhi+55xZr4mTepQ7vxGvsxWNX/
         Hgr3+4SJ9CJoG6GZrSOYSLDhzKu7CCSLswFG0N37MLq1oEJTGl0WyQfmdbBqjtfo4blp
         so7Cx5bV2ixmKQ4DaxWZus4uWnmWnle3X8ZR8ntjxnVwDb1JIVng8XmL8WjTjQfn1oYE
         8KiwNa8K4p4GmxRJdmycyq+vleEKG+bif7tL9Fd7uREhQ69QcLFZDeEANBDpo0FiDqG6
         SLJghG0tT7XMq3pJ1lmBymTEemb79BZzLg/fcZlswpxReG22CKA5YoF4JLHrD0pJ56QX
         JPwg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=casper.20170209 header.b=VAG3pda5;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=ZBzYfrDM;
       spf=pass (google.com: domain of kernel-hardening-return-11710-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11710-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=casper.20170209 header.b=VAG3pda5;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=ZBzYfrDM;
       spf=pass (google.com: domain of kernel-hardening-return-11710-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11710-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Sun, 11 Feb 2018 13:16:46 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: rdunlap@infradead.org, corbet@lwn.net, keescook@chromium.org,
	mhocko@kernel.org, labbott@redhat.com, jglisse@redhat.com,
	hch@infradead.org, cl@linux.com,
	linux-security-module@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 3/6] struct page: add field for vm_struct
Message-ID: <20180211211646.GC4680@bombadil.infradead.org>
References: <20180211031920.3424-1-igor.stoppa@huawei.com>
 <20180211031920.3424-4-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180211031920.3424-4-igor.stoppa@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592073184128407406?=
X-GMAIL-MSGID: =?utf-8?q?1592140928638072861?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Feb 11, 2018 at 05:19:17AM +0200, Igor Stoppa wrote:
> The struct page has a "mapping" field, which can be re-used, to store a
> pointer to the parent area. This will avoid more expensive searches.
> 
> As example, the function find_vm_area is reimplemented, to take advantage
> of the newly introduced field.

Umm.  Is it more efficient?  You're replacing an rb-tree search with a
page-table walk.  You eliminate a spinlock, which is great, but is the
page-table walk more efficient?  I suppose it'll depend on the depth of
the rb-tree, and (at least on x86), the page tables should already be
in cache.

Unrelated to this patch, I'm working on a patch to give us page_type,
and I think I'll allocate a bit to mark pages which are vmalloced.
