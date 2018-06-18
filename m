Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B466EC5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E35B2075A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E35B2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935546AbeFRU2H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:28:07 -0400
Received: from s3.sipsolutions.net ([144.76.63.242]:57924 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754801AbeFRU2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:28:06 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.91)
        (envelope-from <johannes@sipsolutions.net>)
        id 1fV0ku-00032F-Mx; Mon, 18 Jun 2018 22:28:04 +0200
Message-ID: <1529353683.3092.32.camel@sipsolutions.net>
Subject: Re: [PATCH v3] bitfield: fix *_encode_bits()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon, 18 Jun 2018 22:28:03 +0200
In-Reply-To: <CAHp75VdY+PF0Edm_py+UiD3nz77HTQps_8uaRh+Sa3C+UKECKA@mail.gmail.com> (sfid-20180618_222109_796813_69F8BCFA)
References: <20180618195618.17536-1-johannes@sipsolutions.net>
         <CAHp75VdY+PF0Edm_py+UiD3nz77HTQps_8uaRh+Sa3C+UKECKA@mail.gmail.com>
         (sfid-20180618_222109_796813_69F8BCFA)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> I think would be better to add test cases first, followed by fix. (1
> patch -> 2 patches)
> In this case Fixes tag would be only for the fix part and backporting
> (if needed) will be much easier.

Can't, unless I introduce a compilation issue in the tests first? That
seems weird. But I guess I can do it the other way around.

> > @@ -143,6 +143,7 @@ static __always_inline base type##_get_bits(__##type v, base field) \
> >         ____MAKE_OP(le##size,u##size,cpu_to_le##size,le##size##_to_cpu) \
> >         ____MAKE_OP(be##size,u##size,cpu_to_be##size,be##size##_to_cpu) \
> >         ____MAKE_OP(u##size,u##size,,)
> > +____MAKE_OP(u8,u8,,)
> 
> Is this one you need, or it's just for sake of tests?

All three ;-)

We'll probably need it eventually (we do have bytes to take bits out
of), for consistency I think we want it, and I wanted to add it to the
tests too.

> For me looks like for consistency we may add fake conversion macros
> for this, such as
> 
> #define cpu_to_le8(x) x
> #define le8_to_cpu(x) x
> ...
> #undef le8_to_cpu
> #undef cpu_to_le8
> 
> And do in the same way like below
> 
> __MAKE_OP(8)

I disagree with this. I don't see why we should have le8_encode_bits()
and be8_encode_bits() and friends, that makes no sense.

> Perhaps
> // SPDX... GPL-2.0+

Yeah, I guess I should have that.

> > +/*
> > + * Test cases for bitfield helpers.
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > +
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> 
> Either module.h (if we can compile as a module) or just init.h otherwise.

It can be a module ... guess I cargo-culted that from another test.

> > +/*
> > + * This should fail compilation:
> > + *     CHECK_ENC_GET(16, 16, 0x0f00, 0x1000);
> > + */
> 
> Perhaps we need some ifdeffery around this. It would allow you to try
> w/o altering the source code.
> 
> #ifdef TEST_BITFIELD_COMPILE
> ...
> #endif

Yeah, I guess we could do that.

> I guess you rather continue and print a statistics X passed out of Y.
> Check how it's done, for example, in other test_* modules.
> (test_printf.c comes first to my mind).

I see it's done that way elsewhere, but I don't really see the point. It
makes the test code more complex, and if you fail here you'd better fix
it, and if you need a few iterations for that it's not really a problem?

johannes
