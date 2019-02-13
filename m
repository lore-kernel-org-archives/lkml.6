Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8F7C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD589222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390693AbfBMIaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:30:22 -0500
Received: from mga14.intel.com ([192.55.52.115]:34636 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733281AbfBMIaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:30:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2019 00:30:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,365,1544515200"; 
   d="scan'208";a="146438540"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 13 Feb 2019 00:30:18 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 13 Feb 2019 10:30:18 +0200
Date:   Wed, 13 Feb 2019 10:30:18 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 16/28] thunderbolt: Discover preboot PCIe paths the
 boot firmware established
Message-ID: <20190213083018.GO7875@lahna.fi.intel.com>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
 <20190206131738.43696-17-mika.westerberg@linux.intel.com>
 <20190212194249.2ftl2ckureow44lo@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212194249.2ftl2ckureow44lo@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 08:42:49PM +0100, Lukas Wunner wrote:
> On Wed, Feb 06, 2019 at 04:17:26PM +0300, Mika Westerberg wrote:
> > +static struct tb_port *tb_port_remote(struct tb_port *port)
> > +{
> > +	struct tb_port *remote = port->remote;
> > +
> > +	/*
> > +	 * If we have a dual link, the remote is available through the
> > +	 * primary link.
> > +	 */
> > +	if (!remote && port->dual_link_port && port->dual_link_port->remote)
> > +		return port->dual_link_port->remote->dual_link_port;
> > +	return remote;
> > +}
> 
> Yet more special-casing for dual-link ports. :-(
> 
> 
> > +	if (tunnel->dst_port->config.type != TB_TYPE_PCIE_UP) {
> > +		tb_port_warn(tunnel->dst_port,
> > +			     "path does not end to a PCIe adapter\n");
> 
> Nit: I think the proper proposition is "on" or "at", not "to".
> 
> The tunnel discovery algorithm looks solid to me, so:
> Reviewed-by: Lukas Wunner <lukas@wunner.de>

Thanks!

> When the module is unloaded, tb_stop() currently deactivates all PCI
> tunnels.  Is this still a good idea now that tunnels are discovered
> on probe?  We could just leave the tunnels in place and rediscover
> them when the module is reloaded.  If something was unplugged in the
> meantime, pciehp will have disconnected the devices and we should
> notice on reprobe that certain tunnels cannot be rediscovered, so no
> harm no foul.  Thoughts?

I agree it makes sense and that's actually what we already do with the
firmware CM.
