Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C4B1C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CA421775
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 10:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CA421775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388716AbeHGMTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 08:19:09 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57430 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726968AbeHGMTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 08:19:09 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5E177854F848C;
        Tue,  7 Aug 2018 18:05:30 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.41) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.399.0; Tue, 7 Aug 2018
 18:05:22 +0800
Subject: Re: [PATCH v3 1/4] ACPI / scan: Fix acpi_is_indirect_io_slave()
 always returning false
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>
References: <20180807080539.17811-1-hdegoede@redhat.com>
 <20180807080539.17811-2-hdegoede@redhat.com>
CC:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        <linux-acpi@vger.kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        <linux-i2c@vger.kernel.org>, <stable@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dann Frazier <dann.frazier@canonical.com>,
        Linuxarm <linuxarm@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <03dae627-a888-317a-ed43-6c374b1b54eb@huawei.com>
Date:   Tue, 7 Aug 2018 11:05:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180807080539.17811-2-hdegoede@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2018 09:05, Hans de Goede wrote:
> Since commit 63347db0affa ("ACPI / scan: Use acpi_bus_get_status() to
> initialize ACPI_TYPE_DEVICE devs") the status field of normal acpi_devices
> gets set to 0 by acpi_bus_type_and_status() and filled with its actual
> value later when acpi_add_single_object() calls acpi_bus_get_status().
>
> This means that status is 0 when acpi_device_enumeration_by_parent()
> gets called which makes the acpi_match_device_ids() call in
> acpi_is_indirect_io_slave() always return -ENOENT.

For for the (child) device the status may be zero, but how about the 
parent device (which is what we care about)? As I see, we would have set 
the parent device status present field at this stage.

Thanks,
John

>
> This commit fixes this by making acpi_bus_type_and_status() set status to
> ACPI_STA_DEFAULT until acpi_add_single_object() calls acpi_bus_get_status()
>
> Fixes: dfda4492322e ("ACPI / scan: Do not enumerate Indirect IO host children")
> Cc: stable@vger.kernel.org
> Cc: John Garry <john.garry@huawei.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Dann Frazier <dann.frazier@canonical.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/scan.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 970dd87d347c..6799d00dd790 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1612,7 +1612,8 @@ static int acpi_add_single_object(struct acpi_device **child,
>  	 * Note this must be done before the get power-/wakeup_dev-flags calls.
>  	 */
>  	if (type == ACPI_BUS_TYPE_DEVICE)
> -		acpi_bus_get_status(device);
> +		if (acpi_bus_get_status(device) < 0)
> +			acpi_set_device_status(device, 0);
>
>  	acpi_bus_get_power_flags(device);
>  	acpi_bus_get_wakeup_device_flags(device);
> @@ -1690,7 +1691,7 @@ static int acpi_bus_type_and_status(acpi_handle handle, int *type,
>  		 * acpi_add_single_object updates this once we've an acpi_device
>  		 * so that acpi_bus_get_status' quirk handling can be used.
>  		 */
> -		*sta = 0;
> +		*sta = ACPI_STA_DEFAULT;
>  		break;
>  	case ACPI_TYPE_PROCESSOR:
>  		*type = ACPI_BUS_TYPE_PROCESSOR;
>


