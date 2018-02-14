Return-Path: <kernel-hardening-return-11788-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x227Jkkdkn/sf+8IkLLG6/i9TvllrIZRi44bL+fQHPVaFiLnvwPrtSg1xVRJIkZbif9ZarC6Z
ARC-Seal: i=1; a=rsa-sha256; t=1518640137; cv=none;
        d=google.com; s=arc-20160816;
        b=I5zCH6MbjwJ/M9l6GMK5ZXr3qZDmiTb4XIkqBVwjdT6Q3MSd3eXahfsZNSTaBIjTwO
         SPw8X4+j/YsGxB92UyiLkF9Qp1+CfL/l59p1gBslg9NdO/Dj/hMzF3mEUPu6yMB4hmoV
         XvLUl9IsdAvJkugvKdJUUXkJ5rOa3FqQI4l2k2TSvt5oX6mHbZkyYpzcWeKeQAw+y+qS
         2oi63JatnPm5ueVOUkQgWbrt776CgTVi/1ce+sNaXQTYleKXyYUv/J6Qs8G6VGMJxbWJ
         faCK1CGVrapu8FKarxwlcmaV9ueWLAP7QwDvjQCvrpo6Zo+oTAFsdRT9PAqL2rfr0j0L
         q4ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=02WB9YsABcIVYaaEbEygVR78Uky5OxkGVejm7V96JXg=;
        b=Zr2BFoJbr1Zi1GAzIk0ohnLJoss1Q4NwG77RcpPLgJXPKAySK0WQiEeL/8Qrg5cqco
         h+DWUFrGp39l8EC8QCC+FbVWmhUzyTHzwB6pDXSUMJeeUd/HaXajx8XuETxvosrTzJM0
         /TPHGqGVZGTGzz34q8xlCUIEXBXCKk+fsDqndqiVtyU+Q0qQGVUrLIRw1KGaFOtbUvTz
         KPj9mWGqtRyIXYFlZRAaLKluMCd0P5HZ4Iajnl/xKkWcFeGgRFp/KU+D3205pwqdGUem
         p9dSbt416Nw337hXs7GTujy4jy7F0i12imchqD6asKXPbplvgjUf+y0BSAtPvrJKRDIA
         e9TA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=YfUProER;
       spf=pass (google.com: domain of kernel-hardening-return-11788-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11788-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=YfUProER;
       spf=pass (google.com: domain of kernel-hardening-return-11788-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11788-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 14 Feb 2018 12:28:35 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <mawilcox@microsoft.com>, linux-mm@kvack.org,
	Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v2 3/8] Convert virtio_console to kvzalloc_struct
Message-ID: <20180214202835.GE20627@bombadil.infradead.org>
References: <20180214201154.10186-1-willy@infradead.org>
 <20180214201154.10186-4-willy@infradead.org>
 <1518639587.3678.25.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518639587.3678.25.camel@perches.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592408604560950999?=
X-GMAIL-MSGID: =?utf-8?q?1592409600514626762?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 12:19:47PM -0800, Joe Perches wrote:
> On Wed, 2018-02-14 at 12:11 -0800, Matthew Wilcox wrote:
> >  	 */
> > -	buf = kmalloc(sizeof(*buf) + sizeof(struct scatterlist) * pages,
> > -		      GFP_KERNEL);
> > +	buf = kvzalloc_struct(buf, sg, pages, GFP_KERNEL);
> >  	if (!buf)
> 
> kvfree?

Yes, that would also need to be done.  The point of these last six
patches was to show the API in use, not for applying.
