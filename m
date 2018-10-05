Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1338C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E0F2087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 10:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="OZGUoIDg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E0F2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbeJERrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 13:47:40 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:49878 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbeJERrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 13:47:40 -0400
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w95AnAd8015519;
        Fri, 5 Oct 2018 19:49:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w95AnAd8015519
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1538736551;
        bh=ezK4SHU5ec3fuzJgQK3+9lbjhWJ/Z71IxBOweH5jZ+k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OZGUoIDgs0j36ImcIcMDPGiWoVNS+JpTUOCBBlbaQ6kU6O5emBGZie+7Ds/ZhSg+K
         B7wVoEr5HXsrVCm94r0oToM5iILIKdkCy9kiV1GUtMPugdRYDQH/bHaojONf873L9E
         HI0fFnkWJWPj8qlVIkT1mod0KsmiYTo32ySHISVz/zBJmp5lKr4xZ+b57+Vr2TnTrK
         VZhy1KoXue9Rc7vLo7kJun/tEyeU1W1D1GqoZSSwpsDrS7KIAa3vUl7V3WT4Di9pMn
         yj/5aX/Jn+oVt5U6AkiPyFKVYtEh6qr4QO+zE0nVaJbma3D4P41L4stIxVVUaAnXqx
         vZxE2PQMc0VaQ==
X-Nifty-SrcIP: [209.85.222.42]
Received: by mail-ua1-f42.google.com with SMTP id r15-v6so4539959uao.1;
        Fri, 05 Oct 2018 03:49:11 -0700 (PDT)
X-Gm-Message-State: ABuFfojJm+tUo9GjGgF+VOpNJcilSXzkA+1ioWO83AXjnzswOvzxYsLJ
        kYxXVKEJESYW08E38ZAxiPE7isZxtF3NvhkKcpo=
X-Google-Smtp-Source: ACcGV60pQLR/7dW3bjNVV8ErkDQXJRW2dXzyh+NbuurKlZ/3NT77uKsmiO9j5qimZO38v/MUp5sIReIqcPDbaXqfEOk=
X-Received: by 2002:ab0:6607:: with SMTP id r7mr3481413uam.6.1538736550161;
 Fri, 05 Oct 2018 03:49:10 -0700 (PDT)
MIME-Version: 1.0
References: <20181004200249.GL5238@garbanzo.do-not-panic.com>
In-Reply-To: <20181004200249.GL5238@garbanzo.do-not-panic.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 5 Oct 2018 19:48:34 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT3NQnTtdxyz79jgoQHoUS0TxkP99yuoY-N5yALLnFO1A@mail.gmail.com>
Message-ID: <CAK7LNAT3NQnTtdxyz79jgoQHoUS0TxkP99yuoY-N5yALLnFO1A@mail.gmail.com>
Subject: Re: [ANN] init-kconfig - easy way to embrace Linux's kconfig
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>, Petr Vorel <pvorel@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Vegard Nossum <vegard.nossum@oracle.com>, nbd@nbd.name,
        kconfig-sat@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,



On Fri, Oct 5, 2018 at 5:03 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> Every now and then a project is born, and they decide to use Linux's
> kconfig to enable configuration of their project. As it stands we *know*
> kconfig is now used in at least over 12 different projects [0]. I myself
> added kconfig to one as well years ago. Even research reveals that
> kconfig has become one of the leading industrial variability modeling
> languages [1] [2].
>
> What is often difficult to do though is to start off using kconfig and
> integrating it into a project. Or updating / syncing to the latest
> kconfig from upstream Linux.
>
> I had yet another need to use kconfig for another small project so
> decided to make a clean template others can use and help keep it in sync.
> This is a passive fork which aims to keep in sync with the Linux
> kernel's latest kconfig to make it easier to keep up to date and to
> enable new projects to use and embrace kconfig on their own.  The goal
> is *not* to fork kconfig and evolve it separately, but rather keep in
> sync with the evolution of kconfig on Linux to make it easier for
> projects to use kconfig and also update their own kconfig when needed.


Syncing kconfig files is easy
since the files are collected in the single place, scripts/kconfig/.

It is true you need some efforts to introduce Kconfig in your project,
but once established, it is just a matter of copying files
under scripts/kconfig.

Copying stuff directly from Linux would be as easy as
doing so from your init-kconfig.




> This may also be useful if folks want to test R&D code on a smaller
> compartamentalized codebase.
>
> If you find this useful and you'd like to help keep it in sync, send
> patches my way as the kernel's kconfig evolves. The code is up on
> gitlab [3].
>
> Do we want to document this option on Linux in case folks want to try
> and embrace kconfig on their own for other projects?
>
> [0] http://www.eng.uwaterloo.ca/~shshe/kconfig_semantics.pdf
> [1] http://gsd.uwaterloo.ca/sites/default/files/vm-2013-berger.pdf
> [2] http://gsd.uwaterloo.ca/sites/default/files/ase241-berger_0.pdf
> [3] https://gitlab.com/mcgrof/init-kconfig
>
>   Luis


Looks like init-kconfig is trying to build some objects as demo.

obj-y = main.o
obj-$(CONFIG_FOO) += foo.o
obj-$(CONFIG_BAR) += bar.o
obj-$(CONFIG_BAZ) += baz.o
obj-$(CONFIG_ALPHA) += alpha/



FWIW, this is something I played with some time ago.

Kbuild Skeleton
https://github.com/masahir0y/kbuild_skeleton

It consists of some core Makefiles and Kconfig.


From the time-stamp, it is already 6 years too old.

I am not sure if it is useful for people,
if so, it is pretty easy to sync up with the latest Linux.



-- 
Best Regards
Masahiro Yamada
