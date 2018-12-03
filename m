Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64471C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DCA20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34DCA20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbeLCMjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:39:22 -0500
Received: from mga11.intel.com ([192.55.52.93]:48552 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbeLCMjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:39:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Dec 2018 04:38:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,310,1539673200"; 
   d="scan'208";a="126616935"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 03 Dec 2018 04:38:24 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 03 Dec 2018 14:38:24 +0200
Date:   Mon, 3 Dec 2018 14:38:24 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Yu Chen <chenyu56@huawei.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, suzhuangluan@hisilicon.com,
        kongfei@hisilicon.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v1 08/12] usb: roles: Add usb role switch notifier.
Message-ID: <20181203123824.GE24338@kuha.fi.intel.com>
References: <20181203034515.91412-1-chenyu56@huawei.com>
 <20181203034515.91412-9-chenyu56@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203034515.91412-9-chenyu56@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 11:45:11AM +0800, Yu Chen wrote:
> This patch adds notifier for drivers want to be informed of the usb role switch.

I think in this case it would be good to explain a little for what we
need the notifier for.

> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> 
> --
> v0:
> The patch is provided by Heikki Krogerus. I modified and test it
> on Hikey960 platform.

I don't think I actually made a "patch" for this. The "diff" I made
showing the idea does not count, so you should not sign off the patch
with my address.

In this case I believe something like "Suggested-by" should be used
instead of SoB tag:

        Suggested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Side note: If this was from me, then there should be "from" line with
my address as well.

> --
> ---
>  drivers/usb/common/roles.c | 20 +++++++++++++++++++-
>  include/linux/usb/role.h   | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/common/roles.c b/drivers/usb/common/roles.c
> index 0f48090c5c30..bfd7a988b64c 100644
> --- a/drivers/usb/common/roles.c
> +++ b/drivers/usb/common/roles.c
> @@ -21,6 +21,7 @@ struct usb_role_switch {
>  	struct device dev;
>  	struct mutex lock; /* device lock*/
>  	enum usb_role role;
> +	struct blocking_notifier_head nh;
>  
>  	/* From descriptor */
>  	struct device *usb2_port;
> @@ -50,8 +51,10 @@ int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role)
>  	mutex_lock(&sw->lock);
>  
>  	ret = sw->set(sw->dev.parent, role);
> -	if (!ret)
> +	if (!ret) {
>  		sw->role = role;
> +		blocking_notifier_call_chain(&sw->nh, role, NULL);
> +	}
>  
>  	mutex_unlock(&sw->lock);
>  
> @@ -59,6 +62,20 @@ int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role)
>  }
>  EXPORT_SYMBOL_GPL(usb_role_switch_set_role);
>  
> +int usb_role_switch_register_notifier(struct usb_role_switch *sw,
> +				      struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_register(&sw->nh, nb);
> +}
> +EXPORT_SYMBOL_GPL(usb_role_switch_register_notifier);
> +
> +int usb_role_switch_unregister_notifier(struct usb_role_switch *sw,
> +					struct notifier_block *nb)
> +{
> +	return blocking_notifier_chain_unregister(&sw->nh, nb);
> +}
> +EXPORT_SYMBOL_GPL(usb_role_switch_unregister_notifier);
> +
>  /**
>   * usb_role_switch_get_role - Get the USB role for a switch
>   * @sw: USB role switch
> @@ -297,6 +314,7 @@ usb_role_switch_register(struct device *parent,
>  		return ERR_PTR(-ENOMEM);
>  
>  	mutex_init(&sw->lock);
> +	BLOCKING_INIT_NOTIFIER_HEAD(&sw->nh);
>  
>  	sw->allow_userspace_control = desc->allow_userspace_control;
>  	sw->usb2_port = desc->usb2_port;
> diff --git a/include/linux/usb/role.h b/include/linux/usb/role.h
> index edc51be4a77c..c97d4be91ada 100644
> --- a/include/linux/usb/role.h
> +++ b/include/linux/usb/role.h
> @@ -40,6 +40,8 @@ struct usb_role_switch_desc {
>  	bool allow_userspace_control;
>  };
>  
> +
> +#if IS_ENABLED(CONFIG_USB_ROLE_SWITCH)
>  int usb_role_switch_set_role(struct usb_role_switch *sw, enum usb_role role);
>  enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw);
>  struct usb_role_switch *usb_role_switch_get(struct device *dev);
> @@ -49,5 +51,49 @@ struct usb_role_switch *
>  usb_role_switch_register(struct device *parent,
>  			 const struct usb_role_switch_desc *desc);
>  void usb_role_switch_unregister(struct usb_role_switch *sw);
> +int usb_role_switch_register_notifier(struct usb_role_switch *sw,
> +				      struct notifier_block *nb);
> +int usb_role_switch_unregister_notifier(struct usb_role_switch *sw,
> +					struct notifier_block *nb);
> +#else
> +static inline int usb_role_switch_set_role(struct usb_role_switch *sw,
> +		enum usb_role role)
> +{
> +	return 0;
> +}
> +
> +static inline enum usb_role usb_role_switch_get_role(struct usb_role_switch *sw)
> +{
> +	return USB_ROLE_NONE;
> +}
> +
> +static inline struct usb_role_switch *usb_role_switch_get(struct device *dev)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
> +static inline void usb_role_switch_put(struct usb_role_switch *sw) { }
> +
> +static inline struct usb_role_switch *
> +usb_role_switch_register(struct device *parent,
> +			 const struct usb_role_switch_desc *desc)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
> +static inline void usb_role_switch_unregister(struct usb_role_switch *sw) { }
> +
> +static int usb_role_switch_register_notifier(struct usb_role_switch *sw,
> +				      struct notifier_block *nb)
> +{
> +	return -ENODEV;
> +}
> +
> +static int usb_role_switch_unregister_notifier(struct usb_role_switch *sw,
> +					struct notifier_block *nb)
> +{
> +	return -ENODEV;
> +}
> +#endif
>  
>  #endif /* __LINUX_USB_ROLE_H */
> -- 
> 2.15.0-rc2

thanks,

-- 
heikki
