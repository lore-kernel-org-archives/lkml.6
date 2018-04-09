Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753464AbeDIS5r (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 14:57:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:52110 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753244AbeDIS5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 14:57:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,427,1517904000";
   d="scan'208";a="45489001"
Subject: Re: [alsa-devel] [PATCH] sound: soc: intel: bxt_da7219_max98357a:
 Replace GFP_ATOMIC with GFP_KERNEL in broxton_audio_probe
To: Jia-Ju Bai <baijiaju1990@gmail.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        sathyanarayana.nujella@intel.com, Adam.Thomson.Opensource@diasemi.com
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vinod.koul@intel.com>
References: <1523270781-22627-1-git-send-email-baijiaju1990@gmail.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <482591fb-bf12-2e0a-e0ef-2ae0b4095000@linux.intel.com>
Date: Mon, 9 Apr 2018 13:57:43 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1523270781-22627-1-git-send-email-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/18 5:46 AM, Jia-Ju Bai wrote:
> broxton_audio_probe() is never called in atomic context.
> This function is only set as ".probe" in "struct platform_driver".
> 
> Despite never getting called from atomic context,
> broxton_audio_probe() calls devm_kzalloc() with GFP_ATOMIC,
> which waits busily for allocation.
> GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
> to avoid busy waiting and improve the possibility of sucessful allocation.

[answering for the series]
Humm, this is interesting.
If indeed we can afford to sleep then the change should be done on ALL 
14 boards in sound/soc/intel/boards which follow the same code pattern.
If we cannot sleep then then none of these changes should be applied.
Liam and Vinod?

> 
> This is found by a static analysis tool named DCNS written by myself.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>   sound/soc/intel/boards/bxt_da7219_max98357a.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
> index ce35ec7..f4361b7 100644
> --- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
> +++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
> @@ -585,7 +585,7 @@ static int broxton_audio_probe(struct platform_device *pdev)
>   {
>   	struct bxt_card_private *ctx;
>   
> -	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_ATOMIC);
> +	ctx = devm_kzalloc(&pdev->dev, sizeof(*ctx), GFP_KERNEL);
>   	if (!ctx)
>   		return -ENOMEM;
>   
> 
