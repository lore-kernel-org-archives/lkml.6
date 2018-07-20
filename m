Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89DDECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 05:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D6E205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 05:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TX9zYBvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D6E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbeGTGSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 02:18:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34883 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbeGTGSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 02:18:44 -0400
Received: by mail-pg1-f194.google.com with SMTP id e6-v6so5837349pgv.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 22:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yOqVsRsZHwXKAUys0UHc5JykXoaLhJo/WgNsVsffsQ0=;
        b=TX9zYBvDf5LDFLSp2L2CfWGTPiHGZu7MzdKpqcjAn43j6/8/tnIh/+MYTagVIQzkoG
         IV/jel/ZQ0lztC4spANLfN+B3oH46Ph/xGhsz5FsAIhgYXrhrRA0QuObSqaQNKrfcWJJ
         gNTeEyW4pjDBDhPZdALkU+G3uSceOasXBF2uY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=yOqVsRsZHwXKAUys0UHc5JykXoaLhJo/WgNsVsffsQ0=;
        b=FPB32X/n9AQVsoF7tbETm7vpMYiPcSPjIX3uVRImmMr7dkSq6O5wAODdXYLzbL/Aj1
         ecmsaWnTNkNSWjmY6DEAS10Yzk8v6sSjI5955jjg9+Np6sUHi398zcQvoA02Bh88D1t4
         rmv5h2gviqZ6kQIFYPwZvijHM1H4CmVrhCQfByAZ68t3ZwacjDmQDO56pZjrPALuuUyZ
         AVqk+sZNMCfLbS5rVt5YIlvSQmi2kgjQNE15BBCuJE7yOwwADF07zfCJU/KtKWGq2vsm
         oA+jMK5RleRjtp0GwW/QsIbg/Lw+JVkEk8DSI/X8FU0t4PEI/pEoGLw9YvjX3Y9lz4O/
         bapw==
X-Gm-Message-State: AOUpUlEC92s8lRuH+Vpw+BbGm7+VlB65Q7hVj4IGNjrGp76FCEJnl4KS
        qgHy+tYguWsWsDqvrNUhdF96ZQ==
X-Google-Smtp-Source: AAOMgpdIIDsHSINp94F+L4rNbOd6RC5+EPTrKiQaAZ1p7pOo8hG1IX9CDjJ1nrybUcjaTk9g647K9Q==
X-Received: by 2002:a63:4c56:: with SMTP id m22-v6mr645849pgl.299.1532064735271;
        Thu, 19 Jul 2018 22:32:15 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id q21-v6sm1189932pfl.156.2018.07.19.22.32.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 22:32:14 -0700 (PDT)
Date:   Fri, 20 Jul 2018 14:33:34 +0900
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
Message-ID: <20180720053333.GJ11258@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Dave Young <dyoung@redhat.com>, James Morse <james.morse@arm.com>,
        catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <20180711074203.3019-4-takahiro.akashi@linaro.org>
 <20180714015223.GA2745@dhcp-128-65.nay.redhat.com>
 <2a4ec965-5258-5835-3022-8f403a2f6bdd@arm.com>
 <20180716122412.GA7160@dhcp-128-65.nay.redhat.com>
 <20180717053104.GB11258@linaro.org>
 <20180717074923.GA8591@dhcp-128-65.nay.redhat.com>
 <20180718053818.GF11258@linaro.org>
 <20180718061350.GA5086@dhcp-128-65.nay.redhat.com>
 <20180718064041.GI11258@linaro.org>
 <20180718064519.GB5324@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718064519.GB5324@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

On Wed, Jul 18, 2018 at 02:45:19PM +0800, Dave Young wrote:
> On 07/18/18 at 03:40pm, AKASHI Takahiro wrote:
> > On Wed, Jul 18, 2018 at 02:13:50PM +0800, Dave Young wrote:
> > > Hi AKASHI,
> > > 
> > > On 07/18/18 at 02:38pm, AKASHI Takahiro wrote:
> > > > Dave,
> > > > 
> > > > On Tue, Jul 17, 2018 at 03:49:23PM +0800, Dave Young wrote:
> > > > > Hi AKASHI,
> > > > > On 07/17/18 at 02:31pm, AKASHI Takahiro wrote:
> > > > > > Hi Dave,
> > > > > > 
> > > > > > On Mon, Jul 16, 2018 at 08:24:12PM +0800, Dave Young wrote:
> > > > > > > On 07/16/18 at 12:04pm, James Morse wrote:
> > > > > > > > Hi Dave,
> > > > > > > > 
> > > > > > > > On 14/07/18 02:52, Dave Young wrote:
> > > > > > > > > On 07/11/18 at 04:41pm, AKASHI Takahiro wrote:
> > > > > > > > >> Memblock list is another source for usable system memory layout.
> > > > > > > > >> So powerpc's arch_kexec_walk_mem() is moved to kexec_file.c so that
> > > > > > > > >> other memblock-based architectures, particularly arm64, can also utilise
> > > > > > > > >> it. A moved function is now renamed to kexec_walk_memblock() and merged
> > > > > > > > >> into the existing arch_kexec_walk_mem() for general use, either resource
> > > > > > > > >> list or memblock list.
> > > > > > > > >>
> > > > > > > > >> A consequent function will not work for kdump with memblock list, but
> > > > > > > > >> this will be fixed in the next patch.
> > > > > > > > 
> > > > > > > > >> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > > > > > > 
> > > > > > > > >> @@ -513,6 +563,10 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
> > > > > > > > >>  int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
> > > > > > > > >>  			       int (*func)(struct resource *, void *))
> > > > > > > > >>  {
> > > > > > > > >> +	if (IS_ENABLED(CONFIG_HAVE_MEMBLOCK) &&
> > > > > > > > >> +			!IS_ENABLED(CONFIG_ARCH_DISCARD_MEMBLOCK))
> > > > > > > > >> +		return kexec_walk_memblock(kbuf, func);
> > > > > > > > > 
> > > > > > > > > AKASHI, I'm not sure if this works on all arches, for example I chekced
> > > > > > > > > the .config on my Nokia N900 kernel tree, there is HAVE_MEMBLOCK=y and
> > > > > > > > > no CONFIG_ARCH_DISCARD_MEMBLOCK, in 32bit arm code no arch_kexec_walk_mem()
> > > > > > > > By doesn't work you mean it's a change in behaviour?
> > > > > > > > I think this is fine because 32bit arm doesn't support KEXEC_FILE, (this file is
> > > > > > > > kexec_file specific right?).
> > > > > > > 
> > > > > > > Ah, replied on a train, I forgot this is only for kexec_file, sorry
> > > > > > > about that.  Please ignore the comment.
> > > > > > > 
> > > > > > > But since we have a weak function arch_kexec_walk_mem, adding another
> > > > > > > condition branch within this weak function looks not good.
> > > > > > > Something like below would be better:
> > > > > > 
> > > > > > I see your concern here, but
> > > > > > 
> > > > > > 
> > > > > > > int kexec_locate_mem_hole(struct kexec_buf *kbuf)
> > > > > > > {
> > > > > > >         int ret;
> > > > > > > 
> > > > > > > 	+ if use memblock
> > > > > > > 	+	ret = kexec_walk_memblock()
> > > > > > > 	+ else
> > > > > > >         	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
> > > > > > > 
> > > > > > >         return ret == 1 ? 0 : -EADDRNOTAVAIL;
> > > > > > > }
> > > > > > 
> > > > > > what if yet another architecture comes to kexec_file and wanna
> > > > > > take a third approach? How can it override those functions?
> > > > > > Depending on kernel configuration, it might re-define either
> > > > > > kexec_walk_memblock() or arch_kexec_walk_mem(). It sounds weird to me.
> > > > > 
> > > > > I also feel this weird, but it is slightly better because currently no
> > > > > user need another overriding requirement, and I feel it is not expected to have in
> > > > > the future for the memblock use.
> > > > > 
> > > > > Rethinking about this issue, we can just remove the weak function and
> > > > > just use general function.
> > > > 
> > > > Do you really want to remove "weak" attribute?
> > > > 
> > > > > Currently with your patch applied only s390 use arch_kexec_walk_mem like
> > > > > below:
> > > > > /*
> > > > >  * The kernel is loaded to a fixed location. Turn off kexec_locate_mem_hole
> > > > >  * and provide kbuf->mem by hand.
> > > > >  */
> > > > > int arch_kexec_walk_mem(struct kexec_buf *kbuf,
> > > > >                         int (*func)(struct resource *, void *))
> > > > > {
> > > > >         return 1;
> > > > > }
> > > > > 
> > > > > AFAIK, all other users initialize kbuf->mem as NULL, so we can check
> > > > 
> > > > As a matter of fact, nobody initializes kbuf->mem before calling
> > > > kexec_add_buffer (in turn, kexec_locate_mem_hole()).
> > > 
> > > Not sure we understand each other..
> > > Let's take an example in arch/x86/kernel/kexec-bzimage64.c:
> > > bzImage64_load() :
> > > 	struct kexec_buf kbuf = { .image = image, .buf_max = ULONG_MAX,
> > > 				.top_down = true };
> > > 
> > > Except the three fields above other members will be initialized as zero
> > > when compiling including the kbuf->mem
> > 
> > Ah, you're right.
> > (My armr64 patch doesn't use struct initializer, though.)
> > 
> > > > 
> > > > > kbuf->mem in int kexec_locate_mem_hole:
> > > > > 
> > > > > if (kbuf->mem)
> > > > > 	return 0;
> > > > > 
> > > > > if use memblock
> > > > > 	kexec_walk_memblock
> > > > > else
> > > > > 	kexec_walk_mem
> > > 
> > > kexec_walk_resource will be better than kexec_walk_mem
> > > 
> > > > 
> > > > I think that your solution will work for existing architectures
> > > > with appropriate patches, but to take your approach, as I said above,
> > > > we will have to modify every call site on all kexec_file-capable architectures.
> > > > 
> > > > If this is what you expect, I will work on it, but I don't think
> > > > that it would be a better idea.
> > 
> > So you would expect me to modify my own arm64 code as well as s390.
> 
> Yes :)  But I had not get time to read all your patches so I was not
> aware the struct initialization in arm64 code so I assumed only s390
> need a change..

Okay, but I don't want to mix cross-arch changes into a single patch,
prefer to leave the current patch as it is and add an additional patch
as you suggested here.

Is that OK for you?

Thanks,
-Takahiro AKASHI


> Thanks
> Dave
