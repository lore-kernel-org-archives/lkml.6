Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C903C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A46B2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 08:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549960396;
	bh=yGdg5Hglt39+9f7fS9w6ZHGZ9IzDo7yFlPvfc4VZjso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k2iQGFK87j81WLiEcIqwI3fKBQtc4NEOKhPkpeJs2MRliSo67QjnTRWtnMCi46DlE
	 /6LxW3wg4PLbRlVN+hhmjH4QILGts+Ms+bejRbcQTWrFO3/eZH2emKC8gYrc89xGXv
	 Va8YqFsyIFZn4nJHln1rvACsGDuGZD5yfSaXwQ5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbfBLIdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 03:33:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:46722 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728209AbfBLIdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 03:33:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EB317AF1F;
        Tue, 12 Feb 2019 08:33:11 +0000 (UTC)
Date:   Tue, 12 Feb 2019 09:33:10 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        akpm@linux-foundation.org, osalvador@suse.de
Subject: Re: [PATCH v2] mm/memory-hotplug: Add sysfs hot-remove trigger
Message-ID: <20190212083310.GM15609@dhcp22.suse.cz>
References: <49ef5e6c12f5ede189419d4dcced5dc04957c34d.1549906631.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49ef5e6c12f5ede189419d4dcced5dc04957c34d.1549906631.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11-02-19 17:50:46, Robin Murphy wrote:
> ARCH_MEMORY_PROBE is a useful thing for testing and debugging hotplug,
> but being able to exercise the (arguably trickier) hot-remove path would
> be even more useful. Extend the feature to allow removal of offline
> sections to be triggered manually to aid development.
> 
> Since process dictates the new sysfs entry be documented, let's also
> document the existing probe entry to match - better 13-and-a-half years
> late than never, as they say...

The probe sysfs is quite dubious already TBH. Apart from testing, is
anybody using it for something real? Do we need to keep an API for
something testing only? Why isn't a customer testing module enough for
such a purpose?

In other words, why do we have to add an API that has to be maintained
for ever for a testing only purpose?

Besides that, what is the reason to use __remove_memory rather than the
exported remove_memory which does an additional locking. Also, we do
trust root to do sane things but are we sure that the current BUG-land
mines in the hotplug code are ready enough to be exported for playing?

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
> +		example, assuming a 1GB section size, the section added by the
> +		above "probe" example could be removed again with the following
> +		command:
> +		# echo 1 > /sys/devices/system/memory/memory2/remove
> +Users:		Memory hotplug testing and development
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 048cbf7d5233..1ba9d1a6ba5e 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -521,7 +521,44 @@ static ssize_t probe_store(struct device *dev, struct device_attribute *attr,
>  }
>  
>  static DEVICE_ATTR_WO(probe);
> -#endif
> +
> +#ifdef CONFIG_MEMORY_HOTREMOVE
> +static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
> +			    const char *buf, size_t count)
> +{
> +	struct memory_block *mem = to_memory_block(dev);
> +	unsigned long start_pfn = section_nr_to_pfn(mem->start_section_nr);
> +	bool remove;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &remove);
> +	if (ret)
> +		return ret;
> +	if (!remove)
> +		return count;
> +
> +	if (!is_memblock_offlined(mem))
> +		return -EBUSY;
> +
> +	ret = lock_device_hotplug_sysfs();
> +	if (ret)
> +		return ret;
> +
> +	if (device_remove_file_self(dev, attr)) {
> +		__remove_memory(pfn_to_nid(start_pfn), PFN_PHYS(start_pfn),
> +				MIN_MEMORY_BLOCK_SIZE * sections_per_block);
> +		ret = count;
> +	} else {
> +		ret = -EBUSY;
> +	}
> +
> +	unlock_device_hotplug();
> +	return ret;
> +}
> +
> +static DEVICE_ATTR_WO(remove);
> +#endif /* CONFIG_MEMORY_HOTREMOVE */
> +#endif /* CONFIG_ARCH_MEMORY_PROBE */
>  
>  #ifdef CONFIG_MEMORY_FAILURE
>  /*
> @@ -615,6 +652,9 @@ static struct attribute *memory_memblk_attrs[] = {
>  	&dev_attr_removable.attr,
>  #ifdef CONFIG_MEMORY_HOTREMOVE
>  	&dev_attr_valid_zones.attr,
> +#ifdef CONFIG_ARCH_MEMORY_PROBE
> +	&dev_attr_remove.attr,
> +#endif
>  #endif
>  	NULL
>  };
> -- 
> 2.20.1.dirty

-- 
Michal Hocko
SUSE Labs
