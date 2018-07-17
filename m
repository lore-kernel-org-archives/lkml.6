Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4672EECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E657B2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 05:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jOMVRwUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E657B2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbeGQGAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 02:00:40 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34208 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbeGQGAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 02:00:40 -0400
Received: by mail-pf0-f195.google.com with SMTP id k19-v6so2089671pfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 22:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EA+PP3glyPYU0NMRlxuiXiRg06tI6vE6AQDU37zSLHo=;
        b=jOMVRwUqLxdnQ8As+UMxCrCGDP3b0t9X3k7CFdtZTbIE1i2UvfHYG2ulNxcKPk+FgK
         RFVPQRO47CrBRyWQBaWiqway7hg9WvgZME27aHv4xB89sl244RouECqhu1VfAKdC6Hr0
         lhLYEvMiHn69hNUCkM9gQJ1oKShsLUg+RiQXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=EA+PP3glyPYU0NMRlxuiXiRg06tI6vE6AQDU37zSLHo=;
        b=dAq2VjfkuI6Q8rTyun86pTkNi71ResZQGBgp3Bu+DvjIWqPPFqf7F3lqkgKOjwx4ZW
         Qu1hV3cYkPjYOdA6xqQQY6QitXRPyEyMrZNQ14ns+kO371I/wMwUxAboAOWLyoNdzR8t
         kDc7cmdYdyy+iu45tETiiqtvBVcJKz48vEPLGwB/N9sScZztsPxGBNaY0wO9C78F6L5H
         8xeALl/e46VkQnYkE2YyYvw79A7DwVfg/5FYWnj3iPv2wh7Jd6JuOCP7GdHyMswXEyOj
         P9MkIbnXwoNdXtsbj1dtkDJWOwZEFde/wu5YKK43YrFEQcwVay5PUkTNCQPZE97UB7gB
         tpYA==
X-Gm-Message-State: AOUpUlHyFJ+wQfEa3gYbZ+WzRmFtwhzZGcqvoC190Q3SsoG2ELFsSAyv
        YP0Itrm12GZSC/zNskHvrlNRRA==
X-Google-Smtp-Source: AAOMgpdn6b/S1LbtCHyUg3k0u7xkGa0Ut2DvIUs3dIOcPocy44LHXupFgSQytADoWC9fIY/jf/JLZA==
X-Received: by 2002:a62:f50b:: with SMTP id n11-v6mr208139pfh.120.1531805392627;
        Mon, 16 Jul 2018 22:29:52 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id g23-v6sm159976pgv.26.2018.07.16.22.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 22:29:52 -0700 (PDT)
Date:   Tue, 17 Jul 2018 14:31:05 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Dave Young <dyoung@redhat.com>
Cc:     James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, bhe@redhat.com,
        arnd@arndb.de, ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v11 03/15] powerpc, kexec_file: factor out memblock-based
 arch_kexec_walk_mem()
Message-ID: <20180717053104.GB11258@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Dave Young <dyoung@redhat.com>, James Morse <james.morse@arm.com>,
        catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
 <20180711074203.3019-4-takahiro.akashi@linaro.org>
 <20180714015223.GA2745@dhcp-128-65.nay.redhat.com>
 <2a4ec965-5258-5835-3022-8f403a2f6bdd@arm.com>
 <20180716122412.GA7160@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716122412.GA7160@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Mon, Jul 16, 2018 at 08:24:12PM +0800, Dave Young wrote:
> On 07/16/18 at 12:04pm, James Morse wrote:
> > Hi Dave,
> > 
> > On 14/07/18 02:52, Dave Young wrote:
> > > On 07/11/18 at 04:41pm, AKASHI Takahiro wrote:
> > >> Memblock list is another source for usable system memory layout.
> > >> So powerpc's arch_kexec_walk_mem() is moved to kexec_file.c so that
> > >> other memblock-based architectures, particularly arm64, can also utilise
> > >> it. A moved function is now renamed to kexec_walk_memblock() and merged
> > >> into the existing arch_kexec_walk_mem() for general use, either resource
> > >> list or memblock list.
> > >>
> > >> A consequent function will not work for kdump with memblock list, but
> > >> this will be fixed in the next patch.
> > 
> > >> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > 
> > >> @@ -513,6 +563,10 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
> > >>  int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
> > >>  			       int (*func)(struct resource *, void *))
> > >>  {
> > >> +	if (IS_ENABLED(CONFIG_HAVE_MEMBLOCK) &&
> > >> +			!IS_ENABLED(CONFIG_ARCH_DISCARD_MEMBLOCK))
> > >> +		return kexec_walk_memblock(kbuf, func);
> > > 
> > > AKASHI, I'm not sure if this works on all arches, for example I chekced
> > > the .config on my Nokia N900 kernel tree, there is HAVE_MEMBLOCK=y and
> > > no CONFIG_ARCH_DISCARD_MEMBLOCK, in 32bit arm code no arch_kexec_walk_mem()
> > By doesn't work you mean it's a change in behaviour?
> > I think this is fine because 32bit arm doesn't support KEXEC_FILE, (this file is
> > kexec_file specific right?).
> 
> Ah, replied on a train, I forgot this is only for kexec_file, sorry
> about that.  Please ignore the comment.
> 
> But since we have a weak function arch_kexec_walk_mem, adding another
> condition branch within this weak function looks not good.
> Something like below would be better:

I see your concern here, but


> int kexec_locate_mem_hole(struct kexec_buf *kbuf)
> {
>         int ret;
> 
> 	+ if use memblock
> 	+	ret = kexec_walk_memblock()
> 	+ else
>         	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
> 
>         return ret == 1 ? 0 : -EADDRNOTAVAIL;
> }

what if yet another architecture comes to kexec_file and wanna
take a third approach? How can it override those functions?
Depending on kernel configuration, it might re-define either
kexec_walk_memblock() or arch_kexec_walk_mem(). It sounds weird to me.

Thanks,
-Takahiro AKASHI

> 
> > 
> > It only affects architectures with MEMBLOCK and KEXEC_FILE: powerpc, s390 and
> > soon arm64. s390 keeps its behaviour because it provides arch_kexec_walk_mem(),
> > and powerpc's is copied in here as its generic 'memblock describes my memory'
> > stuff. The implementation would be the same on arm64, so we're doing this to
> > avoid duplicating otherwise generic arch code. I think 32bit arm should be able
> > to use this too if it gets KEXEC_FILE support. (32bit arms' KEXEC already
> > depends on MEMBLOCK).
> > 
> > 
> > Thanks,
> > 
> > James
> 
> Thanks
> Dave
