Return-Path: <john.garry@huawei.com>
X-Google-Smtp-Source: AIpwx4/tDYNVdxYAGladhLBCurDohzYO2+KDFaJNDat4wYkcXdrYxAhXF9CZPkZCboUXu6v2bQEG
ARC-Seal: i=1; a=rsa-sha256; t=1522771337; cv=none;
        d=google.com; s=arc-20160816;
        b=fL94TJcbF+AujeT/gkQF0Bf2JFyJNJm2ZY3+m7LpNStGf4LyOtG5wJojwh4nsEUb/g
         dI+thsUZQf30fUvjEacTDSJKDZ8SWnvAPWed5stgYhZRXZ8Yj307t9tn9SlGkbWwDkuM
         M/vlrsAi2c9tJ/YplP1x9SKpNzrAcZ6tlScnGnh+ORC/YKZVV9FMXt4j3j5HRHDlIs/q
         8ooIyzPvaGbzQn/zpNrfb4X9PZR4IHSjQz3C93DWUAJ53LeMwuBLuwN7qW4iuhYfz7bs
         HuM2uQd84VX0mvva1ipylnJHSeCsRTYNEJXZSzjGXScuuZ1PlyPizVqFAisXcvOqjD5W
         lGvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=ABq0bpk0O+F/BiJiLgINwyOjqv5LpYmmshzzvHTBmPY=;
        b=J3BuJ3GChrABkPYiZwAGPyUZSKVoSlOmgrceid4aLH02DwJaZYn6J9ZDv4lzVL1TTU
         YnJSa9ySXjUDPrfzrxxPnxHDFRac0uvuMATJ31GFaVTW+k8jS0lKpvw5A/+9xxT/kLjV
         qGqEpKUssn6WcOluaCzc71gkezw4AJY5oBbsa7rk1KHoVU47PEvJs2q5cqS0mK+VImrA
         f4TY8t8Al7oIE+u/N9mrcT8MNuL2eLJYm+tnzJvZlO0B+XxIXT7cCR7N4RzBjPktt4+u
         k+7nqqUo9P5JH7hvipuwp4j91d/2ypDDrqzV9rDBvGdmcbNQzGeC+YdrRouX9TDTJ49d
         YTIw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.190 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of john.garry@huawei.com designates 45.249.212.190 as permitted sender) smtp.mailfrom=john.garry@huawei.com
Subject: Re: [PATCH v17 01/10] LIB: Introduce a generic PIO mapping method
To: Thierry Reding <thierry.reding@gmail.com>
References: <1521051359-34473-1-git-send-email-john.garry@huawei.com>
 <1521051359-34473-2-git-send-email-john.garry@huawei.com>
 <20180403140410.GE27789@ulmo> <20180403143909.GA21171@ulmo>
CC: <mika.westerberg@linux.intel.com>, <rafael@kernel.org>,
	<lorenzo.pieralisi@arm.com>, <rjw@rjwysocki.net>, <hanjun.guo@linaro.org>,
	<robh+dt@kernel.org>, <bhelgaas@google.com>, <arnd@arndb.de>,
	<mark.rutland@arm.com>, <olof@lixom.net>, <dann.frazier@canonical.com>,
	<andy.shevchenko@gmail.com>, <robh@kernel.org>,
	<andriy.shevchenko@linux.intel.com>, <joe@perches.com>,
	<benh@kernel.crashing.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linuxarm@huawei.com>, <minyard@acm.org>, <devicetree@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <rdunlap@infradead.org>,
	<gregkh@linuxfoundation.org>, <akpm@linux-foundation.org>,
	<frowand.list@gmail.com>, <agraf@suse.de>, <linux-tegra@vger.kernel.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <ab748c97-2b55-d090-606f-5491551feff6@huawei.com>
Date: Tue, 3 Apr 2018 17:01:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180403143909.GA21171@ulmo>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594938019743784580?=
X-GMAIL-MSGID: =?utf-8?q?1596741477400727636?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>>> +int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
>>> +{
>>> +	struct logic_pio_hwaddr *range;
>>> +	resource_size_t start = new_range->hw_start;
>>> +	resource_size_t end = new_range->hw_start + new_range->size;
>>> +	resource_size_t mmio_sz = 0;
>>> +	resource_size_t iio_sz = MMIO_UPPER_LIMIT;
>>> +	int ret = 0;
>>> +
>>> +	if (!new_range || !new_range->fwnode || !new_range->size)
>>> +		return -EINVAL;
>>> +
>>> +	mutex_lock(&io_range_mutex);
>>> +	list_for_each_entry_rcu(range, &io_range_list, list) {
>>> +		if (range->fwnode == new_range->fwnode) {
>>> +			/* range already there */
>>> +			ret = -EFAULT;
>>> +			goto end_register;
>>> +		}
>>

Hi Thierry,

>> This is the -EFAULT that propagates to pci-tegra.c's ->probe() and fails
>> to bind the driver.
>>
>> I'm not exactly sure what's causing the duplicate here because it's
>> rather difficult to get at something useful from just the ->fwnode, but
>> I'm fairly sure that the reason this breaks is because the Tegra driver
>> will defer probe due to some regulators that aren't available on the
>> first try. Given the above code and the rest of this file, I can't see a
>> way to "fix" the driver and remove the I/O range on failure.
>>
>> This is doubly bad because this doesn't only leak the ranges on probe
>> deferral, but also on driver unload, and we just added support for
>> building the Tegra driver as a loadable module, so these are actually
>> cases that can happen in regular uses of the driver.
>>
>> I have no idea on how to fix this. Anyone know of a quick fix to restore
>> PCI for Tegra other than reverting all of these changes?
>>
>> I suppose an API could be added to unregister the range, but the calling
>> sequence is rather obfuscated, so removing the range will look totally
>> asymmetric, I'm afraid.
>>
>> Here's the call stack:
>>
>> 	tegra_pcie_probe()
>> 	tegra_pcie_parse_dt()
>> 	of_pci_range_to_resource()
>> 	pci_register_io_range()
>> 	logic_pio_register_range()
>>
>> So the range here is registered as part of a resource parsing function,
>> which is supposed to not have any side-effects. There's no equivalent of
>> that parsing routine (i.e. no "unparse" function that would undo the
>> effects of parsing).
>>
>> Perhaps a cleaner way would be to decouple the parsing from the actual
>> request step that has the side-effect.

This could be added if we agreed that it would be useful.

>>
>> Going back in history a little, it looks like even before this commit
>> the I/O range registration was triggered by the parsing code and even
>> the range leak was there, except that it caused pci_register_io_range()
>> to return 0 rather than -EFAULT. Perhaps the quickest fix for this would
>> be to do the same in the new code and restore drivers that accidentally
>> depend on this behaviour.
>
> I can confirm that the following fixes the issue for me, though I don't
> think it's a very clean fix given that the range will remain requested
> forever, even if the driver is gone. But since that's already been the
> case for quite a while, probably something that can be fixed separately.
>

Right, there was no way to deregister the range previously.  From 
looking at the history here I see no reason to not support it.

As for this patch, as you said, the only difference is that we fault on 
trying to register the same range again. So this solution seems reasonable.

On another point, for the tegra driver, is it possible to defer earlier 
in the probe, before these currently irreversible steps are taken?

Thanks very much,
John

> Cc'ing linux-tegra for visibility.
>
> Thierry
>
> --- >8 ---
> diff --git a/lib/logic_pio.c b/lib/logic_pio.c
> index 29cedeadb397..4664b87e1c5f 100644
> --- a/lib/logic_pio.c
> +++ b/lib/logic_pio.c
> @@ -46,7 +46,6 @@ int logic_pio_register_range(struct logic_pio_hwaddr *new_range)
>  	list_for_each_entry_rcu(range, &io_range_list, list) {
>  		if (range->fwnode == new_range->fwnode) {
>  			/* range already there */
> -			ret = -EFAULT;
>  			goto end_register;
>  		}
>  		if (range->flags == LOGIC_PIO_CPU_MMIO &&
>
