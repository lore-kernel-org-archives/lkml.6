Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82310C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAB720C0E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ql2/yipC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DAB720C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeHBJjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:39:54 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38580 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeHBJjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:39:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id p6-v6so1083320ljc.5;
        Thu, 02 Aug 2018 00:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BVM00BBrzX1IXEr7fiozMAAk2XvQtvnL+B8elRKALmg=;
        b=ql2/yipCU6X7IShNHQc5iV3h2JOMKBgOKaJL12fjgiwGTZoA5Xc9ysN8gVtWFdh7T9
         kzvpGDVDuXmZLC5dWnzKhrGT5YpW82N33LznJiBYojE6KtyrMSD0vwATcUQL01XU5OpI
         PV30MD/Xe8J8zUCywycs1N5H7Ff3jd/p+hEGXtMrn1BIUHXOnq7siKEACoUHAzW0PU/K
         NZzu5LwhrFbzV9yVNTjt0EABgYoN07NDk5H7hLOb/C1JiVSu7b1Oo0XxiB3BAMMzXStf
         OxUgnedHPiO68si38puhJ5RFSpOpA9aTygALPNXwTRCeE2/zbnY6+zk8QY8sOQRkKZUo
         DCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BVM00BBrzX1IXEr7fiozMAAk2XvQtvnL+B8elRKALmg=;
        b=dbP65GQXCCI/duSJEnT8ohjuSq/uNRSI2Z4b4Pol8PrXiDN2My2H1PzE1lOyRH58A3
         A4hbbD9NhAFlk1H7cIY2lUsAHqogpNSvo8c2xJluyCwWog7INqBSWwIwDZr0Al1NeKLE
         5ilhVr4jC79JVFA+m8GurJ+V/7eXjquz2D6T3VKCUQU6h+JRLJ1sDx/+G7Odgatgi4ZY
         cfihFcKETDFkwnZ6KaxolSVLqsDVcYcpbzZYBtDrBEDGdwylb9RMN/ebmIaiq31o9nNG
         9j4efSSPtY98Tb0Wx3t6x8r6/0/FPMFiarrAs8S5kqhxrYODQahC97vL2gVFlQMObMZh
         3KXg==
X-Gm-Message-State: AOUpUlEMosKMw3qyNDzITls06f3kKgG36sRStq7xd2yH2EXyhGdolP2e
        ndPL59Cfm4aPN+gyxsLDqeMRinSpTjmnwR4qZ7U=
X-Google-Smtp-Source: AAOMgpdHGI+/LD7Ks2o0RkflpWjjyq/Fk7Tjrinqkp3uzXSpZJoSDjMFS4Btxj+9JfJRLzE0brvchsLmB+iWopdTGDc=
X-Received: by 2002:a2e:4186:: with SMTP id d6-v6mr1224832ljf.36.1533196197402;
 Thu, 02 Aug 2018 00:49:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:2b14:0:0:0:0:0 with HTTP; Thu, 2 Aug 2018 00:49:56 -0700 (PDT)
In-Reply-To: <20180802064714eucas1p12f3c32c453a49dc4e0d2785ff7fa72ec~G-mV4kIr70116001160eucas1p1P@eucas1p1.samsung.com>
References: <20180726155459.GA30138@jordon-HP-15-Notebook-PC>
 <CGME20180802062607epcas1p339ff6aeb0cbdc3b6ece2617be4aadb41@epcas1p3.samsung.com>
 <CAFqt6zY6vcqrmztcEf9QYMXoHr08oTirSTNA7X6+5YvvoHRR4A@mail.gmail.com> <20180802064714eucas1p12f3c32c453a49dc4e0d2785ff7fa72ec~G-mV4kIr70116001160eucas1p1P@eucas1p1.samsung.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 2 Aug 2018 13:19:56 +0530
Message-ID: <CAFqt6zaDfW7nvttcYN-Fr6pSCNPz9LGNWYND7PK5eMiR8bU6Zw@mail.gmail.com>
Subject: Re: [PATCH v2] gpu/drm/exynos: Convert drm_atomic_helper_suspend/resume()
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Inki Dae <inki.dae@samsung.com>, jy0922.shim@samsung.com,
        sw0312.kim@samsung.com, Kyungmin Park <kyungmin.park@samsung.com>,
        airlied@linux.ie, kgene@kernel.org, krzk@kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ajit Linux <ajitn.linux@gmail.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 12:17 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hi Souptick,
>
> On 2018-08-02 08:25, Souptick Joarder wrote:
>> On Thu, Jul 26, 2018 at 9:24 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>>> convert drm_atomic_helper_suspend/resume() to use
>>> drm_mode_config_helper_suspend/resume().
>>>
>>> exynos_drm_fbdev_suspend/resume can be removed
>>> as drm_mode_config_helper_suspend/resume has
>>> implement the same in generic way.
>>>
>>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>>> Signed-off-by: Ajit Negi <ajitn.linux@gmail.com>
>>> ---
>>> v2: Address Inki Dae's comment. Remove
>>>      ret variable from both suspend/resume
>>>      function.
>>>
>> Any further comment on this patch ?
>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
> However you need to rebase onto current drm-next, because there have
> been some changes, which prevent this patch from applying.
>
> pm_runtime_suspended(dev) checks were useless and have been removed,
> what simplifies suspend/resume functions even more. Now it is too
> late for v4.19 merge window, so this patch will have to wait for
> v4.20.

Thanks, I will remove in v3 after rebase to drm-next.

>>>   drivers/gpu/drm/exynos/exynos_drm_drv.c   | 26 ++++----------------------
>>>   drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 17 -----------------
>>>   drivers/gpu/drm/exynos/exynos_drm_fbdev.h | 10 ----------
>>>   3 files changed, 4 insertions(+), 49 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_drv.c b/drivers/gpu/drm/exynos/exynos_drm_drv.c
>>> index a81b4a5..46d28cd 100644
>>> --- a/drivers/gpu/drm/exynos/exynos_drm_drv.c
>>> +++ b/drivers/gpu/drm/exynos/exynos_drm_drv.c
>>> @@ -151,39 +151,21 @@ static void exynos_drm_postclose(struct drm_device *dev, struct drm_file *file)
>>>   static int exynos_drm_suspend(struct device *dev)
>>>   {
>>>          struct drm_device *drm_dev = dev_get_drvdata(dev);
>>> -       struct exynos_drm_private *private;
>>>
>>> -       if (pm_runtime_suspended(dev) || !drm_dev)
>>> +       if (pm_runtime_suspended(dev))
>>>                  return 0;
>>>
>>> -       private = drm_dev->dev_private;
>>> -
>>> -       drm_kms_helper_poll_disable(drm_dev);
>>> -       exynos_drm_fbdev_suspend(drm_dev);
>>> -       private->suspend_state = drm_atomic_helper_suspend(drm_dev);
>>> -       if (IS_ERR(private->suspend_state)) {
>>> -               exynos_drm_fbdev_resume(drm_dev);
>>> -               drm_kms_helper_poll_enable(drm_dev);
>>> -               return PTR_ERR(private->suspend_state);
>>> -       }
>>> -
>>> -       return 0;
>>> +       return drm_mode_config_helper_suspend(drm_dev);
>>>   }
>>>
>>>   static int exynos_drm_resume(struct device *dev)
>>>   {
>>>          struct drm_device *drm_dev = dev_get_drvdata(dev);
>>> -       struct exynos_drm_private *private;
>>>
>>> -       if (pm_runtime_suspended(dev) || !drm_dev)
>>> +       if (pm_runtime_suspended(dev))
>>>                  return 0;
>>>
>>> -       private = drm_dev->dev_private;
>>> -       drm_atomic_helper_resume(drm_dev, private->suspend_state);
>>> -       exynos_drm_fbdev_resume(drm_dev);
>>> -       drm_kms_helper_poll_enable(drm_dev);
>>> -
>>> -       return 0;
>>> +       return drm_mode_config_helper_resume(drm_dev);
>>>   }
>>>   #endif
>>>
>>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
>>> index 132dd52..918dd2c 100644
>>> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
>>> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
>>> @@ -270,20 +270,3 @@ void exynos_drm_fbdev_fini(struct drm_device *dev)
>>>          private->fb_helper = NULL;
>>>   }
>>>
>>> -void exynos_drm_fbdev_suspend(struct drm_device *dev)
>>> -{
>>> -       struct exynos_drm_private *private = dev->dev_private;
>>> -
>>> -       console_lock();
>>> -       drm_fb_helper_set_suspend(private->fb_helper, 1);
>>> -       console_unlock();
>>> -}
>>> -
>>> -void exynos_drm_fbdev_resume(struct drm_device *dev)
>>> -{
>>> -       struct exynos_drm_private *private = dev->dev_private;
>>> -
>>> -       console_lock();
>>> -       drm_fb_helper_set_suspend(private->fb_helper, 0);
>>> -       console_unlock();
>>> -}
>>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.h b/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
>>> index b338472..6840b6a 100644
>>> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
>>> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.h
>>> @@ -19,8 +19,6 @@
>>>
>>>   int exynos_drm_fbdev_init(struct drm_device *dev);
>>>   void exynos_drm_fbdev_fini(struct drm_device *dev);
>>> -void exynos_drm_fbdev_suspend(struct drm_device *drm);
>>> -void exynos_drm_fbdev_resume(struct drm_device *drm);
>>>
>>>   #else
>>>
>>> @@ -39,14 +37,6 @@ static inline void exynos_drm_fbdev_restore_mode(struct drm_device *dev)
>>>
>>>   #define exynos_drm_output_poll_changed (NULL)
>>>
>>> -static inline void exynos_drm_fbdev_suspend(struct drm_device *drm)
>>> -{
>>> -}
>>> -
>>> -static inline void exynos_drm_fbdev_resume(struct drm_device *drm)
>>> -{
>>> -}
>>> -
>>>   #endif
>>>
>>>   #endif
>>> --
>>> 1.9.1
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
