Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbeCIKLy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 05:11:54 -0500
Received: from mailapp01.imgtec.com ([195.59.15.196]:41644 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750948AbeCIKLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 05:11:52 -0500
Date: Fri, 9 Mar 2018 10:11:49 +0000
From: Eric Engestrom <eric.engestrom@imgtec.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        <linux-fbdev@vger.kernel.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] video: fbdev: via_aux_vt1636: remove VLA usage
Message-ID: <20180309101149.46ew4havwqa4mupu@imgtec.com>
References: <20180307194703.GA3862@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20180307194703.GA3862@embeddedgus>
User-Agent: NeoMutt/20171215
X-Originating-IP: [10.60.4.28]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 2018-03-07 13:47:03 -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wvla, remove VLA and replace it
> with a fixed-length array instead. Also, remove variable 'len'.
> 
> Notice that no new IDs have been added in seven years.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/video/fbdev/via/via_aux_vt1636.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/via/via_aux_vt1636.c b/drivers/video/fbdev/via/via_aux_vt1636.c
> index 9e015c1..d6273a4 100644
> --- a/drivers/video/fbdev/via/via_aux_vt1636.c
> +++ b/drivers/video/fbdev/via/via_aux_vt1636.c
> @@ -35,10 +35,10 @@ void via_aux_vt1636_probe(struct via_aux_bus *bus)
>  		.addr	=	0x40,
>  		.name	=	name};
>  	/* check vendor id and device id */
> -	const u8 id[] = {0x06, 0x11, 0x45, 0x33}, len = ARRAY_SIZE(id);
> -	u8 tmp[len];
> +	const u8 id[4] = {0x06, 0x11, 0x45, 0x33};
> +	u8 tmp[4];
>  
> -	if (!via_aux_read(&drv, 0x00, tmp, len) || memcmp(id, tmp, len))
> +	if (!via_aux_read(&drv, 0x00, tmp, 4) || memcmp(id, tmp, 4))

I would recommend keeping ARRAY_SIZE(); even if nothing's been added in
a while, it's still clearer in the code if we can see where these `4`
come from.

Something like this instead?
----8<----
@@ -35,10 +35,10 @@ void via_aux_vt1636_probe(struct via_aux_bus *bus)
 		.addr	=	0x40,
 		.name	=	name};
 	/* check vendor id and device id */
-	const u8 id[] = {0x06, 0x11, 0x45, 0x33}, len = ARRAY_SIZE(id);
-	u8 tmp[len];
+	const u8 id[] = {0x06, 0x11, 0x45, 0x33};
+	u8 tmp[ARRAY_SIZE(id)];
 
-	if (!via_aux_read(&drv, 0x00, tmp, len) || memcmp(id, tmp, len))
+	if (!via_aux_read(&drv, 0x00, tmp, ARRAY_SIZE(id)) || memcmp(id, tmp, ARRAY_SIZE(id)))
 		return;
 
 	printk(KERN_INFO "viafb: Found %s\n", name);
---->8----

Note that sizeof is evaluated a compile time, so `u8 tmp[ARRAY_SIZE(id)]`
is *not* a VLA. All that's needed was to remove `len` :)

>  		return;
>  
>  	printk(KERN_INFO "viafb: Found %s\n", name);
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
