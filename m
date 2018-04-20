Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755003AbeDTNgp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:36:45 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57067 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754898AbeDTNgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:36:43 -0400
Subject: Re: [RFC PATCH 2/2] HISI LPC: Add PNP device support
To: Mika Westerberg <mika.westerberg@linux.intel.com>
References: <1524218846-169934-1-git-send-email-john.garry@huawei.com>
 <1524218846-169934-3-git-send-email-john.garry@huawei.com>
 <20180420131229.GW2173@lahna.fi.intel.com>
CC: <rjw@rjwysocki.net>, <andriy.shevchenko@linux.intel.com>,
        <linux-acpi@vger.kernel.org>, <lenb@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <graeme.gregory@linaro.org>, <helgaas@kernel.org>,
        <linuxarm@huawei.com>, <z.liuxinliang@hisilicon.com>
From: John Garry <john.garry@huawei.com>
Message-ID: <269650cd-e167-a124-3f0e-a598b5ed82c6@huawei.com>
Date: Fri, 20 Apr 2018 14:36:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180420131229.GW2173@lahna.fi.intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mika,

>>  /*
>> @@ -469,8 +472,11 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
>>  	struct acpi_device *child;
>>  	int size, ret, count = 0, cell_num = 0;
>>
>> -	list_for_each_entry(child, &adev->children, node)
>> +	list_for_each_entry(child, &adev->children, node) {
>> +		if (acpi_is_pnp_device(child))
>> +			continue;
>>  		cell_num++;
>> +	}
>>
>>  	/* allocate the mfd cell and companion ACPI info, one per child */
>>  	size = sizeof(*mfd_cells) + sizeof(*hisi_lpc_mfd_cells);
>> @@ -492,6 +498,9 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
>>  			.pnpid = pnpid,
>>  		};
>>
>> +		if (acpi_is_pnp_device(child))
>> +			continue;
>> +
>>  		/*
>>  		 * For any instances of this host controller (Hip06 and Hip07
>>  		 * are the only chipsets), we would not have multiple slaves
>> @@ -523,6 +532,33 @@ static int hisi_lpc_acpi_probe(struct device *hostdev)
>>  		return ret;
>>  	}
>>
>> +	list_for_each_entry(child, &adev->children, node) {
>> +		struct pnp_resource *pnp_res;
>> +		struct pnp_dev *pnp_dev;
>> +		int rc;
>> +
>> +		if (!acpi_is_pnp_device(child))
>> +			continue;
>> +
>> +		pnp_dev = child->driver_data;
>
> ...or better yet a PNP helper function that makes this more
> understandable.

Sure, but I would not say the helper function would do the same, due to 
to (ab)use of driver_data element. As I mentioned in patch 1/2, I 
couldn't see a current method for the acpi_device to reference the PNP 
device.

>
>> +
>> +		/*
>> +		 * Prior to adding the device, we need to translate the
>> +		 * resources to logical PIO addresses.
>> +		 */
>> +		list_for_each_entry(pnp_res, &pnp_dev->resources, list) {
>> +			struct resource *res = &pnp_res->res;
>> +
>> +			if (res->flags | IORESOURCE_IO)
>
> I think you should use
>
> 	if (resource_type(res) == IORESOURCE_IO)
>
> instead.

Yes, since I don't know the difference between logical OR and logical AND :)

>
>> +				hisi_lpc_acpi_xlat_io_res(child, adev, res);
>> +		}
>> +		rc = pnp_add_device(pnp_dev);
>> +		if (rc) {
>> +			put_device(&pnp_dev->dev);
>> +			return rc;
>> +		}
>> +	}
>> +

Cheers,
John

>>  	return 0;
>>  }
>>
>> --
>> 1.9.1
>
> .
>
