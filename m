Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E4CC04AB8
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77602086C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 21:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MXTvDpTL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77602086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeINCqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 22:46:23 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35842 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbeINCqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 22:46:23 -0400
Received: by mail-yb1-f195.google.com with SMTP id d34-v6so3937299yba.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 14:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kDMVm/qrpjKw4oBGMPe+qrrYZc83ZMucyvXnqUAdL2Q=;
        b=MXTvDpTLI2Ox1/qpPYafM9sVSSUHZ3K6Ipf3qA4rl4s/FC8sNKkQ1vIrUoNGfXzBjh
         W59tEJm23V1cB5WMNaTYGpDub22FCjsDOXmFJM78zfPqdQMU8d0Mc13XWvaZkWU4omqn
         E4jJwKDKSHlJwPhYULpL5wyfObRyoPItGV/DQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kDMVm/qrpjKw4oBGMPe+qrrYZc83ZMucyvXnqUAdL2Q=;
        b=imaN5cmjlJf17D78P+twEdJBhEFaJ8IAxM6/MYfwcj5awNfyBuxly6qoo4NbNXIzHZ
         Oqt07yrlql+mStL8yXmb+Ilg0mFKVmM8J1TX6V4MGpcpVfzYjbqw0edLMu4uy3Al3dCp
         FxKsLzmhEFisU0nUWwALhLUUkFGdNjvTLKveDDqs5IqBvEVaQWzbQOGtdc0MDUTzbPIw
         GAS2UefDaGoV964y+Yd98cwu8Nl1yB2RiQmv8FkLbt+obDFUpYBPv7b7XP7/FuVl05FK
         M2jEZT/oJDoLH8ctdmi3rRTLl964tgrmZoGTi6SGYgT3RYtBnk3dKWTCAUl8pm0QCmOw
         bxSg==
X-Gm-Message-State: APzg51A5mYzH0lHYdpW2ZDZiXyj6ijiaxKHadCmHizdNO6GFfVBpUaMK
        j9TY45P3DGcecmJNKSPh61+Egc5lJ00=
X-Google-Smtp-Source: ANB0VdYH9oWjvMIlMHFKrDO6IuImK6p4H5wFSqVvI2PybLRSFHgj0jY8QgG/PDLtXbiQhhxCyv8vXw==
X-Received: by 2002:a25:8109:: with SMTP id o9-v6mr4377734ybk.395.1536874504430;
        Thu, 13 Sep 2018 14:35:04 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id c124-v6sm1813311ywe.47.2018.09.13.14.35.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 14:35:03 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id y20-v6so3905012ybi.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 14:35:03 -0700 (PDT)
X-Received: by 2002:a25:dd82:: with SMTP id u124-v6mr4321542ybg.171.1536874502819;
 Thu, 13 Sep 2018 14:35:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 13 Sep 2018 14:35:02
 -0700 (PDT)
In-Reply-To: <f35a04a0-fa60-7905-96bf-36a0dfb055a8@nvidia.com>
References: <20180724132719.GA32237@embeddedor.com> <d9e87a82-f70f-3eca-5f63-2450863e7099@embeddedor.com>
 <f35a04a0-fa60-7905-96bf-36a0dfb055a8@nvidia.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 13 Sep 2018 14:35:02 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKd5SEabmr4sCW-=Oksi6WvO11tDB_9Un1fRYQAoq2h0w@mail.gmail.com>
Message-ID: <CAGXu5jKd5SEabmr4sCW-=Oksi6WvO11tDB_9Un1fRYQAoq2h0w@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/secboot/acr: fix memory leak
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 8:02 PM, John Hubbard <jhubbard@nvidia.com> wrote:
> On 8/2/18 12:51 PM, Gustavo A. R. Silva wrote:
>> Hi all,
>>
>> Friendly ping! Who can take this?
>>
>> Thanks
>> --
>> Gustavo
>>
>> On 07/24/2018 08:27 AM, Gustavo A. R. Silva wrote:
>>> In case memory resources for *bl_desc* were allocated, release
>>> them before return.
>>>
>>> Addresses-Coverity-ID: 1472021 ("Resource leak")
>>> Fixes: 0d466901552a ("drm/nouveau/secboot/acr: Remove VLA usage")
>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>> ---
>>>  drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
>>> index d02e183..5c14d6a 100644
>>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
>>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
>>> @@ -801,6 +801,7 @@ acr_r352_load(struct nvkm_acr *_acr, struct nvkm_falcon *falcon,
>>>              bl = acr->hsbl_unload_blob;
>>>      } else {
>>>              nvkm_error(_acr->subdev, "invalid secure boot blob!\n");
>>> +            kfree(bl_desc);
>>>              return -EINVAL;
>>>      }
>>>
>>>
>
> Hi Gustavo,
>
> Seeing as how I've been working on this corner of Nouveau lately (don't ask, haha),
> I reviewed and also tested this. It looks good, you can add:
>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Ben can you take this?

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
Pixel Security
