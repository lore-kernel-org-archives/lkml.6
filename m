Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27485C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B1421567
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:10:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B1421567
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbeHBVDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 17:03:17 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:45443 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbeHBVDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 17:03:17 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 69C88100DA1A6;
        Thu,  2 Aug 2018 21:10:48 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 092A9355EE; Thu,  2 Aug 2018 21:10:47 +0200 (CEST)
Date:   Thu, 2 Aug 2018 21:10:47 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>, stable@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/8] drm/nouveau: Fix bogus
 drm_kms_helper_poll_enable() placement
Message-ID: <20180802191047.GA6180@wunner.de>
References: <20180801211459.7731-1-lyude@redhat.com>
 <20180801211459.7731-2-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801211459.7731-2-lyude@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lyude,

thanks a lot for your persistence in attacking these runtime PM
issues in nouveau.  v4 of this series looks very good overall.
I only have comments on patches 1, 2 and 8.  On this patch 1
it's merely a nit:

On Wed, Aug 01, 2018 at 05:14:51PM -0400, Lyude Paul wrote:
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -835,7 +835,6 @@ nouveau_pmops_runtime_suspend(struct device *dev)
>  		return -EBUSY;
>  	}
>  
> -	drm_kms_helper_poll_disable(drm_dev);
>  	nouveau_switcheroo_optimus_dsm();
>  	ret = nouveau_do_suspend(drm_dev, true);
>  	pci_save_state(pdev);

This third hunk in the patch lacks an explanation in the commit message.
I think its rationale is that drm_kms_helper_poll_disable() is already
invoked in nouveau_display_fini(), which gets called on ->runtime_suspend,
hence need not be invoked once more in nouveau_pmops_runtime_suspend().

Thanks,

Lukas
