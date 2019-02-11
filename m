Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F9B5C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39B4120863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfBKIas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:30:48 -0500
Received: from mga03.intel.com ([134.134.136.65]:23066 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfBKIas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:30:48 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 00:30:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,358,1544515200"; 
   d="scan'208";a="319335796"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga005.fm.intel.com with SMTP; 11 Feb 2019 00:30:44 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 11 Feb 2019 10:30:43 +0200
Date:   Mon, 11 Feb 2019 10:30:43 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 12/28] thunderbolt: Add functions for allocating and
 releasing hop IDs
Message-ID: <20190211083043.GT7875@lahna.fi.intel.com>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
 <20190206131738.43696-13-mika.westerberg@linux.intel.com>
 <20190210121353.fw7gj4pm7ce3flvf@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190210121353.fw7gj4pm7ce3flvf@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 01:13:53PM +0100, Lukas Wunner wrote:
> On Wed, Feb 06, 2019 at 04:17:22PM +0300, Mika Westerberg wrote:
> > Each port has a separate path configuration space that is used for
> > finding the next hop (switch) in the path. Hop ID is an index to this
> > configuration space and hop IDs 0 - 7 are reserved.
> > 
> > In order to get next available hop ID for each direction we provide two
> > pairs of helper functions that can be used to allocate and release hop
> > IDs for a given port.
> [...]
> > +static int tb_port_alloc_hopid(struct tb_port *port, bool in, int min_hopid,
> > +			       int max_hopid)
> > +{
> > +	int port_max_hopid;
> > +	struct ida *ida;
> > +
> > +	if (in) {
> > +		port_max_hopid = port->config.max_in_hop_id;
> > +		ida = &port->in_hopids;
> > +	} else {
> > +		port_max_hopid = port->config.max_out_hop_id;
> > +		ida = &port->out_hopids;
> > +	}
> > +
> > +	/* Hop IDs 0-7 are reserved */
> > +	if (min_hopid < 8)
> > +		min_hopid = 8;
> > +
> > +	if (max_hopid < 0 || max_hopid > port_max_hopid)
> > +		max_hopid = port_max_hopid;
> > +
> > +	return ida_simple_get(ida, min_hopid, max_hopid + 1, GFP_KERNEL);
> > +}
> 
> If there are two Macs at the ends of the daisy-chain with Thunderbolt
> devices in-between, the other Mac may already have established tunnels
> to some of the devices and therefore has occupied hop entries in the
> devices' path config space.  How do you ensure that you don't allocate
> the same entries and overwrite the other Mac's hop entries, thereby
> breaking its tunnels?

If the other Mac has enumerated the device (set the upstream port,
route, depth) then the other Mac cannot access the device. You get an
error (we deal with that in the later patch in the series when we
identify XDomain connections). The Hop ID allocation is only relevant in
a single domain.  Crossing one needs to have protocol such as we have in
case of ThunderboltIP to negotiate Hop IDs used in the link between two
domains.
