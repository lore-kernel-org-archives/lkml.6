Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B91AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 05:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D562064E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 05:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D562064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbeH0JUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 05:20:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54394 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726771AbeH0JUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 05:20:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 35CB740216F2;
        Mon, 27 Aug 2018 05:35:12 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1C0752166B41;
        Mon, 27 Aug 2018 05:35:10 +0000 (UTC)
Date:   Mon, 27 Aug 2018 13:35:07 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, n-horiguchi@ah.jp.nec.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com,
        douly.fnst@cn.fujitsu.com
Subject: Re: [PATCH v5 4/4] x86/boot/KASLR: Limit kaslr to choosing the
 immovable memory
Message-ID: <20180827053507.GA1748@MiWiFi-R3L-srv>
References: <20180807065000.30958-1-fanc.fnst@cn.fujitsu.com>
 <20180807065000.30958-5-fanc.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807065000.30958-5-fanc.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 27 Aug 2018 05:35:12 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Mon, 27 Aug 2018 05:35:12 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/18 at 02:50pm, Chao Fan wrote:
> If 'CONFIG_MEMORY_HOTREMOVE' specified and the account of immovable
> memory regions is not zero. Calculate the intersection between memory
> regions from e820/efi memory table and immovable memory regions.
> Or go on the old code.
> 
> Rename process_mem_region to slots_count to match slots_fetch_random,
> and name new function as process_mem_region.
> 
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/compressed/kaslr.c | 66 ++++++++++++++++++++++++++------
>  1 file changed, 55 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 720878f967a3..9c6e24a23a2d 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -635,9 +635,9 @@ static unsigned long slots_fetch_random(void)
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
>  	struct slot_area slot_area;
> @@ -714,6 +714,56 @@ static void process_mem_region(struct mem_vector *entry,
>  	}
>  }
>  
> +static bool process_mem_region(struct mem_vector *region,
> +			       unsigned long long minimum,
> +			       unsigned long long image_size)
> +{
> +#ifdef CONFIG_MEMORY_HOTREMOVE
> +	/*
> +	 * If immovable memory found, filter the intersection between
> +	 * immovable memory and region to slots_count.
> +	 * Otherwise, go on old code.
> +	 */
> +	if (num_immovable_mem > 0) {

Is it possible to take num_immovable_mem out from the #ifdef
CONFIG_MEMORY_HOTREMOVE region so that you can check it earlier to see
if the old way need be taken? This way, we can reduce one level of
indentation in the for loop. Just personal thought.

static bool process_mem_region(struct mem_vector *region,
                            unsigned long long minimum,
                            unsigned long long image_size)
{
	if (!num_immovable_mem) {
		slots_count(region, minimum, image_size);
		
		if (slot_area_index == MAX_SLOT_AREA) {
			debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
			return 1;
		}
		return 0;
	}


#ifdef CONFIG_MEMORY_HOTREMOVE
	for (i = 0; i < num_immovable_mem; i++) {
		......
	}
#endif
}

> +		int i;
> +
> +		for (i = 0; i < num_immovable_mem; i++) {
> +			struct mem_vector entry;
> +			unsigned long long start, end, entry_end, region_end;
> +
> +			start = immovable_mem[i].start;
> +			end = start + immovable_mem[i].size;
> +			region_end = region->start + region->size;
> +
> +			entry.start = clamp(region->start, start, end);
> +			entry_end = clamp(region_end, start, end);
> +
> +			if (entry.start + image_size < entry_end) {
> +				entry.size = entry_end - entry.start;
> +				slots_count(&entry, minimum, image_size);
> +
> +				if (slot_area_index == MAX_SLOT_AREA) {
> +					debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
> +					return 1;
> +				}
> +			}
> +		}
> +		return 0;
> +	}
> +#endif
> +	/*
> +	 * If no immovable memory found, or MEMORY_HOTREMOVE disabled,
> +	 * walk all the regions, so use region directely.
> +	 */
> +	slots_count(region, minimum, image_size);
> +
> +	if (slot_area_index == MAX_SLOT_AREA) {
> +		debug_putstr("Aborted e820/efi memmap scan (slot_areas full)!\n");
> +		return 1;
> +	}
> +	return 0;
> +}
> +
>  #ifdef CONFIG_EFI
>  /*
>   * Returns true if mirror region found (and must have been processed
> @@ -779,11 +829,8 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
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
> @@ -810,11 +857,8 @@ static void process_e820_entries(unsigned long minimum,
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
> 2.17.1
> 
> 
> 
