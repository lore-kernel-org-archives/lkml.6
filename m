Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9387C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9321206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 17:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xhjZ1hUQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbfBSRGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 12:06:12 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42836 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbfBSRGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 12:06:12 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1JH5PBB093841;
        Tue, 19 Feb 2019 11:05:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550595925;
        bh=2vPgCDSqvTggKvWD79zvCXLn7IeLn2DADd4mN5V801s=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xhjZ1hUQqPy7PSP7wDv9rH3l/8GBZjvn1Xj494hVKfOmcgnFjte2FLTeZZ7x++qL9
         /SQWSxIcHPD18kUSeCExAcvk8PrB8iyY1KfdH2a0MKsjmU2E+dhymmBpMPap7JX0nc
         gOKvAuAMqE14d/JXYHy5RhgGCEFbi2lEE1LKnu08=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1JH5PSs045608
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Feb 2019 11:05:25 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 19
 Feb 2019 11:05:25 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 19 Feb 2019 11:05:25 -0600
Received: from [172.22.103.104] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1JH5OkP025868;
        Tue, 19 Feb 2019 11:05:24 -0600
Subject: Re: [PATCH v2 1/2] ASoC: codecs: pcm186x: fix wrong usage of
 DECLARE_TLV_DB_SCALE()
To:     <Codrin.Ciubotariu@microchip.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>
CC:     <dannenberg@ti.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20190219162840.7244-1-codrin.ciubotariu@microchip.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <abf49724-6567-43cf-852c-027c7948860d@ti.com>
Date:   Tue, 19 Feb 2019 11:05:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190219162840.7244-1-codrin.ciubotariu@microchip.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/19 10:29 AM, Codrin.Ciubotariu@microchip.com wrote:
> From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> 
> According to DS, the gain is between -12 dB and 40 dB, with a 0.5 dB step.
> Tested on pcm1863.
> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---

Acked-by: Andrew F. Davis <afd@ti.com>

> 
> Changes in v2:
>  - fixed title - added correct macro;
>  - revert the removal of a new line;
> 
>  sound/soc/codecs/pcm186x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/pcm186x.c b/sound/soc/codecs/pcm186x.c
> index 809b7e9f03ca..c36a391fec8a 100644
> --- a/sound/soc/codecs/pcm186x.c
> +++ b/sound/soc/codecs/pcm186x.c
> @@ -42,7 +42,7 @@ struct pcm186x_priv {
>  	bool is_master_mode;
>  };
>  
> -static const DECLARE_TLV_DB_SCALE(pcm186x_pga_tlv, -1200, 4000, 50);
> +static const DECLARE_TLV_DB_SCALE(pcm186x_pga_tlv, -1200, 50, 0);
>  
>  static const struct snd_kcontrol_new pcm1863_snd_controls[] = {
>  	SOC_DOUBLE_R_S_TLV("ADC Capture Volume", PCM186X_PGA_VAL_CH1_L,
> 
