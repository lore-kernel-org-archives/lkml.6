Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B693EC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6242082A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 15:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6242082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbeKEAZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 19:25:33 -0500
Received: from mga06.intel.com ([134.134.136.31]:60658 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730148AbeKEAZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 19:25:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2018 07:10:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,464,1534834800"; 
   d="scan'208";a="83905861"
Received: from kbyon-mobl.amr.corp.intel.com (HELO [10.251.138.109]) ([10.251.138.109])
  by fmsmga008.fm.intel.com with ESMTP; 04 Nov 2018 07:10:13 -0800
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: mrfld: fix uninitialized
 variable access
To:     Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20181103212140.890081-1-arnd@arndb.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f14b9bda-47d9-cb3a-b881-0a8058a0f59c@linux.intel.com>
Date:   Sun, 4 Nov 2018 09:10:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181103212140.890081-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/3/18 4:21 PM, Arnd Bergmann wrote:
> Randconfig testing revealed a very old bug, with gcc-8:
>
> sound/soc/intel/atom/sst/sst_loader.c: In function 'sst_load_fw':
> sound/soc/intel/atom/sst/sst_loader.c:357:5: error: 'fw' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>    if (fw == NULL) {
>       ^
> sound/soc/intel/atom/sst/sst_loader.c:354:25: note: 'fw' was declared here
>    const struct firmware *fw;
>
> We must check the return code of request_firmware() before we look at the
> pointer result that may be uninitialized when the function fails.

yes indeed, good catch.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

>
> Fixes: 9012c9544eea ("ASoC: Intel: mrfld - Add DSP load and management")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   sound/soc/intel/atom/sst/sst_loader.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/sound/soc/intel/atom/sst/sst_loader.c b/sound/soc/intel/atom/sst/sst_loader.c
> index 27413ebae956..b8c456753f01 100644
> --- a/sound/soc/intel/atom/sst/sst_loader.c
> +++ b/sound/soc/intel/atom/sst/sst_loader.c
> @@ -354,14 +354,14 @@ static int sst_request_fw(struct intel_sst_drv *sst)
>   	const struct firmware *fw;
>   
>   	retval = request_firmware(&fw, sst->firmware_name, sst->dev);
> -	if (fw == NULL) {
> -		dev_err(sst->dev, "fw is returning as null\n");
> -		return -EINVAL;
> -	}
>   	if (retval) {
>   		dev_err(sst->dev, "request fw failed %d\n", retval);
>   		return retval;
>   	}
> +	if (fw == NULL) {
> +		dev_err(sst->dev, "fw is returning as null\n");
> +		return -EINVAL;
> +	}
>   	mutex_lock(&sst->sst_lock);
>   	retval = sst_cache_and_parse_fw(sst, fw);
>   	mutex_unlock(&sst->sst_lock);
