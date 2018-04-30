Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754090AbeD3Nsk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 09:48:40 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:46367 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753044AbeD3Nsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 09:48:39 -0400
X-Google-Smtp-Source: AB8JxZp6ucKBf0qFymrJj+hHwWhvJTwxmcgpeUgk/TfybDdqsqxTCXue+u2GgBUcDEqUTwYtBcVDAx+AQtXWiZ2trnc=
MIME-Version: 1.0
In-Reply-To: <20180430123856.GI5147@dell>
References: <20180427223023.11849-1-ksspiers@google.com> <20180430123856.GI5147@dell>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 30 Apr 2018 06:48:37 -0700
X-Google-Sender-Auth: aRpd9yX2m_9XQ2-fa5h4uYgoRN4
Message-ID: <CAGXu5jKZmVAHo+T7VryYn0VuhSi8zCNWdj_F-8BqwvV+xwY15A@mail.gmail.com>
Subject: Re: [PATCH v2] rave-sp: Remove VLA
To: Lee Jones <lee.jones@linaro.org>
Cc: Kyle Spiers <ksspiers@google.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3UDmlCZ026708

On Mon, Apr 30, 2018 at 5:38 AM, Lee Jones <lee.jones@linaro.org> wrote:
> On Fri, 27 Apr 2018, Kyle Spiers wrote:
>
>> As part of the effort to remove VLAs from the kernel[1], this creates
>> constants for the checksum lengths of CCITT and 8B2C and changes
>> crc_calculated to be the maximum size of a checksum.
>>
>> https://lkml.org/lkml/2018/3/7/621
>>
>> Signed-off-by: Kyle Spiers <ksspiers@google.com>
>> ---
>>  drivers/mfd/rave-sp.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> Applied, thanks.
>
> Kees, do you want me to add your Ack?

Sure!

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

>
>> diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
>> index 5c858e784a89..4ce96b7137db 100644
>> --- a/drivers/mfd/rave-sp.c
>> +++ b/drivers/mfd/rave-sp.c
>> @@ -45,7 +45,9 @@
>>  #define RAVE_SP_DLE                  0x10
>>
>>  #define RAVE_SP_MAX_DATA_SIZE                64
>> -#define RAVE_SP_CHECKSUM_SIZE                2  /* Worst case scenario on RDU2 */
>> +#define RAVE_SP_CHECKSUM_8B2C                1
>> +#define RAVE_SP_CHECKSUM_CCITT               2
>> +#define RAVE_SP_CHECKSUM_SIZE                RAVE_SP_CHECKSUM_CCITT
>>  /*
>>   * We don't store STX, ETX and unescaped bytes, so Rx is only
>>   * DATA + CSUM
>> @@ -415,7 +417,12 @@ static void rave_sp_receive_frame(struct rave_sp *sp,
>>       const size_t payload_length  = length - checksum_length;
>>       const u8 *crc_reported       = &data[payload_length];
>>       struct device *dev           = &sp->serdev->dev;
>> -     u8 crc_calculated[checksum_length];
>> +     u8 crc_calculated[RAVE_SP_CHECKSUM_SIZE];
>> +
>> +     if (unlikely(checksum_length > sizeof(crc_calculated))) {
>> +             dev_warn(dev, "Checksum too long, dropping\n");
>> +             return;
>> +     }
>>
>>       print_hex_dump(KERN_DEBUG, "rave-sp rx: ", DUMP_PREFIX_NONE,
>>                      16, 1, data, length, false);
>
> --
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog



-- 
Kees Cook
Pixel Security
