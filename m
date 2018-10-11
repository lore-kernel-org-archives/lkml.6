Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DB2C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA21B2085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 08:18:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA21B2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeJKPoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 11:44:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:30497 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbeJKPoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 11:44:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 01:18:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,367,1534834800"; 
   d="scan'208";a="98233733"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 11 Oct 2018 01:18:20 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 11 Oct 2018 11:18:19 +0300
Date:   Thu, 11 Oct 2018 11:18:19 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC/PATCH 2/5] device property: introduce notion of subnodes
 for legacy boards
Message-ID: <20181011081819.GB24771@kuha.fi.intel.com>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
 <20180917181603.125492-3-dmitry.torokhov@gmail.com>
 <20180920135348.GF11965@kuha.fi.intel.com>
 <20180921233119.GA44099@dtor-ws>
 <20180924132050.GK11965@kuha.fi.intel.com>
 <20180924184543.GB156847@dtor-ws>
 <20180925121927.GL11965@kuha.fi.intel.com>
 <20181005214734.GC215120@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005214734.GC215120@dtor-ws>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Sorry for the late reply. I decided to give this a try myself, and
I've now prepared something (not for the gpio stuff!). I'll do a quick
internal review round, and send it to you guys as RFC after that..

On Fri, Oct 05, 2018 at 02:47:34PM -0700, Dmitry Torokhov wrote:
> Hi Heikki,
> 
> On Tue, Sep 25, 2018 at 03:19:27PM +0300, Heikki Krogerus wrote:
> > On Mon, Sep 24, 2018 at 11:45:43AM -0700, Dmitry Torokhov wrote:
> > > I think we are talking about totally different use cases and that is why
> > > we are having hard time coming to a mutually agreeable solution. Could
> > > you please describe in more detail what you would like to achieve,
> > > and preferably show how it is described now with DT and/or ACPI, so that
> > > I have a better frame of reference.
> > 
> > Yes, of course. Sorry.
> > 
> > USB ports are devices that usually the USB controller drivers register
> > (or actually the USB core code). They are represented in both ACPI and
> > DT as child nodes of the controller device node. The USB connector OF
> > node is defined in file
> > Documentation/devicetree/bindings/connector/usb-connector.txt
> > 
> > In short, the controller drivers will request handle to a child node
> > that represents a port, and only after that register the actual port
> > device.
> > 
> > The drivers I'm looking at currently are the USB Type-C port
> > controller drivers and the port manager (in Greg's usb-next or
> > linux-next):
> > 
> >         drivers/usb/typec/tcpm/tcpci.c
> >         drivers/usb/typec/tcpm/fusb302.c
> >         drivers/usb/typec/tcpm/tcpm.c
> > 
> > The goal is simply to get rid of the platform data as usual, and
> > ideally so that we don't need any extra code in order to support the
> > "legacy" platforms.
> 
> Are these actually used on any of the "legacy" platforms? I fetched
> linux-next today, but I do not actually see anything in
> drivers/usb/typec touching platform data...

It's not touching any platform data, and I would like to keep it that
way :-). The device for fusb302 is created for example in
drivers/platform/x86/intel_cht_int33fe.c.

The fusb302.c driver already tries to find that child node named
"connector" (and so do the other port drivers). I'm trying to supply
the driver that node here somehow so I can avoid quirks.

> In the context of the connector, even before we descend to child nodes
> details, how do you propose implementing references between fwnodes?
> Especially since the other node (in case you complementing existing
> topology) may be ACPI or DT instance?

The different fwnode types (ACPI, OF, etc.) must live in parallel,
i.e. you can not have something like ACPI parent node with
property_set children if that's what you mean. The "secondary" member
will link the different types of fwnodes together, but they will live
their separate lives. I'm not planning on changing that.

I'm just looking for a smooth way of describing the devices in
software when the firmware is not supplying the hardware description,
just like you. What I really need is separation of the fwnode
registration from device registration in those cases. For that I now
have a proposal, and I believe my proposal will work for you as a
baseline as well.


Thanks,

-- 
heikki
