Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeBCMpT (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 07:45:19 -0500
Received: from gateway34.websitewelcome.com ([192.185.149.46]:21983 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751702AbeBCMpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 07:45:10 -0500
Date: Sat, 03 Feb 2018 06:22:28 -0600
Message-ID: <20180203062228.Horde.Yi_1isNJ5NW9KaWlA9DyQsP@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Rob Clark <robdclark@gmail.com>
Cc: David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/msm/adreno/a5xx_debugfs: fix potential NULL pointer
 dereference
References: <20180202123223.GA4410@embeddedor.com>
 <20180202163006.GA878@jcrouse-lnx.qualcomm.com>
 <CAF6AEGuKHknW3o4tfe95E7RLLk7OQGTFh=HDtijPDQyp3b+B6Q@mail.gmail.com>
In-Reply-To: <CAF6AEGuKHknW3o4tfe95E7RLLk7OQGTFh=HDtijPDQyp3b+B6Q@mail.gmail.com>
User-Agent: Horde Application Framework 5
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 108.167.133.22
X-Source-L: Yes
X-Exim-ID: 1ehwpw-002EDK-JN
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: gator4166.hostgator.com [108.167.133.22]:28576
X-Source-Auth: garsilva@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Quoting Rob Clark <robdclark@gmail.com>:

> On Fri, Feb 2, 2018 at 11:30 AM, Jordan Crouse  
> <jcrouse@codeaurora.org> wrote:
>> On Fri, Feb 02, 2018 at 06:32:23AM -0600, Gustavo A. R. Silva wrote:
>>> _minor_ is being dereferenced before it is null checked, hence there
>>> is a potential null pointer dereference. Fix this by moving the pointer
>>> dereference after _minor_ has been null checked.
>>>
>>> Fixes: 024ad8df763f ("drm/msm: add a5xx specific debugfs")
>>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>>> ---
>>>
>>> I wonder if a better solution for this would be to WARN_ON in case _minor_
>>> happens to be NULL and return -EINVAL, instead of just returning zero.
>>>
>>> Something like:
>>>
>>> struct drm_device *dev;
>>>
>>> if (WARN_ON(!minor)
>>>       return -EINVAL;
>>>
>>> dev = minor->dev;
>>>
>>> What do you think?
>>
>> In my opinion everything in debugfs is optional. I'm not sure if it is even
>> possible for dev->primary, dev->render or dev->control to be NULL  
>> from the DRM
>> core but if so I think the failure should be silent.
>>
>
> Don't have code in front of me atm, but I think this is one of those
> things you can hit both before and after we have the minor, depending
> on whether filesystem and fw are present when the driver loads or
> not.. so I don't think it should be a WARN_ON().
>

I get it. Then in this case this patch should work just fine.

Thank you both Jordan and Rob for the feedback.
--
Gustavo

> BR,
> -R
>
>
>> Jordan
>>>
>>>  drivers/gpu/drm/msm/adreno/a5xx_debugfs.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_debugfs.c  
>>> b/drivers/gpu/drm/msm/adreno/a5xx_debugfs.c
>>> index 6b27941..059ec7d 100644
>>> --- a/drivers/gpu/drm/msm/adreno/a5xx_debugfs.c
>>> +++ b/drivers/gpu/drm/msm/adreno/a5xx_debugfs.c
>>> @@ -159,13 +159,15 @@ DEFINE_SIMPLE_ATTRIBUTE(reset_fops, NULL,  
>>> reset_set, "%llx\n");
>>>
>>>  int a5xx_debugfs_init(struct msm_gpu *gpu, struct drm_minor *minor)
>>>  {
>>> -     struct drm_device *dev = minor->dev;
>>> +     struct drm_device *dev;
>>>       struct dentry *ent;
>>>       int ret;
>>>
>>>       if (!minor)
>>>               return 0;
>>>
>>> +     dev = minor->dev;
>>> +
>>>       ret = drm_debugfs_create_files(a5xx_debugfs_list,
>>>                       ARRAY_SIZE(a5xx_debugfs_list),
>>>                       minor->debugfs_root, minor);
>>> --
>>> 2.7.4
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> --
>> The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
>> a Linux Foundation Collaborative Project
