Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EDBBC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A8D2082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 07:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A8D2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeLEHko convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 02:40:44 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34574 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbeLEHko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 02:40:44 -0500
Received: by mail-ot1-f66.google.com with SMTP id t5so17826241otk.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 23:40:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JNQhOhszSHcggNaD1SBayBjLbXetxd8vVoIXLJFOLls=;
        b=aaj76gWvFRqeF5yop0sJq8odqk2CVaUSPOkg1JhJTP0W9rRQrH5+xjUPMnvJ1l4bPe
         b9PVlAmKwGVkVGBD98kUUz/8Iajzg2QjiWAz/ATObkDIu5eV83tGCGIoFkANgyCQuKd8
         3us1xBRgXfpWghmiHRIVgkjQ+j/5yTQdcuaiob6g0dzM0Z42Y1gAdyt3W4CUScCxcCQu
         sPJiVVxEYBqpRstZiKhmf/kWKBhJrbjzyT73laNBWOSQA2ZuYUGBkpJ5VIGOYJCdLhMN
         e/oKyJzNfuohCGOx5TYKoIZJyxgrG6IlzDpBy1EDXM5mLG1B9J3WDe/qjPWUyVtghpNY
         MQTA==
X-Gm-Message-State: AA+aEWaB4v6tlgjgAJqJXS2b57mufGL9jXjJZ8eBwkJyZzLum4cS2qwH
        5U4zntocrwW/geuHwXdp0n3Blkhb4A5JZ3gu7rn6dg==
X-Google-Smtp-Source: AFSGD/UrN4JljRWTRvMnVubzH//Z4S09NkST192w6Ii7WNXmmFTNNpclxl8mDG/jGvBm7M+5sx76yyp2nKe6X0pHP6Y=
X-Received: by 2002:a05:6830:1289:: with SMTP id z9mr13755442otp.281.1543995643229;
 Tue, 04 Dec 2018 23:40:43 -0800 (PST)
MIME-Version: 1.0
References: <20181204205345.9514-1-malat@debian.org> <ba978bc1-e137-8abf-01a0-e1c68341a95f@c-s.fr>
In-Reply-To: <ba978bc1-e137-8abf-01a0-e1c68341a95f@c-s.fr>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Wed, 5 Dec 2018 08:40:31 +0100
Message-ID: <CA+7wUswgOLp8z6-VOf86=dSf1PCOT4CW4RpMOC-J_p2xBiZkwA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/32: Move the old 6xx -mcpu logic before the
 TARGET_CPU logic
To:     Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 10:28 PM Christophe LEROY
<christophe.leroy@c-s.fr> wrote:
>
>
>
> Le 04/12/2018 à 21:53, Mathieu Malaterre a écrit :
> > The code:
> >
> >    ifdef CONFIG_6xx
> >    KBUILD_CFLAGS          += -mcpu=powerpc
> >    endif
> >
> > was added in 2006 in commit f48b8296b315 ("[PATCH] powerpc32: Set cpu
> > explicitly in kernel compiles"). This change was acceptable since the
> > TARGET_CPU logic was 64-bit only.
> >
> > Since commit 0e00a8c9fd92 ("powerpc: Allow CPU selection
> > also on PPC32") this logic is no longer acceptable after the TARGET_CPU
> > specific. It currently appends -mcpu=powerpc at the end of the command
> > line, after any TARGET_CPU specific:
> >
> >    gcc -Wp,-MD,init/.do_mounts.o.d ...
> >      -mcpu=powerpc -mbig-endian -m32 ...
> >      -mcpu=e300c2 ...
> >      -mcpu=powerpc ...
> >      ../init/do_mounts.c
> >
> > Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> > Fixes: 0e00a8c9fd92 ("powerpc: Allow CPU selection also on PPC32")
> > Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> > Link: https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg142315.html
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
> > ---
> >   arch/powerpc/Makefile | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> > index 8a2ce14d68d0..544b30667ea5 100644
> > --- a/arch/powerpc/Makefile
> > +++ b/arch/powerpc/Makefile
> > @@ -30,6 +30,10 @@ endif
> >   endif
> >   endif
> >
> > +ifdef CONFIG_6xx
> > +KBUILD_CFLAGS                += -mcpu=powerpc
> > +endif
> > +
>
> Could you make the patch on top of my serie (ie after the change of
> CONFIG_6xx to CONFIG_BOOK3S_32 ?

Sure. That will defeat the point of the Fixes: line, but I guess who
cares anyway ? Will re-submit asap.

> The serie is in origin/next-test
>
> Thanks,
> Christophe
>
> >   ifeq ($(CROSS_COMPILE),)
> >   KBUILD_DEFCONFIG := $(shell uname -m)_defconfig
> >   else
> > @@ -241,10 +245,6 @@ KBUILD_CFLAGS    += $(call cc-option,-fno-dwarf2-cfi-asm)
> >   # often slow when they are implemented at all
> >   KBUILD_CFLAGS               += $(call cc-option,-mno-string)
> >
> > -ifdef CONFIG_6xx
> > -KBUILD_CFLAGS                += -mcpu=powerpc
> > -endif
> > -
> >   cpu-as-$(CONFIG_4xx)                += -Wa,-m405
> >   cpu-as-$(CONFIG_ALTIVEC)    += $(call as-option,-Wa$(comma)-maltivec)
> >   cpu-as-$(CONFIG_E200)               += -Wa,-me200
> >
