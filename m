Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751230AbeFDUhd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:37:33 -0400
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:52052 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750879AbeFDUhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:37:32 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FGAQBwohVbmGOa6ERcGgEBAQEBAgEBA?=
 =?us-ascii?q?QEIAQEBAYQXgQ0oCphfgXmUS4F4C4RsAoIRITUXAQIBAQEBAQECAQECEAEBAQE?=
 =?us-ascii?q?BCAsLBigvgjUiglMBAQEEJxM/DAQCAQgRBAEBHwkHRgkIAgQBDQUIgxqCAahOM?=
 =?us-ascii?q?4hBgWiIQoITgQ+DDYpHAphuBwKOW4FEg3iHZpEfgUMCggdwUIJDgiAOCY4Xb41?=
 =?us-ascii?q?/gRkBAQ?=
X-IPAS-Result: =?us-ascii?q?A2FGAQBwohVbmGOa6ERcGgEBAQEBAgEBAQEIAQEBAYQXgQ0?=
 =?us-ascii?q?oCphfgXmUS4F4C4RsAoIRITUXAQIBAQEBAQECAQECEAEBAQEBCAsLBigvgjUig?=
 =?us-ascii?q?lMBAQEEJxM/DAQCAQgRBAEBHwkHRgkIAgQBDQUIgxqCAahOM4hBgWiIQoITgQ+?=
 =?us-ascii?q?DDYpHAphuBwKOW4FEg3iHZpEfgUMCggdwUIJDgiAOCY4Xb41/gRkBAQ?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.187
X-IronPort-AV: E=Sophos;i="5.49,477,1520917200";
   d="scan'208";a="201079798"
X-DLP: DLP_GlobalPCIDSS
To: <benjamin.tissoires@redhat.com>, <jikos@kernel.org>
CC: <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] HID: core: allow concurrent registration of drivers
Thread-Topic: [PATCH] HID: core: allow concurrent registration of drivers
Thread-Index: AQHT+NV5fk+195GLLUuRdr+lgJ0afaRQlLQQ
Date: Mon, 4 Jun 2018 20:37:30 +0000
Message-ID: <4635b69c79704cc3beee5f97d9e739f2@ausx13mpc120.AMER.DELL.COM>
References: <20180531114929.30545-1-benjamin.tissoires@redhat.com>
In-Reply-To: <20180531114929.30545-1-benjamin.tissoires@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w54Kbbf4011054

Benjamin,

I had to make a minor change since I didn't see
>  #define HID_STAT_DUP_DETECTED	BIT(2)
In Linus's tree.

I tested with master today though and it seems to be working now with your patch across
several boot attempts.

Tested-by: Mario Limonciello <mario.limonciello@dell.com>

Thanks,

> -----Original Message-----
> From: Benjamin Tissoires [mailto:benjamin.tissoires@redhat.com]
> Sent: Thursday, May 31, 2018 6:49 AM
> To: Jiri Kosina; Limonciello, Mario
> Cc: linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Benjamin Tissoires
> Subject: [PATCH] HID: core: allow concurrent registration of drivers
> 
> Detected on the Dell XPS 9365.
> The laptop has 2 devices that benefit from the hid-generic auto-unbinding.
> When those 2 devices are presented to the userspace, udev loads both
> wacom and hid-multitouch. When this happens, the code in
> __hid_bus_reprobe_drivers() is called concurrently and the second device
> gets reprobed twice.
> An other bug in the power_supply subsystem prevent to remove the wacom
> driver if it just finished its initialization, which basically kills
> the wacom node.
> 
> Fixes c17a7476e4c4 ("HID: core: rewrite the hid-generic automatic unbind")
> 
> Cc: stable@vger.kernel.org # v4.17
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
> 
> Hi Mario,
> 
> can you please test this on your faulty XPS?
> I think it'll fix the issue, but I can not reproduce, so better wait for
> your confirmation.
> 
> Jiri, ideally I would love to see this in v4.17 final, but Mario seems
> to be on PTO until next week. I guess we'll just push this in v4.17.1
> then. Also, if you can double check that it makes sense, that would be
> nice :)
> 
> Cheers,
> Benjamin
> 
>  drivers/hid/hid-core.c | 5 ++++-
>  include/linux/hid.h    | 3 ++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 2f7367b1de00..7afed0c0f9e5 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1960,6 +1960,8 @@ static int hid_device_probe(struct device *dev)
>  	}
>  	hdev->io_started = false;
> 
> +	clear_bit(ffs(HID_STAT_REPROBED), &hdev->status);
> +
>  	if (!hdev->driver) {
>  		id = hid_match_device(hdev, hdrv);
>  		if (id == NULL) {
> @@ -2223,7 +2225,8 @@ static int __hid_bus_reprobe_drivers(struct device *dev,
> void *data)
>  	struct hid_device *hdev = to_hid_device(dev);
> 
>  	if (hdev->driver == hdrv &&
> -	    !hdrv->match(hdev, hid_ignore_special_drivers))
> +	    !hdrv->match(hdev, hid_ignore_special_drivers) &&
> +	    !test_and_set_bit(ffs(HID_STAT_REPROBED), &hdev->status))
>  		return device_reprobe(dev);
> 
>  	return 0;
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index ee2510019033..aee281522c6d 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -517,6 +517,7 @@ struct hid_output_fifo {
>  #define HID_STAT_ADDED		BIT(0)
>  #define HID_STAT_PARSED		BIT(1)
>  #define HID_STAT_DUP_DETECTED	BIT(2)
> +#define HID_STAT_REPROBED	BIT(3)
> 
>  struct hid_input {
>  	struct list_head list;
> @@ -585,7 +586,7 @@ struct hid_device {
> 		/* device report descriptor */
>  	bool battery_avoid_query;
>  #endif
> 
> -	unsigned int status;						/* see
> STAT flags above */
> +	unsigned long status;						/* see
> STAT flags above */
>  	unsigned claimed;						/*
> Claimed by hidinput, hiddev? */
>  	unsigned quirks;						/* Various
> quirks the device can pull on us */
>  	bool io_started;						/* If IO has started
> */
> --
> 2.14.3
