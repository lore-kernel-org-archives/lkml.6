Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932293AbeEWKAw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 06:00:52 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35123 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932180AbeEWKAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 06:00:51 -0400
X-Google-Smtp-Source: AB8JxZqzn1RNsOGj0cK5wtnsSUEWxE/gVQHXro36kXX03+a3zXp3N3VaoUrmFB+ga0WTF3o96D74Og==
Subject: Re: [PATCH] drm/xen-front: fix pointer casts
To: Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        daniel.vetter@intel.com, boris.ostrovsky@oracle.com
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180521073912.13510-1-andr2000@gmail.com>
 <fc2a9af5-dd46-1ff9-c92f-d7e3b102e43e@suse.com>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <a33efc9f-1212-3e13-202b-35adc34f17e9@gmail.com>
Date: Wed, 23 May 2018 13:00:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <fc2a9af5-dd46-1ff9-c92f-d7e3b102e43e@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/23/2018 12:19 PM, Juergen Gross wrote:
> On 21/05/18 09:39, Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> Building for a 32-bit target results in warnings from casting
>> between a 32-bit pointer and a 64-bit integer. Fix the warnings
>> by casting those pointers to uintptr_t first.
>>
>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>> ---
>>   drivers/gpu/drm/xen/xen_drm_front.h       | 4 ++--
>>   drivers/gpu/drm/xen/xen_drm_front_shbuf.c | 2 +-
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xen/xen_drm_front.h b/drivers/gpu/drm/xen/xen_drm_front.h
>> index 2c2479b571ae..8e15dbebc4ba 100644
>> --- a/drivers/gpu/drm/xen/xen_drm_front.h
>> +++ b/drivers/gpu/drm/xen/xen_drm_front.h
>> @@ -126,12 +126,12 @@ struct xen_drm_front_drm_info {
>>   
>>   static inline u64 xen_drm_front_fb_to_cookie(struct drm_framebuffer *fb)
>>   {
>> -	return (u64)fb;
>> +	return (u64)(uintptr_t)fb;
> Do you really still need the cast to u64?
Indeed, I can remove (u64) now, thank you
>
>>   }
>>   
>>   static inline u64 xen_drm_front_dbuf_to_cookie(struct drm_gem_object *gem_obj)
>>   {
>> -	return (u64)gem_obj;
>> +	return (u64)(uintptr_t)gem_obj;
>>   }
>>   
>>   int xen_drm_front_mode_set(struct xen_drm_front_drm_pipeline *pipeline,
>> diff --git a/drivers/gpu/drm/xen/xen_drm_front_shbuf.c b/drivers/gpu/drm/xen/xen_drm_front_shbuf.c
>> index 8099cb343ae3..47fc93847765 100644
>> --- a/drivers/gpu/drm/xen/xen_drm_front_shbuf.c
>> +++ b/drivers/gpu/drm/xen/xen_drm_front_shbuf.c
>> @@ -122,7 +122,7 @@ static void guest_calc_num_grefs(struct xen_drm_front_shbuf *buf)
>>   }
>>   
>>   #define xen_page_to_vaddr(page) \
>> -		((phys_addr_t)pfn_to_kaddr(page_to_xen_pfn(page)))
>> +		((phys_addr_t)(uintptr_t)pfn_to_kaddr(page_to_xen_pfn(page)))
> phys_addr_t for a virtual address?
This is because the resulting value is then passed to gnttab_set_map_op/
gnttab_set_unmap_op which expects host address to be passed as
phys_addr_t addr :(
Please see [1], [2]: regardless of the fact that xen_page_to_vaddr does
produce host address I have to convert it to phys_addr_t then to pass to 
[1] and [2].
Please also see [3], [4], [5] which either cast to phys_addr_t or
unsigned long or u64.
>
> Juergen

[1] 
https://elixir.bootlin.com/linux/v4.17-rc6/source/include/xen/grant_table.h#L147
[2] 
https://elixir.bootlin.com/linux/v4.17-rc6/source/include/xen/grant_table.h#L163
[3] 
https://elixir.bootlin.com/linux/v4.17-rc6/source/drivers/block/xen-blkback/blkback.c#L845
[4] 
https://elixir.bootlin.com/linux/v4.17-rc6/source/drivers/net/xen-netback/netback.c#L334
[5] 
https://elixir.bootlin.com/linux/v4.17-rc6/source/drivers/xen/xenbus/xenbus_client.c#L478
