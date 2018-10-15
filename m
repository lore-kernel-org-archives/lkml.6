Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5476C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 23:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673BF20658
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 23:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="KqArj2jd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 673BF20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbeJPGtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:49:46 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:48492 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbeJPGtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rgqGvJESciL9wTXwv/93QO4Zer+exqU0wL6S9kL+IhU=; b=KqArj2jdoAZ38BzP0NXTGFODk
        brh0DiOc67RtGNzUT071I7C+1cB23SIIqEJYKpnckODkyiZI1tLZhuRbh+rRmXi7+V+kwklqewqak
        Wd0R5KrknhjN9XgWcDmdUfDKoV/S1olrRbqr8t6DirIxXKSEnrzFSRwFnpe0a9aK0+lqc=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:44489)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gCBsQ-0003CR-JE; Tue, 16 Oct 2018 00:02:18 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gCBsI-0008Ck-QH; Tue, 16 Oct 2018 00:02:11 +0100
Date:   Tue, 16 Oct 2018 00:02:07 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Nicolas Pitre <nicolas.pitre@linaro.org>
Cc:     arnd@arndb.de, ulli.kroll@googlemail.com,
        linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        joel@jms.id.au, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] ARM: copypage: do not use naked functions
Message-ID: <20181015230206.GC30658@n2100.armlinux.org.uk>
References: <20181015222621.14673-1-stefan@agner.ch>
 <nycvar.YSQ.7.76.1810151831040.1498@knanqh.ubzr>
 <20181015224152.GA30658@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1810151843100.1498@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1810151843100.1498@knanqh.ubzr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 06:54:49PM -0400, Nicolas Pitre wrote:
> On Mon, 15 Oct 2018, Russell King - ARM Linux wrote:
> 
> > On Mon, Oct 15, 2018 at 06:35:33PM -0400, Nicolas Pitre wrote:
> > > On Tue, 16 Oct 2018, Stefan Agner wrote:
> > > 
> > > > GCC documentation says naked functions should only use basic ASM
> > > > syntax. The extended ASM or mixture of basic ASM and "C" code is
> > > > not guaranteed. Currently it seems to work though.
> > > > 
> > > > Furthermore with Clang using parameters in extended asm in a
> > > > naked function is not supported:
> > > >   arch/arm/mm/copypage-v4wb.c:47:9: error: parameter references not
> > > >   allowed in naked functions
> > > >         : "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64));
> > > >                ^
> > > > 
> > > > Use a regular function to be more portable. Also use volatile asm
> > > > to avoid unsolicited optimizations.
> > > > 
> > > > Tested with qemu versatileab machine and versatile_defconfig and
> > > > qemu mainstone machine using pxa_defconfig compiled with GCC 7.2.1
> > > > and Clang 7.0.
> > > > 
> > > > Link: https://github.com/ClangBuiltLinux/linux/issues/90
> > > > Reported-by: Joel Stanley <joel@jms.id.au>
> > > > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > > > ---
> > > >  arch/arm/mm/copypage-fa.c       | 17 +++++++++++------
> > > >  arch/arm/mm/copypage-feroceon.c | 17 +++++++++++------
> > > >  arch/arm/mm/copypage-v4mc.c     | 14 +++++++++-----
> > > >  arch/arm/mm/copypage-v4wb.c     | 17 +++++++++++------
> > > >  arch/arm/mm/copypage-v4wt.c     | 17 +++++++++++------
> > > >  arch/arm/mm/copypage-xsc3.c     | 17 +++++++++++------
> > > >  arch/arm/mm/copypage-xscale.c   | 13 ++++++++-----
> > > >  7 files changed, 72 insertions(+), 40 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/mm/copypage-fa.c b/arch/arm/mm/copypage-fa.c
> > > > index ec6501308c60..33ccd396bf99 100644
> > > > --- a/arch/arm/mm/copypage-fa.c
> > > > +++ b/arch/arm/mm/copypage-fa.c
> > > > @@ -17,11 +17,16 @@
> > > >  /*
> > > >   * Faraday optimised copy_user_page
> > > >   */
> > > > -static void __naked
> > > > -fa_copy_user_page(void *kto, const void *kfrom)
> > > > +static void fa_copy_user_page(void *kto, const void *kfrom)
> > > >  {
> > > > -	asm("\
> > > > -	stmfd	sp!, {r4, lr}			@ 2\n\
> > > > +	register void *r0 asm("r0") = kto;
> > > > +	register const void *r1 asm("r1") = kfrom;
> > > > +
> > > > +	asm(
> > > > +	__asmeq("%0", "r0")
> > > > +	__asmeq("%1", "r1")
> > > > +	"\
> > > > +	stmfd	sp!, {r4}			@ 2\n\
> > > >  	mov	r2, %2				@ 1\n\
> > > >  1:	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
> > > >  	stmia	r0, {r3, r4, ip, lr}		@ 4\n\
> > > > @@ -34,9 +39,9 @@ fa_copy_user_page(void *kto, const void *kfrom)
> > > >  	subs	r2, r2, #1			@ 1\n\
> > > >  	bne	1b				@ 1\n\
> > > >  	mcr	p15, 0, r2, c7, c10, 4		@ 1   drain WB\n\
> > > > -	ldmfd	sp!, {r4, pc}			@ 3"
> > > > +	ldmfd	sp!, {r4}			@ 3"
> > > >  	:
> > > > -	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 32));
> > > > +	: "r" (r0), "r" (r1), "I" (PAGE_SIZE / 32));
> > > 
> > > This is still wrong as you list r0 and r1 in the input operand list 
> > > where they must remain constant but the code does modify them. You 
> > > should list them in the output operand list with the "&" attribute. Also 
> > > r2 should be listed in the clobbered list.
> > 
> > Either we keep these as naked functions (and, if Clang wants to
> > try to inline naked functions which makes no sense, also mark them
> > as noinline) or we make them proper functions and also add (eg) r4
> > to the clobber list and get rid of the stacking of that register
> > along with LR/PC.
> 
> Yes, indeed.
> 
> I'd say: remove the naked stuff, and let the compiler do the 
> prologue/epilogue itself (or inline it for that matter). And don't force 
> pointers and counter into particular registers. This way r0-r3 could be 
> used as temporaries since they're probably already clobbered by the call 
> to kmap_atomic() anyway. That is likely to be better than forcing ip/lr 
> as temporaryes.

That doesn't work for the general case - which is where the functions
are called via function pointers, and so are never inlined.  For these,
the current code is optimal, and I suspect the compiler will do worse
with it.

For the two instances (v4wb and mc) that don't follow that pattern,
you may be right, but I'd want to see the result of the changes.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
