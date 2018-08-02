Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1B5C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0AE121566
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 19:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0AE121566
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbeHBVdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 17:33:17 -0400
Received: from bmailout2.hostsharing.net ([83.223.90.240]:52075 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeHBVdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 17:33:17 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id C62342800B3C5;
        Thu,  2 Aug 2018 21:40:41 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 5570B2FEA6; Thu,  2 Aug 2018 21:40:41 +0200 (CEST)
Date:   Thu, 2 Aug 2018 21:40:41 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Lyude Paul <lyude@redhat.com>
Cc:     nouveau@lists.freedesktop.org,
        Karol Herbst <karolherbst@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 8/8] drm/nouveau: Call pm_runtime_get_noresume() from
 hpd handlers
Message-ID: <20180802194041.GC6180@wunner.de>
References: <20180801211459.7731-1-lyude@redhat.com>
 <20180801211459.7731-9-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801211459.7731-9-lyude@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 01, 2018 at 05:14:58PM -0400, Lyude Paul wrote:
> We can't and don't need to try resuming the device from our hotplug
> handlers, but hotplug events are generally something we'd like to keep
> the device awake for whenever possible. So, grab a PM ref safely in our
> hotplug handlers using pm_runtime_get_noresume() and mark the device as
> busy once we're finished.

Patch looks fine in principle, but doesn't seem to be sufficient to fix
the following race:

1. runtime_suspend commences
2. user plugs in a display before the runtime_suspend worker disables
   hotplug interrupts in nouveau_display_fini()
3. hotplug is handled, display is lit up
4. runtime_suspend worker waits for hotplug handler to finish
5. GPU is runtime suspended and the newly plugged in display goes black

The call to pm_runtime_mark_last_busy() has no effect in this situation
because rpm_suspend() doesn't look at the last_busy variable after the
call to rpm_callback().  What's necessary here is that runtime_suspend is
aborted and -EBUSY returned.

Thanks,

Lukas

> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: stable@vger.kernel.org
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Karol Herbst <karolherbst@gmail.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_connector.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
> index 8409c3f2c3a1..5a8e8c1ad647 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -1152,6 +1152,11 @@ nouveau_connector_hotplug(struct nvif_notify *notify)
>  	const char *name = connector->name;
>  	struct nouveau_encoder *nv_encoder;
>  
> +	/* Resuming the device here isn't possible; but the suspend PM ops
> +	 * will wait for us to finish our work before disabling us so this
> +	 * should be enough
> +	 */
> +	pm_runtime_get_noresume(drm->dev->dev);
>  	nv_connector->hpd_task = current;
>  
>  	if (rep->mask & NVIF_NOTIFY_CONN_V0_IRQ) {
> @@ -1171,6 +1176,9 @@ nouveau_connector_hotplug(struct nvif_notify *notify)
>  	}
>  
>  	nv_connector->hpd_task = NULL;
> +
> +	pm_runtime_mark_last_busy(drm->dev->dev);
> +	pm_runtime_put_autosuspend(drm->dev->dev);
>  	return NVIF_NOTIFY_KEEP;
>  }
>  
> -- 
> 2.17.1
> 
