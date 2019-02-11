Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E332C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13D5620823
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfBKIqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:46:03 -0500
Received: from mga12.intel.com ([192.55.52.136]:18720 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725931AbfBKIqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:46:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 00:46:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,358,1544515200"; 
   d="scan'208";a="116930851"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga008.jf.intel.com with SMTP; 11 Feb 2019 00:45:59 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 11 Feb 2019 10:45:58 +0200
Date:   Mon, 11 Feb 2019 10:45:58 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 14/28] thunderbolt: Extend tunnel creation to more
 than 2 adjacent switches
Message-ID: <20190211084558.GU7875@lahna.fi.intel.com>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
 <20190206131738.43696-15-mika.westerberg@linux.intel.com>
 <20190210153328.44ur6o5z2xjae42c@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190210153328.44ur6o5z2xjae42c@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 04:33:28PM +0100, Lukas Wunner wrote:
> On Wed, Feb 06, 2019 at 04:17:24PM +0300, Mika Westerberg wrote:
> > Now that we can allocate hop IDs per port on a path, we can take
> > advantage of this and create tunnels covering longer paths than just
> > between two adjacent switches. PCIe actually does not need this as it is
> > always a daisy chain between two adjacent switches but this way we do
> > not need to hard-code creation of the tunnel.
> 
> That doesn't seem to be correct, at the bottom of this page there's
> a figure showing a PCI tunnel between non-adjacent switches (blue line):
> 
> https://developer.apple.com/library/archive/documentation/HardwareDrivers/Conceptual/ThunderboltDevGuide/Basics/Basics.html
> 
> I'm not sure if there are advantages to such tunnels:  Reduced latency
> perhaps because packets need not pass through PCIe adapters on the
> in-between device?  Or maybe this allows for more fine-grained traffic
> prioritization?

Interesting.

Are you sure Apple actually uses setup like that? I think I have never
seen such configuration happening on any of the devices I have.

I can update the changelog to mention that if you think it is useful.
Something like below maybe?

 PCIe actually does not need this as it is typically a daisy chain
 between two adjacent switches but this way we do not need to hard-code
 creation of the tunnel.

> > +	i = 0;
> > +	tb_for_each_port(in_port, src, dst)
> > +		i++;
> 
> This looks more complicated than necessary.  Isn't the path length
> always the length of the route string from in_port switch to out_port
> switch, plus 2 for the adapter on each end?  Or do paths without
> adapters exist?

Yes, I think you are right.

> > +	for (i = 0; i < num_hops; i++) {
> > +		in_port = tb_port_get_next(src, dst, out_port);
> > +
> > +		if (in_port->dual_link_port && in_port->link_nr != link_nr)
> > +			in_port = in_port->dual_link_port;
> > +
> > +		ret = tb_port_alloc_in_hopid(in_port, in_hopid, -1);
> > +		if (ret < 0)
> > +			goto err;
> > +		in_hopid = ret;
> > +
> > +		out_port = tb_port_get_next(src, dst, in_port);
> > +		if (!out_port)
> > +			goto err;
> 
> There's a NULL pointer check here, but the invocation of tb_port_get_next()
> further up to assign in_port lacks such a check.  Is it guaranteed to never
> be NULL?

No, I'll add NULL check there.
