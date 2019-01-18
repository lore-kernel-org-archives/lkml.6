Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B62C1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14B9D2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lOWNJGgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfARVir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 16:38:47 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35592 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729595AbfARVir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 16:38:47 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so6903828plo.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 13:38:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nD9AXsHMsReXlxJOvTkuVVtJE+NgYYtgeRF+rQSNkvo=;
        b=lOWNJGgC8uz2Ol5EzJe/0VcyIGrQKPY/5ddax80v9wJboF1z9kN2u7pj8giXrpHunv
         m27sEYqxlT4YAnaXZD6lRUrCsZ1peXsfZ7ekJHnf576AcN7PzDiyCPf0FnvrQnp79Rnc
         O+7lIxyiY08127XtmK6pcTIKVGACVuVyjyQFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nD9AXsHMsReXlxJOvTkuVVtJE+NgYYtgeRF+rQSNkvo=;
        b=iQb5cNB1t61qROXKpysIMl2v0r9e6jyOt0Wykkej7OtbXdvXg2dGOF05B91iEtXEaU
         VnoJNA9LnYieMrmb56mb2XXtYAwy/PQjLpzG6aowUbQtTCTUjxKiQmOEwYwKe82p8136
         vX9rPH3257B4VZmIytyIMpchwHWbhihqpe9Vd+RuV9nBxQyYKF7pg8KtYPbDujJ68Nu2
         c6FSOv/qw2XtK2Hg22tmdDPXRW55Qu6K0pMnTOe1m+TsRUJJdPVAf+CtKTHU77opJhmb
         NlWKoHQOZoHH7hym9AF7OMe9XFMx85B8hx9DiqT1+qMzxoPK0Tt3EHasQPbYKJ0hC2Aq
         d6rQ==
X-Gm-Message-State: AJcUukeIw3ufxDkXQzlme6eRyzes0633+wwWKsHkuHRb43ebiHrxbqtQ
        G7mKlr+QBqoN/9KEjJuZBFMQjw==
X-Google-Smtp-Source: ALg8bN7LG49XgcxmIN5rTb6vB/LobJcLC3MDdoxuBXQaw7vVBLcuW34Q++xNMB0/ptvBMXd5h9JJBw==
X-Received: by 2002:a17:902:d891:: with SMTP id b17mr21011555plz.80.1547847526289;
        Fri, 18 Jan 2019 13:38:46 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 64sm10662033pff.101.2019.01.18.13.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 13:38:45 -0800 (PST)
Date:   Fri, 18 Jan 2019 13:38:44 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        Dmitry Grinberg <dmitrygr@google.com>
Subject: Re: [PATCH v3 1/3] Bluetooth: Add quirk for reading BD_ADDR from
 fwnode property
Message-ID: <20190118213844.GB261387@google.com>
References: <20181228220546.367-1-mka@chromium.org>
 <20181228220546.367-2-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181228220546.367-2-mka@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 02:05:44PM -0800, Matthias Kaehlcke wrote:
> Add HCI_QUIRK_USE_BDADDR_PROPERTY to allow controllers to retrieve
> the public Bluetooth address from the firmware node property
> 'local-bd-address'. If quirk is set and the property does not exist
> or is invalid the controller is marked as unconfigured.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> Tested-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> Changes in v3:
> - return no value from hci_dev_get_bd_addr_from_property() since
>   currently nobody uses it anyway
> - use bacpy() in hci_dev_get_bd_addr_from_property()
> - return -EADDRNOTAVAIL if no BD_ADDR is configured or if the driver
>   has no ->set_bdaddr
> 
> Changes in v2:
> - added check for return value of ->setup()
> - only read BD_ADDR from the property if it isn't assigned yet. This
>   is needed to support configuration from user space
> - refactored the branch of the new quirk to get rid of 'bd_addr_set'
> - added 'Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>' tag
> ---
>  include/net/bluetooth/hci.h | 12 +++++++++++
>  net/bluetooth/hci_core.c    | 43 +++++++++++++++++++++++++++++++++++++
>  net/bluetooth/mgmt.c        |  6 ++++--
>  3 files changed, 59 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index c36dc1e20556a..fbba43e9bef5b 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -158,6 +158,18 @@ enum {
>  	 */
>  	HCI_QUIRK_INVALID_BDADDR,
>  
> +	/* When this quirk is set, the public Bluetooth address
> +	 * initially reported by HCI Read BD Address command
> +	 * is considered invalid. The public BD Address can be
> +	 * specified in the fwnode property 'local-bd-address'.
> +	 * If this property does not exist or is invalid controller
> +	 * configuration is required before this device can be used.
> +	 *
> +	 * This quirk can be set before hci_register_dev is called or
> +	 * during the hdev->setup vendor callback.
> +	 */
> +	HCI_QUIRK_USE_BDADDR_PROPERTY,
> +
>  	/* When this quirk is set, the duplicate filtering during
>  	 * scanning is based on Bluetooth devices addresses. To allow
>  	 * RSSI based updates, restart scanning if needed.
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 7352fe85674be..3ccfa351b87bb 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -30,6 +30,7 @@
>  #include <linux/rfkill.h>
>  #include <linux/debugfs.h>
>  #include <linux/crypto.h>
> +#include <linux/property.h>
>  #include <asm/unaligned.h>
>  
>  #include <net/bluetooth/bluetooth.h>
> @@ -1355,6 +1356,32 @@ int hci_inquiry(void __user *arg)
>  	return err;
>  }
>  
> +/**
> + * hci_dev_get_bd_addr_from_property - Get the Bluetooth Device Address
> + *				       (BD_ADDR) for a HCI device from
> + *				       a firmware node property.
> + * @hdev:	The HCI device
> + *
> + * Search the firmware node for 'local-bd-address'.
> + *
> + * All-zero BD addresses are rejected, because those could be properties
> + * that exist in the firmware tables, but were not updated by the firmware. For
> + * example, the DTS could define 'local-bd-address', with zero BD addresses.
> + */
> +static void hci_dev_get_bd_addr_from_property(struct hci_dev *hdev)
> +{
> +	struct fwnode_handle *fwnode = dev_fwnode(hdev->dev.parent);
> +	bdaddr_t ba;
> +	int ret;
> +
> +	ret = fwnode_property_read_u8_array(fwnode, "local-bd-address",
> +					    (u8 *)&ba, sizeof(ba));
> +	if (ret < 0 || !bacmp(&ba, BDADDR_ANY))
> +		return;
> +
> +	bacpy(&hdev->public_addr, &ba);
> +}
> +
>  static int hci_dev_do_open(struct hci_dev *hdev)
>  {
>  	int ret = 0;
> @@ -1422,6 +1449,22 @@ static int hci_dev_do_open(struct hci_dev *hdev)
>  		if (hdev->setup)
>  			ret = hdev->setup(hdev);
>  
> +		if (ret)
> +			goto setup_failed;
> +
> +		if (test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) {
> +			if (!bacmp(&hdev->public_addr, BDADDR_ANY))
> +				hci_dev_get_bd_addr_from_property(hdev);
> +
> +			if (bacmp(&hdev->public_addr, BDADDR_ANY) &&
> +			    hdev->set_bdaddr)
> +				ret = hdev->set_bdaddr(hdev,
> +						       &hdev->public_addr);
> +			else
> +				ret = -EADDRNOTAVAIL;
> +		}
> +
> +setup_failed:
>  		/* The transport driver can set these quirks before
>  		 * creating the HCI device or in its setup callback.
>  		 *
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index ccce954f81468..fae84353d030f 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -551,7 +551,8 @@ static bool is_configured(struct hci_dev *hdev)
>  	    !hci_dev_test_flag(hdev, HCI_EXT_CONFIGURED))
>  		return false;
>  
> -	if (test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks) &&
> +	if ((test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks) ||
> +	     test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) &&
>  	    !bacmp(&hdev->public_addr, BDADDR_ANY))
>  		return false;
>  
> @@ -566,7 +567,8 @@ static __le32 get_missing_options(struct hci_dev *hdev)
>  	    !hci_dev_test_flag(hdev, HCI_EXT_CONFIGURED))
>  		options |= MGMT_OPTION_EXTERNAL_CONFIG;
>  
> -	if (test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks) &&
> +	if ((test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks) ||
> +	     test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) &&
>  	    !bacmp(&hdev->public_addr, BDADDR_ANY))
>  		options |= MGMT_OPTION_PUBLIC_ADDRESS;
>  

Marcel (et al), do you have any more comments on this series or
is it ready to land?

Thanks

Matthias
