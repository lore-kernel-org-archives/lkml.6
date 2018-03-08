Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755924AbeCHTfr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:35:47 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45859 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755690AbeCHTfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:35:45 -0500
X-Google-Smtp-Source: AG47ELu5xMhger+UiUpazGCkOy2DICbtbbZy703Qgn8uzr06Mb8njNuEIxGEeMuLqe8s6oTlSyndpQ==
Date: Thu, 08 Mar 2018 11:35:43 -0800 (PST)
X-Google-Original-Date: Thu, 08 Mar 2018 11:35:27 PST (-0800)
Subject: Re: [PATCH] riscv: Implement free_initrd_mem.
In-Reply-To: <87efkuv0pf.fsf@xps13.shealevy.com>
CC: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From: Palmer Dabbelt <palmer@sifive.com>
To: shea@shealevy.com
Message-ID: <mhng-dd74e051-4ddc-4ca9-bfd6-d0c1ea5eb4f4@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Mar 2018 11:14:52 PST (-0800), shea@shealevy.com wrote:
> Hi Palmer,
>
> Palmer Dabbelt <palmer@sifive.com> writes:
>
>> On Tue, 20 Feb 2018 05:50:43 PST (-0800), shea@shealevy.com wrote:
>>> Signed-off-by: Shea Levy <shea@shealevy.com>
>>> ---
>>>  arch/riscv/mm/init.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>>> index c77df8142be2..1c832b541e95 100644
>>> --- a/arch/riscv/mm/init.c
>>> +++ b/arch/riscv/mm/init.c
>>> @@ -66,5 +66,11 @@ void free_initmem(void)
>>>  #ifdef CONFIG_BLK_DEV_INITRD
>>>  void free_initrd_mem(unsigned long start, unsigned long end)
>>>  {
>>> +	if (start == initrd_start)
>>> +		start = round_down(start, PAGE_SIZE);
>>> +	if (end == initrd_end)
>>> +		end = round_up(end, PAGE_SIZE);
>>> +
>>> +	free_reserved_area((void *)start, (void *)end, -1, "initrd");
>>>  }
>>>  #endif /* CONFIG_BLK_DEV_INITRD */
>>
>> It looks like everyone is doing something slightly different here:
>>
>> * arm64 doesn't round to a page size, and has keep_initrd.
>> * arm calls poison_init_mem(), and has keep_initrd.
>> * sparc64 doesn't round, and doesn't have a keep_initrd.
>> * mips doesn't round, and doesn't have a keep_initrd.
>> * x86 rounds end to a page size but not start, and doesn't have a keep_initrd.
>>
>> It feels like this should be something generic.  I'm adding linux-kernel to see 
>> what people think.
>
> Should I try to whip up something generic?

I think that'd be best.  Nobody has said anything specific, but it's generally 
been suggested to take bits that we copy into our port and make them generic.  
If there's no clean way do to so then I'm OK taking this, though.
