Return-Path: <mhocko@kernel.org>
X-Google-Smtp-Source: AH8x225sSIToPTMEucYDCfkOTzNzXiS4L4pkSa4cowQNMiYEDpXSlHgJj/ZtuDgBYRtIhshNBiwM
ARC-Seal: i=1; a=rsa-sha256; t=1518694646; cv=none;
        d=google.com; s=arc-20160816;
        b=hekV07YYLAMnIG3+AfvpxRklhMmcM3N1IMgv9rzF3/mat5WbIpabXEefzbz8jMqb+X
         UmB+aa6iQ3q48buvzl7sjhQ0jdxu6o8RpAqHEsa8QU24wrFe0jSfGAGN1PR/Us8/pXZE
         Ru+DHbI8aCF2jcQXM10GPnUUhQU6jAGoCrAyap/CFzSjI1oMIDbThmJ+kduP0N2LC0VS
         fWb8JDIJn5cX9+8q2RGJHtLVsLSHNiyKsdPN2XCJWuaGmOHRM6IXGezWFjZUj5QQkPV+
         ysHYr/I/rJlKke4sYqwDQpCdnQd35FizAxOVUaKelEGahFbgCuWBzdF3vurJa4/MAPiW
         LqTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=SmgBOs6TsSIb6QSXUGVG4NCwHxeEoh3IqbH6Kne9nQ0=;
        b=CVu8hIgHa3R+5kgg8ZM8+pp5DS5wWvnytUN+ug5taHNsMRCtqQxinneeYzk9vehBI1
         tn2ICirRgIOlZWcI9NE2SLa+cZF4aFSWwiNkVCjWqzM7/IAvkfWat9vkSyeNCMJtrscf
         12bU/lC/EOtMlIiCq5sP7HzdKipIIQC7t9PJEqR0ORMer3dWswlkDmCbkBtVKhO4Z9xB
         UTakRPz6vqE70QvMpYQmf16Xo/zPrc5yVHGMX0vc1bYw3Kq4jxvM1hBFnBAaC9FOQoJE
         OtMMowvBp+5Je1ZFq+pJqi4PmE8DkmI5Qhi1qVCfWLep8+Ye4/uTy+39LiLe7TQmD66f
         +PcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Date: Thu, 15 Feb 2018 12:37:25 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
	akpm@linux-foundation.org, mgorman@techsingularity.net,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, vbabka@suse.cz,
	bharata@linux.vnet.ibm.com, tglx@linutronix.de, mingo@redhat.com,
	hpa@zytor.com, x86@kernel.org, dan.j.williams@intel.com,
	kirill.shutemov@linux.intel.com, bhe@redhat.com
Subject: Re: [PATCH v3 2/4] x86/mm/memory_hotplug: determine block size based
 on the end of boot memory
Message-ID: <20180215113725.GC7275@dhcp22.suse.cz>
References: <20180213193159.14606-1-pasha.tatashin@oracle.com>
 <20180213193159.14606-3-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213193159.14606-3-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592315446070110278?=
X-GMAIL-MSGID: =?utf-8?q?1592466757923786631?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue 13-02-18 14:31:57, Pavel Tatashin wrote:
> Memory sections are combined into "memory block" chunks. These chunks are
> the units upon which memory can be added and removed.
> 
> On x86, the new memory may be added after the end of the boot memory,
> therefore, if block size does not align with end of boot memory, memory
> hot-plugging/hot-removing can be broken.
> 
> Currently, whenever machine is boot with more than 64G the block size
> unconditionally increased to 2G from the base 128M in order to reduce
> number of memory devices in sysfs:
> 	/sys/devices/system/memory/memoryXXX
> 
> But, we must use the largest allowed block size that aligns to the next
> address to be able to hotplug the next block of memory.
> 
> So, when memory is larger than 64G, we check the end address and find the
> largest block size that is still power of two but smaller or equal to 2G.
> 
> Before, the fix:
> Run qemu with:
> -m 64G,slots=2,maxmem=66G -object memory-backend-ram,id=mem1,size=2G
> 
> (qemu) device_add pc-dimm,id=dimm1,memdev=mem1
> Block size [0x80000000] unaligned hotplug range: start 0x1040000000,
> 							size 0x80000000
> acpi PNP0C80:00: add_memory failed
> acpi PNP0C80:00: acpi_memory_enable_device() error
> acpi PNP0C80:00: Enumeration failure
> 
> With the fix memory is added successfully, as the block size is set to 1G,
> and therefore aligns with start address 0x1040000000.

I dunno. If x86 maintainers are OK with this then why not, but I do not
like how this is x86 specific. I would much rather address this by
making the memblock user interface more sane.

> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---
>  arch/x86/mm/init_64.c | 33 +++++++++++++++++++++++++++++----
>  1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index 1ab42c852069..f7dc80364397 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1326,14 +1326,39 @@ int kern_addr_valid(unsigned long addr)
>  	return pfn_valid(pte_pfn(*pte));
>  }
>  
> +/*
> + * Block size is the minimum quantum of memory which can be hot-plugged or
> + * hot-removed. It must be power of two, and must be equal or larger than
> + * MIN_MEMORY_BLOCK_SIZE.
> + */
> +#define MAX_BLOCK_SIZE (2UL << 30)
> +
> +/* Amount of ram needed to start using large blocks */
> +#define MEM_SIZE_FOR_LARGE_BLOCK (64UL << 30)
> +
>  static unsigned long probe_memory_block_size(void)
>  {
> -	unsigned long bz = MIN_MEMORY_BLOCK_SIZE;
> +	unsigned long boot_mem_end = max_pfn << PAGE_SHIFT;
> +	unsigned long bz;
>  
> -	/* if system is UV or has 64GB of RAM or more, use large blocks */
> -	if (is_uv_system() || ((max_pfn << PAGE_SHIFT) >= (64UL << 30)))
> -		bz = 2UL << 30; /* 2GB */
> +	/* If this is UV system, always set 2G block size */
> +	if (is_uv_system()) {
> +		bz = MAX_BLOCK_SIZE;
> +		goto done;
> +	}
>  
> +	/* Use regular block if RAM is smaller than MEM_SIZE_FOR_LARGE_BLOCK */
> +	if (boot_mem_end < MEM_SIZE_FOR_LARGE_BLOCK) {
> +		bz = MIN_MEMORY_BLOCK_SIZE;
> +		goto done;
> +	}
> +
> +	/* Find the largest allowed block size that aligns to memory end */
> +	for (bz = MAX_BLOCK_SIZE; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
> +		if (IS_ALIGNED(boot_mem_end, bz))
> +			break;
> +	}
> +done:
>  	pr_info("x86/mm: Memory block size: %ldMB\n", bz >> 20);
>  
>  	return bz;
> -- 
> 2.16.1
> 

-- 
Michal Hocko
SUSE Labs
