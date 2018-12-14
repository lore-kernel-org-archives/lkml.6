Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45224C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A02208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:04:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A02208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbeLNNEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:04:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51534 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbeLNNEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:04:11 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E91C87F6D0;
        Fri, 14 Dec 2018 13:04:10 +0000 (UTC)
Received: from [10.72.12.27] (ovpn-12-27.pek2.redhat.com [10.72.12.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B9AA46714A;
        Fri, 14 Dec 2018 13:04:08 +0000 (UTC)
Subject: Re: r8152: Add support for MAC address pass through on RTL8153-BND
To:     Mario Limonciello <mario.limonciello@dell.com>,
        David Miller <davem@davemloft.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux USB <linux-usb@vger.kernel.org>,
        anthony.wong@canonical.com
References: <1544537774-4370-1-git-send-email-mario.limonciello@dell.com>
From:   Perry Yuan <pyuan@redhat.com>
Message-ID: <a7efd0ef-8729-4257-9059-3c06d4828e7e@redhat.com>
Date:   Fri, 14 Dec 2018 21:04:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <1544537774-4370-1-git-send-email-mario.limonciello@dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 14 Dec 2018 13:04:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/18 10:16 PM, Mario Limonciello wrote:
> All previous docks and dongles that have supported this feature use
> the RTL8153-AD chip.
>
> RTL8153-BND is a new chip that will be used in upcoming Dell type-C docks.
> It should be added to the whitelist of devices to activate MAC address
> pass through.
>
> Per confirming with Realtek all devices containing RTL8153-BND should
> activate MAC pass through and there won't use pass through bit on efuse
> like in RTL8153-AD.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> ---
>   drivers/net/usb/r8152.c | 33 ++++++++++++++++++++++-----------
>   1 file changed, 22 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index f1b5201..60dd1ec 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -129,6 +129,7 @@
>   #define USB_UPS_CTRL		0xd800
>   #define USB_POWER_CUT		0xd80a
>   #define USB_MISC_0		0xd81a
> +#define USB_MISC_1		0xd81f
>   #define USB_AFE_CTRL2		0xd824
>   #define USB_UPS_CFG		0xd842
>   #define USB_UPS_FLAGS		0xd848
> @@ -555,6 +556,7 @@ enum spd_duplex {
>   
>   /* MAC PASSTHRU */
>   #define AD_MASK			0xfee0
> +#define BND_MASK		0x0004
>   #define EFUSE			0xcfdb
>   #define PASS_THRU_MASK		0x1
>   
> @@ -1150,7 +1152,7 @@ static int rtl8152_set_mac_address(struct net_device *netdev, void *p)
>   	return ret;
>   }
>   
> -/* Devices containing RTL8153-AD can support a persistent
> +/* Devices containing proper chips can support a persistent
>    * host system provided MAC address.
>    * Examples of this are Dell TB15 and Dell WD15 docks
>    */
> @@ -1165,13 +1167,23 @@ static int vendor_mac_passthru_addr_read(struct r8152 *tp, struct sockaddr *sa)
>   
>   	/* test for -AD variant of RTL8153 */
>   	ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_MISC_0);
> -	if ((ocp_data & AD_MASK) != 0x1000)
> -		return -ENODEV;
> -
> -	/* test for MAC address pass-through bit */
> -	ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, EFUSE);
> -	if ((ocp_data & PASS_THRU_MASK) != 1)
> -		return -ENODEV;
> +	if ((ocp_data & AD_MASK) == 0x1000) {
> +		/* test for MAC address pass-through bit */
> +		ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, EFUSE);
> +		if ((ocp_data & PASS_THRU_MASK) != 1) {
> +			netif_dbg(tp, probe, tp->netdev,
> +				  "No efuse for RTL8153-AD MAC pass through\n");
> +			return -ENODEV;
> +		}
> +	} else {
> +		/* test for RTL8153-BND */
> +		ocp_data = ocp_read_byte(tp, MCU_TYPE_USB, USB_MISC_1);
> +		if ((ocp_data & BND_MASK) == 0) {
> +			netif_dbg(tp, probe, tp->netdev,
> +				  "Invalid variant for MAC pass through\n");
> +			return -ENODEV;
> +		}
> +	}
>   
>   	/* returns _AUXMAC_#AABBCCDDEEFF# */
>   	status = acpi_evaluate_object(NULL, "\\_SB.AMAC", NULL, &buffer);
> @@ -1217,9 +1229,8 @@ static int set_ethernet_addr(struct r8152 *tp)
>   	if (tp->version == RTL_VER_01) {
>   		ret = pla_ocp_read(tp, PLA_IDR, 8, sa.sa_data);
>   	} else {
> -		/* if this is not an RTL8153-AD, no eFuse mac pass thru set,
> -		 * or system doesn't provide valid _SB.AMAC this will be
> -		 * be expected to non-zero
> +		/* if device doesn't support MAC pass through this will
> +		 * be expected to be non-zero
>   		 */
>   		ret = vendor_mac_passthru_addr_read(tp, &sa);
>   		if (ret < 0)

Tested-by : Perry Yuan <pyuan@redhat.com>

