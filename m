Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC3CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40E020880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 09:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfBUJfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 04:35:13 -0500
Received: from mga03.intel.com ([134.134.136.65]:56889 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfBUJfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 04:35:12 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 01:35:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,394,1544515200"; 
   d="scan'208";a="148639191"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 21 Feb 2019 01:35:08 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 21 Feb 2019 11:35:08 +0200
Date:   Thu, 21 Feb 2019 11:35:08 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] platform/x86: intel_cht_int33fe: Provide fwnode for
 the USB connector
Message-ID: <20190221093508.GF5054@kuha.fi.intel.com>
References: <20190219115959.55553-1-heikki.krogerus@linux.intel.com>
 <20190219115959.55553-2-heikki.krogerus@linux.intel.com>
 <CAHp75VcoqwP5VrOW60XtQHLAO1KOmc_Kyn-KQsZC-tsiwpQq3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcoqwP5VrOW60XtQHLAO1KOmc_Kyn-KQsZC-tsiwpQq3A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 05:55:21PM +0200, Andy Shevchenko wrote:
> On Tue, Feb 19, 2019 at 2:00 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > In ACPI, and now also in DT, the USB connectors usually have
> > their own device nodes. In case of USB Type-C, those
> > connector (port) nodes are child nodes of the controller or
> > PHY device, in our case the fusb302. The software fwnodes
> > allow us to create a similar child node for fusb302 that
> > represents the connector also on Intel CHT.
> >
> > This makes it possible replace the fusb302 specific device
> > properties which were deprecated with the common USB
> > connector properties that tcpm.c is able to use directly.
> 
> > +       /* Node for the FUSB302 controller */
> > +       data->fusb302_node = fwnode_create_software_node(fusb302_props, NULL);
> > +       if (IS_ERR(data->fusb302_node))
> > +               return PTR_ERR(data->fusb302_node);
> > +
> > +       /* Node for the connector (FUSB302 is the parent) */
> > +       data->port_node = fwnode_create_software_node(usb_connector_props,
> > +                                                     data->fusb302_node);
> > +       if (IS_ERR(data->port_node)) {
> 
> > +               fwnode_remove_software_node(data->fusb302_node);
> 
> Sounds like a candidate for
> devm_fwnode_create_software_node()

If you don't mind, let's think about that later.

I'm not comfortable at all with the idea of introducing
devm_fwnode_create_software_node(). I would like to talk about that
separately. It's not going to be a problem to change this driver later
even if we decide to add the function.


thanks,

-- 
heikki
