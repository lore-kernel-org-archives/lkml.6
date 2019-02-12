Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF925C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 03:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F2542083E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 03:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfBLDU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 22:20:57 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59772 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbfBLDU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 22:20:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63BDBEBD;
        Mon, 11 Feb 2019 19:20:56 -0800 (PST)
Received: from [10.162.43.137] (p8cg001049571a15.blr.arm.com [10.162.43.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8DBC3F557;
        Mon, 11 Feb 2019 19:20:53 -0800 (PST)
Subject: Re: [PATCH v2] mm/memory-hotplug: Add sysfs hot-remove trigger
To:     Robin Murphy <robin.murphy@arm.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, mhocko@kernel.org, akpm@linux-foundation.org,
        osalvador@suse.de
References: <49ef5e6c12f5ede189419d4dcced5dc04957c34d.1549906631.git.robin.murphy@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <4d92d783-736b-b94c-dbfd-1560c0936fb3@arm.com>
Date:   Tue, 12 Feb 2019 08:50:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <49ef5e6c12f5ede189419d4dcced5dc04957c34d.1549906631.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/11/2019 11:20 PM, Robin Murphy wrote:
> ARCH_MEMORY_PROBE is a useful thing for testing and debugging hotplug,
> but being able to exercise the (arguably trickier) hot-remove path would
> be even more useful. Extend the feature to allow removal of offline
> sections to be triggered manually to aid development.
> 
> Since process dictates the new sysfs entry be documented, let's also
> document the existing probe entry to match - better 13-and-a-half years
> late than never, as they say...
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> v2: Use is_memblock_offlined() helper, write up documentation
> 
>  .../ABI/testing/sysfs-devices-memory          | 25 +++++++++++
>  drivers/base/memory.c                         | 42 ++++++++++++++++++-
>  2 files changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-memory b/Documentation/ABI/testing/sysfs-devices-memory
> index deef3b5723cf..02a4250964e0 100644
> --- a/Documentation/ABI/testing/sysfs-devices-memory
> +++ b/Documentation/ABI/testing/sysfs-devices-memory
> @@ -91,3 +91,28 @@ Description:
>  		memory section directory.  For example, the following symbolic
>  		link is created for memory section 9 on node0.
>  		/sys/devices/system/node/node0/memory9 -> ../../memory/memory9
> +
> +What:		/sys/devices/system/memory/probe
> +Date:		October 2005
> +Contact:	Linux Memory Management list <linux-mm@kvack.org>
> +Description:
> +		The file /sys/devices/system/memory/probe is write-only, and
> +		when written will simulate a physical hot-add of a memory

Small nit. It does not 'simulate' but really does add the memory block into
the memblock, buddy allocator and so on.

> +		section at the given address. For example, assuming a section
> +		of unused memory exists at physical address 0x80000000, it can
> +		be introduced to the kernel with the following command:
> +		# echo 0x80000000 > /sys/devices/system/memory/probe
> +Users:		Memory hotplug testing and development
> +
> +What:		/sys/devices/system/memory/memoryX/remove
> +Date:		February 2019
> +Contact:	Linux Memory Management list <linux-mm@kvack.org>
> +Description:
> +		The file /sys/devices/system/memory/memoryX/remove is
> +		write-only, and when written with a boolean 'true' value will
> +		simulate a physical hot-remove of that memory section. For

Same here.
> +		example, assuming a 1GB section size, the section added by the
> +		above "probe" example could be removed again with the following

There is no need to mention specific memory block sizes like 1G in documentation
for this generic interface which would work for all possible sizes.
