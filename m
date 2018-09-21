Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B55ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C669421567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NX66nPP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C669421567
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390766AbeIUWam (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:30:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34116 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389683AbeIUWam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:30:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id d19-v6so6314441pgv.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 09:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a/G45wFZVarS6LqhwUfRvK1fjvAaMaoId9rSpjSDwMg=;
        b=NX66nPP2t+deQL9fksGgGNCLay+q8l+gX5tZSLoLRkz0nhfp2DH7dP6uRhazrweJfU
         8OPsQ8/zkxJkIukNHSRVBUf8oIN4rYWZtOxuh9dV69UPchY7mzFQo4R+3aFVShHFA+6a
         vR1EBu7hgKwDJS1VVeLRBpZPrv4yi31MHeYF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a/G45wFZVarS6LqhwUfRvK1fjvAaMaoId9rSpjSDwMg=;
        b=Skq/4edkieTGEnPoknKpb5MFrZvs7a1TGuNeihfBDHtGAzp+bag4GLhqYB85jf30dp
         GN1tb28ajx+KqDYPTXWlyjwW8Q28p7QZMBGGQa9/BEJ2jajU8kBIJ9Z+mNLwRozbC94c
         XZrWKDtLPHSWJL2mFxUAGge0EGlye1rS8yA8WvciCtFaBCg0rPJnUlrq+JoCoddx44Zy
         2LWjk1Ytk3p3NRlzThVTmwNUAfRkiUgY3UiHNUPUk97Dq97MrOsY38Bgf0rgSXgOp3db
         4CgawB/zfJHNINs+2RZ3PtyoymUkks/HpvmgKfIA1rDHcQwucmbu1FkzbBlFHFW5hg1Q
         x++g==
X-Gm-Message-State: APzg51AANNiBur2NwwtZklFrKXD3snmto393dIgBOBS73BsKvBFua9Yb
        fB1dgWXDSsP64b0jwVvM0mflSQ==
X-Google-Smtp-Source: ANB0VdZ1+tQzDLYD17idlpy0ZlR3mi58ydTTa+0rPuSusC3Bgw0xeEcNGgHwYQW82VWy6zg16gkFIg==
X-Received: by 2002:a63:cc4f:: with SMTP id q15-v6mr42041998pgi.217.1537548059912;
        Fri, 21 Sep 2018 09:40:59 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id o10-v6sm58870839pfk.76.2018.09.21.09.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 09:40:59 -0700 (PDT)
Date:   Fri, 21 Sep 2018 09:40:58 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 1/2] device property: Add device_get_bd_address() and
 fwnode_get_bd_address()
Message-ID: <20180921164058.GW22824@google.com>
References: <20180920223436.202454-1-mka@chromium.org>
 <20180920223436.202454-2-mka@chromium.org>
 <20180921071312.gg7xshwa2ro3hiix@kekkonen.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180921071312.gg7xshwa2ro3hiix@kekkonen.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Fri, Sep 21, 2018 at 10:13:12AM +0300, Sakari Ailus wrote:
> Hi Matthias,
> 
> On Thu, Sep 20, 2018 at 03:34:35PM -0700, Matthias Kaehlcke wrote:
> > Provide an API for Bluetooth drivers to retrieve the Bluetooth Device
> > address (BD_ADDR) for a device. If the device node has a property
> > 'local-bd-address' the BD address is read from this property.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  drivers/base/property.c  | 49 ++++++++++++++++++++++++++++++++++++++++
> >  include/linux/property.h |  4 ++++
> >  2 files changed, 53 insertions(+)
> > 
> > diff --git a/drivers/base/property.c b/drivers/base/property.c
> > index 240ab5230ff6..8fe546b9805a 100644
> > --- a/drivers/base/property.c
> > +++ b/drivers/base/property.c
> > @@ -18,6 +18,8 @@
> >  #include <linux/etherdevice.h>
> >  #include <linux/phy.h>
> >  
> > +#define BD_ADDR_LEN	6
> > +
> >  struct property_set {
> >  	struct device *dev;
> >  	struct fwnode_handle fwnode;
> > @@ -1315,6 +1317,53 @@ void *device_get_mac_address(struct device *dev, char *addr, int alen)
> >  }
> >  EXPORT_SYMBOL(device_get_mac_address);
> >  
> > +/**
> > + * fwnode_get_bd_address - Get the Bluetooth Device Address (BD_ADDR) from the
> > + *                         firmware node
> > + * @fwnode:	Pointer to the firmware node
> > + * @addr:	Address of buffer to store the BD address in
> > + * @alen:	Length of the buffer pointed to by addr, should be BD_ADDR_LEN
> > + *
> > + * Search the firmware node for 'local-bd-address'.
> > + *
> > + * All-zero BD addresses are rejected, because those could be properties
> > + * that exist in the firmware tables, but were not updated by the firmware. For
> > + * example, the DTS could define 'local-bd-address', with zero BD addresses.
> > + */
> > +int fwnode_get_bd_address(struct fwnode_handle *fwnode, u8 *addr, int alen)
> 
> How about using bdaddr_t instead? The original caller was casting it to u8
> probably just because there was no function specifically for this purpose.

I was considering that, but wasn't sure if it would be 'correct' to
include net/bluetooth/bluetooth.h (with the typdef of bdaddr_t) from
property.h since it is very frugal on headers and complex types.

That said I'd also prefer to use bdaddr_t if the API isn't limited to
basic data types on purpose.

> I wonder if this also should be made depend on CONFIG_BT. The fwnode
> framework is unconditionally a part of the kernel and it's not very big at
> the moment but adding stuff little by little will add up eventually.

Sounds good!

> > +{
> > +	u8 buf[BD_ADDR_LEN];
> > +	int ret;
> > +
> > +	if (alen != BD_ADDR_LEN)
> > +		return -EINVAL;
> > +
> > +	ret = fwnode_property_read_u8_array(fwnode, "local-bd-address",
> > +					    buf, alen);
> > +	if (ret < 0)
> > +		return ret;
> > +	if (is_zero_ether_addr(buf))
> > +		return -ENODATA;
> > +
> > +	memcpy(addr, buf, BD_ADDR_LEN);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(fwnode_get_bd_address);
> > +
> > +/**
> > + * device_get_bd_address - Get the Bluetooth Device Address (BD_ADDR) for a
> > + *                         given device
> > + * @dev:	Pointer to the device
> > + * @addr:	Address of buffer to store the BD address in
> > + * @alen:	Length of the buffer pointed to by addr, should be BD_ADDR_LEN
> > + */
> > +int device_get_bd_address(struct device *dev, u8 *addr, int alen)
> > +{
> > +	return fwnode_get_bd_address(dev_fwnode(dev), addr, alen);
> > +}
> > +EXPORT_SYMBOL(device_get_bd_address);
> > +
> >  /**
> >   * fwnode_irq_get - Get IRQ directly from a fwnode
> >   * @fwnode:	Pointer to the firmware node
> > diff --git a/include/linux/property.h b/include/linux/property.h
> > index ac8a1ebc4c1b..4e2f1b276f4f 100644
> > --- a/include/linux/property.h
> > +++ b/include/linux/property.h
> > @@ -287,9 +287,13 @@ int device_get_phy_mode(struct device *dev);
> >  
> >  void *device_get_mac_address(struct device *dev, char *addr, int alen);
> >  
> > +int device_get_bd_address(struct device *dev, u8 *addr, int alen);
> > +
> >  int fwnode_get_phy_mode(struct fwnode_handle *fwnode);
> >  void *fwnode_get_mac_address(struct fwnode_handle *fwnode,
> >  			     char *addr, int alen);
> > +int fwnode_get_bd_address(struct fwnode_handle *fwnode,
> > +			  u8 *addr, int alen);
> 
> This would be a good opportunity to add a newline here, and avoid adding
> one after device_get_mac_address().

Will do

Thanks for the review!
