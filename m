Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751298AbeCIHnl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 02:43:41 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:44295 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbeCIHnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 02:43:39 -0500
X-Google-Smtp-Source: AG47ELs8xec3bZ6ELBymI8r4rotfbqEaha8Ef4xZLFIv9UrRuqYEJvz5VCvHowVvPxG7FHlWmi2C5xUx3MPAdaotgEI=
MIME-Version: 1.0
In-Reply-To: <1520507105.11634.5.camel@perches.com>
References: <20180308080020.22828-1-ard.biesheuvel@linaro.org>
 <20180308080020.22828-13-ard.biesheuvel@linaro.org> <1520507105.11634.5.camel@perches.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Fri, 9 Mar 2018 07:43:37 +0000
Message-ID: <CAKv+Gu8iMvzvSP9-YPe+ms4qVMjcQqNQ25Wa16JW_tEG7P+jtQ@mail.gmail.com>
Subject: Re: [PATCH 12/12] efi: make const array 'apple' static
To: Joe Perches <joe@perches.com>
Cc: linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Colin Ian King <colin.king@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 March 2018 at 11:05, Joe Perches <joe@perches.com> wrote:
> On Thu, 2018-03-08 at 08:00 +0000, Ard Biesheuvel wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Don't populate the const read-only array 'buf' on the stack but instead
>> make it static. Makes the object code smaller by 64 bytes:
>>
>> Before:
>>    text          data     bss     dec     hex filename
>>    9264             1      16    9281    2441 arch/x86/boot/compressed/eboot.o
>>
>> After:
>>    text          data     bss     dec     hex filename
>>    9200             1      16    9217    2401 arch/x86/boot/compressed/eboot.o
>>
>> (gcc version 7.2.0 x86_64)
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>  arch/x86/boot/compressed/eboot.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
>> index 886a9115af62..f2251c1c9853 100644
>> --- a/arch/x86/boot/compressed/eboot.c
>> +++ b/arch/x86/boot/compressed/eboot.c
>> @@ -423,7 +423,7 @@ static void retrieve_apple_device_properties(struct boot_params *boot_params)
>>
>>  static void setup_quirks(struct boot_params *boot_params)
>>  {
>> -     efi_char16_t const apple[] = { 'A', 'p', 'p', 'l', 'e', 0 };
>> +     static efi_char16_t const apple[] = { 'A', 'p', 'p', 'l', 'e', 0 };
>
> Perhaps
>
> static const efi_char16_t apple[] ...
>
> is better.
>

Why would that be any better? I have always found the 'const'
placement after the type to be much clearer.

const void *
void const *
void * const

I.e., #2 and #3 are equivalent, and so 'const' associates to the left
not to the right, unless it is at the beginning.

Personally, I don't mind either way, but saying it is 'better' is a stretch imo
