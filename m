Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE280C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823212150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 07:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823212150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389258AbeIUNBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 09:01:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:58062 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbeIUNBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 09:01:01 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Sep 2018 00:13:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,284,1534834800"; 
   d="scan'208";a="85392786"
Received: from lwallet-mobl2.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.249.254.69])
  by orsmga003.jf.intel.com with SMTP; 21 Sep 2018 00:13:13 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id BCA9621F17; Fri, 21 Sep 2018 10:13:12 +0300 (EEST)
Date:   Fri, 21 Sep 2018 10:13:12 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Matthias Kaehlcke <mka@chromium.org>
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
Message-ID: <20180921071312.gg7xshwa2ro3hiix@kekkonen.localdomain>
References: <20180920223436.202454-1-mka@chromium.org>
 <20180920223436.202454-2-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180920223436.202454-2-mka@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Thu, Sep 20, 2018 at 03:34:35PM -0700, Matthias Kaehlcke wrote:
> Provide an API for Bluetooth drivers to retrieve the Bluetooth Device
> address (BD_ADDR) for a device. If the device node has a property
> 'local-bd-address' the BD address is read from this property.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/base/property.c  | 49 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/property.h |  4 ++++
>  2 files changed, 53 insertions(+)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 240ab5230ff6..8fe546b9805a 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -18,6 +18,8 @@
>  #include <linux/etherdevice.h>
>  #include <linux/phy.h>
>  
> +#define BD_ADDR_LEN	6
> +
>  struct property_set {
>  	struct device *dev;
>  	struct fwnode_handle fwnode;
> @@ -1315,6 +1317,53 @@ void *device_get_mac_address(struct device *dev, char *addr, int alen)
>  }
>  EXPORT_SYMBOL(device_get_mac_address);
>  
> +/**
> + * fwnode_get_bd_address - Get the Bluetooth Device Address (BD_ADDR) from the
> + *                         firmware node
> + * @fwnode:	Pointer to the firmware node
> + * @addr:	Address of buffer to store the BD address in
> + * @alen:	Length of the buffer pointed to by addr, should be BD_ADDR_LEN
> + *
> + * Search the firmware node for 'local-bd-address'.
> + *
> + * All-zero BD addresses are rejected, because those could be properties
> + * that exist in the firmware tables, but were not updated by the firmware. For
> + * example, the DTS could define 'local-bd-address', with zero BD addresses.
> + */
> +int fwnode_get_bd_address(struct fwnode_handle *fwnode, u8 *addr, int alen)

How about using bdaddr_t instead? The original caller was casting it to u8
probably just because there was no function specifically for this purpose.

I wonder if this also should be made depend on CONFIG_BT. The fwnode
framework is unconditionally a part of the kernel and it's not very big at
the moment but adding stuff little by little will add up eventually.

> +{
> +	u8 buf[BD_ADDR_LEN];
> +	int ret;
> +
> +	if (alen != BD_ADDR_LEN)
> +		return -EINVAL;
> +
> +	ret = fwnode_property_read_u8_array(fwnode, "local-bd-address",
> +					    buf, alen);
> +	if (ret < 0)
> +		return ret;
> +	if (is_zero_ether_addr(buf))
> +		return -ENODATA;
> +
> +	memcpy(addr, buf, BD_ADDR_LEN);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(fwnode_get_bd_address);
> +
> +/**
> + * device_get_bd_address - Get the Bluetooth Device Address (BD_ADDR) for a
> + *                         given device
> + * @dev:	Pointer to the device
> + * @addr:	Address of buffer to store the BD address in
> + * @alen:	Length of the buffer pointed to by addr, should be BD_ADDR_LEN
> + */
> +int device_get_bd_address(struct device *dev, u8 *addr, int alen)
> +{
> +	return fwnode_get_bd_address(dev_fwnode(dev), addr, alen);
> +}
> +EXPORT_SYMBOL(device_get_bd_address);
> +
>  /**
>   * fwnode_irq_get - Get IRQ directly from a fwnode
>   * @fwnode:	Pointer to the firmware node
> diff --git a/include/linux/property.h b/include/linux/property.h
> index ac8a1ebc4c1b..4e2f1b276f4f 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -287,9 +287,13 @@ int device_get_phy_mode(struct device *dev);
>  
>  void *device_get_mac_address(struct device *dev, char *addr, int alen);
>  
> +int device_get_bd_address(struct device *dev, u8 *addr, int alen);
> +
>  int fwnode_get_phy_mode(struct fwnode_handle *fwnode);
>  void *fwnode_get_mac_address(struct fwnode_handle *fwnode,
>  			     char *addr, int alen);
> +int fwnode_get_bd_address(struct fwnode_handle *fwnode,
> +			  u8 *addr, int alen);

This would be a good opportunity to add a newline here, and avoid adding
one after device_get_mac_address().

>  struct fwnode_handle *fwnode_graph_get_next_endpoint(
>  	const struct fwnode_handle *fwnode, struct fwnode_handle *prev);
>  struct fwnode_handle *

-- 
Regards,

Sakari Ailus
sakari.ailus@linux.intel.com
