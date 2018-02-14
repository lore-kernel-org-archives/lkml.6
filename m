Return-Path: <kernel-hardening-return-11794-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x225CIlSfJu/7YFkY5scCmJUivpIBsPwMG0BDYcULSiOwd8LSV7JRXeZjkr34LbscKToj794k
ARC-Seal: i=1; a=rsa-sha256; t=1518643799; cv=none;
        d=google.com; s=arc-20160816;
        b=vOXpQCsFU8NAvmstSTM6kqXdmxY6Mu9jPU0Yxl4264mI66Aun9SKCBKFfLHjC3Q+0s
         7sbW1H4CZan2l2QtbFbXQJkIMpO9yMAfQGTS6dpNBTddnyf0itG9aU7Rc8KBB1D0ygAM
         B9lwhmfYpOpKNEYvf5yJXeYeub+2s6qf+/7GPLm4jsFrpUu/77eyyOohD+RW9W9pUeF1
         d2rkRS7rKFurMsHFnA+3b6YQSvavVRx+IxS/eWJyAe7eoXUyldf9SKqQmab2JLFlHGp2
         ZGYEbLBysD2exMzSTIsNTBHssqx3/3CSo5mbzvMGItCJZf6I2paQi9t1K3D4oX7D5WbD
         1Njg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=aHfR6pIzrG0I++zDknDzQGR7fVjAZRELV7GgSdb/SEg=;
        b=tfuuk8ddVPm8lhgbgZvm+wL99aw5+PQc6zbcz4b5CNy0vVdh7WndfUkCaY+RTPpkqz
         LGb2CJDXMdqNOwL6vz6K7VF7KSJNuVNqY8MChq1Qy+42jBh5kHr+UEvLNQwVXwAKNY2F
         c5y59n6JDJwiLnioboEyRAG+VW8695UK+9eZGfGq5ua2L3pdKG+gy9UxaTlJ5BMLWbhg
         2fZqxNo8PJU0OJLSFdLW5k/UDYVZ0+M9mmNlJPAYFmA9MVxZPzG6WazE3nEAq+fU33tE
         cg1sLwxuZEzyTde7myRh6mKADpI42Eg1Gfolh1DVPB1ouKIclmgRgbqLp2yPORRMGFv5
         8CWw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=Oa3ez9Gx;
       spf=pass (google.com: domain of kernel-hardening-return-11794-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11794-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=Oa3ez9Gx;
       spf=pass (google.com: domain of kernel-hardening-return-11794-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11794-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 14 Feb 2018 13:29:37 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <mawilcox@microsoft.com>, linux-mm@kvack.org,
	Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v2 2/8] mm: Add kvmalloc_ab_c and kvzalloc_struct
Message-ID: <20180214212937.GG20627@bombadil.infradead.org>
References: <20180214201154.10186-1-willy@infradead.org>
 <20180214201154.10186-3-willy@infradead.org>
 <1518641152.3678.28.camel@perches.com>
 <20180214211203.GF20627@bombadil.infradead.org>
 <1518643449.3678.33.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518643449.3678.33.camel@perches.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592408583578566616?=
X-GMAIL-MSGID: =?utf-8?q?1592413440834020856?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 01:24:09PM -0800, Joe Perches wrote:
> On Wed, 2018-02-14 at 13:12 -0800, Matthew Wilcox wrote:
> > On Wed, Feb 14, 2018 at 12:45:52PM -0800, Joe Perches wrote:
> > > Perhaps kv[zm]alloc_buf_and_array is better naming.
> > 
> > I think that's actively misleading.  The programmer isn't allocating a
> > buf, they're allocating a struct.  kvzalloc_hdr_arr was the earlier name,
> > and that made some sense; they're allocating an array with a header.
> > But nobody thinks about it like that; they're allocating a structure
> > with a variably sized array at the end of it.
> > 
> > If C macros had decent introspection, I'd like it to be:
> > 
> > 	sev = kvzalloc_struct(elems, GFP_KERNEL);
> > 
> > and have the macro examine the structure pointed to by 'sev', check
> > the last element was an array, calculate the size of the array element,
> > and call kvzalloc_ab_c.  But we don't live in that world, so I have to
> > get the programmer to tell me the structure and the name of the last
> > element in it.
> 
> Look at your patch 4
> 
> -       dev_dax = kzalloc(sizeof(*dev_dax) + sizeof(*res) * count, GFP_KERNEL);
> +       dev_dax = kvzalloc_struct(dev_dax, res, count, GFP_KERNEL);
> 
> Here what is being allocated is exactly a struct
> and an array.

No, it's a struct *containing* an array.  Look at patches 5 & 8 where I
have to convert the structs to contain the array which was silently
being allocated immediately after them.

> And this doesn't compile either.

Does for me.  What error are you seeing?
