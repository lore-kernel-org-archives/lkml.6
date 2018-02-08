Return-Path: <kernel-hardening-return-11656-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x226xK4Tp09pirWr4wS3nJb1bdBEN+nIEkG4/XA0vHAAMglKsOzC9ZezLGZDC98m9KcHUHmxd
ARC-Seal: i=1; a=rsa-sha256; t=1518062833; cv=none;
        d=google.com; s=arc-20160816;
        b=BHsjY6SJEx1xsykRSGmuQb59frSh3f1sysfL1DODKk/fs+b0bGUjMbDd+1PxCHJtyo
         gSIJ6pUH9e1btRNvvMm3B3H4CsoFs5UR7RzR4dzf2DSbEy4kDjTmcIreZ6mWY5PoRta6
         eaDDuSmytSRyFjB9DgQqH6FF/Xv3lklV5rgv/7Fy0MgC5K6xgeXaaQKT2njSOAow0u4V
         D2PbmLW7rgaMTtWFUk2h05gSFCONnGiIWo28Cpblc9F/S8dBWcJC4v7bgf3XXg0XA7le
         C62ZyvdbXifvnno3VFKXGJlb6fWm1V5ujM/2dl5QbCrb0TIWKAvwTHLhMCd91O7J2kO7
         zQjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=R9nnssFPF9ywdef9ImzpTBWz7oMqSHut8meIUnwwVTM=;
        b=LzYeRm3M61pRWF5my3/xKqKBNIFiNttyFlR4QZzgq7v1suDCs3gZUiOOcZHG7rTJuu
         nQDRTooC4vJSFcodfK4SC17vhmQ7Q681qn6QvM3CTadEkK+Wdyn08AiYjJq+/AqkIL4I
         tKLdt4S1FuMI8W6J2gR52nAUN9cXBWXkU9zHVxJJB5xwV31TpI2nByyeslVif+5C1MJM
         soAIzqmPJaki4xBxIz5TCH9vLX0GjDnE0ctOu6sICxTw+bM7f/Xyc68j3kckgFd2mL2v
         h1UCKjKKIprzJ/jQuxT3ObxHN+ODQGPombN9Zg2ZR4F0Ir4LQvNb53J4ZzKS+RFWVq6o
         ZooA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=che3nTqo;
       spf=pass (google.com: domain of kernel-hardening-return-11656-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11656-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=che3nTqo;
       spf=pass (google.com: domain of kernel-hardening-return-11656-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11656-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Wed, 7 Feb 2018 20:06:55 -0800
From: Matthew Wilcox <willy@infradead.org>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: linux-mm@kvack.org, kernel-hardening@lists.openwall.com,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC] Warn the user when they could overflow mapcount
Message-ID: <20180208040655.GD14918@bombadil.infradead.org>
References: <20180208021112.GB14918@bombadil.infradead.org>
 <20180208031804.GD3304@eros>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208031804.GD3304@eros>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591796976786547518?=
X-GMAIL-MSGID: =?utf-8?q?1591804254179712103?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 08, 2018 at 02:18:04PM +1100, Tobin C. Harding wrote:
> > +++ b/Documentation/sysctl/vm.txt
> > @@ -379,7 +379,8 @@ While most applications need less than a thousand maps, certain
> >  programs, particularly malloc debuggers, may consume lots of them,
> >  e.g., up to one or two maps per allocation.
> >  
> > -The default value is 65536.
> > +The default value is 65530.  Increasing this value without decreasing
> > +pid_max may allow a hostile user to corrupt kernel memory.
> 
> Just checking - did you mean the final '0' on this value?

That's what my laptop emits ...

mm/mmap.c:int max_map_count __read_mostly = DEFAULT_MAX_MAP_COUNT;
include/linux/mm.h:#define DEFAULT_MAX_MAP_COUNT        (USHRT_MAX - MAPCOUNT_ELF_CORE_MARGIN)
include/linux/mm.h:#define MAPCOUNT_ELF_CORE_MARGIN     (5)

should be the same value for everybody.
