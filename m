Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552D6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D882086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 17:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R0C1bhrb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D882086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388586AbeKPDRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:17:24 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40744 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388226AbeKPDRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 22:17:23 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAFH8Y08041568;
        Thu, 15 Nov 2018 11:08:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542301714;
        bh=SA+c35vcb26k/opTxQsDRWa5JGWStheeBFdX6SNDG5Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=R0C1bhrb1C+nuROdNandkSPSuoJqp4+Ejr1c5yADnJteTCy72tXJp0mKnrkAKMB/g
         dU3NyNWjH/uo/iSjZkpdhtzybUOYfcH3dX6zfEKpCvxPV2hKUMYmFz6Mw9l+hb+P9F
         gZfEj9Ro3pfA1n+6gZ41gs9Xd0nJcBC4w5eSSXwE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAFH8Yx8089143
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Nov 2018 11:08:34 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 15
 Nov 2018 11:08:34 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 15 Nov 2018 11:08:34 -0600
Received: from [10.247.29.163] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAFH8YUc002943;
        Thu, 15 Nov 2018 11:08:34 -0600
Subject: Re: [PATCH] ASoC: pcm186x: Fix device reset-registers trigger value
To:     Andreas Dannenberg <dannenberg@ti.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Stephane Le Provost <stephane.leprovost@mediatek.com>
References: <20181115170131.1839-1-dannenberg@ti.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <a7db24e0-94fe-7875-c4a6-84d739ac185b@ti.com>
Date:   Thu, 15 Nov 2018 11:08:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181115170131.1839-1-dannenberg@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/18 11:01 AM, Andreas Dannenberg wrote:
> According to the current device datasheet (TI Lit # SLAS831D, revised
> March 2018) the value written to the device's PAGE register to trigger
> a complete register reset should be 0xfe, not 0xff. So go ahead and
> update to the correct value.
> 
> Reported-by: Stephane Le Provost <stephane.leprovost@mediatek.com>
> Tested-by: Stephane Le Provost <stephane.leprovost@mediatek.com>
> Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
> ---


Does 0xff not reset the device? If so then this is not just a typo but a
bug and this patch should have a fixes tag. Either way:

Acked-by: Andrew F. Davis <afd@ti.com>


>  sound/soc/codecs/pcm186x.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/pcm186x.h b/sound/soc/codecs/pcm186x.h
> index 2c6ba55bf394..bb3f0c42a1cd 100644
> --- a/sound/soc/codecs/pcm186x.h
> +++ b/sound/soc/codecs/pcm186x.h
> @@ -139,7 +139,7 @@ enum pcm186x_type {
>  #define PCM186X_MAX_REGISTER		PCM186X_CURR_TRIM_CTRL
>  
>  /* PCM186X_PAGE */
> -#define PCM186X_RESET			0xff
> +#define PCM186X_RESET			0xfe
>  
>  /* PCM186X_ADCX_INPUT_SEL_X */
>  #define PCM186X_ADC_INPUT_SEL_POL	BIT(7)
> 
