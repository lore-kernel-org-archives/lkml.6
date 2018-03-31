Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753272AbeCaGRj (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 02:17:39 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:54184
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753146AbeCaGRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 02:17:37 -0400
X-IronPort-AV: E=Sophos;i="5.48,383,1517871600";
   d="scan'208";a="260468728"
Date: Sat, 31 Mar 2018 08:17:34 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Joe Perches <joe@perches.com>
cc: Varsha Rao <rvarsha016@gmail.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, cocci <cocci@systeme.lip6.fr>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [Cocci] [PATCH] crypto: cavium: zip: Remove unnecessary
 parentheses
In-Reply-To: <1522441039.2210.50.camel@perches.com>
Message-ID: <alpine.DEB.2.20.1803310816360.2373@hadrien>
References: <20180328175736.17360-1-rvarsha016@gmail.com> <1522260676.12357.121.camel@perches.com> <CAAFX7JTfWdaGra+kWBJt-GXVVO601K03qWnExFKFD_9vxS-03g@mail.gmail.com> <1522441039.2210.50.camel@perches.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Mar 2018, Joe Perches wrote:

> On Thu, 2018-03-29 at 21:03 +0530, Varsha Rao wrote:
> > On Wed, Mar 28, 2018 at 11:41 PM, Joe Perches wrote:
> > >
> > > On Wed, 2018-03-28 at 23:27, Varsha Rao wrote:
> > > > This patch fixes the clang warning of extraneous parentheses, with the
> > > > following coccinelle script.
> > > >
> > > > @@
> > > > identifier i;
> > > > constant c;
> > > > @@
> > > > (
> > > > -((i == c))
> > > > +i == c
> > > > >
> > > >
> > > > -((i <= c))
> > > > +i <= c
> > >
> > > Why just the "==" and "<=" cases?
> > > Why not "<", ">" and ">=" too?
> > >
> > > Why not expression instead of constant?
> >
> > Initially I had the other cases too and used expression instead of
> > constant. But the results included only "==" and "<=" cases with
> > constant. Along with one false positive case.
> hmm
> Perhaps you should use something like this?
> @@
> identifier i;
> constant c;
> @@
>
> -(
> \(i == c\|i <= c\|i < c\|i >= c\|i > c\)
> -)

This is not safe with respect to !.  The following seems to address this
problem:

@@
identifier i;
constant c;
expression e;
@@

(
!(e)
|
-(
\(i == c\|i <= c\|i < c\|i >= c\|i > c\)
-)
)

julia
