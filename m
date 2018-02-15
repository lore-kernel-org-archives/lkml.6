Return-Path: <kernel-hardening-return-11802-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x225cF825LVZeqsyL6PbO/iW+M+nej0r3/Vzy8YJVcvJSU1MCc8q6MqNb98Fd0+9E3XMdluGQ
ARC-Seal: i=1; a=rsa-sha256; t=1518716223; cv=none;
        d=google.com; s=arc-20160816;
        b=yKxrK9gPpqmUuc8W09jssNH6lueKx3HJJqwzv7vvxV35QyXq/uvtXNaLkSNTk+/iMR
         +He/EDFFFIl3dSdHGJYgB7MfegXeUsqAI6I+WkuMPDT1XE3BjvcaHEzUCZjGG600R/MD
         gaKjAt/XAGDU/0TJFXw7x1WEhESKSpeWD+tAj7E1pbcgACKLmWKcR+EEOkgCopkWcuJL
         aikYno4mQIOTojHC+Vc2mCHvroo2MKUyulgjwtUY5/kJwXnAqT2UqnL27Xz4wKhiB+II
         U9ppS4N+WiQY/MLtmiungHvFqbK+Rql4CFy0DPtBaPtY0uzOHgPUndnz2aPJbxpiuyn3
         r9YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=pKJELLqaHI/1zrXhYTTOtNSudP9U1qs3l3Xu+DAVm70=;
        b=MQHM9SfEZzWNmjE/xY5BFbdfgpkfOjxDM27tXqXHQU4MgAFM0/7JPzWpKCHQWUPO4M
         mk97urjsVVC6v/JjwBpAiki10eozTCyn4oXM21snrsyB+lKc/emBQtgHhx9OiNc2NPnw
         RDDwtAx9bJle2df37M3BveQK2iakSHj8rCcdRhp024ABW5dfkFje+duarMS2JlfDbeGs
         tUYEVgR7Mk3IjkzNKjrdOYYfDcWD5515Phy6KC9IgQrPqaFRQTT0ibP30GDmp2xBWF98
         pIJ8O7H4TCJUVsvuunJp2KrTsYVRHWCRd7Xx1Ba9UOv0vH0SfYqI4xMRYGfgfS/Nw02X
         Lf+w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=j3iJYiwh;
       spf=pass (google.com: domain of kernel-hardening-return-11802-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11802-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=j3iJYiwh;
       spf=pass (google.com: domain of kernel-hardening-return-11802-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11802-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 15 Feb 2018 09:36:39 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Joe Perches <joe@perches.com>, Matthew Wilcox <mawilcox@microsoft.com>,
	linux-mm@kvack.org, Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v2 2/8] mm: Add kvmalloc_ab_c and kvzalloc_struct
Message-ID: <20180215173639.GA10146@bombadil.infradead.org>
References: <20180214201154.10186-1-willy@infradead.org>
 <20180214201154.10186-3-willy@infradead.org>
 <1518641152.3678.28.camel@perches.com>
 <20180214211203.GF20627@bombadil.infradead.org>
 <20180214155833.9f1563b87391f7ff79ca7ed0@linux-foundation.org>
 <20180215034050.GA5775@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215034050.GA5775@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592408583578566616?=
X-GMAIL-MSGID: =?utf-8?q?1592489382518497077?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 07:40:50PM -0800, Matthew Wilcox wrote:
> > 	a_foo = kvzalloc_struct_buf(struct foo, struct bar, nr_bars);
> > 
> > or, of course.
> > 
> > 	a_foo = kvzalloc_struct_buf(typeof(*a_foo), typeof(a_foo->bar[0]),
> > 				    nr_bars);
> > 
> > or whatever.

This version works, although it's more typing in the callers:

-               attr_group = kvzalloc_struct(attr_group, attrs, i + 1,
+               attr_group = kvzalloc_struct(typeof(*attr_group), attrs, i + 1,
                                                                GFP_KERNEL);
...
-       dev_dax = kvzalloc_struct(dev_dax, res, count, GFP_KERNEL);
+       dev_dax = kvzalloc_struct(struct dev_dax, res, count, GFP_KERNEL);
...
-#define kvzalloc_struct(p, member, n, gfp)                             \
-       (typeof(p))kvzalloc_ab_c(n,                                     \
-               sizeof(*(p)->member) + __must_be_array((p)->member),    \
-               offsetof(typeof(*(p)), member), gfp)
+#define kvzalloc_struct(s, member, n, gfp) ({                          \
+       s *__p;                                                         \
+       (s *)kvzalloc_ab_c(n,                                           \
+               sizeof(*(__p)->member) + __must_be_array((__p)->member),\
+               offsetof(s, member), gfp);                              \
+})

Gives all the same checking as the current version, and doesn't involve
passing an uninitialised pointer to the macro.

It also looks pretty similar:

	p = kvzalloc(sizeof(*p), GFP_KERNEL);
	p = kvzalloc_struct(typeof(*p), array, count, GFP_KERNEL);
	p = kvzalloc_array(sizeof(*p), count);
