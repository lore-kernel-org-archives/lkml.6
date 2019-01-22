Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84377C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5822C21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfAVNXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:23:38 -0500
Received: from mga02.intel.com ([134.134.136.20]:2638 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728215AbfAVNXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:23:37 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2019 05:23:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,506,1539673200"; 
   d="scan'208";a="140294381"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 22 Jan 2019 05:23:33 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 22 Jan 2019 15:23:33 +0200
Date:   Tue, 22 Jan 2019 15:23:33 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Jun Li <lijun.kernel@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/5] usb: roles: Find the muxes by also matching
 against the device node
Message-ID: <20190122132333.GC22960@kuha.fi.intel.com>
References: <20181024150525.11552-1-heikki.krogerus@linux.intel.com>
 <20181024150525.11552-4-heikki.krogerus@linux.intel.com>
 <CAKgpwJVaOrZaPOZrfeDiym=P=uZSbG1Aw5T0xayuPMFxG-3cyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgpwJVaOrZaPOZrfeDiym=P=uZSbG1Aw5T0xayuPMFxG-3cyQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 01:40:02PM +0800, Jun Li wrote:
> Hi Heikki,
> Heikki Krogerus <heikki.krogerus@linux.intel.com> 于2018年10月24日周三 下午11:06写道：
> >
> > When the connections are defined in firmware, struct
> > device_connection will have the fwnode member pointing to
> > the device node (struct fwnode_handle) of the requested
> > device, and the endpoint will not be used at all in that
> > case.
> >
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >  drivers/usb/common/roles.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/usb/common/roles.c b/drivers/usb/common/roles.c
> > index 99116af07f1d..bb52e006d203 100644
> > --- a/drivers/usb/common/roles.c
> > +++ b/drivers/usb/common/roles.c
> > @@ -8,6 +8,7 @@
> >   */
> >
> >  #include <linux/usb/role.h>
> > +#include <linux/property.h>
> >  #include <linux/device.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> > @@ -84,7 +85,12 @@ enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw)
> >  }
> >  EXPORT_SYMBOL_GPL(usb_role_switch_get_role);
> >
> > -static int __switch_match(struct device *dev, const void *name)
> > +static int switch_fwnode_match(struct device *dev, const void *fwnode)
> > +{
> > +       return dev_fwnode(dev) == fwnode;
> 
> Seems this should be dev_fwnode(dev->parent) == fwnode;
> The role switch is the child dev of the caller of usb_role_switch_register().

Indeed.

thanks,

-- 
heikki
