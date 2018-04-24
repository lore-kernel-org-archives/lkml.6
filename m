Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751990AbeDXRoH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 13:44:07 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35726 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbeDXRoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 13:44:04 -0400
X-Google-Smtp-Source: AIpwx4+jKmeaExvwj6E8aeUUlipN+oCMKvHK4JkjiIGuCIDtlZKNLe1tjx1ChWsJ/B2TKuyCAVyuUA==
Subject: Re: [PATCH] of: overlay: Stop leaking resources on overlay removal
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Tull <atull@kernel.org>
References: <097f1b01-6cb4-8dcb-0498-7b4c59a7ea53@siemens.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <7aca82c1-a02c-2f84-bc32-6e8a118ba601@gmail.com>
Date: Tue, 24 Apr 2018 10:44:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <097f1b01-6cb4-8dcb-0498-7b4c59a7ea53@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/24/18 09:19, Jan Kiszka wrote:
> Only the overlay notifier callbacks have a chance to potentially get
> hold of references to those two resources, but they do not store them.
> So it is safe to stop the intentional leaking.
> 
> See also https://lkml.org/lkml/2018/4/23/1063 and following.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Ideally, we sort out any remaining worries during the 4.17-rc cycle.
> 
>  drivers/of/overlay.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index b35fe88f1851..3553f1f57a62 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -671,17 +671,8 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>  		of_node_put(ovcs->fragments[i].overlay);
>  	}
>  	kfree(ovcs->fragments);
> -
> -	/*
> -	 * TODO
> -	 *
> -	 * would like to: kfree(ovcs->overlay_tree);
> -	 * but can not since drivers may have pointers into this data
> -	 *
> -	 * would like to: kfree(ovcs->fdt);
> -	 * but can not since drivers may have pointers into this data
> -	 */
> -
> +	kfree(ovcs->overlay_tree);
> +	kfree(ovcs->fdt);
>  	kfree(ovcs);
>  }
>  
> 

Nack.  It is premature to submit this while the conversation is
continuing in the other thread.

I'll continue the conversation in the other thread.

-Frank
