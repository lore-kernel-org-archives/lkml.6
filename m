Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbeBHJka (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 04:40:30 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39702 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbeBHJk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 04:40:28 -0500
X-Google-Smtp-Source: AH8x227BTSug6yznQzJ3oX8ckr46Tp9JZHC4oj3FSClh+ksQoNYT2qpse5GodHTmuSa+/XvsL5zL7Y+9rV6Bkfv3LqM=
MIME-Version: 1.0
In-Reply-To: <2c9f9935-a1ce-84de-e90b-c9462c9bf785@st.com>
References: <20180201104243.20726-1-philippe.cornu@st.com> <20180201104243.20726-2-philippe.cornu@st.com>
 <2c9f9935-a1ce-84de-e90b-c9462c9bf785@st.com>
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date: Thu, 8 Feb 2018 10:40:27 +0100
Message-ID: <CA+M3ks7Dc47FZB6DSm-hZEuOo7KHZyS+7ueeN7xZ4mCktbD1cw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] drm/stm: ltdc: add non-alpha color formats
To: Yannick FERTRE <yannick.fertre@st.com>
Cc: Philippe CORNU <philippe.cornu@st.com>,
        Vincent ABRIOU <vincent.abriou@st.com>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        Mickael REULIER <mickael.reulier@st.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w189eajT026274

2018-02-06 10:12 GMT+01:00 Yannick FERTRE <yannick.fertre@st.com>:
> Reviewed-by: Yannick Fertré <yannick.fertre@st.com>
>
>
> On 02/01/2018 11:42 AM, Philippe Cornu wrote:
>> ltdc supports natively some color formats with alpha (like
>> ARGB8888, ARGB1555, ARGB4444...). Related non-alpha formats are
>> supported too (ARGB8888->XRGB8888, ARGB4444->XRGB4444...) by
>> adjusting ltdc blending factors.
>>
>> Note: Wayland/Weston requests by default the non-alpha XRGB8888
>> color format.
>>
>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>

Applied on drm-misc-next

Benjamin
>> ---
>>   drivers/gpu/drm/stm/ltdc.c | 33 +++++++++++++++++++++++++++++++--
>>   1 file changed, 31 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
>> index 90b3de516c91..f6f26fc0ae9e 100644
>> --- a/drivers/gpu/drm/stm/ltdc.c
>> +++ b/drivers/gpu/drm/stm/ltdc.c
>> @@ -328,6 +328,26 @@ static inline u32 to_drm_pixelformat(enum ltdc_pix_fmt pf)
>>       }
>>   }
>>
>> +static inline u32 get_pixelformat_without_alpha(u32 drm)
>> +{
>> +     switch (drm) {
>> +     case DRM_FORMAT_ARGB4444:
>> +             return DRM_FORMAT_XRGB4444;
>> +     case DRM_FORMAT_RGBA4444:
>> +             return DRM_FORMAT_RGBX4444;
>> +     case DRM_FORMAT_ARGB1555:
>> +             return DRM_FORMAT_XRGB1555;
>> +     case DRM_FORMAT_RGBA5551:
>> +             return DRM_FORMAT_RGBX5551;
>> +     case DRM_FORMAT_ARGB8888:
>> +             return DRM_FORMAT_XRGB8888;
>> +     case DRM_FORMAT_RGBA8888:
>> +             return DRM_FORMAT_RGBX8888;
>> +     default:
>> +             return 0;
>> +     }
>> +}
>> +
>>   static irqreturn_t ltdc_irq_thread(int irq, void *arg)
>>   {
>>       struct drm_device *ddev = arg;
>> @@ -680,6 +700,9 @@ static void ltdc_plane_atomic_update(struct drm_plane *plane,
>>
>>       /* Specifies the blending factors */
>>       val = BF1_PAXCA | BF2_1PAXCA;
>> +     if (!fb->format->has_alpha)
>> +             val = BF1_CA | BF2_1CA;
>> +
>>       reg_update_bits(ldev->regs, LTDC_L1BFCR + lofs,
>>                       LXBFCR_BF2 | LXBFCR_BF1, val);
>>
>> @@ -747,8 +770,8 @@ static struct drm_plane *ltdc_plane_create(struct drm_device *ddev,
>>       struct device *dev = ddev->dev;
>>       struct drm_plane *plane;
>>       unsigned int i, nb_fmt = 0;
>> -     u32 formats[NB_PF];
>> -     u32 drm_fmt;
>> +     u32 formats[NB_PF * 2];
>> +     u32 drm_fmt, drm_fmt_no_alpha;
>>       int ret;
>>
>>       /* Get supported pixel formats */
>> @@ -757,6 +780,12 @@ static struct drm_plane *ltdc_plane_create(struct drm_device *ddev,
>>               if (!drm_fmt)
>>                       continue;
>>               formats[nb_fmt++] = drm_fmt;
>> +
>> +             /* Add the no-alpha related format if any & supported */
>> +             drm_fmt_no_alpha = get_pixelformat_without_alpha(drm_fmt);
>> +             if (!drm_fmt_no_alpha)
>> +                     continue;
>> +             formats[nb_fmt++] = drm_fmt_no_alpha;
>>       }
>>
>>       plane = devm_kzalloc(dev, sizeof(*plane), GFP_KERNEL);
