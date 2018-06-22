Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3299AC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D919E2415B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="F8IU+4yf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dy2MBOMx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D919E2415B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751345AbeFVLmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 07:42:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60626 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751411AbeFVLmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 07:42:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5E2D360B67; Fri, 22 Jun 2018 11:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529667732;
        bh=IKOgBZW65VnDeymLlEA8dEYnfj6MIITTir6EpBkRFxA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=F8IU+4yfWv5bgZcCrui0jb3a1NfKfypWY0wQQdSTg9DHQVOPu9MZ3ExZLwj2NznNe
         PDU4XGEMYZEin/HL1KYCKCrGEjJ/3/dehqj3vI/VEJ8lWs9qoGFrY7pUr37KnZlrdw
         CibwO3y4t04q6an978pkcRlv5zYTSsaPjycGhnWE=
Received: from [10.204.66.249] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akhilpo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 400CE605BD;
        Fri, 22 Jun 2018 11:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1529667731;
        bh=IKOgBZW65VnDeymLlEA8dEYnfj6MIITTir6EpBkRFxA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dy2MBOMxX66ab6lrXp2R6GvdgBA3VGDlJgUTNPaTzE/G/XXa1xLTvRHyz4EHkJonV
         qLFWZVW/nJBco1546hqr4W34hkSZg2X8zl8SFniYGY5VHRjL7ayS3vUnuyHyuWTPxN
         rEUYosULt64s2X1HApfClXeQaScPA3WSWOvAV+IY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 400CE605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=akhilpo@codeaurora.org
Subject: Re: [PATCH v2] dma-buf/fence: Take refcount on the module that owns
 the fence
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        Gustavo Padovan <gustavo@padovan.org>, sumit.semwal@linaro.org,
        jcrouse@codeaurora.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, smasetty@codeaurora.org
References: <1529660407-6266-1-git-send-email-akhilpo@codeaurora.org>
 <1529661856.7034.404.camel@padovan.org>
 <152966212844.11773.6596589902326100250@mail.alporthouse.com>
From:   Akhil P Oommen <akhilpo@codeaurora.org>
Message-ID: <cb950fea-b0cc-bbe7-9e94-78c62849cb64@codeaurora.org>
Date:   Fri, 22 Jun 2018 17:12:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <152966212844.11773.6596589902326100250@mail.alporthouse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/22/2018 3:38 PM, Chris Wilson wrote:
> Quoting Gustavo Padovan (2018-06-22 11:04:16)
>> Hi Akhil,
>>
>> On Fri, 2018-06-22 at 15:10 +0530, Akhil P Oommen wrote:
>>> Each fence object holds function pointers of the module that
>>> initialized
>>> it. Allowing the module to unload before this fence's release is
>>> catastrophic. So, keep a refcount on the module until the fence is
>>> released.
>>>
>>> Signed-off-by: Akhil P Oommen <akhilpo@codeaurora.org>
>>> ---
>>> Changes in v2:
>>> - added description for the new function parameter.
>>>
>>>   drivers/dma-buf/dma-fence.c | 16 +++++++++++++---
>>>   include/linux/dma-fence.h   | 10 ++++++++--
>>>   2 files changed, 21 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-
>>> fence.c
>>> index 4edb9fd..2aaa44e 100644
>>> --- a/drivers/dma-buf/dma-fence.c
>>> +++ b/drivers/dma-buf/dma-fence.c
>>> @@ -18,6 +18,7 @@
>>>    * more details.
>>>    */
>>>   
>>> +#include <linux/module.h>
>>>   #include <linux/slab.h>
>>>   #include <linux/export.h>
>>>   #include <linux/atomic.h>
>>> @@ -168,6 +169,7 @@ void dma_fence_release(struct kref *kref)
>>>   {
>>>        struct dma_fence *fence =
>>>                container_of(kref, struct dma_fence, refcount);
>>> +     struct module *module = fence->owner;
>>>   
>>>        trace_dma_fence_destroy(fence);
>>>   
>>> @@ -178,6 +180,8 @@ void dma_fence_release(struct kref *kref)
>>>                fence->ops->release(fence);
>>>        else
>>>                dma_fence_free(fence);
>>> +
>>> +     module_put(module);
>>>   }
>>>   EXPORT_SYMBOL(dma_fence_release);
>>>   
>>> @@ -541,6 +545,7 @@ struct default_wait_cb {
>>>   
>>>   /**
>>>    * dma_fence_init - Initialize a custom fence.
>>> + * @module:  [in]    the module that calls this API
>>>    * @fence:   [in]    the fence to initialize
>>>    * @ops:     [in]    the dma_fence_ops for operations on this
>>> fence
>>>    * @lock:    [in]    the irqsafe spinlock to use for locking
>>> this fence
>>> @@ -556,8 +561,9 @@ struct default_wait_cb {
>>>    * to check which fence is later by simply using dma_fence_later.
>>>    */
>>>   void
>>> -dma_fence_init(struct dma_fence *fence, const struct dma_fence_ops
>>> *ops,
>>> -            spinlock_t *lock, u64 context, unsigned seqno)
>>> +_dma_fence_init(struct module *module, struct dma_fence *fence,
>>> +             const struct dma_fence_ops *ops, spinlock_t *lock,
>>> +             u64 context, unsigned seqno)
>>>   {
>>>        BUG_ON(!lock);
>>>        BUG_ON(!ops || !ops->wait || !ops->enable_signaling ||
>>> @@ -571,7 +577,11 @@ struct default_wait_cb {
>>>        fence->seqno = seqno;
>>>        fence->flags = 0UL;
>>>        fence->error = 0;
>>> +     fence->owner = module;
>>> +
>>> +     if (!try_module_get(module))
>>> +             fence->owner = NULL;
>>>   
>>>        trace_dma_fence_init(fence);
>>>   }
>>> -EXPORT_SYMBOL(dma_fence_init);
>>> +EXPORT_SYMBOL(_dma_fence_init);
>> Do we still need to export the symbol, it won't be called from outside
>> anymore? Other than that looks good to me:
Yes. Because dma_fence_init() is now a macro that resolves to 
_dma_fence_init().
> There's a big drawback in that a module reference is often insufficient,
> and that a reference on the driver (or whatever is required for the
> lifetime of the fence) will already hold the module reference.
I didn't quite understand what you meant here. Could you please elaborate?
>
> Considering that we want a few 100k fences in flight per second, is
> there no other way to only export a fence with a module reference?
> -Chris

Thanks,
Akhil.

