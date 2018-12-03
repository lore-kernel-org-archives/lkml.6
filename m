Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494ADC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E83120851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OevCFM8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E83120851
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbeLCXWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:22:46 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38847 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLCXWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:22:46 -0500
Received: by mail-oi1-f194.google.com with SMTP id a77so12594445oii.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 15:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cYCFcJ1UdDdLdTFH8pPRXacbQNJ1dh92bXLqX6q3pYk=;
        b=OevCFM8JY8gCnIyRJRNgg8mr7ASkqBVQ3bsPKtDpmve/0pVcAYergzBjl2Zx3GPEWO
         M5PEbu7wdzTPS3ZU0+8pZCGR95r3VCN7mI4WPbkYbBNdaV3jRVOCc8Ll7G3c3fhhUXda
         pUSbCJY2GXRaB3ryUyb6AuXTLAKUjsiaw51W/Q5HptR9P17ZP63WTLA+fbVK+nujVurN
         KVaS3GrsrmyKHT+ZAQg+gB6+s7XW3+MMnhtU4opSvHfkn8U7dOnJo9ViLpmL7VrQGkHv
         v67aj/Epz4Txzss+xyevySbDYkH+njx74aq4oUjGk6bVlj7QPcExSje//DAZUlQ3Yrej
         Uw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cYCFcJ1UdDdLdTFH8pPRXacbQNJ1dh92bXLqX6q3pYk=;
        b=abtmCQaM8q5q/Yy2/2d9HBspSIpJnK3Q8RYBlkPtwZxNjjVthEFU9wS1w8EzEAVvD8
         koqc4SjLaFBfC/lShFO3eanlYXx4I4ukm/4wLajhtIavKd1sHpF7h0jkKSXeH7PJs9bY
         oqd0pXWE2kdKhHBwHDsp24bmFXbkkAENRs6m2y+ydRNwXx945jrnFv4Hb6Eaqot+pnhB
         Pxy1++C5Oj21nPvy8mI2NQR6b9G3tHgQY0AyDlhXTddSPtD9uTbtqY1+bLTGs8BgXHL2
         lcTF4yihUOqoqgqK6AaGksq66ktJmDrSj7USXNseSOpe07+mYoozRaXumnpOJqMs48VK
         nchg==
X-Gm-Message-State: AA+aEWZp6ddsc/diSFg2edWRrTIDqa1/bgbUEZDonoMDwzRnKhVkci9g
        JBO35zNL2ZFs+GlvGU3QN61kBcsIRiwZXnao16VGZQ==
X-Google-Smtp-Source: AFSGD/Vcut7LP5rRRau7La1WiN2r6QBxUFrAW8XpW7YN/1b90lz9976AReAP7gI1smwgC/lWRW2eakQYEF0bC5gASN4=
X-Received: by 2002:aca:be41:: with SMTP id o62mr10616674oif.206.1543879363718;
 Mon, 03 Dec 2018 15:22:43 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-7-brendanhiggins@google.com> <CAL_JsqJLNSg-38hej8LV+Oh-YXBM2hRGomie3b_psa9LvzoRYg@mail.gmail.com>
 <20181130033704.GL18410@garbanzo.do-not-panic.com> <CAL_Jsq+jxHHmT5bLnABnF7S0fSBZvH72nDPyY5LHTn9Zm9hCUw@mail.gmail.com>
 <20181130182203.GS18410@garbanzo.do-not-panic.com>
In-Reply-To: <20181130182203.GS18410@garbanzo.do-not-panic.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 3 Dec 2018 15:22:32 -0800
Message-ID: <CAFd5g47ndhD+j6-_tTV-9N8eY0_48kEvEO76BzOWi-BD3GYauw@mail.gmail.com>
Subject: Re: [RFC v3 06/19] arch: um: enable running kunit from User Mode Linux
To:     mcgrof@kernel.org
Cc:     Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com, rostedt@goodmis.org,
        Tim.Bird@sony.com, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, dan.j.williams@intel.com,
        linux-nvdimm@lists.01.org, kieran.bingham@ideasonboard.com,
        Frank Rowand <frowand.list@gmail.com>,
        Knut Omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 10:22 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Fri, Nov 30, 2018 at 08:05:34AM -0600, Rob Herring wrote:
> > On Thu, Nov 29, 2018 at 9:37 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > On Wed, Nov 28, 2018 at 03:26:03PM -0600, Rob Herring wrote:
> > > > On Wed, Nov 28, 2018 at 1:37 PM Brendan Higgins
> > > > <brendanhiggins@google.com> wrote:
> > > > >
> > > > > Make minimum number of changes outside of the KUnit directories for
> > > > > KUnit to build and run using UML.
> > > >
> > > > There's nothing in this patch limiting this to UML.
> > >
> > > Not that one, but the abort thing segv thing is, eventually.
> > > To support other architectures we'd need to make a wrapper to that
> > > hack which Brendan added, and then allow each os to implement
> > > its own call, and add an asm-generic helper.

I think Rob is referring to the description for this patch. This patch
previously did what you suggested, Luis, (source the KUnit kconfig
from arch/um/) but Kees asked me to change it to how it is now (which
probably makes sense if we are saying KUnit is not intended to be tied
to a particular architecture, no?), and I forgot to update the commit
description, sorry.

> >
> > I've not looked into why this is needed, but can't you make the abort
> > support optional and arches can select it when they support it.
>
> Its why I have asked for it to be properly documented. The patches in no
> way illustrate *why* such thing is done. And if we are going to
> potentially have other archs do something similar best to make it
> explicit.

Yeah, I should better document it. I should also probably not include
any UML specific header files in kunit/test.h; that seems like I am
asking to get more tightly coupled if I am not careful about exactly
what things I depend on.

I think Luis is right, I need to add a wrapper around the features
needed for the hack to support abort() and then write a UML specific
implementation.

For the asm-generic case, we could probably just have abort() call
BUG(), with that KUnit should work on most architectures, albeit with
pretty reduced functionality.

>
> > At
> > least before, the DT unittests didn't need this to run and shouldn't
> > depend on it after converting to kunit.

Fair enough.
