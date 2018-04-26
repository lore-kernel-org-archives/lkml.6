Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754287AbeDZUUr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 16:20:47 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39972 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752358AbeDZUUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 16:20:45 -0400
X-Google-Smtp-Source: AIpwx4/MDZ4jeMSDg5LIEgCeoLKjjovTl313lxokvVxjrCrbtdujVt0CDephgDcl+DSmYAzVnfps1A==
Subject: Re: [PATCH v2] of: overlay: Stop leaking resources on overlay removal
To: Jan Kiszka <jan.kiszka@siemens.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Tull <atull@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <e8704374-857c-d80e-e91c-89d59e1cffbe@siemens.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <bb034d02-6bff-6828-bbf6-021bf4d39a95@gmail.com>
Date: Thu, 26 Apr 2018 13:20:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e8704374-857c-d80e-e91c-89d59e1cffbe@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/26/18 04:00, Jan Kiszka wrote:
> Only the overlay notifier callbacks have a chance to potentially get
> hold of references to those two resources, but they are not supposed to
> store them beyond OF_OVERLAY_POST_REMOVE.
> 
> Document the overlay notifier API, its constraint regarding pointer
> lifetime, and then remove intentional leaks of ovcs->overlay_tree and
> ovcs->fdt from free_overlay_changeset.
> 
> See also https://lkml.org/lkml/2018/4/23/1063 and following.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  Documentation/devicetree/overlay-notes.txt |  8 ++++++++
>  drivers/of/overlay.c                       | 30 +++++++++++++++++++++---------
>  2 files changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/overlay-notes.txt b/Documentation/devicetree/overlay-notes.txt
> index a4feb6dde8cd..725fb8d255c1 100644
> --- a/Documentation/devicetree/overlay-notes.txt
> +++ b/Documentation/devicetree/overlay-notes.txt
> @@ -98,6 +98,14 @@ Finally, if you need to remove all overlays in one-go, just call
>  of_overlay_remove_all() which will remove every single one in the correct
>  order.
>  
> +In addition, there is the option to register notifiers that get called on
> +overlay operations. See of_overlay_notifier_register/unregister and
> +enum of_overlay_notify_action for details.
> +
> +Note that a notifier callback is not supposed to store pointers to a device
> +tree node or its content beyond OF_OVERLAY_POST_REMOVE corresponding to the
> +respective node it received.
> +
>  Overlay DTS Format
>  ------------------
>  
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index b35fe88f1851..7baa53e5b1d7 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -102,12 +102,28 @@ static DEFINE_IDR(ovcs_idr);
>  
>  static BLOCKING_NOTIFIER_HEAD(overlay_notify_chain);
>  
> +/**
> + * of_overlay_notifier_register() - Register notifier for overlay operations
> + * @nb:		Notifier block to register
> + *
> + * Register for notification on overlay operations on device tree nodes. The
> + * reported actions definied by @of_reconfig_change. The notifier callback
> + * furthermore receives a pointer to the affected device tree node.
> + *
> + * Note that a notifier callback is not supposed to store pointers to a device
> + * tree node or its content beyond @OF_OVERLAY_POST_REMOVE corresponding to the
> + * respective node it received.
> + */
>  int of_overlay_notifier_register(struct notifier_block *nb)
>  {
>  	return blocking_notifier_chain_register(&overlay_notify_chain, nb);
>  }
>  EXPORT_SYMBOL_GPL(of_overlay_notifier_register);
>  
> +/**
> + * of_overlay_notifier_register() - Unregister notifier for overlay operations
> + * @nb:		Notifier block to unregister
> + */
>  int of_overlay_notifier_unregister(struct notifier_block *nb)
>  {
>  	return blocking_notifier_chain_unregister(&overlay_notify_chain, nb);
> @@ -671,17 +687,13 @@ static void free_overlay_changeset(struct overlay_changeset *ovcs)
>  		of_node_put(ovcs->fragments[i].overlay);
>  	}
>  	kfree(ovcs->fragments);
> -
>  	/*
> -	 * TODO
> -	 *
> -	 * would like to: kfree(ovcs->overlay_tree);
> -	 * but can not since drivers may have pointers into this data
> -	 *
> -	 * would like to: kfree(ovcs->fdt);
> -	 * but can not since drivers may have pointers into this data
> +	 * There should be no live pointers into ovcs->overlay_tree and
> +	 * ovcs->fdt due to the policy that overlay notifiers are not allowed
> +	 * to retain pointers into the overlay devicetree.
>  	 */
> -
> +	kfree(ovcs->overlay_tree);
> +	kfree(ovcs->fdt);
>  	kfree(ovcs);
>  }
>  
> 

These added kfree()s are depending on good review of overlay notifier
patches to prevent retaining pointers into this freed memory.  When
this patch is accepted I will submit a patch to add a "K:" pattern
line to the Overlay MAINTAINERS entry to catch when overlay notifiers
are added.

Reviewed-by: Frank Rowand <frowand.list@gmail.com>
