Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA289C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F6420849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 13:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="KUzYHY86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F6420849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbeLKNAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 08:00:14 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:30117 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbeLKNAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 08:00:14 -0500
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wBBD02hW027415;
        Tue, 11 Dec 2018 22:00:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wBBD02hW027415
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1544533203;
        bh=twubWNm7C/dHzNFwoFHVCUMciZ0Sld3ahZ1E7w/D48Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KUzYHY86ID8JjhXQ6Ey2ZIpONlHlRutHRwgJBti2rHRSozoW00BY2kn/r/mT7SShH
         7Jv5WJ0xKj8X/b6FBGgDFybditq/MO64GzZrN1JxTLx0H770Pkej3N+p3QdFSGXjuK
         SCi7YaGh48TBDJW3rg35i3bgcX5/pDoZ1E5XtsqxwsyBf8S99plf7UvkYZY3Unnlw+
         oOjjl3ia1QXUTtIzZWEwZro3g0DfD7q6Bu9DGG3mfUB7FAkpNMgZeVKne/Za9HgpF2
         TsbM0OyPGU4Sz+VWbA20/BfC2HR3QYYplUqUP7qLvl+eT1Q6i1C7knx1daTUtSyE0y
         +0TubPkvbpJeg==
X-Nifty-SrcIP: [209.85.222.41]
Received: by mail-ua1-f41.google.com with SMTP id e16so5069081uam.12;
        Tue, 11 Dec 2018 05:00:03 -0800 (PST)
X-Gm-Message-State: AA+aEWb4jrFmOXNjnRt47e9bXBzoPyptyMPzwwm5UJbuPJWav1Vq2THG
        HD/iDXWYI9bRNq6Xt0LrIvLCq3wu/SbWc7cuz0s=
X-Google-Smtp-Source: AFSGD/VqzOYRbYT45HUtGTBbZIr4xjI6beS8S0eCVtRR639tWGfJa672xNME7Tgo1tY98gGLM+L1YJnc5uvfT2jUn3I=
X-Received: by 2002:ab0:6705:: with SMTP id q5mr7405382uam.89.1544533202351;
 Tue, 11 Dec 2018 05:00:02 -0800 (PST)
MIME-Version: 1.0
References: <1544009286-15705-1-git-send-email-yamada.masahiro@socionext.com>
 <1544009286-15705-2-git-send-email-yamada.masahiro@socionext.com> <20181206150325.GA2726@infradead.org>
In-Reply-To: <20181206150325.GA2726@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 11 Dec 2018 21:59:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS7hh4f8mYoZc7RUWStnchhftUN0nU5MJ_trjyNJx50Lw@mail.gmail.com>
Message-ID: <CAK7LNAS7hh4f8mYoZc7RUWStnchhftUN0nU5MJ_trjyNJx50Lw@mail.gmail.com>
Subject: Re: [PATCH 2/3] kbuild: generate asm-generic wrappers if mandatory
 headers are missing
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,


On Fri, Dec 7, 2018 at 12:04 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Dec 05, 2018 at 08:28:05PM +0900, Masahiro Yamada wrote:
> > Some time ago, Sam pointed out a certain degree of overwrap between
> > generic-y and mandatory-y. (https://lkml.org/lkml/2017/7/10/121)
> >
> > I a bit tweaked the meaning of mandatory-y; now it defines the minimum
> > set of ASM headers that all architectures must have.
> >
> > If arch does not have specific implementation of a mandatory header,
> > Kbuild will let it fallback to the asm-generic one by automatically
> > generating a wrapper. This will allow to drop lots of redundant
> > generic-y defines.
> >
> > Previously, "mandatory" was used in the context of UAPI, but I guess
> > this can be extended to kernel space ASM headers.
>
> How useful is it to keep the generic-y behavior around at all vs making
> everything useful mandatory?


What I can tell is not all architectures
support kvm_para.h, ucontext.h

I guess they will stay as arch-specific generic-y,
but I am not an expert in this area.


kvm_para.h is missing csky, nds32, riscv.

ucontext.h is missing in alpha, arm, m68k, parisc, sparc, xtensa



bpf_perf_event.h could be promoted to mandatory-y ?
All architectures have it.


-- 
Best Regards
Masahiro Yamada
