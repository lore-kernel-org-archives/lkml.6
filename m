Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFC8C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF502190B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732084AbfBLSqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:46:48 -0500
Received: from mga06.intel.com ([134.134.136.31]:34920 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729007AbfBLSqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:46:47 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Feb 2019 10:46:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,362,1544515200"; 
   d="scan'208";a="133742515"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga002.jf.intel.com with SMTP; 12 Feb 2019 10:46:44 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 12 Feb 2019 20:46:43 +0200
Date:   Tue, 12 Feb 2019 20:46:43 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-kernel@vger.kernel.org,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 18/28] thunderbolt: Scan only valid NULL adapter ports
 in hotplug
Message-ID: <20190212184643.GJ7875@lahna.fi.intel.com>
References: <20190206131738.43696-1-mika.westerberg@linux.intel.com>
 <20190206131738.43696-19-mika.westerberg@linux.intel.com>
 <20190212140422.hiwll4cilgs7ruev@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212140422.hiwll4cilgs7ruev@wunner.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 03:04:22PM +0100, Lukas Wunner wrote:
> On Wed, Feb 06, 2019 at 04:17:28PM +0300, Mika Westerberg wrote:
> > The only way to expand Thunderbolt topology is through the NULL adapter
> > ports (typically ports 1, 2, 3 and 4). There is no point handling
> > Thunderbolt hotplug events on any other port.
> > 
> > Add a helper function (tb_port_is_null()) that can be used to determine
> > if the port is NULL port, and use it in software connection manager code
> > when hotplug event is handled.
> 
> Andreas called these ports TB_TYPE_PORT.  If the official name is NULL,
> then renaming to TB_TYPE_NULL might be a useful cleanup.  (Though it
> seems the control port, i.e. port 0, is also of type TB_TYPE_PORT?)

Yes, they are called NULL ports. The control port does not have port
config space but is still accounted in max port number of the switch and
also has the type TB_TYPE_PORT but you access it when you talk to switch
config space.

Since the type is the same, I would like to keep it like this and
differentiate control port using the port number 0 where needed.

> > --- a/drivers/thunderbolt/tb.c
> > +++ b/drivers/thunderbolt/tb.c
> > @@ -344,10 +344,12 @@ static void tb_handle_hotplug(struct work_struct *work)
> >  		tb_port_info(port,
> >  			     "got plug event for connected port, ignoring\n");
> >  	} else {
> > -		tb_port_info(port, "hotplug: scanning\n");
> > -		tb_scan_port(port);
> > -		if (!port->remote)
> > -			tb_port_info(port, "hotplug: no switch found\n");
> > +		if (tb_port_is_null(port)) {
> > +			tb_port_info(port, "hotplug: scanning\n");
> > +			tb_scan_port(port);
> > +			if (!port->remote)
> > +				tb_port_info(port, "hotplug: no switch found\n");
> > +		}
> 
> There's several other sanity checks further up in this function.
> Why not move the tb_port_is_null() check near them, e.g. below the
> check for tb_is_upstream_port()?

DP adapters also get hotplug events and in subsequent patches we add
handling for those in this function as well.
