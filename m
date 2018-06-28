Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF3BC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129CD208F7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 11:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 129CD208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965507AbeF1Led (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 07:34:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:13195 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965449AbeF1Lec (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 07:34:32 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2018 04:34:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,283,1526367600"; 
   d="scan'208";a="68026013"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 28 Jun 2018 04:34:27 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 28 Jun 2018 14:34:27 +0300
Date:   Thu, 28 Jun 2018 14:34:27 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
        Mats Karrman <mats.dev.list@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] usb: typec: mux: Get the mux identifier from
 function parameter
Message-ID: <20180628113427.GB30974@kuha.fi.intel.com>
References: <20180627151953.30942-1-heikki.krogerus@linux.intel.com>
 <20180627151953.30942-4-heikki.krogerus@linux.intel.com>
 <20180628105155.GB5191@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628105155.GB5191@kroah.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 07:51:55PM +0900, Greg Kroah-Hartman wrote:
> On Wed, Jun 27, 2018 at 06:19:48PM +0300, Heikki Krogerus wrote:
> > In order for the muxes to be usable with alternate modes,
> > the alternate mode devices will need also to be able to get
> > a handle to the muxes on top of the port devices. To make
> > that possible, the muxes need to be possible to request with
> > an identifier.
> > 
> > This will change the API so that the mux identifier is given
> > as a function parameter to typec_mux_get(), and the hard-coded
> > "typec-mux" is replaced with that value.
> > 
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >  drivers/usb/typec/class.c     | 2 +-
> >  drivers/usb/typec/mux.c       | 6 +++---
> >  include/linux/usb/typec_mux.h | 2 +-
> >  3 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> > index 2b3eaa969f3b..b860bd3a0acb 100644
> > --- a/drivers/usb/typec/class.c
> > +++ b/drivers/usb/typec/class.c
> > @@ -1357,7 +1357,7 @@ struct typec_port *typec_register_port(struct device *parent,
> >  		goto err_switch;
> >  	}
> >  
> > -	port->mux = typec_mux_get(cap->fwnode ? &port->dev : parent);
> > +	port->mux = typec_mux_get(parent, "typec-mux");
> 
> This changes the first parameter for this call, is that ok?  Doesn't
> that change the functionality here?

No, I noticed that cap->fwnode is set after we call that function, so
we always ended up using parent.

This needs to be fixed properly of course, but I choose not to propose
anything in this series. We don't yet use the fwnode handle with the
muxes in any case, as the device connection API does not support
anything else except build-in connections descriptions for now.


Thanks,

-- 
heikki
