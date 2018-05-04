Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751013AbeEDEJQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 00:09:16 -0400
Received: from mta-p2.oit.umn.edu ([134.84.196.202]:50740 "EHLO
        mta-p2.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750707AbeEDEJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 00:09:14 -0400
X-Google-Smtp-Source: AB8JxZpMWCr44VDBnRgE8LEWHSEpJkJMMqIhnM7o1iTK3VWBsiKfEFGuwxYZmSieraMtlFDrubsqVscksAUJ4hL6SmA=
MIME-Version: 1.0
In-Reply-To: <4390a69e-a297-313d-044d-abf846eff1d1@axentia.se>
References: <1525300581-27217-1-git-send-email-wang6495@umn.edu> <4390a69e-a297-313d-044d-abf846eff1d1@axentia.se>
From: Wenwen Wang <wang6495@umn.edu>
Date: Thu, 3 May 2018 23:08:32 -0500
X-Gmail-Original-Message-ID: <CAAa=b7e5_E_7zSaAfTm8kSA_2MkyYXv-xS=ZH1AY9-u_s+Y+CA@mail.gmail.com>
Message-ID: <CAAa=b7e5_E_7zSaAfTm8kSA_2MkyYXv-xS=ZH1AY9-u_s+Y+CA@mail.gmail.com>
Subject: Re: [PATCH] i2c: core-smbus: fix a potential uninitialization bug
To: Peter Rosin <peda@axentia.se>
Cc: Kangjie Lu <kjlu@umn.edu>, Wolfram Sang <wsa@the-dreams.de>,
        "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Wenwen Wang <wang6495@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 3, 2018 at 3:34 PM, Peter Rosin <peda@axentia.se> wrote:
> On 2018-05-03 00:36, Wenwen Wang wrote:
>> In i2c_smbus_xfer_emulated(), there are two buffers: msgbuf0 and msgbuf1,
>> which are used to save a series of messages, as mentioned in the comment.
>> According to the value of the variable "size", msgbuf0 is initialized to
>> various values. In contrast, msgbuf1 is left uninitialized until the
>> function i2c_transfer() is invoked. However, mgsbuf1 is not always
>> initialized on all possible execution paths (implementation) of
>> i2c_transfer(). Thus, it is possible that mgsbuf1 may still not be
>
> double negation here
>
>> uninitialized even after the invocation of the function i2c_transfer(). In
>> the following execution, the uninitialized msgbuf1 will be used, such as
>> for security checks. Since uninitialized values can be random and
>> arbitrary, this will cause undefined behaviors or even check bypass. For
>> example, it is expected that if the value of "size" is
>> I2C_SMBUS_BLOCK_PROC_CALL, the value of data->block[0] should not be larger
>> than I2C_SMBUS_BLOCK_MAX. But, at the end of i2c_smbus_xfer_emulated(), the
>> value read from msgbuf1 is assigned to data->block[0], which can
>> potentially lead to invalid block write size, as demonstrated in the error
>> message.
>>
>> This patch simply initializes the buffer msgbuf1 with 0 to avoid undefined
>> behaviors or security issues.
>>
>> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
>> ---
>>  drivers/i2c/i2c-core-smbus.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
>> index b5aec33..0fcca75 100644
>> --- a/drivers/i2c/i2c-core-smbus.c
>> +++ b/drivers/i2c/i2c-core-smbus.c
>> @@ -324,7 +324,7 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
>>        * somewhat simpler.
>>        */
>>       unsigned char msgbuf0[I2C_SMBUS_BLOCK_MAX+3];
>> -     unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2];
>> +     unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2] = {0};
>
> I think this will result in the whole of msgbuf1 being filled with zeroes.
> It might be cheaper to do this with code proper rather than with an
> initializer?

Thanks for your comment, Peter!  How about using a memset() only when
i2c_smbus_xfer_emulated() emulates reading commands, since msgbuf1 is
used only in that case?

Thanks,
Wenwen

>
> Cheers,
> Peter
>
>>       int num = read_write == I2C_SMBUS_READ ? 2 : 1;
>>       int i;
>>       u8 partial_pec = 0;
>>
>
