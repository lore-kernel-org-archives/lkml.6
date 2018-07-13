Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE27ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FEA820842
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FEA820842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeGMJ6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 05:58:03 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:44773
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726467AbeGMJ6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 05:58:03 -0400
X-IronPort-AV: E=Sophos;i="5.51,347,1526335200"; 
   d="scan'208";a="272902254"
Received: from unknown (HELO hadrien.local) ([38.97.127.241])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jul 2018 11:44:08 +0200
Date:   Fri, 13 Jul 2018 05:44:06 -0400 (EDT)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Himanshu Jha <himanshujha199640@gmail.com>
cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org,
        =?ISO-8859-15?Q?Ville_Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
        yamada.masahiro@socionext.com, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH 01/18] coccinelle: change strncpy+truncation to
 strlcpy
In-Reply-To: <20180713091412.GA11250@himanshu-Vostro-3559>
Message-ID: <alpine.DEB.2.20.1807130540270.3044@hadrien>
References: <1531444483-17338-1-git-send-email-asmadeus@codewreck.org> <20180713074455.GA6859@himanshu-Vostro-3559> <20180713080023.GB9638@nautica> <20180713091412.GA11250@himanshu-Vostro-3559>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 13 Jul 2018, Himanshu Jha wrote:

> On Fri, Jul 13, 2018 at 10:00:23AM +0200, Dominique Martinet wrote:
> > Himanshu Jha wrote on Fri, Jul 13, 2018:
> > > > I expect each maintainer will pick their share of the patchs if they
> > > > agree with it and the rest will just be dropped?
> > >
> > > Masahiro Yamada <yamada.masahiro@socionext.com> takes coccinelle patches,
> > > so please cc him or your patch would be lost.
> >
> > Thanks, will do.
> >
> > > > +virtual patch
> > > > +virtual context
> > >
> > > You might consider adding context rule or remove this line perhaps ?
> >
> > Victim of copypasta, I'll remove this.
> >
> > > > +-strncpy@p(
> > > > ++strlcpy(
> > > > +  dest, src, sz);
> > > > +-dest[sz - 1] = '\0';
> > >
> > > The above rule produces an output that I think is not correct:
> > > --------------------------------------------------------------
> > > diff =
> > > diff -u -p a//ti/wl1251/acx.c b//ti/wl1251/acx.c
> > > --- a//ti/wl1251/acx.c
> > > +++ b//ti/wl1251/acx.c
> > > @@ -150,14 +150,7 @@ int wl1251_acx_fw_version(struct wl1251
> > >  	}
> > >
> > >  	/* be careful with the buffer sizes */
> > > -	strncpy(buf, rev->fw_version, min(len, sizeof(rev->fw_version)));
> > > -
> > > -	/*
> > > -	 * if the firmware version string is exactly
> > > -	 * sizeof(rev->fw_version) long or fw_len is less than
> > > -	 * sizeof(rev->fw_version) it won't be null terminated
> > > -	 */
> > > -	buf[min(len, sizeof(rev->fw_version)) - 1] = '\0';
> > > +	strlcpy(buf, rev->fw_version, min(len, sizeof(rev->fw_version)));
> > >
> > > -----------------------------------------------------------------
> > >
> > > I think the comment is useful and should not be removed.
> >
> > I agree this comment is useful now that I'm taking a closer look, I
> > glanced at this too fast.
> > I'm not sure how to make coccinelle not remove comments between lines
> > though?
>
> Well, there is no such facility in Coccinelle to ignore comments.
> You can hack with other facilities provided in SmPL though ;)
>
> Try this:
>
> $ spatch -D patch --sp-file strlcopy.cocci --very-quiet drivers/net/wireless/ti/wl1251/acx.c
>
> ---------------------------------------------------------------------
> virtual patch
>
> @depends on patch@
> expression dest, src, sz;
> identifier f;
> @@
>
> (
> - strncpy(
> + strlcpy(
>   dest, src, sizeof(sz));
> - dest[sizeof(sz) - 1] = '\0';
> |
> - strncpy(
> + strlcpy(
>   dest, src, f);
> - dest[f - 1] = '\0';
> )
> ---------------------------------------------------------------------
>
> This eliminates that case because expression is generic metavariable and
> it somehow matched whole "min(len, sizeof(...)..", so it better to
> divide the rules as done above to be more specific about the matching
> pattern.
>
> I thought to replace "identifier f" with "constant F" but that misses
> few cases.
>
> Also, it is advised to put a space affer '+/-'

Thanks Himanshu for the suggestions.

However, I'm not sure to follow the discussion.  The original problem was
that Coccinelle was removing a comment that should be preserved.  I think
that this occurs because the line just below the comment is completely
removed.  Coccinelle considers that the comment belongs with that line and
if the line is removed the comment won't make much sense.

In Himanshu's solution, the code is just not transformed at all, so as a
side effect the comment stays too.  Is that what is wanted in this case?

julia
