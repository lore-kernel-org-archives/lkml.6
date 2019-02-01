Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB07C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769BB218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 14:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbfBAOwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 09:52:17 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:23827 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727450AbfBAOwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 09:52:17 -0500
Received: from pmoreau.org (unknown [84.198.244.197])
        (Authenticated sender: pierre.morrow)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 9BDAF200424;
        Fri,  1 Feb 2019 15:52:01 +0100 (CET)
Date:   Fri, 1 Feb 2019 15:51:43 +0100
From:   Pierre Moreau <pierre.morrow@free.fr>
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [Nouveau] [PATCH -next] drm/nouveau: fix copy-paste error in
 nouveau_fence_wait_uevent_handler
Message-ID: <20190201145143.vwiljlpfa5waqyr7@pmoreau.org>
Mail-Followup-To: Ben Skeggs <bskeggs@redhat.com>,
        YueHaibing <yuehaibing@huawei.com>, David Airlie <airlied@linux.ie>,
        nouveau@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <1542284042-153903-1-git-send-email-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1542284042-153903-1-git-send-email-yuehaibing@huawei.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping, Ben.
I see that in `nouveau_fence_done()` there is a check on `chan` not being NULL
prior to passing it to `nouveau_fence_update()`. Would something similar be
needed here?

Pierre

On 2018-11-15 — 12:14, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/gpu/drm/nouveau/nouveau_fence.c: In function 'nouveau_fence_wait_uevent_handler':
> drivers/gpu/drm/nouveau/nouveau_fence.c:156:27: warning:
>  variable 'chan' set but not used [-Wunused-but-set-variable]
> 
> nouveau_fence_update should use rcu protected 'chan'
> rather than 'fence->channel'
> 
> Fixes: 0ec5f02f0e2c ("drm/nouveau: prevent stale fence->channel pointers, and protect with rcu")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_fence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/nouveau/nouveau_fence.c
> index d4964f3..91286d0 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_fence.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
> @@ -157,7 +157,7 @@
>  
>  		fence = list_entry(fctx->pending.next, typeof(*fence), head);
>  		chan = rcu_dereference_protected(fence->channel, lockdep_is_held(&fctx->lock));
> -		if (nouveau_fence_update(fence->channel, fctx))
> +		if (nouveau_fence_update(chan, fctx))
>  			ret = NVIF_NOTIFY_DROP;
>  	}
>  	spin_unlock_irqrestore(&fctx->lock, flags);
> 
> 
> 
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
