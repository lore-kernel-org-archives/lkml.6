Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755934AbeDWPgw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 11:36:52 -0400
Received: from foss.arm.com ([217.140.101.70]:42444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755636AbeDWPgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 11:36:49 -0400
Date: Mon, 23 Apr 2018 16:36:47 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Ayan Kumar Halder <ayan.halder@arm.com>
Cc: brian.starkey@arm.com, malidp@foss.arm.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nd@arm.com
Subject: Re: [PATCH v2 6/8] drm/arm/malidp: Enable/disable the scaling engine
 interrupts with memory writeback
Message-ID: <20180423153647.GF14661@e110455-lin.cambridge.arm.com>
References: <1524495051-3891-1-git-send-email-ayan.halder@arm.com>
 <1524495051-3891-7-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1524495051-3891-7-git-send-email-ayan.halder@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 03:50:49PM +0100, Ayan Kumar Halder wrote:
> Scaling engine interrupts need to be enabled/disabled as and when memwrite
> is enabled and disabled. The reason being scaling engine interrupts are
> used only by the memory writeout layer.
> 
> This patch depends on:
> https://lkml.org/lkml/2017/5/15/695
> 
> Signed-off-by: Ayan Kumar Halder <ayan.halder@arm.com>
> 
> ---
> Changes in v2:-
> - Removed the change id and modified the commit message
> ---
>  drivers/gpu/drm/arm/malidp_hw.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
> index f5633bc..90d76e4 100644
> --- a/drivers/gpu/drm/arm/malidp_hw.c
> +++ b/drivers/gpu/drm/arm/malidp_hw.c
> @@ -621,12 +621,14 @@ static int malidp550_enable_memwrite(struct malidp_hw_device *hwdev,
>  	malidp_hw_setbits(hwdev, MALIDP550_SE_MEMWRITE_ONESHOT | MALIDP_SE_MEMWRITE_EN,
>  			  MALIDP550_SE_CONTROL);
>  
> +	malidp_se_irq_hw_init(hwdev);
>  	return 0;
>  }
>  
>  static void malidp550_disable_memwrite(struct malidp_hw_device *hwdev)
>  {
>  	u32 base = malidp_get_block_base(hwdev, MALIDP_DE_BLOCK);
> +	malidp_se_irq_fini(hwdev);
>  	malidp_hw_clearbits(hwdev, MALIDP550_SE_MEMWRITE_ONESHOT | MALIDP_SE_MEMWRITE_EN,
>  			    MALIDP550_SE_CONTROL);
>  	malidp_hw_clearbits(hwdev, MALIDP_SCALE_ENGINE_EN, base + MALIDP_DE_DISPLAY_FUNC);

We now know that this patch is broken, because it disables interrupts
for the writeback after a previous commit has enabled them but before
the writeback engine has finished writing, so the better place for
enabling and disabling the SE IRQs is in the malidp_pm_{suspend,resume}
functions, not here.

Only for this patch: NACK.

Best regards,
Liviu

> -- 
> 2.7.4
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
