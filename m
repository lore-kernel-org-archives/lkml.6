Return-Path: <kernel-hardening-return-11661-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x224MYKgWzK29sAQaH/JN1JqhyLpVEHb9EMk4Q2mndgB/SeZNa9OSTk3asJY/aNezvrIsmrF/
ARC-Seal: i=1; a=rsa-sha256; t=1518118976; cv=none;
        d=google.com; s=arc-20160816;
        b=hi2cxAFlFkfXWcYUN2HGiRxxaNoyBlaNRdLlOY3GeoH+bSM6Y7gxQMYr3flxVDdENy
         yUO9JOu4UDN2qKB1Aec3ySSSgii7xUZ8RTV2G474N5biznTA1vN23FI10RjMSb6JVkWm
         ihDYl8/osNiWUbkopm6fxmj88Pnsgt1h14ETESDNuo/o9VEmf/4b8LwN+iL0TBNA5mjx
         YKmLPkBheUG+PtCCgU36pJMZYo7GNUvy55tREhpxeBLrrPhehUT/xInVPl9wszjU+Cmu
         D6y6UET9rA1uk2usVWdrdWxStdhvbNd8JFkk3oj1LsYl9O0Tt4gRK23MQPbbphLhJKl0
         g42A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :list-id:list-subscribe:list-unsubscribe:list-help:list-post
         :precedence:mailing-list:arc-authentication-results;
        bh=+ZtWX9IVq45x1+pYxShvjfDPDtTuvfex0fzIsv69hFk=;
        b=CIoj+z14w9nrT+Hhr4nd/ylFyz5n4PI3vpJxft+sVIORwtLdi83eCLMGqAzV+/pAsa
         pJNzEU3efDlhBvXbHHXSCvJPnmWaEvi4wKfmqsO6ej4F3y8OEvxoaafauBDZYJUKV4iI
         15P14SCQIWZ2t1YiPmXs6hPIGwY3v32NlQTF/xsBkTDWMTWXGP3vp8s/kUCFrv7/hnWL
         H+6WVI6GZikRjTRIaeNzrZelYBWmPQO7Xc2HVLKNtFVeGBd7G7yZttwbXMwRzELBD5gH
         n1OuoMRYRnPoaMPntRWzCt0CTIQMOtXMe0La3x+FZ2EsE1FqI5S276oWAEF1M39tY8cp
         zfGA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=Og83/0Y6;
       spf=pass (google.com: domain of kernel-hardening-return-11661-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11661-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@infradead.org header.s=bombadil.20170209 header.b=Og83/0Y6;
       spf=pass (google.com: domain of kernel-hardening-return-11661-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11661-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Thu, 8 Feb 2018 11:42:35 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Daniel Micay <danielmicay@gmail.com>
Cc: Jann Horn <jannh@google.com>, linux-mm@kvack.org,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	kernel list <linux-kernel@vger.kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC] Warn the user when they could overflow mapcount
Message-ID: <20180208194235.GA3424@bombadil.infradead.org>
References: <20180208021112.GB14918@bombadil.infradead.org>
 <CAG48ez2-MTJ2YrS5fPZi19RY6P_6NWuK1U5CcQpJ25=xrGSy_A@mail.gmail.com>
 <CA+DvKQLHDR0s=6r4uiHL8kw2_PnfJcwYfPxgQOmuLbc=5k39+g@mail.gmail.com>
 <20180208185648.GB9524@bombadil.infradead.org>
 <CA+DvKQLHcFc3+kW_SnD6hs53yyD5Zi+uAeSgDMm1tRzxqy-Opg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+DvKQLHcFc3+kW_SnD6hs53yyD5Zi+uAeSgDMm1tRzxqy-Opg@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591796976786547518?=
X-GMAIL-MSGID: =?utf-8?q?1591863124399667917?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 08, 2018 at 02:33:58PM -0500, Daniel Micay wrote:
> I don't think the kernel can get away with the current approach.
> Object sizes and counts on 64-bit should be 64-bit unless there's a
> verifiable reason they can get away with 32-bit. Having it use leak
> memory isn't okay, just much less bad than vulnerabilities exploitable
> beyond just denial of service.
> 
> Every 32-bit reference count should probably have a short comment
> explaining why it can't overflow on 64-bit... if that can't be written
> or it's too complicated to demonstrate, it probably needs to be
> 64-bit. It's one of many pervasive forms of integer overflows in the
> kernel... :(

Expanding _mapcount to 64-bit, and for that matter expanding _refcount
to 64-bit too is going to have a severe effect on memory consumption.
It'll take an extra 8 bytes per page of memory in your system, so 2GB
for a machine with 1TB memory (earlier we established this attack isn't
feasible for a machine with less than 1TB).

It's not something a user is going to hit accidentally; it is only
relevant to an attack scenario.  That's a lot of memory to sacrifice to
defray this attack.  I think we should be able to do better.
