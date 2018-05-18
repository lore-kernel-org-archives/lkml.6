Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752253AbeERT0e (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 15:26:34 -0400
Received: from mta-p4.oit.umn.edu ([134.84.196.204]:33170 "EHLO
        mta-p4.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbeERT0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 15:26:30 -0400
X-Google-Smtp-Source: AB8JxZrbkJKR9LRsIDTSGw/ZwUA21mlVZzSgdMntvyuhDhydUiQXejOZCUSgYAhV49iaaOuuYGMa/FLPtcqxdb/ndC4=
MIME-Version: 1.0
In-Reply-To: <ac843580-884e-b0fc-60af-8d73ba099100@axentia.se>
References: <1525525030-9805-1-git-send-email-wang6495@umn.edu>
 <20180510111737.b6g7s2nnf6froote@ninjato> <ac843580-884e-b0fc-60af-8d73ba099100@axentia.se>
From: Wenwen Wang <wang6495@umn.edu>
Date: Fri, 18 May 2018 14:25:48 -0500
X-Gmail-Original-Message-ID: <CAAa=b7cvVW-LDY6PuHKVTaj5unp90JH4mxP2kFxfOO2OAcGkgw@mail.gmail.com>
Message-ID: <CAAa=b7cvVW-LDY6PuHKVTaj5unp90JH4mxP2kFxfOO2OAcGkgw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] i2c: core-smbus: fix a potential uninitialization bug
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Peter Rosin <peda@axentia.se>, Kangjie Lu <kjlu@umn.edu>,
        "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Wenwen Wang <wang6495@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, this patch does not aim to "fix" all potential driver bugs but
adds an additional protection in case the implementation of
.master_xfer is incorrect.

>From this perspective, it is still necessary to apply this patch, as
pointed out by Peter.

Thanks,
Wenwen

On Mon, May 14, 2018 at 3:31 PM, Peter Rosin <peda@axentia.se> wrote:
> On 2018-05-10 13:17, Wolfram Sang wrote:
>> On Sat, May 05, 2018 at 07:57:10AM -0500, Wenwen Wang wrote:
>>> In i2c_smbus_xfer_emulated(), there are two buffers: msgbuf0 and msgbuf1,
>>> which are used to save a series of messages, as mentioned in the comment.
>>> According to the value of the variable 'size', msgbuf0 is initialized to
>>> various values. In contrast, msgbuf1 is left uninitialized until the
>>> function i2c_transfer() is invoked. However, msgbuf1 is not always
>>> initialized on all possible execution paths (implementation) of
>>> i2c_transfer(). Thus, it is possible that msgbuf1 may still be
>>> uninitialized even after the invocation of the function i2c_transfer(),
>>> especially when the return value of ic2_transfer() is not checked properly.
>>> In the following execution, the uninitialized msgbuf1 will be used, such as
>>> for security checks. Since uninitialized values can be random and
>>> arbitrary, this will cause undefined behaviors or even check bypass. For
>>> example, it is expected that if the value of 'size' is
>>> I2C_SMBUS_BLOCK_PROC_CALL, the value of data->block[0] should not be larger
>>> than I2C_SMBUS_BLOCK_MAX. But, at the end of i2c_smbus_xfer_emulated(), the
>>> value read from msgbuf1 is assigned to data->block[0], which can
>>> potentially lead to invalid block write size, as demonstrated in the error
>>> message.
>>>
>>> This patch initializes the first byte of msgbuf1 with 0 to avoid such
>>> undefined behaviors or security issues.
>>>
>>> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
>>
>> From what I can tell, this patch is not needed anymore after patch 2 is
>> applied. Correct?
>
> AFAIU, it is only needed if there are bugs elsewhere. I.e. it's for extra
> protection. If all drivers implement .master_xfer correctly, msgbuf1 will
> be filled in and the return value will be the number of messages (i.e. 2)
> OR you get a negative return value and the msgbuf1 content will not matter.
>
> The patch does not magically fix all possible driver bugs, so in that
> sense this patch is still "needed".
>
> Also - again AFAIU - there is no known bug that actually gets caught by
> this extra check.
>
> Cheers,
> Peter
