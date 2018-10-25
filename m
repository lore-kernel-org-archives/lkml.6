Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F81C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D57A2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZZFJajWa";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="m/RPXc9b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D57A2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeJYXJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:09:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44910 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbeJYXJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:09:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E1AF6611F1; Thu, 25 Oct 2018 14:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540478200;
        bh=3UKG10o133NKydqUq8poZ6iJlVE/J5xxD9EfCIBkGJo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZZFJajWalZdq1wSpIjuXBoFEGV7fXZivhE9jrSeEFyE7w33jLz5YJUqxquQP8Q3Lm
         uqSUE7sZjx+NZXAF630ZLtRaG62PPJmWZMw+M7A4/SyuOInj0yWIgd1nfRWL+yixSH
         uyP8yTH//M+VYtg6PwcTtcNIVuBbsPpnstVbDSLw=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 3A85B60246;
        Thu, 25 Oct 2018 14:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1540478199;
        bh=3UKG10o133NKydqUq8poZ6iJlVE/J5xxD9EfCIBkGJo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m/RPXc9b5FWG7Hw10RGbIPvTrlnkFDcyrsMUzrxbOystsYYMj8XggtGxEpw5/fuia
         /87LksqN1DccxWMj3baF5Z8K3jyDFVnpuX9cF49HR4fqPAeqb5sb9JwEoWsdvdQpbd
         3T6nbyMziP6Wz5Guytd/KyTNnVGqf2F8gHaM5Seo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 25 Oct 2018 20:06:39 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Dmitry Grinberg <dmitrygr@google.com>
Subject: Re: [PATCH 1/2] Bluetooth: Add quirk for reading BD_ADDR from fwnode
 property
In-Reply-To: <20181025002134.256791-2-mka@chromium.org>
References: <20181025002134.256791-1-mka@chromium.org>
 <20181025002134.256791-2-mka@chromium.org>
Message-ID: <4041ef05cdd70d28d665d3288c4d4c43@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-25 05:51, Matthias Kaehlcke wrote:
> Add HCI_QUIRK_USE_BDADDR_PROPERTY to allow controllers to retrieve
> the public Bluetooth address from the firmware node property
> 'local-bd-address'. If quirk is set and the property does not exist
> or is invalid the controller is marked as unconfigured.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> hci_dev_get_bd_addr_from_property() currently assumes that the
> firmware node with 'local-bd-address' is from hdev->dev.parent, not
> sure if this universally true. However if it is true for existing
> device that might use this interface we can assume this for now
> (unless there is a clear solution now), and cross the bridge of
> finding an alternative when we actually encounter the situation.
> One option could be to look for the first parent that has a fwnode.
> ---
>  include/net/bluetooth/hci.h | 12 +++++++++++
>  net/bluetooth/hci_core.c    | 42 +++++++++++++++++++++++++++++++++++++
>  net/bluetooth/mgmt.c        |  6 ++++--
>  3 files changed, 58 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index cdd9f1fe7cfa..a5d748099752 100644
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
> index 74b29c7d841c..97214262c4fb 100644
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
> @@ -1355,9 +1356,40 @@ int hci_inquiry(void __user *arg)
>  	return err;
>  }
> 
> +/**
> + * hci_dev_get_bd_addr_from_property - Get the Bluetooth Device 
> Address
> + *				       (BD_ADDR) for a HCI device from
> + *				       a firmware node property.
> + * @hdev:	The HCI device
> + *
> + * Search the firmware node for 'local-bd-address'.
> + *
> + * All-zero BD addresses are rejected, because those could be 
> properties
> + * that exist in the firmware tables, but were not updated by the 
> firmware. For
> + * example, the DTS could define 'local-bd-address', with zero BD 
> addresses.
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
> +	bool bd_addr_set = false;
> 
>  	BT_DBG("%s %p", hdev->name, hdev);
> 
> @@ -1422,6 +1454,16 @@ static int hci_dev_do_open(struct hci_dev *hdev)
>  		if (hdev->setup)
>  			ret = hdev->setup(hdev);
> 
> +		if (test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) {
> +			if (!hci_dev_get_bd_addr_from_property(hdev))
> +				if (hdev->set_bdaddr &&
> +				    !hdev->set_bdaddr(hdev, &hdev->public_addr))
> +					bd_addr_set = true;
> +
> +			if (!bd_addr_set)
> +				hci_dev_set_flag(hdev, HCI_UNCONFIGURED);
> +		}
> +
>  		/* The transport driver can set these quirks before
>  		 * creating the HCI device or in its setup callback.
>  		 *
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 3bdc8f3ca259..3d9edb752403 100644
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
> @@ -566,7 +567,8 @@ static __le32 get_missing_options(struct hci_dev 
> *hdev)
>  	    !hci_dev_test_flag(hdev, HCI_EXT_CONFIGURED))
>  		options |= MGMT_OPTION_EXTERNAL_CONFIG;
> 
> -	if (test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks) &&
> +	if ((test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks) ||
> +	     test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) &&
>  	    !bacmp(&hdev->public_addr, BDADDR_ANY))
>  		options |= MGMT_OPTION_PUBLIC_ADDRESS;

Looks fine to me.

Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
-- 
Regards
Balakrishna.
