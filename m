Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC74C64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 05:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9632087D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 05:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cy6qTeZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F9632087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbeJFMzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 08:55:13 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:45978 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbeJFMzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 08:55:13 -0400
Received: by mail-oi1-f171.google.com with SMTP id e17-v6so12067793oig.12;
        Fri, 05 Oct 2018 22:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WCseJAA0rNXiW8azI+VZDlgB494Cr/VqyESt1C6Gm/Y=;
        b=cy6qTeZT5jz3P4d1Xfz9H8LmNjU7mn+nGRiPbTWcXZmxsBRPdVC3X80qZbalq1dYL4
         zTKb8ePP347RTXEgsrLYHLCcDGCCojqPasFKwnpr1t0jkXkVSVx/Y5bg2LLmSrkBYrgA
         zSAwJlqz2u2LceyydSci+YZvPFVf8ow4dv/E6RLmTP+HxIiVcNFYo+i6f5e6zhlUhiQ9
         E63kkP9URUjGk8Tv1F53MJibwspaLdWuL9nLbNbwGiIVE6FHui4H93nVoSsOX646mVmz
         z8Sh157iifNGhPo00o1e0MOt41+ZhrVA4SqmcLHp7uPZP7mmWE6HIU4F20YHWXU2FABm
         FEqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WCseJAA0rNXiW8azI+VZDlgB494Cr/VqyESt1C6Gm/Y=;
        b=Z3nZZWiVZrZne51988wp3zBy5TqGPgdySBsjVwxdtyX0qBiYg9F3DsZ8+69a350AjH
         4dGqyHj3RUdKthSElTzp35jLqmDlACdzZ1JFgxHN83JkJvCDJsfkvKUePg41dXDkadQN
         D2Rkh6HwbZbv/bMNIAsSkfwkBTneIJZu9nq0jDm+CsJ37KVwHJy0Gfwy1iIXREhzRJpE
         bXc8VvjxMSq8dp9yN7cKNFM+q2Or+9FYIR+PhKWGmt9kMrnqjGZOz83VNxNI6r2XBDzz
         XUXTmAbAnn78jnd9uzYBl5Ym4ofivIckfuVwH5vVYv5bwCms2tY0eLG4cbUhFH4z5riP
         5f6w==
X-Gm-Message-State: ABuFfoiXCYUpKGz0T2zYvcuFs4yr8m4n66fGE5KmAMRvqMO6Pf8ohv61
        36QgCf0eAPgOf8tt4WLwkCSqxe1DxgzmeeY158A=
X-Google-Smtp-Source: ACcGV63BqO8bAXf9k/cLvImmV37UUN8krx3pRiY34Xmxcnv2R70YjGeF6gi/kDlBm48J8r8rYFpKdTwzOUOiBzC9zHk=
X-Received: by 2002:a54:4f89:: with SMTP id g9-v6mr989325oiy.214.1538805193595;
 Fri, 05 Oct 2018 22:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20181004200249.GL5238@garbanzo.do-not-panic.com>
In-Reply-To: <20181004200249.GL5238@garbanzo.do-not-panic.com>
From:   Ulf Magnusson <ulfalizer@gmail.com>
Date:   Sat, 6 Oct 2018 07:53:02 +0200
Message-ID: <CAFkk2KQk8ZZhjo3aC1hi2Kph5okuS-UVApboajUXEcu0JFGPOg@mail.gmail.com>
Subject: Re: [ANN] init-kconfig - easy way to embrace Linux's kconfig
To:     "Luis R . Rodriguez" <mcgrof@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>, pvorel@suse.cz,
        rostedt@goodmis.org, johannes@sipsolutions.net,
        valentinrothberg@gmail.com, vegard.nossum@oracle.com, nbd@nbd.name,
        kconfig-sat@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 10:03 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
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
>
> This may also be useful if folks want to test R&D code on a smaller
> compartamentalized codebase.
>
> If you find this useful and you'd like to help keep it in sync, send
> patches my way as the kernel's kconfig evolves. The code is up on
> gitlab).) [3].
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

Shameless self-plug:

There's also a Python Kconfig implementation that's starting to get
picked up by several projects: https://github.com/ulfalizer/kconfiglib

It has a terminal menuconfig interface with a lot more features than
mconf (a demonstration is available at
https://raw.githubusercontent.com/ulfalizer/Kconfiglib/screenshots/screenshots/menuconfig.gif),
and can also be used e.g. to generate cross-referenced Kconfig
documentation that includes propagated dependencies:
https://docs.zephyrproject.org/latest/reference/kconfig/index.html
(note: heavy page).

Kconfiglib is based around a library (an old version appears in e.g.
U-Boot and Yocto, and a newer version in e.g. Espressif). The
documentation generation is just a script
(https://github.com/zephyrproject-rtos/zephyr/blob/master/doc/scripts/genrest.py),
and the same goes for the menuconfig and the other tools. The core
library takes part of all the trickiness related to evaluating
symbols.

I realize there would probably be massive opposition to adding a
Python dependency to a core part of the kernel, so I'm not going for
that. For most other projects, I think it's a good fit though.

Cheers,
Ulf
