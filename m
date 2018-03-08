Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750897AbeCHUbc (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 15:31:32 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35633 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbeCHUba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 15:31:30 -0500
X-Google-Smtp-Source: AG47ELtua9VEESBfygO/N2+5b6/tM1B7qtOSbdNqJlEriZfGhTu5QSg2KBb8eghCUp77X7UACDQezQ==
Date: Thu, 08 Mar 2018 12:31:28 -0800 (PST)
X-Google-Original-Date: Thu, 08 Mar 2018 12:30:57 PST (-0800)
Subject: Re: [PATCH] riscv: Implement free_initrd_mem.
In-Reply-To: <874llquz7n.fsf@xps13.shealevy.com>
CC: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From: Palmer Dabbelt <palmer@sifive.com>
To: shea@shealevy.com
Message-ID: <mhng-a815a939-8405-42db-ba34-2a49a622e663@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Mar 2018 11:47:08 PST (-0800), shea@shealevy.com wrote:
> Palmer Dabbelt <palmer@sifive.com> writes:
>
>> On Thu, 08 Mar 2018 11:14:52 PST (-0800), shea@shealevy.com wrote:
>>> Hi Palmer,
>>>
>>> Palmer Dabbelt <palmer@sifive.com> writes:
>>>
>>>> On Tue, 20 Feb 2018 05:50:43 PST (-0800), shea@shealevy.com wrote:
>>>>> Signed-off-by: Shea Levy <shea@shealevy.com>
>>>>> ---
>>>>>  arch/riscv/mm/init.c | 6 ++++++
>>>>>  1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>>>>> index c77df8142be2..1c832b541e95 100644
>>>>> --- a/arch/riscv/mm/init.c
>>>>> +++ b/arch/riscv/mm/init.c
>>>>> @@ -66,5 +66,11 @@ void free_initmem(void)
>>>>>  #ifdef CONFIG_BLK_DEV_INITRD
>>>>>  void free_initrd_mem(unsigned long start, unsigned long end)
>>>>>  {
>>>>> +	if (start == initrd_start)
>>>>> +		start = round_down(start, PAGE_SIZE);
>>>>> +	if (end == initrd_end)
>>>>> +		end = round_up(end, PAGE_SIZE);
>>>>> +
>>>>> +	free_reserved_area((void *)start, (void *)end, -1, "initrd");
>>>>>  }
>>>>>  #endif /* CONFIG_BLK_DEV_INITRD */
>>>>
>>>> It looks like everyone is doing something slightly different here:
>>>>
>>>> * arm64 doesn't round to a page size, and has keep_initrd.
>>>> * arm calls poison_init_mem(), and has keep_initrd.
>>>> * sparc64 doesn't round, and doesn't have a keep_initrd.
>>>> * mips doesn't round, and doesn't have a keep_initrd.
>>>> * x86 rounds end to a page size but not start, and doesn't have a keep_initrd.
>>>>
>>>> It feels like this should be something generic.  I'm adding linux-kernel to see 
>>>> what people think.
>>>
>>> Should I try to whip up something generic?
>>
>> I think that'd be best.  Nobody has said anything specific, but it's generally 
>> been suggested to take bits that we copy into our port and make them generic.  
>> If there's no clean way do to so then I'm OK taking this, though.
>
> OK, will add it to my queue.

Thanks!
