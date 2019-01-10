Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731AAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B49B20665
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 02:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfAJCvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 21:51:01 -0500
Received: from mga07.intel.com ([134.134.136.100]:52610 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727235AbfAJCvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 21:51:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2019 18:50:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,459,1539673200"; 
   d="scan'208";a="290363097"
Received: from apulla-mobl2.amr.corp.intel.com (HELO [10.252.139.64]) ([10.252.139.64])
  by orsmga005.jf.intel.com with ESMTP; 09 Jan 2019 18:50:56 -0800
Subject: Re: [alsa-devel] [PATCH -next v2] ASoC: Intel: bytcht_es8316: use
 correct drvdata in snd_byt_cht_es8316_mc_remove()
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <1547023011-8321-1-git-send-email-weiyongjun1@huawei.com>
 <1547084589-40006-1-git-send-email-weiyongjun1@huawei.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e8051a70-be59-9c08-b998-bdd8d291aa73@linux.intel.com>
Date:   Wed, 9 Jan 2019 20:50:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1547084589-40006-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/9/19 7:43 PM, Wei Yongjun wrote:
> The snd_byt_cht_es8316_mc_remove() use the platform drvdata as a type
> of 'struct byt_cht_es8316_private', but snd_byt_cht_es8316_mc_probe()
> set it to 'struct snd_soc_card', as suggested by Dan Carpenter, fix
> the usage in snd_byt_cht_es8316_mc_remove().
>
> Fixes: 0d3e91da0750 ("ASoC: Intel: bytcht_es8316: Add external speaker mux support")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
> v1 -> v2: fix snd_byt_cht_es8316_mc_remove() instead, suggested by Dan.
> ---
>   sound/soc/intel/boards/bytcht_es8316.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
> index cdf2061..fa9c4cf 100644
> --- a/sound/soc/intel/boards/bytcht_es8316.c
> +++ b/sound/soc/intel/boards/bytcht_es8316.c
> @@ -544,7 +544,8 @@ static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
>   
>   static int snd_byt_cht_es8316_mc_remove(struct platform_device *pdev)
>   {
> -	struct byt_cht_es8316_private *priv = platform_get_drvdata(pdev);
> +	struct snd_soc_card *card = platform_get_drvdata(pdev);
> +	struct byt_cht_es8316_private *priv = snd_soc_card_get_drvdata(card);
>   
>   	gpiod_put(priv->speaker_en_gpio);
>   	return 0;
>
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
