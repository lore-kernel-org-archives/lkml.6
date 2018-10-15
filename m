Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99DBC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946272054F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R3BVFCnR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 946272054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbeJPGmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:42:12 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33303 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbeJPGmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:42:11 -0400
Received: by mail-qt1-f195.google.com with SMTP id q40-v6so23544455qte.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 15:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=E4FQiwSJmBc7kyShqXZBk91wjEehqaL5rHhd/tM2fBA=;
        b=R3BVFCnRcP5v9gq8xPygT5YNc7a0kL2yTAvc7IpC/RMtnsOPwnutshp9OdGFfB8M0t
         YHsOjrq1oozH2RKkKVfqI0mU9gQH+juxMgLi1i7mwKzRpVzoH69WzM9LYxB5rP30ES7m
         89Z0+GCxIdXPJyeqx1SOs5xiDoh+9PkrI9E64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=E4FQiwSJmBc7kyShqXZBk91wjEehqaL5rHhd/tM2fBA=;
        b=mc10sY+KrfSCv+l1fOv3hN7/bTf7GS1evZttmW2Zr9pwWutQjeHN+lu9I5pEa6CAa3
         +U2a4w47hCXCCgWHbV3TlNPm5Lhy7XMJIwjIzAun09Gy5eZFEST2vljxzvhVQtRhClaR
         VwNsltRH6O+SzAOGLbX1PLrVOxhZA/tym5ErFDknh7oVfvXCx+kI805Np3NwwD05r8FA
         DcmxTw65mga+bdYmwBsyTevRcUBL2JvUelc0LUBkCEk0FGcYvoXkrgwsVDvtug0vYbSb
         nMrkbV5Sl87zDbZ5Pfzf4bf9UKl8CIVjbqrq4RbdyPHcMI4JIA5LehkStDm5NWpiS6YQ
         K5LA==
X-Gm-Message-State: ABuFfogwp/LFDh9H5KVAJpYF4nWi3ae4qqBWPNQ4gd4/16qhKkpL/7Zj
        FVYxGb7WG4SMEy4/P6NrLKmSYw==
X-Google-Smtp-Source: ACcGV62AerW4zD9WOR95SWiX25+Ppop4/7tYZBBEDaGXI7syilDhexRCKd2oSyXUGWYAUl8JNhxyfA==
X-Received: by 2002:aed:3807:: with SMTP id j7-v6mr18635028qte.140.1539644091229;
        Mon, 15 Oct 2018 15:54:51 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id h66-v6sm6457901qkc.53.2018.10.15.15.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 15:54:50 -0700 (PDT)
Date:   Mon, 15 Oct 2018 18:54:49 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
cc:     Stefan Agner <stefan@agner.ch>, ulli.kroll@googlemail.com,
        joel@jms.id.au, arnd@arndb.de, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ARM: copypage: do not use naked functions
In-Reply-To: <20181015224152.GA30658@n2100.armlinux.org.uk>
Message-ID: <nycvar.YSQ.7.76.1810151843100.1498@knanqh.ubzr>
References: <20181015222621.14673-1-stefan@agner.ch> <nycvar.YSQ.7.76.1810151831040.1498@knanqh.ubzr> <20181015224152.GA30658@n2100.armlinux.org.uk>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Oct 2018, Russell King - ARM Linux wrote:

> On Mon, Oct 15, 2018 at 06:35:33PM -0400, Nicolas Pitre wrote:
> > On Tue, 16 Oct 2018, Stefan Agner wrote:
> > 
> > > GCC documentation says naked functions should only use basic ASM
> > > syntax. The extended ASM or mixture of basic ASM and "C" code is
> > > not guaranteed. Currently it seems to work though.
> > > 
> > > Furthermore with Clang using parameters in extended asm in a
> > > naked function is not supported:
> > >   arch/arm/mm/copypage-v4wb.c:47:9: error: parameter references not
> > >   allowed in naked functions
> > >         : "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 64));
> > >                ^
> > > 
> > > Use a regular function to be more portable. Also use volatile asm
> > > to avoid unsolicited optimizations.
> > > 
> > > Tested with qemu versatileab machine and versatile_defconfig and
> > > qemu mainstone machine using pxa_defconfig compiled with GCC 7.2.1
> > > and Clang 7.0.
> > > 
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/90
> > > Reported-by: Joel Stanley <joel@jms.id.au>
> > > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > > ---
> > >  arch/arm/mm/copypage-fa.c       | 17 +++++++++++------
> > >  arch/arm/mm/copypage-feroceon.c | 17 +++++++++++------
> > >  arch/arm/mm/copypage-v4mc.c     | 14 +++++++++-----
> > >  arch/arm/mm/copypage-v4wb.c     | 17 +++++++++++------
> > >  arch/arm/mm/copypage-v4wt.c     | 17 +++++++++++------
> > >  arch/arm/mm/copypage-xsc3.c     | 17 +++++++++++------
> > >  arch/arm/mm/copypage-xscale.c   | 13 ++++++++-----
> > >  7 files changed, 72 insertions(+), 40 deletions(-)
> > > 
> > > diff --git a/arch/arm/mm/copypage-fa.c b/arch/arm/mm/copypage-fa.c
> > > index ec6501308c60..33ccd396bf99 100644
> > > --- a/arch/arm/mm/copypage-fa.c
> > > +++ b/arch/arm/mm/copypage-fa.c
> > > @@ -17,11 +17,16 @@
> > >  /*
> > >   * Faraday optimised copy_user_page
> > >   */
> > > -static void __naked
> > > -fa_copy_user_page(void *kto, const void *kfrom)
> > > +static void fa_copy_user_page(void *kto, const void *kfrom)
> > >  {
> > > -	asm("\
> > > -	stmfd	sp!, {r4, lr}			@ 2\n\
> > > +	register void *r0 asm("r0") = kto;
> > > +	register const void *r1 asm("r1") = kfrom;
> > > +
> > > +	asm(
> > > +	__asmeq("%0", "r0")
> > > +	__asmeq("%1", "r1")
> > > +	"\
> > > +	stmfd	sp!, {r4}			@ 2\n\
> > >  	mov	r2, %2				@ 1\n\
> > >  1:	ldmia	r1!, {r3, r4, ip, lr}		@ 4\n\
> > >  	stmia	r0, {r3, r4, ip, lr}		@ 4\n\
> > > @@ -34,9 +39,9 @@ fa_copy_user_page(void *kto, const void *kfrom)
> > >  	subs	r2, r2, #1			@ 1\n\
> > >  	bne	1b				@ 1\n\
> > >  	mcr	p15, 0, r2, c7, c10, 4		@ 1   drain WB\n\
> > > -	ldmfd	sp!, {r4, pc}			@ 3"
> > > +	ldmfd	sp!, {r4}			@ 3"
> > >  	:
> > > -	: "r" (kto), "r" (kfrom), "I" (PAGE_SIZE / 32));
> > > +	: "r" (r0), "r" (r1), "I" (PAGE_SIZE / 32));
> > 
> > This is still wrong as you list r0 and r1 in the input operand list 
> > where they must remain constant but the code does modify them. You 
> > should list them in the output operand list with the "&" attribute. Also 
> > r2 should be listed in the clobbered list.
> 
> Either we keep these as naked functions (and, if Clang wants to
> try to inline naked functions which makes no sense, also mark them
> as noinline) or we make them proper functions and also add (eg) r4
> to the clobber list and get rid of the stacking of that register
> along with LR/PC.

Yes, indeed.

I'd say: remove the naked stuff, and let the compiler do the 
prologue/epilogue itself (or inline it for that matter). And don't force 
pointers and counter into particular registers. This way r0-r3 could be 
used as temporaries since they're probably already clobbered by the call 
to kmap_atomic() anyway. That is likely to be better than forcing ip/lr 
as temporaryes.


Nicolas
