Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F89ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5629C208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5629C208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbeGQHrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:47:53 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:48591 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbeGQHrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:47:53 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 8906E280248C7;
        Tue, 17 Jul 2018 09:16:41 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 27F57E791; Tue, 17 Jul 2018 09:16:41 +0200 (CEST)
Date:   Tue, 17 Jul 2018 09:16:41 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>, linux-pm@vger.kernel.org
Subject: Re: [Nouveau] [PATCH 1/5] drm/nouveau: Prevent RPM callback
 recursion in suspend/resume paths
Message-ID: <20180717071641.GA5411@wunner.de>
References: <20180716235936.11268-1-lyude@redhat.com>
 <20180716235936.11268-2-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716235936.11268-2-lyude@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[cc += linux-pm]

Hi Lyude,

First of all, thanks a lot for looking into this. 

On Mon, Jul 16, 2018 at 07:59:25PM -0400, Lyude Paul wrote:
> In order to fix all of the spots that need to have runtime PM get/puts()
> added, we need to ensure that it's possible for us to call
> pm_runtime_get/put() in any context, regardless of how deep, since
> almost all of the spots that are currently missing refs can potentially
> get called in the runtime suspend/resume path. Otherwise, we'll try to
> resume the GPU as we're trying to resume the GPU (and vice-versa) and
> cause the kernel to deadlock.
> 
> With this, it should be safe to call the pm runtime functions in any
> context in nouveau with one condition: any point in the driver that
> calls pm_runtime_get*() cannot hold any locks owned by nouveau that
> would be acquired anywhere inside nouveau_pmops_runtime_resume().
> This includes modesetting locks, i2c bus locks, etc.
[snip]
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -835,6 +835,8 @@ nouveau_pmops_runtime_suspend(struct device *dev)
>  		return -EBUSY;
>  	}
>  
> +	dev->power.disable_depth++;
> +

I'm not sure if that variable is actually private to the PM core.
Grepping through the tree I only find a single occurrence where it's
accessed outside the PM core and that's in amdgpu.  So this looks
a little fishy TBH.  It may make sense to cc such patches to linux-pm
to get Rafael & other folks involved with the PM core to comment.

Also, the disable_depth variable only exists if the kernel was
compiled with CONFIG_PM enabled, but I can't find a "depends on PM"
or something like that in nouveau's Kconfig.  Actually, if PM is
not selected, all the nouveau_pmops_*() functions should be #ifdef'ed
away, but oddly there's no #ifdef CONFIG_PM anywhere in nouveau_drm.c.

Anywayn, if I understand the commit message correctly, you're hitting a
pm_runtime_get_sync() in a code path that itself is called during a
pm_runtime_get_sync().  Could you include stack traces in the commit
message?  My gut feeling is that this patch masks a deeper issue,
e.g. if the runtime_resume code path does in fact directly poll outputs,
that would seem wrong.  Runtime resume should merely make the card
accessible, i.e. reinstate power if necessary, put into PCI_D0,
restore registers, etc.  Output polling should be scheduled
asynchronously.

Thanks,

Lukas
