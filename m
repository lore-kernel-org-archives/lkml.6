Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E22C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE9F20881
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 08:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731524AbfAaI0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 03:26:51 -0500
Received: from bmailout3.hostsharing.net ([176.9.242.62]:38247 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfAaI0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 03:26:51 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 9EEAB100D940B;
        Thu, 31 Jan 2019 09:26:49 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 472FF162E5; Thu, 31 Jan 2019 09:26:49 +0100 (CET)
Date:   Thu, 31 Jan 2019 09:26:49 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 03/28] thunderbolt: Enable TMU access when accessing port
 space on legacy devices
Message-ID: <20190131082649.vat2epdhmuh4itt7@wunner.de>
References: <20190129150143.12681-1-mika.westerberg@linux.intel.com>
 <20190129150143.12681-4-mika.westerberg@linux.intel.com>
 <20190129215858.c2yws2ce76d7qm62@wunner.de>
 <20190130093705.GF7875@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130093705.GF7875@lahna.fi.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 11:37:05AM +0200, Mika Westerberg wrote:
> On Tue, Jan 29, 2019 at 10:58:58PM +0100, Lukas Wunner wrote:
> > On Tue, Jan 29, 2019 at 06:01:18PM +0300, Mika Westerberg wrote:
> > > +int tb_port_find_cap(struct tb_port *port, enum tb_port_cap cap)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = tb_port_enable_tmu(port, true);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = __tb_port_find_cap(port, cap);
> > > +
> > > +	tb_port_enable_tmu(port, false);
> > > +
> > > +	return ret;
> > > +}
> > 
> > Would there be a downside to setting the TMU bit on all ports all the time
> > (e.g. on switch enumeration)?
> 
> You mean turn it on once and keep it like that? Quick experimentation
> with a couple of LR devices did not show any side-effects so I guess we
> could just turn it on once during the enumeration in affected devices.

I guess I'm confused because I thought TMU is used for clock synchronization
across the daisy-chain, so I would expect it to be available only on ports
of type TB_TYPE_PORT, not on adapters of any type.  Yet a code comment in
the current implementation of tb_port_find_cap() talks about TMU on DP out
adapters?

This patch says that the bit that's being modified is used for "access"
to the TMU.  So apparently the bit is not about enablement of clock
synchronization, but only about granting access to the TMU?  (For whom?)

Doesn't TMU synchronization need to be enabled on all devices on the
daisy chain for Thunderbolt to function?  (BTW in MacBooks with dual
Alpine Ridge, e.g. MacBookPro13,3, the two controllers' TMU in and out
pins are wired together, presumably this allows for clock synchronization
across Thunderbolt chips in the same machine.)


> Main reason it is now in cap.c is because we only need it to be enabled
> during the cap walk and that allows keeping both workarounds in the same
> file close to the place where it is used.

I was only wondering whether the bit should be set all the time
because I was worrying that clock synchronization would otherwise
not be enabled.  And if tb_port_find_cap() is called frequently,
setting the bit only once provides for a small performance improvement.
OTOH it would then be necessary to restore the bit when coming out of
(runtime or system) suspend.  I guess I don't have a strong opinion
on this because I don't fully grasp what the bit is for.

Thanks,

Lukas
