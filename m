Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDC4C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB41208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 04:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB41208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeJRMU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 08:20:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59378 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbeJRMU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 08:20:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 702A680F6D;
        Thu, 18 Oct 2018 04:21:27 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9FD5780FF0;
        Thu, 18 Oct 2018 04:21:26 +0000 (UTC)
Date:   Thu, 18 Oct 2018 12:21:23 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-acpi@vger.kernel.org,
        bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, msys.mizuma@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v9 8/8] x86/boot/KASLR: Limit kaslr to choosing the
 immovable memory
Message-ID: <20181018042123.GD1885@192.168.1.4>
References: <20181017102012.872-1-fanc.fnst@cn.fujitsu.com>
 <20181017102012.872-9-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017102012.872-9-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 18 Oct 2018 04:21:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/18 at 06:20pm, Chao Fan wrote:
> If CONFIG_MEMORY_HOTREMOVE enabled and the amount of immovable
> memory regions is not zero. Calculate the intersection between memory

This if conditional adverbial clauses is not an complete sentence.

> regions from e820/efi memory table and immovable memory regions.
					^ get?
> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/compressed/kaslr.c | 72 +++++++++++++++++++++++++++-----
>  1 file changed, 61 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 0c3567bc231c..3ebb150f61eb 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -101,6 +101,11 @@ static bool memmap_too_large;
>  /* Store memory limit specified by "mem=nn[KMG]" or "memmap=nn[KMG]" */
>  static unsigned long long mem_limit = ULLONG_MAX;
>  
> +#ifdef CONFIG_MEMORY_HOTREMOVE
> +/* Store the immovable memory regions */
> +extern struct mem_vector immovable_mem[MAX_NUMNODES*2];

Sorry, Chao. I may not follow your old patch change, why the length of
immovable_mem is MAX_NUMNODES*2, is there any reason or basis?

> +#endif
> +
>  
>  enum mem_avoid_index {
>  	MEM_AVOID_ZO_RANGE = 0,
> @@ -577,9 +582,9 @@ static unsigned long slots_fetch_random(void)
>  	return 0;
>  }
>  
> -static void process_mem_region(struct mem_vector *entry,
> -			       unsigned long minimum,
> -			       unsigned long image_size)
> +static void slots_count(struct mem_vector *entry,
> +			unsigned long minimum,
> +			unsigned long image_size)
>  {
>  	struct mem_vector region, overlap;
>  	unsigned long start_orig, end;
> @@ -655,6 +660,57 @@ static void process_mem_region(struct mem_vector *entry,
>  	}
>  }
>  
> +static bool process_mem_region(struct mem_vector *region,
> +			       unsigned long long minimum,
> +			       unsigned long long image_size)
> +{
> +	int i;
> +	/*
> +	 * If no immovable memory found, or MEMORY_HOTREMOVE disabled,
> +	 * walk all the regions, so use region directely.
> +	 */
> +	if (num_immovable_mem == 0) {
> +		slots_count(region, minimum, image_size);
> +
> +		if (slot_area_index == MAX_SLOT_AREA) {
> +			debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
> +			return 1;
> +		}
> +		return 0;
> +	}
> +
> +#ifdef CONFIG_MEMORY_HOTREMOVE
> +	/*
> +	 * If immovable memory found, filter the intersection between
> +	 * immovable memory and region to slots_count.
> +	 * Otherwise, go on old code.

Could you explain more about what is the old code in otherwise case you
want to go on?

> +	 */
> +	for (i = 0; i < num_immovable_mem; i++) {
> +		struct mem_vector entry;
> +		unsigned long long start, end, entry_end, region_end;
> +
> +		if (!mem_overlaps(region, &immovable_mem[i]))
> +			continue;
> +
> +		start = immovable_mem[i].start;
> +		end = start + immovable_mem[i].size;
> +		region_end = region->start + region->size;
> +
> +		entry.start = clamp(region->start, start, end);
> +		entry_end = clamp(region_end, start, end);
> +		entry.size = entry_end - entry.start;
> +
> +		slots_count(&entry, minimum, image_size);

Obviously, your patch log only covers this place of code. About renaming
process_mem_region() to  slot_count(), and add another level of wrapper 
process_mem_region(), may also need be mentioned in patch log.

> +
> +		if (slot_area_index == MAX_SLOT_AREA) {
> +			debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
> +			return 1;
> +		}
> +	}
> +	return 0;
> +#endif
> +}
> +
>  #ifdef CONFIG_EFI
>  /*
>   * Returns true if mirror region found (and must have been processed
> @@ -720,11 +776,8 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
>  
>  		region.start = md->phys_addr;
>  		region.size = md->num_pages << EFI_PAGE_SHIFT;
> -		process_mem_region(&region, minimum, image_size);
> -		if (slot_area_index == MAX_SLOT_AREA) {
> -			debug_putstr("Aborted EFI scan (slot_areas full)!\n");
> +		if (process_mem_region(&region, minimum, image_size))
>  			break;
> -		}
>  	}
>  	return true;
>  }
> @@ -751,11 +804,8 @@ static void process_e820_entries(unsigned long minimum,
>  			continue;
>  		region.start = entry->addr;
>  		region.size = entry->size;
> -		process_mem_region(&region, minimum, image_size);
> -		if (slot_area_index == MAX_SLOT_AREA) {
> -			debug_putstr("Aborted e820 scan (slot_areas full)!\n");
> +		if (process_mem_region(&region, minimum, image_size))
>  			break;
> -		}
>  	}
>  }
>  
> -- 
> 2.17.2
> 
> 
> 
