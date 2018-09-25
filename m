Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95B6C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C5CF2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C5CF2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeIZDnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:43:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:12119 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbeIZDnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:43:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 14:33:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,303,1534834800"; 
   d="scan'208";a="235894319"
Received: from ymargoli-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.2.174])
  by orsmga004.jf.intel.com with ESMTP; 25 Sep 2018 14:33:23 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id 4418221E3F; Wed, 26 Sep 2018 00:33:22 +0300 (EEST)
Date:   Wed, 26 Sep 2018 00:33:22 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v3.1 1/2] device property: Add device_get_bd_address()
 and fwnode_get_bd_address()
Message-ID: <20180925213321.buotrpzlvokem24n@kekkonen.localdomain>
References: <20180925191014.85573-1-mka@chromium.org>
 <20180925191014.85573-2-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180925191014.85573-2-mka@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Tue, Sep 25, 2018 at 12:10:13PM -0700, Matthias Kaehlcke wrote:
> Provide an API for Bluetooth drivers to retrieve the Bluetooth Device
> address (BD_ADDR) for a device. If the device node has a property
> 'local-bd-address' the BD address is read from this property.
> 
> The definition of bdaddr_t is moved to types.h to make it visible in
> property.h without having to include (the mostly unrelated) bluetooth.h
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
> Changes in v3:
> - move definition of bdaddr_t to types.h to avoid include of
>   bluetooth.h from property.h
> - add stubs for the new functions
> 
> Changes in v2:
> - use bdaddr_t instead of byte pointer + len
> - use EXPORT_SYMBOL_GPL for the new functions instead of EXPORT_SYMBOL
> - put new functions inside #if IS_ENABLED(CONFIG_BT)
> - some new line juggling in property.h
> - added 'Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>' tag
> ---
>  drivers/base/property.c           | 46 +++++++++++++++++++++++++++++++
>  include/linux/property.h          | 18 ++++++++++++
>  include/linux/types.h             |  5 ++++
>  include/net/bluetooth/bluetooth.h |  5 ----
>  4 files changed, 69 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 240ab5230ff6..afe412133188 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -1315,6 +1315,52 @@ void *device_get_mac_address(struct device *dev, char *addr, int alen)
>  }
>  EXPORT_SYMBOL(device_get_mac_address);
>  
> +#if IS_ENABLED(CONFIG_BT)
> +
> +/**
> + * fwnode_get_bd_address - Get the Bluetooth Device Address (BD_ADDR) from the
> + *                         firmware node
> + * @fwnode:	Pointer to the firmware node
> + * @bd_addr:	Pointer to struct to store the BD address in
> + *
> + * Search the firmware node for 'local-bd-address'.
> + *
> + * All-zero BD addresses are rejected, because those could be properties
> + * that exist in the firmware tables, but were not updated by the firmware. For
> + * example, the DTS could define 'local-bd-address', with zero BD addresses.
> + */
> +int fwnode_get_bd_address(struct fwnode_handle *fwnode, bdaddr_t *bd_addr)
> +{
> +	bdaddr_t ba;
> +	int ret;
> +
> +	ret = fwnode_property_read_u8_array(fwnode, "local-bd-address",
> +					    (u8 *)&ba, sizeof(bdaddr_t));

sizeof(ba)

> +	if (ret < 0)
> +		return ret;
> +	if (is_zero_ether_addr((u8 *)&ba))
> +		return -ENODATA;
> +
> +	memcpy(bd_addr, &ba, sizeof(bdaddr_t));

How about simply:

	*bd_addr = ba;

Either way,

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(fwnode_get_bd_address);
> +
> +/**
> + * device_get_bd_address - Get the Bluetooth Device Address (BD_ADDR) for a
> + *                         given device
> + * @dev:	Pointer to the device
> + * @bd_addr:	Pointer to struct to store the BD address in
> + */
> +int device_get_bd_address(struct device *dev, bdaddr_t *bd_addr)
> +{
> +	return fwnode_get_bd_address(dev_fwnode(dev), bd_addr);
> +}
> +EXPORT_SYMBOL_GPL(device_get_bd_address);
> +
> +#endif
> +
>  /**
>   * fwnode_irq_get - Get IRQ directly from a fwnode
>   * @fwnode:	Pointer to the firmware node
> diff --git a/include/linux/property.h b/include/linux/property.h
> index ac8a1ebc4c1b..5df4e0bd8c83 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -286,10 +286,28 @@ const void *device_get_match_data(struct device *dev);
>  int device_get_phy_mode(struct device *dev);
>  
>  void *device_get_mac_address(struct device *dev, char *addr, int alen);
> +#if IS_ENABLED(CONFIG_BT)
> +int device_get_bd_address(struct device *dev, bdaddr_t *bd_addr);
> +#else
> +static inline int device_get_bd_address(struct device *dev,
> +					bdaddr_t *bd_addr)
> +{
> +	return -ENOTSUPP;
> +}
> +#endif
>  
>  int fwnode_get_phy_mode(struct fwnode_handle *fwnode);
>  void *fwnode_get_mac_address(struct fwnode_handle *fwnode,
>  			     char *addr, int alen);
> +#if IS_ENABLED(CONFIG_BT)
> +int fwnode_get_bd_address(struct fwnode_handle *fwnode, bdaddr_t *bd_addr);
> +#else
> +static inline int fwnode_get_bd_address(struct fwnode_handle *fwnode,
> +					bdaddr_t *bd_addr)
> +{
> +	return -ENOTSUPP;
> +}
> +#endif
>  struct fwnode_handle *fwnode_graph_get_next_endpoint(
>  	const struct fwnode_handle *fwnode, struct fwnode_handle *prev);
>  struct fwnode_handle *
> diff --git a/include/linux/types.h b/include/linux/types.h
> index 9834e90aa010..ff6984a00a3b 100644
> --- a/include/linux/types.h
> +++ b/include/linux/types.h
> @@ -230,5 +230,10 @@ struct callback_head {
>  typedef void (*rcu_callback_t)(struct rcu_head *head);
>  typedef void (*call_rcu_func_t)(struct rcu_head *head, rcu_callback_t func);
>  
> +/* Bluetooth Device Address (BD_ADDR) */
> +typedef struct {
> +	__u8 b[6];
> +} __packed bdaddr_t;
> +
>  #endif /*  __ASSEMBLY__ */
>  #endif /* _LINUX_TYPES_H */
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index ec9d6bc65855..9401c7431a8f 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -190,11 +190,6 @@ static inline const char *state_to_string(int state)
>  	return "invalid state";
>  }
>  
> -/* BD Address */
> -typedef struct {
> -	__u8 b[6];
> -} __packed bdaddr_t;
> -
>  /* BD Address type */
>  #define BDADDR_BREDR		0x00
>  #define BDADDR_LE_PUBLIC	0x01

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
