Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B86C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 00:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D517E20989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 00:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544143321;
	bh=vqp8LjO/eMXwBlhMDX3QdEwSenFyWd4X75HHYRPAels=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Esl1IwdjGrmEEcWCUVBNSWfl0SiQJnoxaC9bag0TMtYa7aaVlPwpQtDZZaOyz4rGj
	 kOHkU4RarigYlxAx0s2I13MuGPp6mBTnIPz6FipOGuXgxaVoj7Bp5TFV+D6NwC9f2Z
	 xEGmMNM53Qccz50JBX/uOR24pA0lmMTL/ho8XUN4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D517E20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbeLGAmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 19:42:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:54622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbeLGAl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 19:41:59 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FAED2146D;
        Fri,  7 Dec 2018 00:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544143318;
        bh=vqp8LjO/eMXwBlhMDX3QdEwSenFyWd4X75HHYRPAels=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LMIdoN64gZ3+E4s9S6nSnbOT3yGBylkLJ6fLubvRXjc1u5igW4FxS4Lu5IfsUzQGn
         Pp37FjBBWAkqcgQUdF/FY1USQX6OTsw6Q99p2UX7yQCDxU3G+drWYW4CR3Fvpkz5wU
         JByKJMPgQX9IA7O4ODVfKs3qF5u6NWdFNQT5afSM=
Received: by mail-qk1-f178.google.com with SMTP id n12so1507351qkh.11;
        Thu, 06 Dec 2018 16:41:58 -0800 (PST)
X-Gm-Message-State: AA+aEWaXfkz+Z6hvubPUi0V3Shtt9MizuqW/fN9FMpTtp69z7xwiw4q9
        iGbQM7EsbUu+tOEtBgntumfDJpgioQldTYyoTw==
X-Google-Smtp-Source: AFSGD/V5c0Rcj8uh4ezUc6Ji6kbJVtMeogNVfn9uDAETaZ+bmWVWfNjwQMLiTaaKFzCYvamqdvTH1D6+zQjV8NUDFlU=
X-Received: by 2002:a37:7682:: with SMTP id r124mr92987qkc.79.1544143317614;
 Thu, 06 Dec 2018 16:41:57 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-18-brendanhiggins@google.com> <CAL_Jsq+09Kx7yMBC_Jw45QGmk6U_fp4N6HOZDwYrM4tWw+_dOA@mail.gmail.com>
 <18814973-8f0a-4647-a097-fcc3dc0b3cd3@infradead.org> <CAFd5g475RK9v9X4qxmXwuHiPMOs05WrZAw6EJWNdVoAHQWguFQ@mail.gmail.com>
 <CAL_JsqL_PivQbrJFEusdKAy-2EQtKL3OHbmyYSK9bzuTOQegqA@mail.gmail.com> <CAFd5g45-HGytAPTx7OQD8B0oAdLncDGSMMTyHCTtyobeUJ15AQ@mail.gmail.com>
In-Reply-To: <CAFd5g45-HGytAPTx7OQD8B0oAdLncDGSMMTyHCTtyobeUJ15AQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 6 Dec 2018 18:41:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKvsCNk5oz-f9-G2TsKbfvO=9HO+-+QfOMz_xEAN8TJJg@mail.gmail.com>
Message-ID: <CAL_JsqKvsCNk5oz-f9-G2TsKbfvO=9HO+-+QfOMz_xEAN8TJJg@mail.gmail.com>
Subject: Re: [RFC v3 17/19] of: unittest: migrate tests to run on KUnit
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, shuah@kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Frank Rowand <frowand.list@gmail.com>, knut.omang@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 5:43 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Tue, Dec 4, 2018 at 5:41 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Dec 3, 2018 at 6:14 PM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> > >
> > > On Thu, Nov 29, 2018 at 4:40 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> > > >
> > > > On 11/28/18 12:56 PM, Rob Herring wrote:
> > > > >> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> > > > >> index ad3fcad4d75b8..f309399deac20 100644
> > > > >> --- a/drivers/of/Kconfig
> > > > >> +++ b/drivers/of/Kconfig
> > > > >> @@ -15,6 +15,7 @@ if OF
> > > > >>  config OF_UNITTEST
> > > > >>         bool "Device Tree runtime unit tests"
> > > > >>         depends on !SPARC
> > > > >> +       depends on KUNIT
> > > > > Unless KUNIT has depends, better to be a select here.
> > > >
> > > > That's just style or taste.  I would prefer to use depends
> > > > instead of select, but that's also just my preference.
> > >
> > > I prefer depends too, but Rob is the maintainer here.
> >
> > Well, we should be consistent, not the follow the whims of each maintainer.
>
> Sorry, I don't think that came out the way I meant it. I don't really
> think we are consistent on this point across the kernel, and I don't
> feel very strongly about the point, so I was just looking to follow
> the path of least resistance. (I also just assumed Rob would keep us
> consistent within drivers/of/.)

I meant across unittests, we should be consistent. All unittests do
either "depends on KUNIT" or "select KUNIT". The question I would ask
is does KUNIT need to be user visible or is useful to enable without
any unittests enabled? With depends, a user has 2 options to go enable
vs. 1 with select.

But if you want a global kill switch to turn off all unittests, then
depends works better.

> I figure if we are running unit tests from the test runner script or
> from an automated system, you won't be hunting for dependencies for a
> single test every time you want to run a test, so select doesn't make
> it easier to configure in most imagined use cases.
>
> KUNIT hypothetically should not depend on anything, so select should
> be safe to use.
>
> On the other hand, if we end up being wrong on this point and KUnit
> gains widespread adoption, I would prefer not to be in a position
> where I have to change a bunch of configs all over the kernel because
> this example got copied and pasted.

You'll be so happy that 100s of tests have been created using kunit,
it won't be a big deal. :)

In any case, I wouldn't spend more time on this.

Rob
