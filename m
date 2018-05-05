Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751243AbeEEMZz (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 08:25:55 -0400
Received: from mta-p4.oit.umn.edu ([134.84.196.204]:55274 "EHLO
        mta-p4.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeEEMZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 08:25:53 -0400
X-Google-Smtp-Source: AB8JxZpJuO+BFSzmrt0hDdkXOLoNCUna4MzJY8sUg0AYHf0uQDhwt1xTbLKbHHI3xq/Tbkv3ciYG+kpbcrLwWclm6Lk=
MIME-Version: 1.0
In-Reply-To: <63ff0aae-9a34-9c6a-625d-7b07b7da9ed3@axentia.se>
References: <1525484596-5585-1-git-send-email-wang6495@umn.edu> <63ff0aae-9a34-9c6a-625d-7b07b7da9ed3@axentia.se>
From: Wenwen Wang <wang6495@umn.edu>
Date: Sat, 5 May 2018 07:17:29 -0500
X-Gmail-Original-Message-ID: <CAAa=b7e+Gvg3kAXbYwQRCvt0m-w-zWi-XqL5Q15vMGS80CWdng@mail.gmail.com>
Message-ID: <CAAa=b7e+Gvg3kAXbYwQRCvt0m-w-zWi-XqL5Q15vMGS80CWdng@mail.gmail.com>
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

On Sat, May 5, 2018 at 5:28 AM, Peter Rosin <peda@axentia.se> wrote:
> On 2018-05-05 03:43, Wenwen Wang wrote:
>> In i2c_smbus_xfer_emulated(), there are two buffers: msgbuf0 and msgbuf1,
>> which are used to save a series of messages, as mentioned in the comment.
>> According to the value of the variable "size", msgbuf0 is initialized to
>> various values. In contrast, msgbuf1 is left uninitialized until the
>> function i2c_transfer() is invoked. However, mgsbuf1 is not always
>> initialized on all possible execution paths (implementation) of
>> i2c_transfer(). Thus, it is possible that mgsbuf1 may still be
>> uninitialized even after the invocation of the function i2c_transfer(),
>> especially when the return value of ic2_transfer() is not checked properly.
>> In the following execution, the uninitialized msgbuf1 will be used, such as
>> for security checks. Since uninitialized values can be random and
>> arbitrary, this will cause undefined behaviors or even check bypass. For
>> example, it is expected that if the value of "size" is
>> I2C_SMBUS_BLOCK_PROC_CALL, the value of data->block[0] should not be larger
>> than I2C_SMBUS_BLOCK_MAX. But, at the end of i2c_smbus_xfer_emulated(), the
>> value read from msgbuf1 is assigned to data->block[0], which can
>> potentially lead to invalid block write size, as demonstrated in the error
>> message.
>>
>> This patch checks the return value of i2c_transfer() and also initializes
>> the first byte of msgbuf1 with 0 to avoid undefined behaviors or security
>> issues.
>>
>> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
>> ---
>>  drivers/i2c/i2c-core-smbus.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
>> index b5aec33..e8470d5 100644
>> --- a/drivers/i2c/i2c-core-smbus.c
>> +++ b/drivers/i2c/i2c-core-smbus.c
>> @@ -344,6 +344,7 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
>>       };
>>
>>       msgbuf0[0] = command;
>> +     msgbug1[0] = 0;
>>       switch (size) {
>>       case I2C_SMBUS_QUICK:
>>               msg[0].len = 0;
>> @@ -466,6 +467,8 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
>>       status = i2c_transfer(adapter, msg, num);
>>       if (status < 0)
>>               return status;
>> +     if (status != num)
>> +             return -EIO;
>>
>>       /* Check PEC if last message is a read */
>>       if (i && (msg[num-1].flags & I2C_M_RD)) {
>>
>
> I think these two hunks should be two separate patches. They address
> orthogonal issues...

Sure, I will split it into two patches and fix the typo :)

Thanks!
Wenwen
