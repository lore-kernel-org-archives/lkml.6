Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484B5C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 15:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168482145D
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 15:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfBJPdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 10:33:31 -0500
Received: from bmailout1.hostsharing.net ([83.223.95.100]:46585 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfBJPdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 10:33:31 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 48CA730000CC1;
        Sun, 10 Feb 2019 16:33:29 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 093D6DFE15; Sun, 10 Feb 2019 16:33:28 +0100 (CET)
Date:   Sun, 10 Feb 2019 16:33:28 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 14/28] thunderbolt: Extend tunnel creation to more
 than 2 adjacent switches
Message-ID: <20190210153328.44ur6o5z2xjae42c@wunner.de>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
 <20190206131738.43696-15-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206131738.43696-15-mika.westerberg@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 04:17:24PM +0300, Mika Westerberg wrote:
> Now that we can allocate hop IDs per port on a path, we can take
> advantage of this and create tunnels covering longer paths than just
> between two adjacent switches. PCIe actually does not need this as it is
> always a daisy chain between two adjacent switches but this way we do
> not need to hard-code creation of the tunnel.

That doesn't seem to be correct, at the bottom of this page there's
a figure showing a PCI tunnel between non-adjacent switches (blue line):

https://developer.apple.com/library/archive/documentation/HardwareDrivers/Conceptual/ThunderboltDevGuide/Basics/Basics.html

I'm not sure if there are advantages to such tunnels:  Reduced latency
perhaps because packets need not pass through PCIe adapters on the
in-between device?  Or maybe this allows for more fine-grained traffic
prioritization?


> +	i = 0;
> +	tb_for_each_port(in_port, src, dst)
> +		i++;

This looks more complicated than necessary.  Isn't the path length
always the length of the route string from in_port switch to out_port
switch, plus 2 for the adapter on each end?  Or do paths without
adapters exist?


> +	for (i = 0; i < num_hops; i++) {
> +		in_port = tb_port_get_next(src, dst, out_port);
> +
> +		if (in_port->dual_link_port && in_port->link_nr != link_nr)
> +			in_port = in_port->dual_link_port;
> +
> +		ret = tb_port_alloc_in_hopid(in_port, in_hopid, -1);
> +		if (ret < 0)
> +			goto err;
> +		in_hopid = ret;
> +
> +		out_port = tb_port_get_next(src, dst, in_port);
> +		if (!out_port)
> +			goto err;

There's a NULL pointer check here, but the invocation of tb_port_get_next()
further up to assign in_port lacks such a check.  Is it guaranteed to never
be NULL?

Thanks,

Lukas
