Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7108EECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B4DD2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 05:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hJvJJanD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B4DD2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbeGRGNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 02:13:10 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40577 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbeGRGNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 02:13:10 -0400
Received: by mail-pf0-f195.google.com with SMTP id e13-v6so1643137pff.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 22:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/aUK2uPANC2fbdKTgLq6QRcMM62yDknyfUpjDK480kc=;
        b=hJvJJanDzL1bXJB2M+0hvAaVONqO0Q5X3+1y/Y62bvyXz/q5nfSOzQshi+s0LZZHfU
         B0YnubgdNjZjnsmzi8k+cTbVFolAsNEplpmbOw/2Sv/4cSkgcmKumTHxHHomlf/6rJxJ
         p97GRhqk8F9Gp3018GP1k2jpiNJQi/gCPH6dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=/aUK2uPANC2fbdKTgLq6QRcMM62yDknyfUpjDK480kc=;
        b=Nl/mF0vQ//SZRSuOl8yXljdWrFPnW7znSAFEen1edQC/eD2Oz6Tnf9rqUnPMS+Gbht
         UlSq5LMg3fBlkIaFEfKhesnLuOgb7h638Vq8RPCAxa4ZuRfzjBXj/84teuTW3uyk7VfZ
         lGMFVygyaNVsxEJddDZQpBwXM8XPex4a/PfJvEnhY7Wl6zvWeZgUW1hfNVHAezCcDbhc
         A2HvoPuA/VYjQpYBnH9I8Ja0RQtN0hJJYnbInGpwRM5yXNFFTLEOe5w96WJmLXCThLYg
         MQoqnfOokznMCd55MCCg/+A1z0LamBMJXtmYFt/7MO/xVzB9WrPP29goY3KGncGu/s6S
         1Pyw==
X-Gm-Message-State: AOUpUlF24LGGpY++2a1A/zhPcm5/aCLG6s2SFomveyP2deVK6nqfMDn0
        EwfZgahPVLRT+GJfmNgMA4/uAg==
X-Google-Smtp-Source: AAOMgpeVlRd3QDgDlFGxmjs8v9ZyBTYOzlqnQXL0+7UAaG0YwJMkLRuF75BXjmilrriu5v1Q3EzNNw==
X-Received: by 2002:a65:6086:: with SMTP id t6-v6mr4492962pgu.424.1531892224784;
        Tue, 17 Jul 2018 22:37:04 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id u69-v6sm6241110pgd.43.2018.07.17.22.37.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 22:37:04 -0700 (PDT)
Date:   Wed, 18 Jul 2018 14:38:20 +0900
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
Message-ID: <20180718053818.GF11258@linaro.org>
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
 <20180717053104.GB11258@linaro.org>
 <20180717074923.GA8591@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717074923.GA8591@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

On Tue, Jul 17, 2018 at 03:49:23PM +0800, Dave Young wrote:
> Hi AKASHI,
> On 07/17/18 at 02:31pm, AKASHI Takahiro wrote:
> > Hi Dave,
> > 
> > On Mon, Jul 16, 2018 at 08:24:12PM +0800, Dave Young wrote:
> > > On 07/16/18 at 12:04pm, James Morse wrote:
> > > > Hi Dave,
> > > > 
> > > > On 14/07/18 02:52, Dave Young wrote:
> > > > > On 07/11/18 at 04:41pm, AKASHI Takahiro wrote:
> > > > >> Memblock list is another source for usable system memory layout.
> > > > >> So powerpc's arch_kexec_walk_mem() is moved to kexec_file.c so that
> > > > >> other memblock-based architectures, particularly arm64, can also utilise
> > > > >> it. A moved function is now renamed to kexec_walk_memblock() and merged
> > > > >> into the existing arch_kexec_walk_mem() for general use, either resource
> > > > >> list or memblock list.
> > > > >>
> > > > >> A consequent function will not work for kdump with memblock list, but
> > > > >> this will be fixed in the next patch.
> > > > 
> > > > >> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > > 
> > > > >> @@ -513,6 +563,10 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
> > > > >>  int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
> > > > >>  			       int (*func)(struct resource *, void *))
> > > > >>  {
> > > > >> +	if (IS_ENABLED(CONFIG_HAVE_MEMBLOCK) &&
> > > > >> +			!IS_ENABLED(CONFIG_ARCH_DISCARD_MEMBLOCK))
> > > > >> +		return kexec_walk_memblock(kbuf, func);
> > > > > 
> > > > > AKASHI, I'm not sure if this works on all arches, for example I chekced
> > > > > the .config on my Nokia N900 kernel tree, there is HAVE_MEMBLOCK=y and
> > > > > no CONFIG_ARCH_DISCARD_MEMBLOCK, in 32bit arm code no arch_kexec_walk_mem()
> > > > By doesn't work you mean it's a change in behaviour?
> > > > I think this is fine because 32bit arm doesn't support KEXEC_FILE, (this file is
> > > > kexec_file specific right?).
> > > 
> > > Ah, replied on a train, I forgot this is only for kexec_file, sorry
> > > about that.  Please ignore the comment.
> > > 
> > > But since we have a weak function arch_kexec_walk_mem, adding another
> > > condition branch within this weak function looks not good.
> > > Something like below would be better:
> > 
> > I see your concern here, but
> > 
> > 
> > > int kexec_locate_mem_hole(struct kexec_buf *kbuf)
> > > {
> > >         int ret;
> > > 
> > > 	+ if use memblock
> > > 	+	ret = kexec_walk_memblock()
> > > 	+ else
> > >         	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
> > > 
> > >         return ret == 1 ? 0 : -EADDRNOTAVAIL;
> > > }
> > 
> > what if yet another architecture comes to kexec_file and wanna
> > take a third approach? How can it override those functions?
> > Depending on kernel configuration, it might re-define either
> > kexec_walk_memblock() or arch_kexec_walk_mem(). It sounds weird to me.
> 
> I also feel this weird, but it is slightly better because currently no
> user need another overriding requirement, and I feel it is not expected to have in
> the future for the memblock use.
> 
> Rethinking about this issue, we can just remove the weak function and
> just use general function.

Do you really want to remove "weak" attribute?

> Currently with your patch applied only s390 use arch_kexec_walk_mem like
> below:
> /*
>  * The kernel is loaded to a fixed location. Turn off kexec_locate_mem_hole
>  * and provide kbuf->mem by hand.
>  */
> int arch_kexec_walk_mem(struct kexec_buf *kbuf,
>                         int (*func)(struct resource *, void *))
> {
>         return 1;
> }
> 
> AFAIK, all other users initialize kbuf->mem as NULL, so we can check

As a matter of fact, nobody initializes kbuf->mem before calling
kexec_add_buffer (in turn, kexec_locate_mem_hole()).

> kbuf->mem in int kexec_locate_mem_hole:
> 
> if (kbuf->mem)
> 	return 0;
> 
> if use memblock
> 	kexec_walk_memblock
> else
> 	kexec_walk_mem

I think that your solution will work for existing architectures
with appropriate patches, but to take your approach, as I said above,
we will have to modify every call site on all kexec_file-capable architectures.

If this is what you expect, I will work on it, but I don't think
that it would be a better idea.

Thanks,
-Takahiro AKASHI

> > 
> > Thanks,
> > -Takahiro AKASHI
> > 
> > > 
> > > > 
> > > > It only affects architectures with MEMBLOCK and KEXEC_FILE: powerpc, s390 and
> > > > soon arm64. s390 keeps its behaviour because it provides arch_kexec_walk_mem(),
> > > > and powerpc's is copied in here as its generic 'memblock describes my memory'
> > > > stuff. The implementation would be the same on arm64, so we're doing this to
> > > > avoid duplicating otherwise generic arch code. I think 32bit arm should be able
> > > > to use this too if it gets KEXEC_FILE support. (32bit arms' KEXEC already
> > > > depends on MEMBLOCK).
> > > > 
> > > > 
> > > > Thanks,
> > > > 
> > > > James
> > > 
> > > Thanks
> > > Dave
> 
> Thanks
> Dave
