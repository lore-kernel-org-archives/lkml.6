Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26486C04EBA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E046020870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="INq2Ntk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E046020870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731247AbeKTIJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:09:56 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42025 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731082AbeKTIJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:09:55 -0500
Received: by mail-pf1-f193.google.com with SMTP id 64so11001120pfr.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 13:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=59SpcEBGDTbUjAhoGBNRiCVTfP9hvpXi6ZEQUqtN9nY=;
        b=INq2Ntk3CQHQPQkFepGAlZvnyrBuSstFBnmaYDtVq3Aq02ZY8V/bXtKIvBheMz/SOe
         wvthbhxD+N3oKo4wZnlRMS7LOvuloFEIcHcfa3e/5csf9NRCHNDYOWzzmxeRrXvfNgQj
         eXd9ETe8bsn3j3RDc95VNAaZ2Ikx0jTr8NMxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=59SpcEBGDTbUjAhoGBNRiCVTfP9hvpXi6ZEQUqtN9nY=;
        b=ctCYgGNRr+J6MDbgWxtWQ0LsFQVKSJqiV/zb4ljBgvUZnQdwldGuEeoQ0h6gHpODfR
         Rp0eq6C4kDmGWltwpgRDGdMDMxzbA/l/WpTLWCLyORe8mDdUpNRw8d9Y3MI1hbsO+3zo
         eEXd0hD0dDVnUpqE7hl/TRfqxf8BR//liiHlQjpMSFsNlcP85U/hBN/ED3MlhDcphOXs
         loBWNIyZk2lgRJ90aQXk7PsGcY+UXFfuP2A7ITKGuYNZJ7SG/tp7mBE/iuhsfrACxPYE
         GfmHcnVRtIbdS0W3MwxT2ygKCS/xTZW+0BZxLOrRT3tPg2P18jfM+2/dfXtJ3M8b2DxX
         pc2w==
X-Gm-Message-State: AGRZ1gLda1t8INUDMM9bHRTX9UE2++mXOqzw5L268ROZO4lUxh77UxuC
        fLb0KwL+2BKP9KtRmWOx/B6+Sw==
X-Google-Smtp-Source: AJdET5ex+V19mmP/60+6bs0oyIH4ge5EMxTJRIiRbAppKSHzaE8n7FIcrIDLfspY9vtPwWhule6rog==
X-Received: by 2002:a63:c503:: with SMTP id f3mr21104270pgd.431.1542663857331;
        Mon, 19 Nov 2018 13:44:17 -0800 (PST)
Received: from localhost ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id u69sm35162091pfj.116.2018.11.19.13.44.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 13:44:16 -0800 (PST)
Date:   Mon, 19 Nov 2018 13:44:15 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        Dmitry Grinberg <dmitrygr@google.com>
Subject: Re: [PATCH v2 1/3] Bluetooth: Add quirk for reading BD_ADDR from
 fwnode property
Message-ID: <20181119214415.GQ22824@google.com>
References: <20181030004415.237101-1-mka@chromium.org>
 <20181030004415.237101-2-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181030004415.237101-2-mka@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

is this in line with what you suggested at
https://lore.kernel.org/patchwork/patch/992280/#1183789 ?

Thanks

Matthias

On Mon, Oct 29, 2018 at 05:44:13PM -0700, Matthias Kaehlcke wrote:
> Add HCI_QUIRK_USE_BDADDR_PROPERTY to allow controllers to retrieve
> the public Bluetooth address from the firmware node property
> 'local-bd-address'. If quirk is set and the property does not exist
> or is invalid the controller is marked as unconfigured.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> Changes in v2:
> - added check for return value of ->setup()
> - only read BD_ADDR from the property if it isn't assigned yet. This
>   is needed to support configuration from user space
> - refactored the branch of the new quirk to get rid of 'bd_addr_set'
> - added 'Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>' tag
> ---
>  include/net/bluetooth/hci.h | 12 ++++++++++
>  net/bluetooth/hci_core.c    | 45 +++++++++++++++++++++++++++++++++++++
>  net/bluetooth/mgmt.c        |  6 +++--
>  3 files changed, 61 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index c36dc1e20556..fbba43e9bef5 100644
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
> index 7352fe85674b..d4149005a661 100644
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
> @@ -1355,6 +1356,36 @@ int hci_inquiry(void __user *arg)
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
> +static int hci_dev_get_bd_addr_from_property(struct hci_dev *hdev)
> +{
> +	struct fwnode_handle *fwnode = dev_fwnode(hdev->dev.parent);
> +	bdaddr_t ba;
> +	int ret;
> +
> +	ret = fwnode_property_read_u8_array(fwnode, "local-bd-address",
> +					    (u8 *)&ba, sizeof(ba));
> +	if (ret < 0)
> +		return ret;
> +	if (!bacmp(&ba, BDADDR_ANY))
> +		return -ENODATA;
> +
> +	hdev->public_addr = ba;
> +
> +	return 0;
> +}
> +
>  static int hci_dev_do_open(struct hci_dev *hdev)
>  {
>  	int ret = 0;
> @@ -1422,6 +1453,20 @@ static int hci_dev_do_open(struct hci_dev *hdev)
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
> +			if (!bacmp(&hdev->public_addr, BDADDR_ANY) ||
> +			    !hdev->set_bdaddr ||
> +			    hdev->set_bdaddr(hdev, &hdev->public_addr))
> +				hci_dev_set_flag(hdev, HCI_UNCONFIGURED);
> +		}
> +
> +setup_failed:
>  		/* The transport driver can set these quirks before
>  		 * creating the HCI device or in its setup callback.
>  		 *
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index ccce954f8146..fae84353d030 100644
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
