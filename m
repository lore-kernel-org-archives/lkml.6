Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8CBC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B27020873
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfBKKqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:46:35 -0500
Received: from mga04.intel.com ([192.55.52.120]:37142 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbfBKKqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:46:34 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 02:46:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,358,1544515200"; 
   d="scan'208";a="145846864"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 11 Feb 2019 02:46:30 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 11 Feb 2019 12:46:29 +0200
Date:   Mon, 11 Feb 2019 12:46:29 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Jun Li <jun.li@nxp.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chen Yu <chenyu56@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/9] usb: roles: Find the muxes by also matching
 against the device node
Message-ID: <20190211104629.GE16987@kuha.fi.intel.com>
References: <20190130160259.46919-1-heikki.krogerus@linux.intel.com>
 <20190130160259.46919-7-heikki.krogerus@linux.intel.com>
 <VI1PR04MB4558283CA9D752D5452FA09989640@VI1PR04MB4558.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB4558283CA9D752D5452FA09989640@VI1PR04MB4558.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 09:58:04AM +0000, Jun Li wrote:
> Hi Heikki,
> 
> > @@ -84,7 +85,12 @@ enum usb_role usb_role_switch_get_role(struct
> > usb_role_switch *sw)  }  EXPORT_SYMBOL_GPL(usb_role_switch_get_role);
> > 
> > -static int __switch_match(struct device *dev, const void *name)
> > +static int switch_fwnode_match(struct device *dev, const void *fwnode)
> > +{
> > +	return dev_fwnode(dev) == fwnode;
> 
> You missed the comment
> https://lkml.org/lkml/2019/1/22/437
> 
> return dev_fwnode(dev->parent) == fwnode;

That's actually not the case. struct usb_role_switch_desc has a member
for fwnode, and that's what we use with the actual mux device. Check
usb_role_switch_register():

        ...
        sw->dev.fwnode = desc->fwnode;
        ...

Sorry for not realizing it before.


thanks,

-- 
heikki
