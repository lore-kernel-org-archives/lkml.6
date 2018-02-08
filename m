Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeBHPCe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 10:02:34 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41041 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750882AbeBHPCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 10:02:33 -0500
From: Philippe CORNU <philippe.cornu@st.com>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick FERTRE <yannick.fertre@st.com>
CC: Alexandre TORGUE <alexandre.torgue@st.com>,
        David Airlie <airlied@linux.ie>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Mickael REULIER" <mickael.reulier@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>
Subject: Re: [PATCH v1 1/2] drm/stm: ltdc: add non-alpha color formats
Thread-Topic: [PATCH v1 1/2] drm/stm: ltdc: add non-alpha color formats
Thread-Index: AQHToMDfjCjR2mm7ykC7v59Hk4J/ZKOaiWCA
Date: Thu, 8 Feb 2018 15:02:24 +0000
Message-ID: <17063027-1eb8-b7f8-4532-ef5ca92e7ea7@st.com>
References: <20180201104243.20726-1-philippe.cornu@st.com>
 <20180201104243.20726-2-philippe.cornu@st.com>
 <2c9f9935-a1ce-84de-e90b-c9462c9bf785@st.com>
 <CA+M3ks7Dc47FZB6DSm-hZEuOo7KHZyS+7ueeN7xZ4mCktbD1cw@mail.gmail.com>
In-Reply-To: <CA+M3ks7Dc47FZB6DSm-hZEuOo7KHZyS+7ueeN7xZ4mCktbD1cw@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C74FBC0560D8B147B43081DDFB2ACCB1@st.com>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-08_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w18F2cW7006369

Hi Benjamin,
and many thanks for having applied the 2 patches.
Philippe :-)

On 02/08/2018 10:40 AM, Benjamin Gaignard wrote:
> 2018-02-06 10:12 GMT+01:00 Yannick FERTRE <yannick.fertre@st.com>:
>> Reviewed-by: Yannick Fertré <yannick.fertre@st.com>
>>
>>
>> On 02/01/2018 11:42 AM, Philippe Cornu wrote:
>>> ltdc supports natively some color formats with alpha (like
>>> ARGB8888, ARGB1555, ARGB4444...). Related non-alpha formats are
>>> supported too (ARGB8888->XRGB8888, ARGB4444->XRGB4444...) by
>>> adjusting ltdc blending factors.
>>>
>>> Note: Wayland/Weston requests by default the non-alpha XRGB8888
>>> color format.
>>>
>>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> 
> Applied on drm-misc-next
> 
> Benjamin
>>> ---
>>>    drivers/gpu/drm/stm/ltdc.c | 33 +++++++++++++++++++++++++++++++--
>>>    1 file changed, 31 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
>>> index 90b3de516c91..f6f26fc0ae9e 100644
>>> --- a/drivers/gpu/drm/stm/ltdc.c
>>> +++ b/drivers/gpu/drm/stm/ltdc.c
>>> @@ -328,6 +328,26 @@ static inline u32 to_drm_pixelformat(enum ltdc_pix_fmt pf)
>>>        }
>>>    }
>>>
>>> +static inline u32 get_pixelformat_without_alpha(u32 drm)
>>> +{
>>> +     switch (drm) {
>>> +     case DRM_FORMAT_ARGB4444:
>>> +             return DRM_FORMAT_XRGB4444;
>>> +     case DRM_FORMAT_RGBA4444:
>>> +             return DRM_FORMAT_RGBX4444;
>>> +     case DRM_FORMAT_ARGB1555:
>>> +             return DRM_FORMAT_XRGB1555;
>>> +     case DRM_FORMAT_RGBA5551:
>>> +             return DRM_FORMAT_RGBX5551;
>>> +     case DRM_FORMAT_ARGB8888:
>>> +             return DRM_FORMAT_XRGB8888;
>>> +     case DRM_FORMAT_RGBA8888:
>>> +             return DRM_FORMAT_RGBX8888;
>>> +     default:
>>> +             return 0;
>>> +     }
>>> +}
>>> +
>>>    static irqreturn_t ltdc_irq_thread(int irq, void *arg)
>>>    {
>>>        struct drm_device *ddev = arg;
>>> @@ -680,6 +700,9 @@ static void ltdc_plane_atomic_update(struct drm_plane *plane,
>>>
>>>        /* Specifies the blending factors */
>>>        val = BF1_PAXCA | BF2_1PAXCA;
>>> +     if (!fb->format->has_alpha)
>>> +             val = BF1_CA | BF2_1CA;
>>> +
>>>        reg_update_bits(ldev->regs, LTDC_L1BFCR + lofs,
>>>                        LXBFCR_BF2 | LXBFCR_BF1, val);
>>>
>>> @@ -747,8 +770,8 @@ static struct drm_plane *ltdc_plane_create(struct drm_device *ddev,
>>>        struct device *dev = ddev->dev;
>>>        struct drm_plane *plane;
>>>        unsigned int i, nb_fmt = 0;
>>> -     u32 formats[NB_PF];
>>> -     u32 drm_fmt;
>>> +     u32 formats[NB_PF * 2];
>>> +     u32 drm_fmt, drm_fmt_no_alpha;
>>>        int ret;
>>>
>>>        /* Get supported pixel formats */
>>> @@ -757,6 +780,12 @@ static struct drm_plane *ltdc_plane_create(struct drm_device *ddev,
>>>                if (!drm_fmt)
>>>                        continue;
>>>                formats[nb_fmt++] = drm_fmt;
>>> +
>>> +             /* Add the no-alpha related format if any & supported */
>>> +             drm_fmt_no_alpha = get_pixelformat_without_alpha(drm_fmt);
>>> +             if (!drm_fmt_no_alpha)
>>> +                     continue;
>>> +             formats[nb_fmt++] = drm_fmt_no_alpha;
>>>        }
>>>
>>>        plane = devm_kzalloc(dev, sizeof(*plane), GFP_KERNEL);
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
