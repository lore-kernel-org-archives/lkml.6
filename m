Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD747C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C0221567
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68C0221567
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbeHBVGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 17:06:35 -0400
Received: from bmailout1.hostsharing.net ([83.223.95.100]:51763 "EHLO
        bmailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbeHBVGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 17:06:35 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 7A43330001EAF;
        Thu,  2 Aug 2018 21:14:05 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 4560A2FEA6; Thu,  2 Aug 2018 21:14:05 +0200 (CEST)
Date:   Thu, 2 Aug 2018 21:14:05 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>, stable@vger.kernel.org,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/8] drm/nouveau: Enable polling even if we have
 runtime PM
Message-ID: <20180802191405.GB6180@wunner.de>
References: <20180801211459.7731-1-lyude@redhat.com>
 <20180801211459.7731-3-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801211459.7731-3-lyude@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 05:14:52PM -0400, Lyude Paul wrote:
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -592,10 +592,11 @@ nouveau_drm_load(struct drm_device *dev, unsigned long flags)
>  		pm_runtime_allow(dev->dev);
>  		pm_runtime_mark_last_busy(dev->dev);
>  		pm_runtime_put(dev->dev);
> -	} else {
> -		/* enable polling for external displays */
> -		drm_kms_helper_poll_enable(dev);
>  	}
> +
> +	/* enable polling for connectors without hpd */
> +	drm_kms_helper_poll_enable(dev);
> +

I'm wondering why drm_kms_helper_poll_enable() is called here at all.
Does the invocation in nouveau_display_init() not suffice?  Can there
be a situation when nouveau_display_init() is not called despite there
being connectors that need to be polled?

Thanks,

Lukas
