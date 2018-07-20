Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441C0ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E184420673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 06:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cSLMNmTh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E184420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbeGTHLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 03:11:09 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44217 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbeGTHLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 03:11:08 -0400
Received: by mail-pl0-f66.google.com with SMTP id m16-v6so4726962pls.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 23:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bEXwFwxayDGdtpOx+Yh7WBt5fMXkT16SHSzUp0ujqjc=;
        b=cSLMNmTh6gHxAP3x+LLKGhaQiFqapF/VxIjN0nIG2ZgHQ3B+JSQsrqI0H6sMgtCe3E
         WtuFGSZB/5oALFoZX8JUpgV9sBS47u11aAIDms9zPt8uzl/tOd89DfJ8GistPyhjqmja
         aiaNH1byHxwrdr2snAel9sQaOo3OSoWl/6h1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=bEXwFwxayDGdtpOx+Yh7WBt5fMXkT16SHSzUp0ujqjc=;
        b=fbq2RywjMu8ZX1CwaU06jLRT4ML5F61ch5d3X98Xy/W7vi7fp6avaT7b4QgAMILrBa
         hkzGlyfJH21fu2Z4gYvJe0MOuo6yHPDcKRuv0pcMXya2p0UQrJ182/K6DpHtBaR15aRx
         fV9vFG3XCPBE1+QplEorOXyurhrgFLRZ9eRo5/70+gehKGY5jq6dGW8A883ef8tyFf3+
         tAK1hx1xjKVWtLCiaKp3sUrNrFywz0hVObdthns9DlOH2CHrRJpAnV7xPtRUSvQT/3zj
         h2Afd2aQfOhnr0jMEC9+sNDTS4i2EW/i33enxFQ2S/sWxXVbqzi8IVdk6t+mIyWe8E0M
         uQ9g==
X-Gm-Message-State: AOUpUlHk3gbW2VyT21YxktlcFTTi35NSvL8CqZ37suOS96MMB1+zPAkt
        xU+Syw9+5Lx4VR60TaoFdJUEYhuHuEA=
X-Google-Smtp-Source: AAOMgpeABoTD0DHTmuIAFWXlJGJPUpbMnpA3HiQztZAsXb1mSUn0v90sKDbHlak0r0sLvdfUjAQDnA==
X-Received: by 2002:a17:902:8bc6:: with SMTP id r6-v6mr789840plo.257.1532067870424;
        Thu, 19 Jul 2018 23:24:30 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id k26-v6sm2164521pfb.167.2018.07.19.23.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 23:24:29 -0700 (PDT)
Date:   Fri, 20 Jul 2018 15:25:49 +0900
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
Message-ID: <20180720062548.GL11258@linaro.org>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Dave Young <dyoung@redhat.com>, James Morse <james.morse@arm.com>,
        catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au, davem@davemloft.net,
        bhe@redhat.com, arnd@arndb.de, ard.biesheuvel@linaro.org,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
References: <2a4ec965-5258-5835-3022-8f403a2f6bdd@arm.com>
 <20180716122412.GA7160@dhcp-128-65.nay.redhat.com>
 <20180717053104.GB11258@linaro.org>
 <20180717074923.GA8591@dhcp-128-65.nay.redhat.com>
 <20180718053818.GF11258@linaro.org>
 <20180718061350.GA5086@dhcp-128-65.nay.redhat.com>
 <20180718064041.GI11258@linaro.org>
 <20180718064519.GB5324@dhcp-128-65.nay.redhat.com>
 <20180720053333.GJ11258@linaro.org>
 <20180720055727.GA9487@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720055727.GA9487@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 01:57:27PM +0800, Dave Young wrote:
> On 07/20/18 at 02:33pm, AKASHI Takahiro wrote:
> > Dave,
> > 
> > On Wed, Jul 18, 2018 at 02:45:19PM +0800, Dave Young wrote:
> > > On 07/18/18 at 03:40pm, AKASHI Takahiro wrote:
> > > > On Wed, Jul 18, 2018 at 02:13:50PM +0800, Dave Young wrote:
> > > > > Hi AKASHI,
> > > > > 
> > > > > On 07/18/18 at 02:38pm, AKASHI Takahiro wrote:
> > > > > > Dave,
> > > > > > 
> > > > > > On Tue, Jul 17, 2018 at 03:49:23PM +0800, Dave Young wrote:
> > > > > > > Hi AKASHI,
> > > > > > > On 07/17/18 at 02:31pm, AKASHI Takahiro wrote:
> > > > > > > > Hi Dave,
> > > > > > > > 
> > > > > > > > On Mon, Jul 16, 2018 at 08:24:12PM +0800, Dave Young wrote:
> > > > > > > > > On 07/16/18 at 12:04pm, James Morse wrote:
> > > > > > > > > > Hi Dave,
> > > > > > > > > > 
> > > > > > > > > > On 14/07/18 02:52, Dave Young wrote:
> > > > > > > > > > > On 07/11/18 at 04:41pm, AKASHI Takahiro wrote:
> > > > > > > > > > >> Memblock list is another source for usable system memory layout.
> > > > > > > > > > >> So powerpc's arch_kexec_walk_mem() is moved to kexec_file.c so that
> > > > > > > > > > >> other memblock-based architectures, particularly arm64, can also utilise
> > > > > > > > > > >> it. A moved function is now renamed to kexec_walk_memblock() and merged
> > > > > > > > > > >> into the existing arch_kexec_walk_mem() for general use, either resource
> > > > > > > > > > >> list or memblock list.
> > > > > > > > > > >>
> > > > > > > > > > >> A consequent function will not work for kdump with memblock list, but
> > > > > > > > > > >> this will be fixed in the next patch.
> > > > > > > > > > 
> > > > > > > > > > >> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > > > > > > > > 
> > > > > > > > > > >> @@ -513,6 +563,10 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
> > > > > > > > > > >>  int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
> > > > > > > > > > >>  			       int (*func)(struct resource *, void *))
> > > > > > > > > > >>  {
> > > > > > > > > > >> +	if (IS_ENABLED(CONFIG_HAVE_MEMBLOCK) &&
> > > > > > > > > > >> +			!IS_ENABLED(CONFIG_ARCH_DISCARD_MEMBLOCK))
> > > > > > > > > > >> +		return kexec_walk_memblock(kbuf, func);
> > > > > > > > > > > 
> > > > > > > > > > > AKASHI, I'm not sure if this works on all arches, for example I chekced
> > > > > > > > > > > the .config on my Nokia N900 kernel tree, there is HAVE_MEMBLOCK=y and
> > > > > > > > > > > no CONFIG_ARCH_DISCARD_MEMBLOCK, in 32bit arm code no arch_kexec_walk_mem()
> > > > > > > > > > By doesn't work you mean it's a change in behaviour?
> > > > > > > > > > I think this is fine because 32bit arm doesn't support KEXEC_FILE, (this file is
> > > > > > > > > > kexec_file specific right?).
> > > > > > > > > 
> > > > > > > > > Ah, replied on a train, I forgot this is only for kexec_file, sorry
> > > > > > > > > about that.  Please ignore the comment.
> > > > > > > > > 
> > > > > > > > > But since we have a weak function arch_kexec_walk_mem, adding another
> > > > > > > > > condition branch within this weak function looks not good.
> > > > > > > > > Something like below would be better:
> > > > > > > > 
> > > > > > > > I see your concern here, but
> > > > > > > > 
> > > > > > > > 
> > > > > > > > > int kexec_locate_mem_hole(struct kexec_buf *kbuf)
> > > > > > > > > {
> > > > > > > > >         int ret;
> > > > > > > > > 
> > > > > > > > > 	+ if use memblock
> > > > > > > > > 	+	ret = kexec_walk_memblock()
> > > > > > > > > 	+ else
> > > > > > > > >         	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
> > > > > > > > > 
> > > > > > > > >         return ret == 1 ? 0 : -EADDRNOTAVAIL;
> > > > > > > > > }
> > > > > > > > 
> > > > > > > > what if yet another architecture comes to kexec_file and wanna
> > > > > > > > take a third approach? How can it override those functions?
> > > > > > > > Depending on kernel configuration, it might re-define either
> > > > > > > > kexec_walk_memblock() or arch_kexec_walk_mem(). It sounds weird to me.
> > > > > > > 
> > > > > > > I also feel this weird, but it is slightly better because currently no
> > > > > > > user need another overriding requirement, and I feel it is not expected to have in
> > > > > > > the future for the memblock use.
> > > > > > > 
> > > > > > > Rethinking about this issue, we can just remove the weak function and
> > > > > > > just use general function.
> > > > > > 
> > > > > > Do you really want to remove "weak" attribute?
> > > > > > 
> > > > > > > Currently with your patch applied only s390 use arch_kexec_walk_mem like
> > > > > > > below:
> > > > > > > /*
> > > > > > >  * The kernel is loaded to a fixed location. Turn off kexec_locate_mem_hole
> > > > > > >  * and provide kbuf->mem by hand.
> > > > > > >  */
> > > > > > > int arch_kexec_walk_mem(struct kexec_buf *kbuf,
> > > > > > >                         int (*func)(struct resource *, void *))
> > > > > > > {
> > > > > > >         return 1;
> > > > > > > }
> > > > > > > 
> > > > > > > AFAIK, all other users initialize kbuf->mem as NULL, so we can check
> > > > > > 
> > > > > > As a matter of fact, nobody initializes kbuf->mem before calling
> > > > > > kexec_add_buffer (in turn, kexec_locate_mem_hole()).
> > > > > 
> > > > > Not sure we understand each other..
> > > > > Let's take an example in arch/x86/kernel/kexec-bzimage64.c:
> > > > > bzImage64_load() :
> > > > > 	struct kexec_buf kbuf = { .image = image, .buf_max = ULONG_MAX,
> > > > > 				.top_down = true };
> > > > > 
> > > > > Except the three fields above other members will be initialized as zero
> > > > > when compiling including the kbuf->mem
> > > > 
> > > > Ah, you're right.
> > > > (My armr64 patch doesn't use struct initializer, though.)
> > > > 
> > > > > > 
> > > > > > > kbuf->mem in int kexec_locate_mem_hole:
> > > > > > > 
> > > > > > > if (kbuf->mem)
> > > > > > > 	return 0;
> > > > > > > 
> > > > > > > if use memblock
> > > > > > > 	kexec_walk_memblock
> > > > > > > else
> > > > > > > 	kexec_walk_mem
> > > > > 
> > > > > kexec_walk_resource will be better than kexec_walk_mem
> > > > > 
> > > > > > 
> > > > > > I think that your solution will work for existing architectures
> > > > > > with appropriate patches, but to take your approach, as I said above,
> > > > > > we will have to modify every call site on all kexec_file-capable architectures.
> > > > > > 
> > > > > > If this is what you expect, I will work on it, but I don't think
> > > > > > that it would be a better idea.
> > > > 
> > > > So you would expect me to modify my own arm64 code as well as s390.
> > > 
> > > Yes :)  But I had not get time to read all your patches so I was not
> > > aware the struct initialization in arm64 code so I assumed only s390
> > > need a change..
> > 
> > Okay, but I don't want to mix cross-arch changes into a single patch,
> > prefer to leave the current patch as it is and add an additional patch
> > as you suggested here.
> Hi AKASHI,
> 
> Maybe add another patch to drop s390 walk function first, then follow
> with this patch with the modification about common code restructure.
> 
> Is this better? For example:
> 03/15 s390, drop s390 arch_kexec_mem_walk
> 04/15 powerpc, kexec_file: factor out memblock-based arch_kexec_walk_mem

That's fine to me, too.

Thanks,
-Takahiro AKASHI

> > 
> > Is that OK for you?
> > 
> > Thanks,
> > -Takahiro AKASHI
> > 
> > 
> > > Thanks
> > > Dave
> 
> Thanks
> Dave
