Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751414AbeDWFBd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 01:01:33 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:36697 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbeDWFBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 01:01:31 -0400
X-Google-Smtp-Source: AIpwx48xBaOsbNiu7JXaPUK8GyU4zXboFMqQDdeLaq8qWcJohCyX9vId3+xjmsZJgWdnyVPoLfXy9KDICVEYKZKHke8=
MIME-Version: 1.0
In-Reply-To: <CADYJ94eQyN7dtnnVN_AF0VixaJh3x52068xYtq54hsS4BpdwFg@mail.gmail.com>
References: <CGME20180406045340epcas1p1ae6416dc25823212303c9109d125c018@epcas1p1.samsung.com>
 <1522990390-30804-1-git-send-email-chandan.vn@samsung.com>
 <ff125919-66f7-6658-e9b1-817188c1bdd9@redhat.com> <CADYJ94eQyN7dtnnVN_AF0VixaJh3x52068xYtq54hsS4BpdwFg@mail.gmail.com>
From: Chandan Vn <vn.chandan@gmail.com>
Date: Mon, 23 Apr 2018 10:30:49 +0530
Message-ID: <CADYJ94e=gFhSF+tQ-1f0Dy61urHjG=UNoWYPq7bsT+-VTR1nDw@mail.gmail.com>
Subject: Re: [PATCH 1/1] arm64: To remove initrd reserved area entry from memblock
To: Laura Abbott <labbott@redhat.com>
Cc: CHANDAN VN <chandan.vn@samsung.com>, catalin.marinas@arm.com,
        will.deacon@arm.com, Takahiro Akashi <takahiro.akashi@linaro.org>,
        james.morse@arm.com, robin.murphy@arm.com, steve.capper@arm.com,
        kristina.martsenko@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, cpgs@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

May I know when this patch would be taken for merging?


On Sat, Apr 7, 2018 at 9:58 AM, Chandan Vn <vn.chandan@gmail.com> wrote:
> On Fri, Apr 6, 2018 at 9:47 PM, Laura Abbott <labbott@redhat.com> wrote:
>> Does this have an impact on anything besides accounting
>> in memblock?
>
> Yes, the impact is only on accounting or debugging.
>
> We were trying to reduce the reserved memory by removing initrd reserved area.
> After disabling "keepinitrd", only way to check if it was removed or
> not was to check
> /sys/kernel/debug/memblock/reserved. We found the entry to be present
> irrespective of
> "keepinitrd" being enabled/disabled.
> I hope that with the fix others wont face similar issue. Also we did
> not find any such problem
> with ARM32 ARCHITECTURE.
>
> On Fri, Apr 6, 2018 at 9:47 PM, Laura Abbott <labbott@redhat.com> wrote:
>> On 04/05/2018 09:53 PM, CHANDAN VN wrote:
>>>
>>> INITRD reserved area entry is not removed from memblock
>>> even though initrd reserved area is freed. After freeing
>>> the memory it is released from memblock. The same can be
>>> checked from /sys/kernel/debug/memblock/reserved.
>>>
>>> The patch makes sure that the initrd entry is removed from
>>> memblock when keepinitrd is not enabled.
>>>
>>
>> Does this have an impact on anything besides accounting
>> in memblock?
>>
>>
>>> Signed-off-by: CHANDAN VN <chandan.vn@samsung.com>
>>> ---
>>>   arch/arm64/mm/init.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
>>> index 9f3c47a..1b18b47 100644
>>> --- a/arch/arm64/mm/init.c
>>> +++ b/arch/arm64/mm/init.c
>>> @@ -646,8 +646,10 @@ void free_initmem(void)
>>>     void __init free_initrd_mem(unsigned long start, unsigned long end)
>>>   {
>>> -       if (!keep_initrd)
>>> +       if (!keep_initrd) {
>>>                 free_reserved_area((void *)start, (void *)end, 0,
>>> "initrd");
>>> +               memblock_free(__virt_to_phys(start), end - start);
>>> +       }
>>>   }
>>>     static int __init keepinitrd_setup(char *__unused)
>>>
>>
