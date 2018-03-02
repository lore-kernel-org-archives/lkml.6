Return-Path: <john.garry@huawei.com>
X-Google-Smtp-Source: AG47ELtf0E5SYhtDQFcyLyWqO9p/+Fiqc0/wuxq9SKA0Jra7u4x3zd8fMgi4UNEACh8Xr+sefUxM
ARC-Seal: i=1; a=rsa-sha256; t=1519986841; cv=none;
        d=google.com; s=arc-20160816;
        b=yGwqy/NPXxXvHb5UuipEEj+C+hQOH0TBWbYu1WM5lxMv0MmT5yI+k/ay77+XCkauIl
         sQPZhqmnUZBglAcGi4ptaqtSWUo+1QGFEjzhlb0lW5LDWFRe26oH69CHQA+6ZhZqQqNZ
         iIgLtl2xidzeYs64wnb1ekIKQlQ1Q9/p6jWSH1Il8Or/pUvACYCU4TKy4SYilG77G7qm
         73NNSMHo+m0Pz/g5E+Udve7hbNblZZ95RmihwSFw8ww8m3R71ZVD5CJYCTsH/ZmaWFae
         kl2JDQaLbxVeIqIcdugSiXdIHakC7xcL30pO4c2l/wbVgp00hPcddc/1nAqh1uSr61NN
         nnQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=VlxWcFebJHTZwMma7s9T+HVgcXylfLaTmD8wUaJE8w8=;
        b=OTB/t39pcFe03vR60bxfPRbWSFwtDX/RrCLD+yi4jo7mf8DTIQiHWVMxQq+tVS7E12
         +s0PLLXYnxeef7NXrp9U/OCi2CDo75YwW79SbjT9P47hpLCUedH3YPbEJo0djTmTX94W
         grS123jj+GAmsH7cGGAU4KyQeIiNcEVeyqga+q18qc65aGZEY4B40kolrxHayRIrsh8O
         y5AALM0yg5JjI1dNo3rlprpLrniGP7zZzf7pCb9fOVk54xg5ou7wHvOOY3cscpB7XA1J
         2hF4W5dOcpz9Tsp/tLqn7NcDYfQpFgDpec4TRy1oZ69VnpRo0RjvipSfKBdq8Vad5wz0
         kkAg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.32 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.32 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Subject: Re: [PATCH v15 1/9] LIB: Introduce a generic PIO mapping method
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	<mika.westerberg@linux.intel.com>, <rafael@kernel.org>,
	<lorenzo.pieralisi@arm.com>, <rjw@rjwysocki.net>, <hanjun.guo@linaro.org>,
	<robh+dt@kernel.org>, <bhelgaas@google.com>, <arnd@arndb.de>,
	<mark.rutland@arm.com>, <olof@lixom.net>, <dann.frazier@canonical.com>,
	<andy.shevchenko@gmail.com>, <robh@kernel.org>
References: <1519663249-9850-1-git-send-email-john.garry@huawei.com>
 <1519663249-9850-2-git-send-email-john.garry@huawei.com>
 <1519931483.10722.342.camel@linux.intel.com>
CC: <joe@perches.com>, <benh@kernel.crashing.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linuxarm@huawei.com>, <minyard@acm.org>,
	<devicetree@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<rdunlap@infradead.org>, <gregkh@linuxfoundation.org>,
	<akpm@linux-foundation.org>, <frowand.list@gmail.com>, <agraf@suse.de>
From: John Garry <john.garry@huawei.com>
Message-ID: <bf00d184-137d-a2fa-b202-f18ce131fdd6@huawei.com>
Date: Fri, 2 Mar 2018 10:33:26 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1519931483.10722.342.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593479227626660665?=
X-GMAIL-MSGID: =?utf-8?q?1593821722756638881?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 01/03/2018 19:11, Andy Shevchenko wrote:
> On Tue, 2018-02-27 at 00:40 +0800, John Garry wrote:
>> From: Zhichang Yuan <yuanzhichang@hisilicon.com>
>>
>> In commit 41f8bba7f555 ("of/pci: Add pci_register_io_range() and
>> pci_pio_to_address()"), a new I/O space management was supported. With
>> that driver, the I/O ranges configured for PCI/PCIe hosts on some
>> architectures can be mapped to logical PIO, converted easily between
>> CPU address and the corresponding logicial PIO. Based on this, PCI
>> I/O devices can be accessed in a memory read/write way through the
>> unified in/out accessors.
>>
>> But on some archs/platforms, there are bus hosts which access I/O
>> peripherals with host-local I/O port addresses rather than memory
>> addresses after memory-mapped.
>>
>> To support those devices, a more generic I/O mapping method is
>> introduced
>> here. Through this patch, both the CPU addresses and the host-local
>> port
>> can be mapped into the logical PIO space with different logical/fake
>> PIOs.
>> After this, all the I/O accesses to either PCI MMIO devices or host-
>> local
>> I/O peripherals can be unified into the existing I/O accessors defined
>> in
>> asm-generic/io.h and be redirected to the right device-specific hooks
>> based on the input logical PIO.
>>
>
> A bit more small comments.
>
>

Hi Andy,

>> +#ifndef __LINUX_LOGIC_PIO_H
>> +#define __LINUX_LOGIC_PIO_H
>> +
>
>> +#ifdef __KERNEL__
>
> Hmm... How the header in include/linux/ can be non-kernel?

I did doubt the legitimacy of this. I think it should be ok to remove.

>
>> +	list_for_each_entry_rcu(range, &io_range_list, list) {
>
>> +		if (range->flags == LOGIC_PIO_CPU_MMIO &&
>> +				new_range->flags ==
>> LOGIC_PIO_CPU_MMIO) {
>
> It's rather fancy indentation.

Right, I should align these.

>
>> +			if (start >= range->hw_start + range->size ||
>> +			    end < range->hw_start)
>
> Misses {}

Right, I will fix.

>
>> +				allocated_mmio_size += range->size;
>> +			else {
>> +				ret = -EFAULT;
>> +				goto end_register;
>> +			}
>
>> +		if (allocated_mmio_size + new_range->size - 1 >
>> +			MMIO_UPPER_LIMIT) {
>
> Fancy indentation.
>
>> +			if (allocated_mmio_size + SZ_64K - 1 >
>> +			MMIO_UPPER_LIMIT) {
>
> Ditto.

Will fix both

>
>> +		if (allocated_iio_size + new_range->size - 1 >
>> +		    IO_SPACE_LIMIT) {
>
> While this is nothing wrong, like above I would consider to check how
> long it is and consider putting on one line.

Fine. Some symbol names can be shortened to aid this.

>
>> +/**
>> + * logic_pio_to_hwaddr - translate logical PIO to HW address
>> + * @pio: logical PIO value
>> + *
>> + * Returns HW address if valid, -1 otherwise
>
> It can't return -1 when the return type is unsigned.
>
>> + *
>> + * Translate the input logical pio to the corresponding hardware
>> address.
>> + * The input pio should be unique in the whole logical PIO space.
>> + */
>> +resource_size_t logic_pio_to_hwaddr(unsigned long pio)
>> +{
>> +	struct logic_pio_hwaddr *range;
>
>> +	resource_size_t hwaddr = (resource_size_t)-1;
>
> Ditto.

ok, I should have changed this to ~0 also.

>
>> +	return hwaddr;
>> +}
>
>> +	list_for_each_entry_rcu(range, &io_range_list, list) {
>> +		if (range->flags != LOGIC_PIO_CPU_MMIO)
>> +			continue;
>
>> +		if (addr >= range->hw_start &&
>> +		    addr < range->hw_start + range->size)
>
> Perhaps you may copy'n'paste in_range() macro from fs/ext* files and use
> in this module. At some point it would be good to make it generic.

OK, I should be able to copy. It would not be good to include 
fs/ufs/util.h, but a generic helper would be useful.

>
>> +			return addr - range->hw_start +
>> +				range->io_start;
>
>
>> +	}
>
>

Thanks very much,
John
