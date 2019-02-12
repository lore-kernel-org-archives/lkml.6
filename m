Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B84C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76442084E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbfBLMyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:54:20 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:39763 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728413AbfBLMyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:54:19 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id A57D1100D940B;
        Tue, 12 Feb 2019 13:54:17 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 5FD43160E04; Tue, 12 Feb 2019 13:54:17 +0100 (CET)
Date:   Tue, 12 Feb 2019 13:54:17 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 14/28] thunderbolt: Extend tunnel creation to more
 than 2 adjacent switches
Message-ID: <20190212125417.4an7efllnf7pqw2v@wunner.de>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
 <20190206131738.43696-15-mika.westerberg@linux.intel.com>
 <20190210153328.44ur6o5z2xjae42c@wunner.de>
 <20190211084558.GU7875@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211084558.GU7875@lahna.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 10:45:58AM +0200, Mika Westerberg wrote:
> On Sun, Feb 10, 2019 at 04:33:28PM +0100, Lukas Wunner wrote:
> > at the bottom of this page there's
> > a figure showing a PCI tunnel between non-adjacent switches (blue line):
> > 
> > https://developer.apple.com/library/archive/documentation/HardwareDrivers/Conceptual/ThunderboltDevGuide/Basics/Basics.html
> > 
> Are you sure Apple actually uses setup like that? I think I have never
> seen such configuration happening on any of the devices I have.

Sorry, I don't know if they actually use that.


> I can update the changelog to mention that if you think it is useful.
> Something like below maybe?
> 
>  PCIe actually does not need this as it is typically a daisy chain
>  between two adjacent switches but this way we do not need to hard-code
>  creation of the tunnel.

LGTM, thanks.


> > > +	i = 0;
> > > +	tb_for_each_port(in_port, src, dst)
> > > +		i++;
> > 
> > This looks more complicated than necessary.  Isn't the path length
> > always the length of the route string from in_port switch to out_port
> > switch, plus 2 for the adapter on each end?  Or do paths without
> > adapters exist?
> 
> Yes, I think you are right.

Simply subtracting the depths of the start and end port's switch also yields
the path length.  Of course this assumes that tunnels aren't established
between non-adjacent switches, but your algorithm doesn't do that.

Thanks,

Lukas
