Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC46C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967FC206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXsfRNHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 967FC206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbeLDNlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 08:41:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:45432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbeLDNlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 08:41:11 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83F1621527;
        Tue,  4 Dec 2018 13:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543930870;
        bh=ZF1zX9Nn+YEZ9DPmmkONF3lFXF8mR+mJDtQBjSXTaMY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KXsfRNHp60vOts38AgaENQ8Pd9aYNoHh+g/4gXpNSIXTgq/++5m12bMW5UfIRRG2t
         T/1rC+26H13AvG5zlkzqOLtgftlMrlIExWqvrr3cqsEW7xYCwK1xJ6E05UmioL4Lhm
         D/C10UadF4GMCKyRts93a0abPZf2nILl6bah7BX0=
Received: by mail-qt1-f174.google.com with SMTP id z16so18011306qtq.4;
        Tue, 04 Dec 2018 05:41:10 -0800 (PST)
X-Gm-Message-State: AA+aEWZRDkhpOO18cAC7ebAXeB30BQTDV6D5x3XAmLcrj1v8nKu8L6Bp
        ZTkx6zadhRMCguw0v8aSrKSiHE9olez282H4vw==
X-Google-Smtp-Source: AFSGD/XCEgRjhb8+2LWYHtGtuf3v/mMGB3e3QEVrbGarafA8XtKPNuzdHm109fPTRclXoOdzNpxSQR1B1p7g+YiFdw8=
X-Received: by 2002:ac8:1712:: with SMTP id w18mr18361451qtj.76.1543930869590;
 Tue, 04 Dec 2018 05:41:09 -0800 (PST)
MIME-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
 <20181128193636.254378-18-brendanhiggins@google.com> <CAL_Jsq+09Kx7yMBC_Jw45QGmk6U_fp4N6HOZDwYrM4tWw+_dOA@mail.gmail.com>
 <18814973-8f0a-4647-a097-fcc3dc0b3cd3@infradead.org> <CAFd5g475RK9v9X4qxmXwuHiPMOs05WrZAw6EJWNdVoAHQWguFQ@mail.gmail.com>
In-Reply-To: <CAFd5g475RK9v9X4qxmXwuHiPMOs05WrZAw6EJWNdVoAHQWguFQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 4 Dec 2018 07:40:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL_PivQbrJFEusdKAy-2EQtKL3OHbmyYSK9bzuTOQegqA@mail.gmail.com>
Message-ID: <CAL_JsqL_PivQbrJFEusdKAy-2EQtKL3OHbmyYSK9bzuTOQegqA@mail.gmail.com>
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

On Mon, Dec 3, 2018 at 6:14 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Thu, Nov 29, 2018 at 4:40 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > On 11/28/18 12:56 PM, Rob Herring wrote:
> > >> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> > >> index ad3fcad4d75b8..f309399deac20 100644
> > >> --- a/drivers/of/Kconfig
> > >> +++ b/drivers/of/Kconfig
> > >> @@ -15,6 +15,7 @@ if OF
> > >>  config OF_UNITTEST
> > >>         bool "Device Tree runtime unit tests"
> > >>         depends on !SPARC
> > >> +       depends on KUNIT
> > > Unless KUNIT has depends, better to be a select here.
> >
> > That's just style or taste.  I would prefer to use depends
> > instead of select, but that's also just my preference.
>
> I prefer depends too, but Rob is the maintainer here.

Well, we should be consistent, not the follow the whims of each maintainer.

Rob
