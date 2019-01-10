Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBA0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8B0214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 09:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="cJvYz2cF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfAJJKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 04:10:43 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45840 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727220AbfAJJKm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 04:10:42 -0500
Received: from zn.tnic (p200300EC2BC5CF005460B1C1902C795E.dip0.t-ipconnect.de [IPv6:2003:ec:2bc5:cf00:5460:b1c1:902c:795e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 84A021EC0432;
        Thu, 10 Jan 2019 10:10:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547111440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=avkZMy8iTqCYsOP/GBrvrkJxLCKAdcWdpaJY93QfGqw=;
        b=cJvYz2cFf0BxRqMEpVCBujk2YoW6iI+hnEhO2n89CBUsrB6Sya2ddhSkiETe/cylv3put0
        srjclBTpP8uVYNhCIL/IzrLfe/ovfx17RTVz8gHPU6cUis6qg75KyFK/zXOWQNecsr8HuF
        9vnL62VOTOVgKoA2YU/r8ZUdUYdCMh0=
Date:   Thu, 10 Jan 2019 10:10:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Liwei Song <liwei.song@windriver.com>
Cc:     Mauro <mchehab@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] edac: unregister the mci device before free the mci
 memory
Message-ID: <20190110091031.GA17621@zn.tnic>
References: <1545721984-183750-1-git-send-email-liwei.song@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1545721984-183750-1-git-send-email-liwei.song@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 25, 2018 at 02:13:04AM -0500, Liwei Song wrote:
> this patch can fix the following kmemleak:
> 
> unreferenced object 0xffff881022b60ee0 (size 32):
>   comm "udevd", pid 262, jiffies 4294709066 (age 1410.265s)
>   hex dump (first 32 bytes):
>     00 7c e8 18 10 88 ff ff 00 74 e8 18 10 88 ff ff .|.......t......
>     00 70 e8 18 10 88 ff ff 00 00 00 00 00 00 00 00 .p..............
>   backtrace:
>     [<ffffffff819814b6>] kmemleak_alloc+0x26/0x50
>     [<ffffffff8115b194>] __kmalloc+0x154/0x2f0
>     [<ffffffff817ca848>] edac_mc_alloc+0x278/0x6d0
>     [<ffffffffa0106f9d>] 0xffffffffa0106f9d
>     [<ffffffff8140c9ae>] local_pci_probe+0x3e/0x70
>     [<ffffffff8140cbb1>] pci_device_probe+0x121/0x130
>     [<ffffffff8155be85>] driver_probe_device+0x105/0x260
>     [<ffffffff8155c0b3>] __driver_attach+0x93/0xa0
>     [<ffffffff81559ed3>] bus_for_each_dev+0x63/0xa0
>     [<ffffffff8155b90e>] driver_attach+0x1e/0x20
>     [<ffffffff8155b500>] bus_add_driver+0x1f0/0x290
>     [<ffffffff8155c6e4>] driver_register+0x64/0xf0
>     [<ffffffff8140c81c>] __pci_register_driver+0x4c/0x50
>     [<ffffffffa010d050>] 0xffffffffa010d050
>     [<ffffffff810002d2>] do_one_initcall+0x102/0x160
>     [<ffffffff810a25e5>] load_module+0x1a65/0x2230
> 
> The kmemleak happened when run "rmmod sb_edac.ko".
> In edac_mc_free, only after mci device is ungistered, it will do the mci
> free task, or it will do the mci unregister action, adjust the sequence
> of the free task to ungister the device first and then free the mci
> struct, then all memory allocated(Include dimms, csrows, channels)by
> edac_mc_alloc() will got freed by edac_mc_free();

I'm reading and rereading that "sentence" and still have no clue what
it is trying to say.

Maybe because it needs to be split into clear and simple declarative
sentences explaining what the problem is first, then what happens and
then what the proposed solution is. All in simple declarative sentences.

Also, spellcheck your writing - there's no "ungister".

> Because all allocated memory was freed by edac_mc_free() and the release
> hook in edac_mc_sysfs.c can not release all allocated memory of EDAC MC,
> so remove the free fragment from it to aviod duplicated memory free.

What duplicated memory freeing - above says "unreferenced object" which
looks to me like it didn't get freed at all.

> Signed-off-by: Liwei Song <liwei.song@windriver.com>
> ---
>  drivers/edac/edac_mc.c       |  7 ++++---
>  drivers/edac/edac_mc_sysfs.c | 12 ------------
>  2 files changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index 7d3edd713932..12d9dc9cf85e 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -506,6 +506,10 @@ void edac_mc_free(struct mem_ctl_info *mci)
>  {
>  	edac_dbg(1, "\n");
>  
> +	/* the mci instance is freed here, when the sysfs object is dropped */
> +	if (device_is_registered(&mci->dev))
> +		edac_unregister_sysfs(mci);
> +
>  	/* If we're not yet registered with sysfs free only what was allocated
>  	 * in edac_mc_alloc().
>  	 */
> @@ -513,9 +517,6 @@ void edac_mc_free(struct mem_ctl_info *mci)
>  		_edac_mc_free(mci);
>  		return;
>  	}
> -
> -	/* the mci instance is freed here, when the sysfs object is dropped */
> -	edac_unregister_sysfs(mci);
>  }
>  EXPORT_SYMBOL_GPL(edac_mc_free);
>  
> diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
> index 20374b8248f0..20211b4ee2f1 100644
> --- a/drivers/edac/edac_mc_sysfs.c
> +++ b/drivers/edac/edac_mc_sysfs.c
> @@ -276,10 +276,6 @@ static const struct attribute_group *csrow_attr_groups[] = {
>  
>  static void csrow_attr_release(struct device *dev)
>  {
> -	struct csrow_info *csrow = container_of(dev, struct csrow_info, dev);
> -
> -	edac_dbg(1, "Releasing csrow device %s\n", dev_name(dev));
> -	kfree(csrow);
>  }
>  
>  static const struct device_type csrow_attr_type = {
> @@ -616,10 +612,6 @@ static const struct attribute_group *dimm_attr_groups[] = {
>  
>  static void dimm_attr_release(struct device *dev)
>  {
> -	struct dimm_info *dimm = container_of(dev, struct dimm_info, dev);
> -
> -	edac_dbg(1, "Releasing dimm device %s\n", dev_name(dev));
> -	kfree(dimm);
>  }
>  
>  static const struct device_type dimm_attr_type = {
> @@ -892,10 +884,6 @@ static const struct attribute_group *mci_attr_groups[] = {
>  
>  static void mci_attr_release(struct device *dev)
>  {
> -	struct mem_ctl_info *mci = container_of(dev, struct mem_ctl_info, dev);
> -
> -	edac_dbg(1, "Releasing csrow device %s\n", dev_name(dev));
> -	kfree(mci);
>  }

And those functions will become empty?

This all looks strange to me. Please try again.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
