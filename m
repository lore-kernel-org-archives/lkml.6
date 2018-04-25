Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751426AbeDYHMd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 03:12:33 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39459 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750945AbeDYHMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 03:12:32 -0400
From: Yannick FERTRE <yannick.fertre@st.com>
To: Philippe CORNU <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        "David Airlie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alexandre TORGUE <alexandre.torgue@st.com>
Subject: Re: [PATCH] drm/stm: ltdc: fix deferred endpoint management
Thread-Topic: [PATCH] drm/stm: ltdc: fix deferred endpoint management
Thread-Index: AQHT1kAeg2xTBfuOqE2IlGfCK/9MDKQQ+3mA
Date: Wed, 25 Apr 2018 07:12:21 +0000
Message-ID: <22c16fe0-9f0b-c325-4a7c-35f3aa86dd86@st.com>
References: <20180417113441.8214-1-philippe.cornu@st.com>
In-Reply-To: <20180417113441.8214-1-philippe.cornu@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0F94384DC50D84EBE50ED0F7D0FF8E1@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-25_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3P7CdYo006948

Hi Philippe,

Reviewed-by: Yannick Fertré <yannick.fertre@st.com>


On 04/17/2018 01:34 PM, Philippe Cornu wrote:
> When a driver related to one of the endpoints is deferred
> due to probe dependencies (i2c, spi...) but the other one
> is ready, ltdc probe continues and the deferred driver
> will never be probed again.
> 
> The fix consists in waiting for all deferred endpoints before
> continuing the ltdc probe.
> 
> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> ---
>   drivers/gpu/drm/stm/ltdc.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
> index e3121d9e4230..014cef8cef37 100644
> --- a/drivers/gpu/drm/stm/ltdc.c
> +++ b/drivers/gpu/drm/stm/ltdc.c
> @@ -987,14 +987,13 @@ int ltdc_load(struct drm_device *ddev)
>   						  &bridge[i]);
>   
>   		/*
> -		 * If at least one endpoint is ready, continue probing,
> -		 * else if at least one endpoint is -EPROBE_DEFER and
> -		 * there is no previous ready endpoints, defer probing.
> +		 * If at least one endpoint is -EPROBE_DEFER, defer probing,
> +		 * else if at least one endpoint is ready, continue probing.
>   		 */
> -		if (!ret)
> +		if (ret == -EPROBE_DEFER)
> +			return ret;
> +		else if (!ret)
>   			endpoint_not_ready = 0;
> -		else if (ret == -EPROBE_DEFER && endpoint_not_ready)
> -			endpoint_not_ready = -EPROBE_DEFER;
>   	}
>   
>   	if (endpoint_not_ready)
> 
