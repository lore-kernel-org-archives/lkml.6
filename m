Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631F9ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251112080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 22:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eX6VSrP5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251112080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbeKAHCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 03:02:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38719 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeKAHCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 03:02:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so8273587pfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 15:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=d/3VpCZ0Aa3ShjyLzNxCDT9XMSAT4U74mvB3YJDt8sk=;
        b=eX6VSrP5jr3ebobFPu8mkzOocEIGmM5qPE5p74+wGHr9YyBSLjT06ItmcchYyiR85y
         FXxmzmyrgWHkQgBKfNqtTq9dq6yIERA4x19Pfp7d3AKAg5CSyhxqivbNpS7yKCX+hqKV
         mOqZg+ugCoIAPvh98FNcB5u0vmFa5n8+suXYA34YdnNHoMKlRrSCYYL1FRf9++2Yibkn
         yAlVCnUmOKzOk5SqMrsAVMeslpnKW0/kaehkSZ7DNB2M218fjlcNg+HABi+fevxuRoLK
         PGcBlT+KpnthEkk2HsdmmJQoDZeJ+3st59Bwm8CW7sXCxHVkePD/yEg7brB5DkYvPtk6
         F5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=d/3VpCZ0Aa3ShjyLzNxCDT9XMSAT4U74mvB3YJDt8sk=;
        b=nLbizuFgOFyddzKNg/JVLwI7yo1IPOVkXru2A4JcsRuDdN0pHzO5ig0OiBEKD3ijaz
         rOo6IH6N0JohXjwDgxt94i0qba9SrnnfMySFyOzqt41NjP3ZWmgtnmkNXuT9hRGM0NeT
         4gvwdOrjTFQWDqYrZNa5UH0pj1AJeOU83tJ6G8UceEz3gR+WiQ1KRAuhALhv6IJbbvzK
         KFNP4Xr5KyHn17AYRUmUZD3IYx7Wnh8cSnBgTuKVC8g3Q2yakg61aqfZWTldeVgGeCia
         TnUWvCEBRySsXpHE92YTQbghMOF3pgIjGtiDYdw6I7ABF8i2nvtClccV/7ov/TcMtTvr
         f++g==
X-Gm-Message-State: AGRZ1gJb/awaOBzPP+JwbktySoBoSIOd8d4ltAlX4XoyCIIxfhR5KCzx
        qqRDkjiSiu6pZJg+9J0CEm4=
X-Google-Smtp-Source: AJdET5eEsyeFs/lpJXpJYu/HYdX2RxwOsfZDwN5MUryd3bU0YO93jcAbvzClWY6bJOjVIthccDcfRw==
X-Received: by 2002:a65:47cb:: with SMTP id f11-v6mr4900412pgs.166.1541023377095;
        Wed, 31 Oct 2018 15:02:57 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q76-v6sm60412618pfa.18.2018.10.31.15.02.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 15:02:55 -0700 (PDT)
Date:   Wed, 31 Oct 2018 15:02:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: Re: [RFC PATCH] lib: Introduce generic __cmpxchg_u64() and use it
 where needed
Message-ID: <20181031220253.GA15505@roeck-us.net>
References: <1541015538-11382-1-git-send-email-linux@roeck-us.net>
 <20181031213240.zhh7dfcm47ucuyfl@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031213240.zhh7dfcm47ucuyfl@pburton-laptop>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 09:32:43PM +0000, Paul Burton wrote:
> Hi Guenter,
> 
> On Wed, Oct 31, 2018 at 12:52:18PM -0700, Guenter Roeck wrote:
> > +/*
> > + * Generic version of __cmpxchg_u64, to be used for cmpxchg64().
> > + * Takes u64 parameters.
> > + */
> > +u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new)
> > +{
> > +	raw_spinlock_t *lock = lock_addr(ptr);
> > +	unsigned long flags;
> > +	u64 prev;
> > +
> > +	raw_spin_lock_irqsave(lock, flags);
> > +	prev = READ_ONCE(*ptr);
> > +	if (prev == old)
> > +		*ptr = new;
> > +	raw_spin_unlock_irqrestore(lock, flags);
> > +
> > +	return prev;
> > +}
> > +EXPORT_SYMBOL(__cmpxchg_u64);
> 
> This is only going to work if we know that memory modified using
> __cmpxchg_u64() is *always* modified using __cmpxchg_u64(). Without that
> guarantee there's nothing to stop some other CPU writing to *ptr after
> the READ_ONCE() above but before we write new to it.
> 
> As far as I'm aware this is not a guarantee we currently provide, so it
> would mean making that a requirement for cmpxchg64() users & auditing
> them all. That would also leave cmpxchg64() with semantics that differ
> from plain cmpxchg(), and semantics that may surprise people. In my view
> that's probably not worth it, and it would be better to avoid using
> cmpxchg64() on systems that can't properly support it.
> 

Good point. Unfortunately this is also true for the architectures with
similar implementations, ie at least sparc32 (and possibly parisc).

The alternatives I can see are
- Do not use cmpxchg64() outside architecture code (ie drop its use from
  the offending driver, and keep doing the same whenever the problem comes
  up again).
or
- Introduce something like ARCH_HAS_CMPXCHG64 and use it to determine
  if cmpxchg64 is supported or not.

Any preference ?

Thanks,
Guenter
