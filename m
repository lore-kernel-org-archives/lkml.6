Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A65FC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BB2A2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BB2A2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbeJEWPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:15:34 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53169 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727725AbeJEWPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:15:34 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1g8Rpl-0007GU-Bd; Fri, 05 Oct 2018 17:16:05 +0200
Message-ID: <1538752564.3545.37.camel@pengutronix.de>
Subject: Re: [PATCH v2] reset: Exclusive resets must be dedicated to a
 single hardware block
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Auger Eric <eric.auger@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Date:   Fri, 05 Oct 2018 17:16:04 +0200
In-Reply-To: <CAMuHMdUC3dGRnMCsX3HjmGgb0-vLSNXKXRiiAS+TzW72_uM+LQ@mail.gmail.com>
References: <20180927180038.24599-1-geert+renesas@glider.be>
         <1538648094.14153.8.camel@pengutronix.de>
         <CAMuHMdV_qb8qDFJ1VT6FYYkHK73tjbp2hOUShaOEhezPWg+VDg@mail.gmail.com>
         <CAMuHMdUC3dGRnMCsX3HjmGgb0-vLSNXKXRiiAS+TzW72_uM+LQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-10-05 at 14:31 +0200, Geert Uytterhoeven wrote:
[...]
> > > > +                     eq = (args2.np == args.np &&
> > > > +                           args2.args_count == args.args_count &&
> > > > +                           !memcmp(args2.args, args.args,
> > > > +                                   args.args_count * sizeof(args.args[0])));
> > 
> > As there's at least one other function in -next that compares of_phandle_args,
> > I will add a helper of_phandle_args_eq().
> > 
> > > > +                     of_node_put(args2.np);
> > > > +                     if (eq)
> > > 
> > > Emitting a loud warning here could be very helpful if it contains
> > > both the reset controller node and the reset index, as well as the
> 
> Actually on DT-based systems, the index is a driver-specific
> implementation detail, and may differ from the actual reset specifier in DT.
> E.g. on R-Car systems, DT uses a human-readable representation matching
> the datasheet, while internally, the driver uses a packed representation.
> Hence printing the index may confuse the user.
> 
> For lookup-based systems, this is different.

Correct. I'm so used to #reset-cells = <1>, it's hard to remember the
exceptions. So let's not try to print indices or args.

> > > consumer nodes: node and node2.
> > 
> > Indeed, will do, also for lookup resets.
> > 
> > We already have of_print_phandle_args(), but that is a bit inflexible.
> > Adding support for "%pOFa" looks like the modern thing to do.
> 
> Scrap that: of_phandle_args is not derived from a device_node, so %pOFa
> is not appropriate (and would crash instead of fall back to a pointer before
> %pOFa support is implemented). And without more users, it doesn't make much
> sense to go for a new type (e.g. "%pOA")...
> 
> Actually, printing the full reset specifier is not needed. A message like
> 
>     /soc/pwm@e6e31000 and /soc/pwm@e6e30000 share a reset on
> /soc/clock-controller@e6150000
> 
> should give sufficient clue to the user.

Yes. You could also pass con_id into __of_reset_is_exclusive and print
that. It would be nice to indicate which consumer requested exclusive
access.

regards
Philipp
