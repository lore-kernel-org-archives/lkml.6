Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C805ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2FEA2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2FEA2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbeGRGuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 02:50:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34048 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726258AbeGRGuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 02:50:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E39E54106D21;
        Wed, 18 Jul 2018 06:14:03 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-41.pek2.redhat.com [10.72.12.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B81E2026D74;
        Wed, 18 Jul 2018 06:13:54 +0000 (UTC)
Date:   Wed, 18 Jul 2018 14:13:50 +0800
From:   Dave Young <dyoung@redhat.com>
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        James Morse <james.morse@arm.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, dhowells@redhat.com, vgoyal@redhat.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, bhe@redhat.com,
        arnd@arndb.de, ard.biesheuvel@linaro.org, bhsharma@redhat.com,
        kexec@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v11 03/15] powerpc, kexec_file: factor out memblock-based
 arch_kexec_walk_mem()
Message-ID: <20180718061350.GA5086@dhcp-128-65.nay.redhat.com>
References: <20180711074203.3019-1-takahiro.akashi@linaro.org>
 <20180711074203.3019-4-takahiro.akashi@linaro.org>
 <20180714015223.GA2745@dhcp-128-65.nay.redhat.com>
 <2a4ec965-5258-5835-3022-8f403a2f6bdd@arm.com>
 <20180716122412.GA7160@dhcp-128-65.nay.redhat.com>
 <20180717053104.GB11258@linaro.org>
 <20180717074923.GA8591@dhcp-128-65.nay.redhat.com>
 <20180718053818.GF11258@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180718053818.GF11258@linaro.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 18 Jul 2018 06:14:04 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Wed, 18 Jul 2018 06:14:04 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dyoung@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AKASHI,

On 07/18/18 at 02:38pm, AKASHI Takahiro wrote:
> Dave,
> 
> On Tue, Jul 17, 2018 at 03:49:23PM +0800, Dave Young wrote:
> > Hi AKASHI,
> > On 07/17/18 at 02:31pm, AKASHI Takahiro wrote:
> > > Hi Dave,
> > > 
> > > On Mon, Jul 16, 2018 at 08:24:12PM +0800, Dave Young wrote:
> > > > On 07/16/18 at 12:04pm, James Morse wrote:
> > > > > Hi Dave,
> > > > > 
> > > > > On 14/07/18 02:52, Dave Young wrote:
> > > > > > On 07/11/18 at 04:41pm, AKASHI Takahiro wrote:
> > > > > >> Memblock list is another source for usable system memory layout.
> > > > > >> So powerpc's arch_kexec_walk_mem() is moved to kexec_file.c so that
> > > > > >> other memblock-based architectures, particularly arm64, can also utilise
> > > > > >> it. A moved function is now renamed to kexec_walk_memblock() and merged
> > > > > >> into the existing arch_kexec_walk_mem() for general use, either resource
> > > > > >> list or memblock list.
> > > > > >>
> > > > > >> A consequent function will not work for kdump with memblock list, but
> > > > > >> this will be fixed in the next patch.
> > > > > 
> > > > > >> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > > > 
> > > > > >> @@ -513,6 +563,10 @@ static int locate_mem_hole_callback(struct resource *res, void *arg)
> > > > > >>  int __weak arch_kexec_walk_mem(struct kexec_buf *kbuf,
> > > > > >>  			       int (*func)(struct resource *, void *))
> > > > > >>  {
> > > > > >> +	if (IS_ENABLED(CONFIG_HAVE_MEMBLOCK) &&
> > > > > >> +			!IS_ENABLED(CONFIG_ARCH_DISCARD_MEMBLOCK))
> > > > > >> +		return kexec_walk_memblock(kbuf, func);
> > > > > > 
> > > > > > AKASHI, I'm not sure if this works on all arches, for example I chekced
> > > > > > the .config on my Nokia N900 kernel tree, there is HAVE_MEMBLOCK=y and
> > > > > > no CONFIG_ARCH_DISCARD_MEMBLOCK, in 32bit arm code no arch_kexec_walk_mem()
> > > > > By doesn't work you mean it's a change in behaviour?
> > > > > I think this is fine because 32bit arm doesn't support KEXEC_FILE, (this file is
> > > > > kexec_file specific right?).
> > > > 
> > > > Ah, replied on a train, I forgot this is only for kexec_file, sorry
> > > > about that.  Please ignore the comment.
> > > > 
> > > > But since we have a weak function arch_kexec_walk_mem, adding another
> > > > condition branch within this weak function looks not good.
> > > > Something like below would be better:
> > > 
> > > I see your concern here, but
> > > 
> > > 
> > > > int kexec_locate_mem_hole(struct kexec_buf *kbuf)
> > > > {
> > > >         int ret;
> > > > 
> > > > 	+ if use memblock
> > > > 	+	ret = kexec_walk_memblock()
> > > > 	+ else
> > > >         	ret = arch_kexec_walk_mem(kbuf, locate_mem_hole_callback);
> > > > 
> > > >         return ret == 1 ? 0 : -EADDRNOTAVAIL;
> > > > }
> > > 
> > > what if yet another architecture comes to kexec_file and wanna
> > > take a third approach? How can it override those functions?
> > > Depending on kernel configuration, it might re-define either
> > > kexec_walk_memblock() or arch_kexec_walk_mem(). It sounds weird to me.
> > 
> > I also feel this weird, but it is slightly better because currently no
> > user need another overriding requirement, and I feel it is not expected to have in
> > the future for the memblock use.
> > 
> > Rethinking about this issue, we can just remove the weak function and
> > just use general function.
> 
> Do you really want to remove "weak" attribute?
> 
> > Currently with your patch applied only s390 use arch_kexec_walk_mem like
> > below:
> > /*
> >  * The kernel is loaded to a fixed location. Turn off kexec_locate_mem_hole
> >  * and provide kbuf->mem by hand.
> >  */
> > int arch_kexec_walk_mem(struct kexec_buf *kbuf,
> >                         int (*func)(struct resource *, void *))
> > {
> >         return 1;
> > }
> > 
> > AFAIK, all other users initialize kbuf->mem as NULL, so we can check
> 
> As a matter of fact, nobody initializes kbuf->mem before calling
> kexec_add_buffer (in turn, kexec_locate_mem_hole()).

Not sure we understand each other..
Let's take an example in arch/x86/kernel/kexec-bzimage64.c:
bzImage64_load() :
	struct kexec_buf kbuf = { .image = image, .buf_max = ULONG_MAX,
				.top_down = true };

Except the three fields above other members will be initialized as zero
when compiling including the kbuf->mem

> 
> > kbuf->mem in int kexec_locate_mem_hole:
> > 
> > if (kbuf->mem)
> > 	return 0;
> > 
> > if use memblock
> > 	kexec_walk_memblock
> > else
> > 	kexec_walk_mem

kexec_walk_resource will be better than kexec_walk_mem

> 
> I think that your solution will work for existing architectures
> with appropriate patches, but to take your approach, as I said above,
> we will have to modify every call site on all kexec_file-capable architectures.
> 
> If this is what you expect, I will work on it, but I don't think
> that it would be a better idea.
> 
> Thanks,
> -Takahiro AKASHI
> 
> > > 
> > > Thanks,
> > > -Takahiro AKASHI
> > > 
> > > > 
> > > > > 
> > > > > It only affects architectures with MEMBLOCK and KEXEC_FILE: powerpc, s390 and
> > > > > soon arm64. s390 keeps its behaviour because it provides arch_kexec_walk_mem(),
> > > > > and powerpc's is copied in here as its generic 'memblock describes my memory'
> > > > > stuff. The implementation would be the same on arm64, so we're doing this to
> > > > > avoid duplicating otherwise generic arch code. I think 32bit arm should be able
> > > > > to use this too if it gets KEXEC_FILE support. (32bit arms' KEXEC already
> > > > > depends on MEMBLOCK).
> > > > > 
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > James
> > > > 
> > > > Thanks
> > > > Dave
> > 
> > Thanks
> > Dave

Thanks
dave
