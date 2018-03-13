Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752455AbeCMI3v (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 04:29:51 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:41462 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752334AbeCMI3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 04:29:49 -0400
X-Google-Smtp-Source: AG47ELsHHC9oKz8yCKaHB1Bk63J3UjzS//DDrsFK5n5AeG5DBa+kQZFlSaoZm9Nyff0AKps0Y+FbYnCtNRGF0p75H74=
MIME-Version: 1.0
In-Reply-To: <20180312233102.GE3795@piout.net>
References: <20180312231338.3756-1-stefano.manni@gmail.com> <20180312233102.GE3795@piout.net>
From: Stefano Manni <stefano.manni@gmail.com>
Date: Tue, 13 Mar 2018 09:29:33 +0100
Message-ID: <CANn9nbhM7LaqKg5pbVMYygAANFhWu3N77BUD6QTaVRngOhz3fg@mail.gmail.com>
Subject: Re: [PATCH] rtc: mcp795: remove VLA usage
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2018-03-13 0:31 GMT+01:00 Alexandre Belloni
<alexandre.belloni@free-electrons.com>:
> Hi,
>
> On 13/03/2018 at 00:13:38 +0100, Stefano Manni wrote:
>> In preparation to enabling -Wvla, remove VLAs and replace them with
>> fixed-length arrays instead.
>>
>> rtc-mcp795.c uses a variable-length array declaration to contain
>> the command to write the rtcc; this can be replaced by a fixed-
>> size array of length 2 (instruction, address) + 32 (data out),
>> assuming a maximum data length of 32 bytes before wrap up.
>>
>> This was prompted by https://lkml.org/lkml/2018/3/7/621
>>
>> Signed-off-by: Stefano Manni <stefano.manni@gmail.com>
>> ---
>>  drivers/rtc/rtc-mcp795.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/rtc/rtc-mcp795.c b/drivers/rtc/rtc-mcp795.c
>> index 77f21331ae21..a5f504e2364c 100644
>> --- a/drivers/rtc/rtc-mcp795.c
>> +++ b/drivers/rtc/rtc-mcp795.c
>> @@ -61,6 +61,9 @@
>>
>>  #define SEC_PER_DAY          (24 * 60 * 60)
>>
>> +/* Maximum length for data out in write operation to RTCC */
>> +#define MCP795_MAX_DATAOUT_LEN       32
>> +
>
> This is wrong, see https://marc.info/?l=linux-kernel&m=152046370320811&w=2
>
> Also, https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git/commit/?h=rtc-next&id=74ce1a932504da166cfbccf5567aa3751b6aa599
>

You sure that the right value to use is 255 + 2? mcp795_rtcc_write() just writes
into the RTCC that contains only 32 registers (table 4-1 of
datasheet). I assumed
32 as the maximum length of data to write before wrapping up (start
from reg 0x0).
Probably 32 is just a wrong assumption but why did you choose 255?

Another thing: don't we need also to check count against the array length?

if (count > MCP795_MAX_DATAOUT_LEN)
    return -EINVAL;
