Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755492AbeDYQik (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:38:40 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:45874 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755076AbeDYQig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:38:36 -0400
X-Google-Smtp-Source: AIpwx4/XVK8bsWNRPowxRxGmj53Z1G2fXuzAD4FT+icPC8z2O7xmy3NjU40oR1qorvri2L3orO/kJhorovmCe3rRGak=
MIME-Version: 1.0
In-Reply-To: <5AE0A5FD.3060009@gmail.com>
References: <a3722bda2eadf1ff229f73da6f0316f954956ae1.1524668025.git.arvind.yadav.cs@gmail.com>
 <d16d5b54-90c9-3137-bc74-2b0d7135a928@oracle.com> <5AE0A5FD.3060009@gmail.com>
From: Shannon Nelson <shannon.lee.nelson@gmail.com>
Date: Wed, 25 Apr 2018 09:38:35 -0700
Message-ID: <CAP-MU4PPuxvtgfM5J5Arb5+sdAWxYPRDtQdm+cbHZO2WioJdfA@mail.gmail.com>
Subject: Re: [PATCH] sparc: vio: use put_device() instead of kfree()
To: arvindY <arvind.yadav.cs@gmail.com>
Cc: Shannon Nelson <shannon.nelson@oracle.com>,
        David Miller <davem@davemloft.net>, jag.raman@oracle.com,
        liam.merwick@oracle.com, linux-kernel <linux-kernel@vger.kernel.org>,
        Sparc kernel list <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, yes, there it is, and the pointer to vio_dev_release() was already
set up a little earlier in this function.

Sorry for the noise.
sln

On Wed, Apr 25, 2018 at 8:59 AM, arvindY <arvind.yadav.cs@gmail.com> wrote:
>
>
> On Wednesday 25 April 2018 09:14 PM, Shannon Nelson wrote:
>>
>> On 4/25/2018 7:56 AM, Arvind Yadav wrote:
>>>
>>> Never directly free @dev after calling device_register(), even
>>> if it returned an error. Always use put_device() to give up the
>>> reference initialized.
>>>
>>> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
>>> ---
>>>   arch/sparc/kernel/vio.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
>>> index 1a0fa10..32bae68 100644
>>> --- a/arch/sparc/kernel/vio.c
>>> +++ b/arch/sparc/kernel/vio.c
>>> @@ -403,7 +403,7 @@ static struct vio_dev *vio_create_one(struct
>>> mdesc_handle *hp, u64 mp,
>>>       if (err) {
>>>           printk(KERN_ERR "VIO: Could not register device %s, err=%d\n",
>>>                  dev_name(&vdev->dev), err);
>>> -        kfree(vdev);
>>> +        put_device(&vdev->dev);
>>
>>
>> Hmmm... I can see why the put_device() might be a good idea, but I think
>> we still need the kfree() so as to not leak the memory that was kzalloc'd
>> above for vdev.
>>
>
> There is no need to call kfree() here. Because put_device()
> will decrement the last reference and then free the memory
> by calling dev->release(It'll call vio_dev_release()).
> Internally put_device() -> kobject_put() -> kobject_cleanup()
> which is responsible to call 'dev -> release' and also free
> other kobject resources.
> If we will call kfree() here, Then It'll be a redundant call.
>
> ~arvind
>
>
>> sln
>>
>>>           return NULL;
>>>       }
>>>       if (vdev->dp)
>>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
==============================================
Mr. Shannon Nelson         Parents can't afford to be squeamish.
