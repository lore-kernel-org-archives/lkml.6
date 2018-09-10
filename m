Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82672C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2946820866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="izKJLt1A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2946820866
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbeIJMd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:33:57 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33310 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbeIJMdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:33:55 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8A7fBpE003326;
        Mon, 10 Sep 2018 02:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536565271;
        bh=0Avy9O6Gzj5CtcgvCOH8MvpOqbc9yJgMRvXONNJZKDU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=izKJLt1AtWng4hY39pmtSVsFKPe3HcZ522YuV1P1JbbGdd4fcO6Ig8HsThjSw6AJ8
         aJ/cfTJEg9XaOiSdiEpZoaLTmBaUhOovLufawzdwTmydYyDmMv/Aw4V2V+WavxRLpN
         qjE28N9PWUa8NFgNw7mjEeRNTDBC5CAmcdmJxLFY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8A7fAEH001598;
        Mon, 10 Sep 2018 02:41:10 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 10
 Sep 2018 02:41:06 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 10 Sep 2018 02:41:05 -0500
Received: from [10.1.3.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8A7f3v1015684;
        Mon, 10 Sep 2018 02:41:04 -0500
Subject: Re: [PATCH] drm/tilcdc: Convert drm_atomic_helper_suspend/resume()
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>, <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Ajit Linux <ajitn.linux@gmail.com>
References: <20180808161641.GA20483@jordon-HP-15-Notebook-PC>
 <CAFqt6zYn_kf+sQ0Dih83CH7hVR2f6ZW-ANVRm9+MX54KcMk=jQ@mail.gmail.com>
From:   Jyri Sarha <jsarha@ti.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsarha@ti.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1f0a17d5-59cc-0d6a-a1dc-a865975bffe2@ti.com>
Date:   Mon, 10 Sep 2018 10:41:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAFqt6zYn_kf+sQ0Dih83CH7hVR2f6ZW-ANVRm9+MX54KcMk=jQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/18 09:45, Souptick Joarder wrote:
> On Wed, Aug 8, 2018 at 9:43 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>
>> convert drm_atomic_helper_suspend/resume() to use
>> drm_mode_config_helper_suspend/resume().
>>
>> saved_state in tilcdc_drm_private will not be used
>> anymore, so it can be removed.
> 
> Any comment on this patch ?

I planned to test this out, but I did not find time to do that. But here
is my:

Reviewed-by: Jyri Sarha <jsarha@ti.com>

I'll pick this up for my next pull request.

BR,
Jyri

>>
>> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> ---
>>  drivers/gpu/drm/tilcdc/tilcdc_drv.c | 14 ++++----------
>>  drivers/gpu/drm/tilcdc/tilcdc_drv.h |  3 ---
>>  2 files changed, 4 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
>> index 0fb300d..33e5332 100644
>> --- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
>> +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
>> @@ -554,29 +554,23 @@ static int tilcdc_debugfs_init(struct drm_minor *minor)
>>  static int tilcdc_pm_suspend(struct device *dev)
>>  {
>>         struct drm_device *ddev = dev_get_drvdata(dev);
>> -       struct tilcdc_drm_private *priv = ddev->dev_private;
>> +       int ret = 0;
>>
>> -       priv->saved_state = drm_atomic_helper_suspend(ddev);
>> +       ret = drm_mode_config_helper_suspend(ddev);
>>
>>         /* Select sleep pin state */
>>         pinctrl_pm_select_sleep_state(dev);
>>
>> -       return 0;
>> +       return ret;
>>  }
>>
>>  static int tilcdc_pm_resume(struct device *dev)
>>  {
>>         struct drm_device *ddev = dev_get_drvdata(dev);
>> -       struct tilcdc_drm_private *priv = ddev->dev_private;
>> -       int ret = 0;
>>
>>         /* Select default pin state */
>>         pinctrl_pm_select_default_state(dev);
>> -
>> -       if (priv->saved_state)
>> -               ret = drm_atomic_helper_resume(ddev, priv->saved_state);
>> -
>> -       return ret;
>> +       return  drm_mode_config_helper_resume(ddev);
>>  }
>>  #endif
>>
>> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.h b/drivers/gpu/drm/tilcdc/tilcdc_drv.h
>> index ead5122..62cea5f 100644
>> --- a/drivers/gpu/drm/tilcdc/tilcdc_drv.h
>> +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.h
>> @@ -70,9 +70,6 @@ struct tilcdc_drm_private {
>>         const uint32_t *pixelformats;
>>         uint32_t num_pixelformats;
>>
>> -       /* The context for pm susped/resume cycle is stored here */
>> -       struct drm_atomic_state *saved_state;
>> -
>>  #ifdef CONFIG_CPU_FREQ
>>         struct notifier_block freq_transition;
>>  #endif
>> --
>> 1.9.1
>>


-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
