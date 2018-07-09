Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C347C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A53AA208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TQzeBN+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53AA208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754200AbeGIFsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 01:48:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39303 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750974AbeGIFsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 01:48:37 -0400
Received: by mail-pg1-f196.google.com with SMTP id n2-v6so1026597pgq.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 22:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/vqqxMHGxkw4EmkJa1U8ZJOSmgaSIRcimPrXH6qYy3o=;
        b=TQzeBN+mhBonsh7jAPJ9JaK3xO47PO3LWaTZG3ngYI5bd7K/vY4r9gJldg1N6ClOtU
         gQLoOKXcL0GddIFmE+gSRLJtckpD9Wi/bgX7MJZw5FG3kEotkJ4hDfH71jT9PV8sjBIN
         U4ucT8Fv0WmykROgdtEqrPoCOdAz6zp8+xL90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=/vqqxMHGxkw4EmkJa1U8ZJOSmgaSIRcimPrXH6qYy3o=;
        b=rzQO/UNUK48kFuV6Mk4DybhNX9RdAsXAJzSeWajH1vtvYeFeJs1C6Q7XCOjI3cd6U7
         uLj9H2/H3EzQXHMpBqhnw+hy7ZcHsp2TrnaqDYmrh72mSVAmgXwVJXZsYLT3Slq2V8+i
         x3Or/ly45KWSYz25n6E9eR7eVVWzq0qpJo9wHCWay1h9KyArf4Nf8Lb4IkPPeDbfJYQ5
         XnsX1lA8S3OtFhSwA7IBkQnLGg4hetb0kHWYYJ+WJz93Umm7dUQynl7amkwUIYCcPOyA
         AWILDVIljiMxFYScc1bpaLc/Byr4KGQHztXOuqWrSVjX/zv91ZEM115nmdBvxuI+gC6G
         ovWQ==
X-Gm-Message-State: APt69E03UyfP7jiI2F2wJ2xTnHIuNP3uqeIL1ezyiivhq+hMfA2xdod2
        OcwVUVtlNvNWX8qs+ESvH3qmag==
X-Google-Smtp-Source: AAOMgpfPI7Wnsac7A4gFeVbbSS3J0jyPMBkvcLXnHV5EAXQdG98PsAj8MwXSLmN9RJykGa3SkLL7NA==
X-Received: by 2002:aa7:8591:: with SMTP id w17-v6mr20027811pfn.77.1531115316921;
        Sun, 08 Jul 2018 22:48:36 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id m15-v6sm19958640pfj.171.2018.07.08.22.48.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 22:48:36 -0700 (PDT)
Date:   Mon, 9 Jul 2018 14:49:54 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     James Morse <james.morse@arm.com>
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v10 03/14] powerpc, kexec_file: factor out memblock-based
 arch_kexec_walk_mem()
Message-ID: <20180709054953.GR28220@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, dyoung@redhat.com,
        bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
 <20180623022058.10935-4-takahiro.akashi@linaro.org>
 <8a59db79-6379-550b-b20e-01036626904e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a59db79-6379-550b-b20e-01036626904e@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James,

On Tue, Jul 03, 2018 at 05:36:24PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 23/06/18 03:20, AKASHI Takahiro wrote:
> > Memblock list is another source for usable system memory layout.
> > A merged new arch_kexec_walk_mem() will walk through either io resource
> > list or memblock list depending on CONFIG_ARCH_DISCARD_MEMBLOCK so that
> > arm64, in addition to powerpc, will be able to utilize this generic
> > function for kexec_file.
> 
> > diff --git a/arch/powerpc/kernel/machine_kexec_file_64.c b/arch/powerpc/kernel/machine_kexec_file_64.c
> > index 0bd23dc789a4..3d4be91786ce 100644
> > --- a/arch/powerpc/kernel/machine_kexec_file_64.c
> > +++ b/arch/powerpc/kernel/machine_kexec_file_64.c
> 
> Does this file still need its memblock.h include?

OK. Will remove it.

> 
> > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > index 63c7ce1c0c3e..563acd1c9a61 100644
> > --- a/kernel/kexec_file.c
> > +++ b/kernel/kexec_file.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/file.h>
> >  #include <linux/slab.h>
> >  #include <linux/kexec.h>
> > +#include <linux/memblock.h>
> >  #include <linux/mutex.h>
> >  #include <linux/list.h>
> >  #include <linux/fs.h>
> > @@ -501,6 +502,53 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
> >  	return locate_mem_hole_bottom_up(start, end, kbuf);
> >  }
> >  
> > +#if defined(CONFIG_HAVE_MEMBLOCK) && !defined(CONFIG_ARCH_DISCARD_MEMBLOCK)
> 
> The only caller is also guarded by these same ifdefs. Can't we remove this and
> rely on the compilers dead-code elimination to remove this function when its not
> needed?

I don't think we can remove this #ifdef.
"for_each_free_mem_range[_reverse]()" is defined under CONFIG_HAVE_MEMBLOCK
in memblock.h. If some architecture wants to support KEXEC_FILE but
doesn't have HAVE_MEMBLOCK, compiling kexec_file.c will fail.

> 
> > +static int kexec_walk_memblock(struct kexec_buf *kbuf,
> > +			       int (*func)(struct resource *, void *))
> > +{
> > +	u64 i;
> > +	phys_addr_t mstart, mend;
> > +	struct resource res = { };
> > +	int ret = 0;
> 
> 
> Keeping this patch as 'just' moving code would avoid having to play
> spot-the-difference:

OK. I will split this patch into two.
But just "moving" is impossible because the function names will be
duplicated in kexec_file.c.

> > +	if (kbuf->image->type == KEXEC_TYPE_CRASH)
> > +		return func(&crashk_res, kbuf);
> 
> This will be new for powerpc, but any attempt to use it should be caught by
> arch_kexec_kernel_image_probe(), which has:
> |	/* We don't support crash kernels yet. */
> |	if (image->type == KEXEC_TYPE_CRASH)
> |		return -EOPNOTSUPP;
> 
> 
> Looks good to me! For what its worth:
> Acked-by: James Morse <james.morse@arm.com>

Thank you for your reviews.

-Takahiro AKASHI

> 
> Thanks,
> 
> James
