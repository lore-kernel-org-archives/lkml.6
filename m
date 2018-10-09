Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07113C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA0C52087D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA0C52087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbeJIUrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:47:19 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51149 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbeJIUrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:47:18 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5924E207C3; Tue,  9 Oct 2018 15:30:18 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 261AE20712;
        Tue,  9 Oct 2018 15:30:18 +0200 (CEST)
Date:   Tue, 9 Oct 2018 15:30:18 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] drm/v3d: Skip debugfs dumping GCA on platforms
 without GCA.
Message-ID: <20181009153018.03867fea@bbrezillon>
In-Reply-To: <20180928232126.4332-4-eric@anholt.net>
References: <20180928232126.4332-1-eric@anholt.net>
        <20180928232126.4332-4-eric@anholt.net>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2018 16:21:26 -0700
Eric Anholt <eric@anholt.net> wrote:

> Fixes an oops reading this debugfs entry on BCM7278.
> 

You probably want to add:

Fixes: 57692c94dcbe ("drm/v3d: Introduce a new DRM driver for Broadcom V3D V3.x+")
Cc: <stable@vger.kernel.org>

> Signed-off-by: Eric Anholt <eric@anholt.net>

In any case, this is

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/gpu/drm/v3d/v3d_debugfs.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_debugfs.c b/drivers/gpu/drm/v3d/v3d_debugfs.c
> index d48008adb085..eb2b2d2f8553 100644
> --- a/drivers/gpu/drm/v3d/v3d_debugfs.c
> +++ b/drivers/gpu/drm/v3d/v3d_debugfs.c
> @@ -71,10 +71,13 @@ static int v3d_v3d_debugfs_regs(struct seq_file *m, void *unused)
>  			   V3D_READ(v3d_hub_reg_defs[i].reg));
>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(v3d_gca_reg_defs); i++) {
> -		seq_printf(m, "%s (0x%04x): 0x%08x\n",
> -			   v3d_gca_reg_defs[i].name, v3d_gca_reg_defs[i].reg,
> -			   V3D_GCA_READ(v3d_gca_reg_defs[i].reg));
> +	if (v3d->ver < 41) {
> +		for (i = 0; i < ARRAY_SIZE(v3d_gca_reg_defs); i++) {
> +			seq_printf(m, "%s (0x%04x): 0x%08x\n",
> +				   v3d_gca_reg_defs[i].name,
> +				   v3d_gca_reg_defs[i].reg,
> +				   V3D_GCA_READ(v3d_gca_reg_defs[i].reg));
> +		}
>  	}
>  
>  	for (core = 0; core < v3d->cores; core++) {

