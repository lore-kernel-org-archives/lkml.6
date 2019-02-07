Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFBEC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B653B2073F
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfBGPc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:32:57 -0500
Received: from foss.arm.com ([217.140.101.70]:38926 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbfBGPc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:32:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 354F9A78;
        Thu,  7 Feb 2019 07:32:56 -0800 (PST)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC90F3F719;
        Thu,  7 Feb 2019 07:32:54 -0800 (PST)
Subject: Re: [PATCH] mm/memory-hotplug: Add sysfs hot-remove trigger
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, mhocko@kernel.org,
        akpm@linux-foundation.org
References: <29ed519902512319bcc62e071d52b712fa97e306.1549469965.git.robin.murphy@arm.com>
 <20190207133620.a4vg2xqphsloke6i@d104.suse.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <7bf25a0f-766e-7924-9a54-64cef9f53b57@arm.com>
Date:   Thu, 7 Feb 2019 15:32:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190207133620.a4vg2xqphsloke6i@d104.suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2019 13:36, Oscar Salvador wrote:
> On Wed, Feb 06, 2019 at 05:03:53PM +0000, Robin Murphy wrote:
>> ARCH_MEMORY_PROBE is a useful thing for testing and debugging hotplug,
>> but being able to exercise the (arguably trickier) hot-remove path would
>> be even more useful. Extend the feature to allow removal of offline
>> sections to be triggered manually to aid development.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> ---
>>
>> This is inspired by a previous proposal[1], but in coming up with a
>> more robust interface I ended up rewriting the whole thing from
>> scratch. The lack of documentation is semi-deliberate, since I don't
>> like the idea of anyone actually relying on this interface as ABI, but
>> as a handy tool it felt useful enough to be worth sharing :)
> 
> Hi Robin,
> 
> I think this might come in handy, especially when trying to test hot-remove
> on arch's that do not have any means to hot-remove memory, or even on virtual
> platforms that do not have yet support for hot-remove depending on the platform,
> like qemu/arm64.
> 
> 
> I could have used this while testing hot-remove on other archs for [1]
> 
>>
>> Robin.
>>
>> [1] https://lore.kernel.org/lkml/22d34fe30df0fbacbfceeb47e20cb1184af73585.1511433386.git.ar@linux.vnet.ibm.com/
>>
> 
>> +	if (mem->state != MEM_OFFLINE)
>> +		return -EBUSY;
> 
> We do have the helper "is_memblock_offlined()", although it is only used in one place now.
> So, I would rather use it here as well.

Ooh, if I'd actually noticed that that helper existed, I would indeed 
have used it - fixed.

>> +
>> +	ret = lock_device_hotplug_sysfs();
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (device_remove_file_self(dev, attr)) {
>> +		__remove_memory(pfn_to_nid(start_pfn), PFN_PHYS(start_pfn),
>> +				MIN_MEMORY_BLOCK_SIZE * sections_per_block);
> 
> Sorry, I am not into sysfs inners, but I thought that:
> device_del::device_remove_attrs::device_remove_groups::sysfs_remove_groups
> would be enough to remove the dev attributes.
> I guess in this case that is not enough, could you explain why?

As I found out the hard way, since the "remove" attribute itself belongs 
to the device being removed, the standard device teardown callchain 
would end up trying to remove the file from its own method, which 
results in deadlock. Fortunately, the PCI sysfs code has a similar 
"remove" attribute which showed me how it should be handled - following 
the kerneldoc breadcrumb trail to kernfs_remove_self() hopefully 
explains it more completely.

Thanks,
Robin.

> 
> 
> [1] https://patchwork.kernel.org/patch/10775339/
> 
