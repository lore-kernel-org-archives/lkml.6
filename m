Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 414EBC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 05:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D059A208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 05:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D059A208D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755658AbeFOFHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 01:07:09 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:48910
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755641AbeFOFGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 01:06:23 -0400
X-IronPort-AV: E=Sophos;i="5.51,225,1526335200"; 
   d="scan'208";a="268855213"
Received: from abo-154-110-68.mrs.modulonet.fr (HELO [192.168.0.15]) ([85.68.110.154])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jun 2018 07:06:20 +0200
Date:   Fri, 15 Jun 2018 07:06:20 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Kees Cook <keescook@chromium.org>
cc:     Elena Reshetova <elena.reshetova@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>, cocci@systeme.lip6.fr,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <mmarek@suse.com>,
        Hans Liljestrand <ishkamiel@gmail.co>
Subject: Re: [PATCH] Coccinelle: add atomic_as_refcounter script
In-Reply-To: <CAGXu5jK-6fNvaEiX1Wvp98BKv+uF17KdFyPQKi5hgE-Jz3-+Tg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1806150705540.2565@hadrien>
References: <1504258820-2122-1-git-send-email-elena.reshetova@intel.com> <CAGXu5jK-6fNvaEiX1Wvp98BKv+uF17KdFyPQKi5hgE-Jz3-+Tg@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 14 Jun 2018, Kees Cook wrote:

> On Fri, Sep 1, 2017 at 2:40 AM, Elena Reshetova
> <elena.reshetova@intel.com> wrote:
> > atomic_as_refcounter.cocci script allows detecting
> > cases when refcount_t type and API should be used
> > instead of atomic_t.
> >
> > Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
> > Acked-by: Julia Lawall <julia.lawall@lip6.fr>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> Oops, I think this got lost. Who can take this patch? I thought Julia
> ran the scripts/coccinelle/ tree, but looking at git log, it looks
> more like it's Masahiro? Either way, let's get this in the tree. Who
> can take it?

Masahiro takes patches.

julia

>
> Thanks!
>
> -Kees
>
> > ---
> >  scripts/coccinelle/api/atomic_as_refcounter.cocci | 131 ++++++++++++++++++++++
> >  1 file changed, 131 insertions(+)
> >  create mode 100644 scripts/coccinelle/api/atomic_as_refcounter.cocci
> >
> > diff --git a/scripts/coccinelle/api/atomic_as_refcounter.cocci b/scripts/coccinelle/api/atomic_as_refcounter.cocci
> > new file mode 100644
> > index 0000000..bfa880d
> > --- /dev/null
> > +++ b/scripts/coccinelle/api/atomic_as_refcounter.cocci
> > @@ -0,0 +1,131 @@
> > +// Check if refcount_t type and API should be used
> > +// instead of atomic_t type when dealing with refcounters
> > +//
> > +// Copyright (c) 2016-2017, Elena Reshetova, Intel Corporation
> > +//
> > +// Confidence: Moderate
> > +// URL: http://coccinelle.lip6.fr/
> > +// Options: --include-headers --very-quiet
> > +
> > +virtual report
> > +
> > +@r1 exists@
> > +identifier a, x;
> > +position p1, p2;
> > +identifier fname =~ ".*free.*";
> > +identifier fname2 =~ ".*destroy.*";
> > +identifier fname3 =~ ".*del.*";
> > +identifier fname4 =~ ".*queue_work.*";
> > +identifier fname5 =~ ".*schedule_work.*";
> > +identifier fname6 =~ ".*call_rcu.*";
> > +
> > +@@
> > +
> > +(
> > + atomic_dec_and_test@p1(&(a)->x)
> > +|
> > + atomic_dec_and_lock@p1(&(a)->x, ...)
> > +|
> > + atomic_long_dec_and_lock@p1(&(a)->x, ...)
> > +|
> > + atomic_long_dec_and_test@p1(&(a)->x)
> > +|
> > + atomic64_dec_and_test@p1(&(a)->x)
> > +|
> > + local_dec_and_test@p1(&(a)->x)
> > +)
> > +...
> > +(
> > + fname@p2(a, ...);
> > +|
> > + fname2@p2(...);
> > +|
> > + fname3@p2(...);
> > +|
> > + fname4@p2(...);
> > +|
> > + fname5@p2(...);
> > +|
> > + fname6@p2(...);
> > +)
> > +
> > +
> > +@script:python depends on report@
> > +p1 << r1.p1;
> > +p2 << r1.p2;
> > +@@
> > +msg = "atomic_dec_and_test variation before object free at line %s."
> > +coccilib.report.print_report(p1[0], msg % (p2[0].line))
> > +
> > +@r4 exists@
> > +identifier a, x, y;
> > +position p1, p2;
> > +identifier fname =~ ".*free.*";
> > +
> > +@@
> > +
> > +(
> > + atomic_dec_and_test@p1(&(a)->x)
> > +|
> > + atomic_dec_and_lock@p1(&(a)->x, ...)
> > +|
> > + atomic_long_dec_and_lock@p1(&(a)->x, ...)
> > +|
> > + atomic_long_dec_and_test@p1(&(a)->x)
> > +|
> > + atomic64_dec_and_test@p1(&(a)->x)
> > +|
> > + local_dec_and_test@p1(&(a)->x)
> > +)
> > +...
> > +y=a
> > +...
> > +fname@p2(y, ...);
> > +
> > +
> > +@script:python depends on report@
> > +p1 << r4.p1;
> > +p2 << r4.p2;
> > +@@
> > +msg = "atomic_dec_and_test variation before object free at line %s."
> > +coccilib.report.print_report(p1[0], msg % (p2[0].line))
> > +
> > +@r2 exists@
> > +identifier a, x;
> > +position p1;
> > +@@
> > +
> > +(
> > +atomic_add_unless(&(a)->x,-1,1)@p1
> > +|
> > +atomic_long_add_unless(&(a)->x,-1,1)@p1
> > +|
> > +atomic64_add_unless(&(a)->x,-1,1)@p1
> > +)
> > +
> > +@script:python depends on report@
> > +p1 << r2.p1;
> > +@@
> > +msg = "atomic_add_unless"
> > +coccilib.report.print_report(p1[0], msg)
> > +
> > +@r3 exists@
> > +identifier x;
> > +position p1;
> > +@@
> > +
> > +(
> > +x = atomic_add_return@p1(-1, ...);
> > +|
> > +x = atomic_long_add_return@p1(-1, ...);
> > +|
> > +x = atomic64_add_return@p1(-1, ...);
> > +)
> > +
> > +@script:python depends on report@
> > +p1 << r3.p1;
> > +@@
> > +msg = "x = atomic_add_return(-1, ...)"
> > +coccilib.report.print_report(p1[0], msg)
> > +
> > +
> > --
> > 2.7.4
> >
>
>
>
> --
> Kees Cook
> Pixel Security
>
