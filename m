Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965053AbeEIPRv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:17:51 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38735 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964813AbeEIPRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:17:48 -0400
X-Google-Smtp-Source: AB8JxZrPxcP0Kr2SvztwfeaNJT1QX+e1Pd9Ktvp6XdAZX1onvnOm+UmuahElwBL2jLOwkPpHp8+QAw==
Subject: Re: [PATCH RESENT v4] dell_rbu: make firmware payload memory
 uncachable
To: Takashi Iwai <tiwai@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, charles_rose@dell.com
References: <20180418054634.10289-1-tiwai@suse.de>
From: Stuart Hayes <stuart.w.hayes@gmail.com>
Message-ID: <848a3ac6-4781-dd54-0b4a-d4839d902284@gmail.com>
Date: Wed, 9 May 2018 10:17:45 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418054634.10289-1-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/18/2018 12:46 AM, Takashi Iwai wrote:
> From: Stuart Hayes <stuart.w.hayes@gmail.com>
> 
> The dell_rbu driver takes firmware update payloads and puts them in memory so
> the system BIOS can find them after a reboot.  This sometimes fails (though
> rarely), because the memory containing the payload is in the CPU cache but
> never gets written back to main memory before the system is rebooted (CPU
> cache contents are lost on reboot).
> 
> With this patch, the payload memory will be changed to uncachable to ensure
> that the payload is actually in main memory before the system is rebooted.
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> Reviewed-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> v2 Added include, removed extra parentheses
> v3 Corrected formatting and include line
> v4 Moved set_memory_uc() outside the while loop so that the memory is
>    definitely allocated before it is set to uncachable
> 
> Andrew, could you pick up this orphan one?  Thanks!
> 
> diff --git a/drivers/firmware/dell_rbu.c b/drivers/firmware/dell_rbu.c
> index 2f452f1f7c8a..53f27a6e2d76 100644
> --- a/drivers/firmware/dell_rbu.c
> +++ b/drivers/firmware/dell_rbu.c
> @@ -45,6 +45,7 @@
>  #include <linux/moduleparam.h>
>  #include <linux/firmware.h>
>  #include <linux/dma-mapping.h>
> +#include <asm/set_memory.h>
>  
>  MODULE_AUTHOR("Abhay Salunke <abhay_salunke@dell.com>");
>  MODULE_DESCRIPTION("Driver for updating BIOS image on DELL systems");
> @@ -181,6 +182,11 @@ static int create_packet(void *data, size_t length)
>  			packet_data_temp_buf = NULL;
>  		}
>  	}
> +	/*
> +	 * set to uncachable or it may never get written back before reboot
> +	 */
> +	set_memory_uc((unsigned long)packet_data_temp_buf, 1 << ordernum);
> +
>  	spin_lock(&rbu_data.lock);
>  
>  	newpacket->data = packet_data_temp_buf;
> @@ -349,6 +355,8 @@ static void packet_empty_list(void)
>  		 * to make sure there are no stale RBU packets left in memory
>  		 */
>  		memset(newpacket->data, 0, rbu_data.packetsize);
> +		set_memory_wb((unsigned long)newpacket->data,
> +			1 << newpacket->ordernum);
>  		free_pages((unsigned long) newpacket->data,
>  			newpacket->ordernum);
>  		kfree(newpacket);
> 

Just a reminder... I don't think this has been picked up yet.  Please let me know if there's anything I could do.
Thanks!
Stuart
