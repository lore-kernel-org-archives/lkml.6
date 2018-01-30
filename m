Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752645AbeA3UCf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 15:02:35 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:13731 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751405AbeA3UCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 15:02:34 -0500
From: Philippe CORNU <philippe.cornu@st.com>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        "laurent.pinchart@ideasonboard.com"
        <laurent.pinchart@ideasonboard.com>
CC: "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/stm: check pitch and size calculations even if
 !CONFIG_MMU
Thread-Topic: [PATCH] drm/stm: check pitch and size calculations even if
 !CONFIG_MMU
Thread-Index: AQHTmd5fCyBFp4Znuki8jEbkNMFw66OMxfSA
Date: Tue, 30 Jan 2018 20:02:21 +0000
Message-ID: <49d20fa9-de53-97b4-df9c-24defcef27ee@st.com>
References: <20180130152400.28972-1-benjamin.gaignard@linaro.org>
In-Reply-To: <20180130152400.28972-1-benjamin.gaignard@linaro.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="utf-8"
Content-ID: <826DC2E52FB4D245A61F9054FBCAFC75@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-30_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w0UK2dKV023939

Hi Benjamin,

Working on a coming patch (based on the new has_alpha field in fourcc), 
I realized that in particular cases (2 layers + "odd" layer sizes) 
memory transfers on MCU are greatly improved too if drm buffers are 
aligned on 128 bytes : )

So I suggest to cancel this patch.

Then you can post a new one removing ifdef CONFIG_MMU endif, or I can do 
it, it is up to you.

Many thanks for your support,
Philippe :-)

On 01/30/2018 04:24 PM, Benjamin Gaignard wrote:
> In all cases we have to check pitch and size calculations.
> Rely on drm_gem_cma_dumb_create for no MMU cases.
> 
> Fixes: 21f815bf773c ("drm/stm: drv: Improve data transfers")
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> ---
>   drivers/gpu/drm/stm/drv.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
> index 8bc7e8418b8d..3e0fb5f34b8e 100644
> --- a/drivers/gpu/drm/stm/drv.c
> +++ b/drivers/gpu/drm/stm/drv.c
> @@ -44,9 +44,11 @@ static int stm_gem_cma_dumb_create(struct drm_file *file,
>   	 */
>   	args->pitch = roundup(min_pitch, 128);
>   	args->height = roundup(args->height, 4);
> -#endif
>   
>   	return drm_gem_cma_dumb_create_internal(file, dev, args);
> +#else
> +	return drm_gem_cma_dumb_create(file, dev, args);
> +#endif
>   }
>   
>   DEFINE_DRM_GEM_CMA_FOPS(drv_driver_fops);
> 
