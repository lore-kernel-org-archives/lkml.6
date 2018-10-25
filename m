Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F054C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDB420838
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DDB420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbeJYP6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 11:58:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:35532 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbeJYP6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 11:58:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2018 00:27:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,423,1534834800"; 
   d="scan'208";a="102327186"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 25 Oct 2018 00:27:21 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 25 Oct 2018 10:27:20 +0300
Date:   Thu, 25 Oct 2018 10:27:20 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 4/5] usb: typec: Find the ports by also matching
 against the device node
Message-ID: <20181025072720.GC2034@kuha.fi.intel.com>
References: <20181024150525.11552-1-heikki.krogerus@linux.intel.com>
 <20181024150525.11552-5-heikki.krogerus@linux.intel.com>
 <4a091620-94fa-5831-6c8c-1690efa0be66@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a091620-94fa-5831-6c8c-1690efa0be66@cogentembedded.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 08:07:09PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 10/24/2018 06:05 PM, Heikki Krogerus wrote:
> 
> > When the connections are defined in firmware, struct
> > device_connection will have the fwnode member pointing to
> > the device node (struct fwnode_handle) of the requested
> > device, and the endpoint will not be used at all in that
> > case.
> > 
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >  drivers/usb/typec/class.c | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> > index 5db0593ca0bd..fe6f3a932a88 100644
> > --- a/drivers/usb/typec/class.c
> > +++ b/drivers/usb/typec/class.c
> > @@ -204,15 +204,28 @@ static void typec_altmode_put_partner(struct altmode *altmode)
> >  	put_device(&adev->dev);
> >  }
> >  
> > -static int __typec_port_match(struct device *dev, const void *name)
> > +static int typec_port_fwnode_match(struct device *dev, const void *fwnode)
> > +{
> > +	return dev_name(fwnode) == fwnode;
> 
>    dev_name(dev), maybe?

Yes.

thanks,

-- 
heikki
