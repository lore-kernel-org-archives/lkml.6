Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965238AbeBMRVn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:21:43 -0500
Received: from esa6.dell-outbound.iphmx.com ([68.232.149.229]:31297 "EHLO
        esa6.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964849AbeBMRVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:21:41 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HmAQA+HoNahz+a6ERdGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQogQAoCpwlggKBF4d/j3sDXAqFOwKCaFgUAQIBAQEBAQECAQI?=
 =?us-ascii?q?QAQEBCgsJCCgvgjgigkoBAQEEJxM/DAQCAQgRBAEBHwkHISUJCAIEAQ0FCIoVA?=
 =?us-ascii?q?xWyIDqHPQ2BMoIRAQEBAQEBAQMBAQEBAQEBAQEBAR2FAYIVhm2Ca4I+hXUFo3k?=
 =?us-ascii?q?1CZB6hQGUTY5KiU6BPDZVgR5wgxiCZSWBbXgBjSSBFwEBAQ?=
X-IPAS-Result: =?us-ascii?q?A2HmAQA+HoNahz+a6ERdGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?ogQAoCpwlggKBF4d/j3sDXAqFOwKCaFgUAQIBAQEBAQECAQIQAQEBCgsJCCgvg?=
 =?us-ascii?q?jgigkoBAQEEJxM/DAQCAQgRBAEBHwkHISUJCAIEAQ0FCIoVAxWyIDqHPQ2BMoI?=
 =?us-ascii?q?RAQEBAQEBAQMBAQEBAQEBAQEBAR2FAYIVhm2Ca4I+hXUFo3k1CZB6hQGUTY5Ki?=
 =?us-ascii?q?U6BPDZVgR5wgxiCZSWBbXgBjSSBFwEBAQ?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.198
X-IronPort-AV: E=Sophos;i="5.46,508,1511848800";
   d="scan'208";a="1050286760"
X-DLP: DLP_GlobalPCIDSS
To: <mika.westerberg@linux.intel.com>, <linux-kernel@vger.kernel.org>
CC: <andreas.noever@gmail.com>, <michael.jamet@intel.com>,
        <yehezkel.bernat@intel.com>, <bhelgaas@google.com>,
        <radion.mirchevsky@intel.com>
Subject: RE: [PATCH 06/18] thunderbolt: Wait a bit longer for ICM to
 authenticate the active NVM
Thread-Topic: [PATCH 06/18] thunderbolt: Wait a bit longer for ICM to
 authenticate the active NVM
Thread-Index: AQHTpOw/wyHt0G7LQECtw3Pv104jiaOik+dg
Date: Tue, 13 Feb 2018 17:21:33 +0000
Message-ID: <a4e11e8dcec643d7bce1d8b1f9fc2c89@ausx13mpc120.AMER.DELL.COM>
References: <20180213170018.9780-1-mika.westerberg@linux.intel.com>
 <20180213170018.9780-7-mika.westerberg@linux.intel.com>
In-Reply-To: <20180213170018.9780-7-mika.westerberg@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.242.75]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1DHLlYJ029330

> -----Original Message-----
> From: Mika Westerberg [mailto:mika.westerberg@linux.intel.com]
> Sent: Tuesday, February 13, 2018 11:00 AM
> To: linux-kernel@vger.kernel.org
> Cc: Andreas Noever <andreas.noever@gmail.com>; Michael Jamet
> <michael.jamet@intel.com>; Yehezkel Bernat <yehezkel.bernat@intel.com>; Bjorn
> Helgaas <bhelgaas@google.com>; Limonciello, Mario
> <Mario_Limonciello@Dell.com>; Radion Mirchevsky
> <radion.mirchevsky@intel.com>; Mika Westerberg
> <mika.westerberg@linux.intel.com>
> Subject: [PATCH 06/18] thunderbolt: Wait a bit longer for ICM to authenticate the
> active NVM
> 
> Sometimes during cold boot ICM has not yet authenticated the active NVM
> image leading to timeout and failing the driver probe. Allow ICM to take
> some more time and increase the timeout to 3 seconds before we give up.
> 
> While there fix icm_firmware_init() to return the real error code
> without overwriting it with -ENODEV.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/thunderbolt/icm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
> index 1183321586c5..611d28e8e5f2 100644
> --- a/drivers/thunderbolt/icm.c
> +++ b/drivers/thunderbolt/icm.c
> @@ -736,14 +736,14 @@ static bool icm_ar_is_supported(struct tb *tb)
>  static int icm_ar_get_mode(struct tb *tb)
>  {
>  	struct tb_nhi *nhi = tb->nhi;
> -	int retries = 5;
> +	int retries = 60;
>  	u32 val;
> 
>  	do {
>  		val = ioread32(nhi->iobase + REG_FW_STS);
>  		if (val & REG_FW_STS_NVM_AUTH_DONE)
>  			break;
> -		msleep(30);
> +		msleep(50);
>  	} while (--retries);
> 
>  	if (!retries) {
> @@ -1063,6 +1063,9 @@ static int icm_firmware_init(struct tb *tb)
>  			break;
> 
>  		default:
> +			if (ret < 0)
> +				return ret;
> +
>  			tb_err(tb, "ICM firmware is in wrong mode: %u\n", ret);
>  			return -ENODEV;
>  		}
> --
> 2.15.1

Mika,

Some of your patches in this series already have the stable tag, but I think 
especially this one is probably a good candidate to add to @stable.
