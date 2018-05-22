Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751872AbeEVOKZ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 10:10:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43490 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbeEVOKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 10:10:23 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Tue, 22 May 2018 19:40:21 +0530
From: Abhishek Sahu <absahu@codeaurora.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Andy Gross <andy.gross@linaro.org>,
        Archit Taneja <architt@codeaurora.org>
Subject: Re: [PATCH v2 06/14] mtd: rawnand: qcom: erased page detection for
 uncorrectable errors only
In-Reply-To: <20180522090459.71d35004@xps13>
References: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
 <1525350041-22995-7-git-send-email-absahu@codeaurora.org>
 <20180522090459.71d35004@xps13>
Message-ID: <6368d5f14b40626bd590f6eda8cf1bcd@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-22 12:34, Miquel Raynal wrote:
> Hi Abhishek,
> 
> On Thu,  3 May 2018 17:50:33 +0530, Abhishek Sahu
> <absahu@codeaurora.org> wrote:
> 
>> Following is the flow in the HW if controller tries to read erased
>> page
> 
> Nit:  ^ missing ':'
> 

  Sure. I will fix this.

>> 
>> 1. First ECC uncorrectable error will be generated from ECC engine
>>    since ECC engine first calculates the ECC with all 0xff and match
>>    the calculated ECC with ECC code in OOB (which is again all 0xff).
>> 2. After getting ECC error, erased CW detection logic will be
>>    applied which is different for BCH and RS ECC
>>     a. For BCH, HW checks if all the bytes in page are 0xff and then
>>        it updates the status in separate register
>>        NAND_ERASED_CW_DETECT_STATUS.
>>     b. For RS ECC, the HW reports the same error when reading an
>>        erased CW, but it notifies that it is an erased CW by
>>        placing special characters at certain offsets in the
>>        buffer.
>> 
>> So the erased CW detect status should be checked only if ECC engine
>> generated the uncorrectable error.
>> 
>> Currently for all other operational errors also (like TIMEOUT, MPU
>> errors, etc.), the erased CW detect logic is being applied so fix this
>> and return EIO for other operational errors.
>> 
>> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
>> ---
>> * Changes from v1:
>> 
>>   1. Added more detail in commit message
>>   2. Added comment before each if/else
> 
> Thanks for that, it's much more ease to review :)

  Thanks Miquel for your review.

  Regards,
  Abhishek

> 
>>   3. Removed redundant check for BS_UNCORRECTABLE_BIT
>> 
>>  drivers/mtd/nand/raw/qcom_nandc.c | 65 
>> ++++++++++++++++++++++++++-------------
>>  1 file changed, 43 insertions(+), 22 deletions(-)
>> 
> 
> Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
> 
> Thanks,
> Miquèl
