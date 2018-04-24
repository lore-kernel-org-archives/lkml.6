Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751709AbeDXQHV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:07:21 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:35624 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751326AbeDXQHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:07:17 -0400
X-Google-Smtp-Source: AIpwx49nY3Gz+OwFeHM1m69JDbtlpwWUHWDgYqzu/2PSsT1VQGE3oNFcZ2cL6GYbhx9y9fBvBl/dMUq1VBRP5vCXtAU=
MIME-Version: 1.0
In-Reply-To: <20180424054315.2yjpnht5pu62i54q@dell>
References: <20180423200255.154645-1-ksspiers@google.com> <20180424054315.2yjpnht5pu62i54q@dell>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 24 Apr 2018 09:07:16 -0700
X-Google-Sender-Auth: kUE_DGH7vPr3qJ3BPGLprjLoKOE
Message-ID: <CAGXu5jL5j6ZknsKN8ve+4qgSQLKsssUTto_UXORABgfHop=-7w@mail.gmail.com>
Subject: Re: [PATCH] rave-sp: Remove VLA
To: Lee Jones <lee.jones@linaro.org>
Cc: Kyle Spiers <ksspiers@google.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 10:43 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 23 Apr 2018, Kyle Spiers wrote:
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
>>
>> diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
>> index 5c858e784a89..99fa482419f9 100644
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
>> +     if (unlikely(length > sizeof(crc_calculated))) {
>
> Forgive me if I have this wrong (it's still very early here), but this
> doesn't leave any room for the payload?
>
>     <--       length         -->
>     <ck len><- payload length ->
>     [CK][CK][D][A][T][A] .. [64]
>
> It is my hope that length would always be larger than the size of the
> checksum, or else there would never be any data?
>
> Should this not be:
>
>     if (unlikely(length > RAVE_SP_MAX_DATA_SIZE))

Oh, whoops, no, this should be:

+     if (unlikely(checksum_lengh > sizeof(crc_calculated))) {

(To validate the VLA max size.)

-Kees

-- 
Kees Cook
Pixel Security
