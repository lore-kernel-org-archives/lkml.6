Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC1DC4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 03:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0F3520855
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 03:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SLywknPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F3520855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbeIHHrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 03:47:37 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9378 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbeIHHrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 03:47:36 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5b933be80000>; Fri, 07 Sep 2018 20:03:04 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 07 Sep 2018 20:02:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 07 Sep 2018 20:02:59 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 8 Sep
 2018 03:02:59 +0000
Received: from [10.110.48.28] (10.110.48.28) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 8 Sep 2018
 03:02:59 +0000
Subject: Re: [PATCH] drm/nouveau/secboot/acr: fix memory leak
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>
CC:     <dri-devel@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <20180724132719.GA32237@embeddedor.com>
 <d9e87a82-f70f-3eca-5f63-2450863e7099@embeddedor.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <f35a04a0-fa60-7905-96bf-36a0dfb055a8@nvidia.com>
Date:   Fri, 7 Sep 2018 20:02:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <d9e87a82-f70f-3eca-5f63-2450863e7099@embeddedor.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1536375823; bh=VnqE71k8gOvwPc1Le74+jQ0l4I0e0gzRB9U3k43lV5g=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=SLywknPyp5ST0m6G3duyy5F1gH4htMpGFPqZo9/FQOMjuAZkTh+hFPGNvLNVqBGEn
         CAbLrU36KFDS0C/Ori6IyCGfYiMGSNQwgISgJYBHRAdnrWsWriX5qwWjvLqvlsmqCP
         5mQu0ATNwPbXgTZ8l6cGA27tRmdw+k2OWBVpJAkVaD34Ipf+R6fj8Gth6JFMXbN/iL
         z9s/n4GyvyB9FOfClNlp75kbLLlX3o5uVzxoPMeD2g0UkNefW2ZPvYLXnabrj1Hp9X
         ZUJnO2f+XVPWeqp6iKSwjwlR9hQ+wVFN1ZTiFCkV9y+4pqEhwg0FaE77kEmABCXPMf
         lfNCO21Q3bWZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/18 12:51 PM, Gustavo A. R. Silva wrote:
> Hi all,
> 
> Friendly ping! Who can take this?
> 
> Thanks
> --
> Gustavo
> 
> On 07/24/2018 08:27 AM, Gustavo A. R. Silva wrote:
>> In case memory resources for *bl_desc* were allocated, release
>> them before return.
>>
>> Addresses-Coverity-ID: 1472021 ("Resource leak")
>> Fixes: 0d466901552a ("drm/nouveau/secboot/acr: Remove VLA usage")
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>  drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
>> index d02e183..5c14d6a 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/acr_r352.c
>> @@ -801,6 +801,7 @@ acr_r352_load(struct nvkm_acr *_acr, struct nvkm_falcon *falcon,
>>  		bl = acr->hsbl_unload_blob;
>>  	} else {
>>  		nvkm_error(_acr->subdev, "invalid secure boot blob!\n");
>> +		kfree(bl_desc);
>>  		return -EINVAL;
>>  	}
>>  
>>

Hi Gustavo,

Seeing as how I've been working on this corner of Nouveau lately (don't ask, haha),
I reviewed and also tested this. It looks good, you can add:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
-- 
John Hubbard
NVIDIA
