Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B751C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE1820838
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 18:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OZozpBIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE1820838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406631AbeKWFjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 00:39:11 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44818 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389115AbeKWFjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 00:39:11 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so7155444lfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 10:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DSxidHE7NLxIc9ha7B0C1HJsye3M8kQFLccGGw1sBls=;
        b=OZozpBIQS4Du4H6DwVqL8gPDs17uGGGupUknz39FCOoRVVxgimxFRM3mcl7WtgAcdK
         D8pQyGj5vNx9JfOHh+nFAjmIe1yxVWS8Qcgs6S0/fhkvcXqLevA0qzp1HXx4kRS1gIqC
         PCuIWVdy7ZOJ//yYGxCzGEnDO04ilaP3H47Pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DSxidHE7NLxIc9ha7B0C1HJsye3M8kQFLccGGw1sBls=;
        b=bYKEq/WlNFe548RUxEkcu+QYeKK47lvuAJ3fdI9FTp9oQgRTysp57o8fOjUAOmjXXe
         KkiNnBs7HZ9lX3IE1k+1su6iJqsc/EhLdpi2CSVUCN+URnnQXh6zhww3cjyHvKRcmsHy
         5PUYb6geYUX9IYz4VwV/szuWwLwTGG6+4oqjC1uD7ry9gvg+xG2vr2WFlij1vDC2e/3M
         wyGJUij2Mra6hHDoY6HOJ+PEyvM9YIMJuS7R+xjkcJv4q+2o75lm/wfryqza9ZUWemEN
         Dy5Puuu1sW0MRojX2uupiFSl6Jdb5A/pg7JvRDWeCZG9SGrxbAOfAs8sgr0j2PHoRsvQ
         gSwQ==
X-Gm-Message-State: AGRZ1gLs8tmp4k+dhnMPBuJg27iFl0+dWEYeVzpToq0sTXEfiFQuKoFP
        Ica61Xvh8/k5bx0iCzGkZptrDaHa6Ef53g==
X-Google-Smtp-Source: AJdET5fkoMeaSbQPkH6xpb07H+dzbAbyuTfXPj7BECHCS+MR+pMjicGEuWUSHXQao/JRCllO27f60w==
X-Received: by 2002:a19:4345:: with SMTP id m5mr7023564lfj.142.1542913108795;
        Thu, 22 Nov 2018 10:58:28 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id s127sm7459282lfe.8.2018.11.22.10.58.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 10:58:27 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id e5-v6so8759744lja.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 10:58:27 -0800 (PST)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr8375271lji.133.1542913106673;
 Thu, 22 Nov 2018 10:58:26 -0800 (PST)
MIME-Version: 1.0
References: <02bfc577-32a5-66be-64bf-d476b7d447d2@kernel.dk>
 <20181121063609.GA109082@gmail.com> <48e27a3a-2bb2-ff41-3512-8aeb3fd59e57@kernel.dk>
 <26eff539-7de7-784c-0c88-f1d30753299d@redhat.com> <7ea44458b90b4d41a08ba9012818d273@AcuMS.aculab.com>
 <CAHk-=wjLNuNpHRfuVTb6awstC9OOmSb3S8aP51ufep-Th4dXKw@mail.gmail.com> <CALCETrW=hMZLUM_nPEEgUW9x9Bmhm2LZ6ZRDiRRguxVT=-_BWA@mail.gmail.com>
In-Reply-To: <CALCETrW=hMZLUM_nPEEgUW9x9Bmhm2LZ6ZRDiRRguxVT=-_BWA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 22 Nov 2018 10:58:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiEUVpSU-GxpKDvN9wnH2yDxkJgE7Vqh46A+fmnvhubyw@mail.gmail.com>
Message-ID: <CAHk-=wiEUVpSU-GxpKDvN9wnH2yDxkJgE7Vqh46A+fmnvhubyw@mail.gmail.com>
Subject: Re: [PATCH] x86: only use ERMS for user copies for larger sizes
To:     Andrew Lutomirski <luto@kernel.org>
Cc:     David.Laight@aculab.com, dvlasenk@redhat.com,
        Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, bp@alien8.de,
        Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, brgerst@gmail.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 10:07 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> I'm not personally volunteering, but I suspect we can do much better
> than we do now:
>
>  - The new MOVDIRI and MOVDIR64B instructions can do big writes to WC
> and UC memory.
>
>  - MOVNTDQA can, I think, do 64-byte loads, but only from WC memory.

No, performance isn't the _primary_ issue. Nobody uses MMIO and
expects high performance from the generic functions (but people may
then tweak individual drivers to do tricks).

And we've historically had various broken hardware that cares deeply
about access size. Trying to be clever and do big accesses could
easily break something.

The fact that nobody has complained about the generic memcpy routines
probably means that the broken hardware isn't in use any more, or it
just works anyway. And nobody has complained about performance either,
so it's clearly not a huge issue. "rep movs" probably works ok on WC
memory writes anyway, it's the UC case that is bad, but I don't think
anybody uses UC and then does the "memcp_to/fromio()" things. If you
have UC memory, you tend to do the accesses properly.

So I suspect we should just write memcpy_{to,from}io() in terms of writel/readl.

Oh, and I just noticed that on x86 we expressly use our old "safe and
sane" functions: see __inline_memcpy(), and its use in
__memcpy_{from,to}io().

So the "falls back to memcpy" was always a red herring. We don't
actually do that.

Which explains why things work.

            Linus
