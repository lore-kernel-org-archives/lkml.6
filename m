Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B5BC61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 19:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8532086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 19:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbfASTvP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 14:51:15 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:48338 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbfASTvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 14:51:12 -0500
Received: from marcel-macpro.fritz.box (p4FF9FD60.dip0.t-ipconnect.de [79.249.253.96])
        by mail.holtmann.org (Postfix) with ESMTPSA id C18DECF352;
        Sat, 19 Jan 2019 20:58:56 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v4 4/5] Bluetooth: btusb: Collect the common Intel
 assignments together
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190118223407.64818-4-rajatja@google.com>
Date:   Sat, 19 Jan 2019 20:51:10 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dtor@chromium.org>,
        Alex Hung <alex.hung@canonical.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        rajatxjain@gmail.com, dtor@google.com, raghuram.hegde@intel.com,
        chethan.tumkur.narayan@intel.com, sukumar.ghorai@intel.com
Content-Transfer-Encoding: 8BIT
Message-Id: <46DE7349-6B10-4B2F-92C2-74D6EEFFF301@holtmann.org>
References: <20181117010748.24347-1-rajatja@google.com>
 <20190118223407.64818-1-rajatja@google.com>
 <20190118223407.64818-4-rajatja@google.com>
To:     Rajat Jain <rajatja@google.com>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajat,

> The BTUSB_INTEL and BTUSB_INTEL_NEW have common functions & quirks are
> assigned to hdev structure. Lets collect them together instead of
> repeating them in different code branches.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v4: same as v1
> v3: same as v1
> v2: same as v1
> 
> drivers/bluetooth/btusb.c | 27 ++++++++++++---------------
> 1 file changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 4761499db9ee..59869643cc29 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3075,28 +3075,25 @@ static int btusb_probe(struct usb_interface *intf,
> 		data->diag = usb_ifnum_to_if(data->udev, ifnum_base + 2);
> 	}
> #endif
> +	if (id->driver_info & BTUSB_INTEL ||
> +	    id->driver_info & BTUSB_INTEL_NEW) {
> 
> -	if (id->driver_info & BTUSB_INTEL) {
> 		hdev->manufacturer = 2;
> -		hdev->setup = btusb_setup_intel;
> -		hdev->shutdown = btusb_shutdown_intel;
> -		hdev->set_diag = btintel_set_diag_mfg;
> 		hdev->set_bdaddr = btintel_set_bdaddr;
> 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
> 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
> 		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
> -	}
> 
> -	if (id->driver_info & BTUSB_INTEL_NEW) {
> -		hdev->manufacturer = 2;
> -		hdev->send = btusb_send_frame_intel;
> -		hdev->setup = btusb_setup_intel_new;
> -		hdev->hw_error = btintel_hw_error;
> -		hdev->set_diag = btintel_set_diag;
> -		hdev->set_bdaddr = btintel_set_bdaddr;
> -		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
> -		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
> -		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
> +		if (id->driver_info & BTUSB_INTEL) {
> +			hdev->setup = btusb_setup_intel;
> +			hdev->shutdown = btusb_shutdown_intel;
> +			hdev->set_diag = btintel_set_diag_mfg;
> +		} else {
> +			hdev->send = btusb_send_frame_intel;
> +			hdev->setup = btusb_setup_intel_new;
> +			hdev->hw_error = btintel_hw_error;
> +			hdev->set_diag = btintel_set_diag;
> +		}
> 	}

please scrap this patch since it is not making anything easier or simpler. You think it does, but it really doesn’t.

Regards

Marcel

