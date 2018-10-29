Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B20C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16FDF2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="KY5uO941"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16FDF2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbeJ2VyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:54:12 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:29707 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbeJ2VyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:54:12 -0400
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w9TD5NPB022483;
        Mon, 29 Oct 2018 22:05:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w9TD5NPB022483
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1540818324;
        bh=kKpdR2Hgs/GOA4qCj3s5kDt9nlDjdbqY5Kbbiemz17Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KY5uO941Ag9bo1Ymktm3Q3xP1gn6DKfH9imEzQIw+wjNwvbaG0e8lTzvHEy4puU9U
         htEZQ81h21ZzPEAjkXSsSEt4fMdGGsY/Sfmzs3PkZOC8icvz+cAQ8YBkJ+0rPjdpCb
         nd3AjOX+7+TTfF/3wiH2YsPmmy6ktm/fRFnylwjU9IBUDS8/Msi/w94+Yl9y4qWmcW
         +tglR0gDef9/U1P3Tg8I3rH2s99rg5UHnhdNLBHXGvsxjPLxN15CdiHff5OhpjEIJ1
         osL9m2djteqmiSaSQ2jHoMf7LqqEtpt+PeI4XFvE0CXebqd+G/OZ7qwdmEHiVRTGFc
         eXhBqbHEkys6w==
X-Nifty-SrcIP: [209.85.217.47]
Received: by mail-vs1-f47.google.com with SMTP id h78so4090745vsi.6;
        Mon, 29 Oct 2018 06:05:23 -0700 (PDT)
X-Gm-Message-State: AGRZ1gL3btAP6dVyL9At2KHmgP/tXky7k8+zIuqu1UpmNz1hogUhP3yC
        hbtRh8KaOAhYnlv4/KNRbIrT8twvwFP8/qLDCf0=
X-Google-Smtp-Source: AJdET5fkZARwZD3QH9BA7w+T0/RypOJIDqidrBsF6PSsFSy7IxTaDEv7ukX21SVT57cKKD9pkYF7VMIuucRImdHLV2g=
X-Received: by 2002:a67:a858:: with SMTP id r85mr5827741vse.215.1540818322492;
 Mon, 29 Oct 2018 06:05:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181028130945.23581-1-changbin.du@gmail.com> <20181028130945.23581-2-changbin.du@gmail.com>
 <20181028140911.21d49629@vmware.local.home>
In-Reply-To: <20181028140911.21d49629@vmware.local.home>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 29 Oct 2018 22:04:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNATixykqHqdu5W3NpfXqBXMNsP0OLKjNdsFc_EzJ_diOxA@mail.gmail.com>
Message-ID: <CAK7LNATixykqHqdu5W3NpfXqBXMNsP0OLKjNdsFc_EzJ_diOxA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] x86/mm: declare check_la57_support() as inline
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        X86 ML <x86@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sparse@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 3:09 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sun, 28 Oct 2018 13:09:42 +0000
> Changbin Du <changbin.du@gmail.com> wrote:
>
> > The level4_kernel_pgt is only defined when X86_5LEVEL is enabled.
> > So declare check_la57_support() as inline to make sure the code
> > referring to level4_kernel_pgt is optimized out. This is a preparation
> > for CONFIG_CC_OPTIMIZE_FOR_DEBUGGING.
> >
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
>
> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>
> -- Steve
>


Applied to linux-kbuild.


-- 
Best Regards
Masahiro Yamada
