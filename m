Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5CCC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 06:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29B32089F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 06:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F29B32089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeG1HvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 03:51:01 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:36075 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726000AbeG1HvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 03:51:01 -0400
X-IronPort-AV: E=Sophos;i="5.51,412,1526335200"; 
   d="scan'208";a="340565730"
Received: from abo-214-111-68.mrs.modulonet.fr (HELO [192.168.0.15]) ([85.68.111.214])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jul 2018 08:25:41 +0200
Date:   Sat, 28 Jul 2018 08:25:41 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     David Laight <David.Laight@ACULAB.COM>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] checkpatch: check for function calls with struct or
 union on stack
In-Reply-To: <1a75fda0861a0b2bce208fbf9b53785bf0e76fa2.camel@perches.com>
Message-ID: <alpine.DEB.2.20.1807280823200.2466@hadrien>
References: <1236369d28b2f1f5389ff652c4eb89e699e6481e.camel@perches.com>  <20180726122533.104f6eea950853ef50ebc680@linux-foundation.org>  <20180726122807.fad0566951e36d930edb6874@linux-foundation.org>  <9d7441a14897426f8ed5befe8da0cad3@AcuMS.aculab.com> 
 <0a6d2ecfacf3786228de664c8e01f6de10314c1b.camel@perches.com>  <9f0377fa74bd4964912ba5a4fc76526d@AcuMS.aculab.com> <1a75fda0861a0b2bce208fbf9b53785bf0e76fa2.camel@perches.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 27 Jul 2018, Joe Perches wrote:

> On Fri, 2018-07-27 at 10:21 +0000, David Laight wrote:
> > From: Joe Perches Sent: 27 July 2018 11:09
> > > On Fri, 2018-07-27 at 10:04 +0000, David Laight wrote:
> > > > From: Andrew Morton Sent: 26 July 2018 20:28
> > > > > On Thu, 26 Jul 2018 12:25:33 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> > > > >
> > > > > > I'll give it a spin, see how noisy it is.
> > > > >
> > > > > Actually, I would prefer if the message, changelog and title
> > > > > used the term "passed by value".  It's a more familiar term
> > > > > and it is possible for a passed-by-value aggregate to in fact
> > > > > be passed in registers.
> > > >
> > > > You need to detect (and ignore) 'small' structures.
> > >
> > > checkpatch is stupid and basically can't do that
> > > as it has no context other than the current line.
> > >
> > > It would need a list of specific struct types to
> > > ignore.  Care to create and send that list to me?
> >
> > Does it even have the type?
>
> Yes, kinda.  But only on the line being matched.
>
> i.e.: <const> [struct or union] [type] [name]
>
> > If it has the prototype it could ignore aggregates that
> > are marked 'const'.
>
> checkpatch has no visibility of any prototype.
>
> It might make sense for this sort of check to be
> added to coccinelle or maybe as a compiler warning
> when the struct is larger than some size.
>
> Original thread for Julia:
> https://lore.kernel.org/patchwork/patch/967890/

Coccinelle doesn't directly know the size of the structure, but it can
count the number of fields.  Maybe a case with an update in the function
body or at least 3 fields is worth reporting on?

julia
