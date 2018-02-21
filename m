Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933083AbeBUL3Z (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 06:29:25 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932077AbeBUL3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 06:29:23 -0500
Subject: Re: [PATCH v3 1/3] Kconfig : Remove HAS_IOMEM dependency for Graphics
 support
To: Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc: Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org,
        geert@linux-m68k.org, tomi.valkeinen@ti.com, b.zolnierkie@samsung.com
References: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
 <2beec7645bac82e7bdef4f6df0b9f4fe28696575.1519053920.git.alifm@linux.vnet.ibm.com>
 <cce8b082-c780-3559-4491-c39eb09482b0@redhat.com>
 <6cae85dc-76d5-1b92-ab13-a5e441eb84a0@linux.vnet.ibm.com>
 <faffcd8e-4ef6-64bc-ab11-9b48ca488ed6@de.ibm.com>
 <f658ea9e-0153-a0e3-544a-8ce575284245@de.ibm.com>
 <20180221113217.11bb1c69.cohuck@redhat.com>
 <b742aa29-70b2-42e1-26d2-8ca0c8945863@de.ibm.com>
 <d1a89481-e5c9-b460-ea9c-f796dc28b748@redhat.com>
 <1f8907d4-c4a3-d41b-8834-679dcc85de4a@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5dfa9213-0e63-54d0-8700-1ced4efd4c28@redhat.com>
Date: Wed, 21 Feb 2018 12:29:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1f8907d4-c4a3-d41b-8834-679dcc85de4a@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.02.2018 12:22, Christian Borntraeger wrote:
> 
> 
> On 02/21/2018 12:14 PM, Thomas Huth wrote:
>> On 21.02.2018 12:09, Christian Borntraeger wrote:
>>>
>>>
>>> On 02/21/2018 11:32 AM, Cornelia Huck wrote:
>>>> On Wed, 21 Feb 2018 11:22:38 +0100
>>>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>>>>
>>>>> On 02/21/2018 11:05 AM, Christian Borntraeger wrote:
>>>>>>
>>>>>>
>>>>>> On 02/19/2018 05:38 PM, Farhan Ali wrote:  
>>>>>>>
>>>>>>>
>>>>>>> On 02/19/2018 11:25 AM, Thomas Huth wrote:  
>>>>>>>> On 19.02.2018 16:47, Farhan Ali wrote:  
>>>>>>>>> The 'commit e25df1205f37 ("[S390] Kconfig: menus with depends on HAS_IOMEM.")'
>>>>>>>>> added the HAS_IOMEM dependecy for "Graphics support". This disabled the
>>>>>>>>> "Graphics support" menu for S390. But if we enable VT layer for S390,
>>>>>>>>> we would also need to enable the dummy console. So let's remove the
>>>>>>>>> HAS_IOMEM dependency.
>>>>>>>>>
>>>>>>>>> Move this dependency to sub menu items and console drivers that use
>>>>>>>>> io memory.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
>>>>>>>>> ---
>>>>>>>>>   drivers/video/Kconfig         | 21 +++++++++++----------
>>>>>>>>>   drivers/video/console/Kconfig |  4 ++--
>>>>>>>>>   2 files changed, 13 insertions(+), 12 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
>>>>>>>>> index 3c20af9..8f10915 100644
>>>>>>>>> --- a/drivers/video/Kconfig
>>>>>>>>> +++ b/drivers/video/Kconfig
>>>>>>>>> @@ -3,7 +3,6 @@
>>>>>>>>>   #
>>>>>>>>>     menu "Graphics support"
>>>>>>>>> -    depends on HAS_IOMEM
>>>>>>>>>     config HAVE_FB_ATMEL
>>>>>>>>>       bool
>>>>>>>>> @@ -11,20 +10,22 @@ config HAVE_FB_ATMEL
>>>>>>>>>   config SH_LCD_MIPI_DSI
>>>>>>>>>       bool
>>>>>>>>>   -source "drivers/char/agp/Kconfig"
>>>>>>>>> +if HAS_IOMEM
>>>>>>>>> +    source "drivers/char/agp/Kconfig"
>>>>>>>>>   -source "drivers/gpu/vga/Kconfig"
>>>>>>>>> +    source "drivers/gpu/vga/Kconfig"
>>>>>>>>>   -source "drivers/gpu/host1x/Kconfig"
>>>>>>>>> -source "drivers/gpu/ipu-v3/Kconfig"
>>>>>>>>> +    source "drivers/gpu/host1x/Kconfig"
>>>>>>>>> +    source "drivers/gpu/ipu-v3/Kconfig"
>>>>>>>>>   -source "drivers/gpu/drm/Kconfig"
>>>>>>>>> +    source "drivers/gpu/drm/Kconfig"  
>>>>>>
>>>>>>
>>>>>> Hmmm, looks like that this makes it impossible to select VIRTIO_GPU - need still more
>>>>>> work.
>>>>>>   
>>>>> Sorry my fault. I had CONFIG_PCI disabled.
>>>>
>>>> That smells like the s390 HAS_IOMEM stuff needs more work -- I guess
>>>> that you want to enable a ccw virtio-gpu device, not a pci one, right?
>>>
>>> It is a ccw virtio-gpu. But s390 has no IOMEM without CONFIG_PCI, so you cannot
>>> select VIRTIO_GPU, which needs DRM, which need IOMEM.
>>
>> So the 'source "drivers/gpu/drm/Kconfig"' should maybe rather reside
>> outside of the "if HAS_IOMEM" path? Or does it not compile anymore that way?
> 
> virtio-gpu depends on drm. So in essence it boils down to if you want virtio-gpu
> you also need to enable PCI, even if the actual channel is ccw.

But if you need to enable PCI to get IOMEM, I wonder why this patch here
is needed at all? The Graphics menu / VT dummy console should be
available in the config if IOMEM is enabled anyway?

 Thomas
