Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754687AbeEHHWc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 03:22:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33380 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754412AbeEHHWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 03:22:31 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 08 May 2018 12:52:29 +0530
From: Abhishek Sahu <absahu@codeaurora.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Archit Taneja <architt@codeaurora.org>,
        Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Andy Gross <andy.gross@linaro.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2 01/14] mtd: rawnand: helper function for setting up ECC
 parameters
In-Reply-To: <20180507101646.3df649b0@bbrezillon>
References: <1525350041-22995-1-git-send-email-absahu@codeaurora.org>
 <1525350041-22995-2-git-send-email-absahu@codeaurora.org>
 <20180507101646.3df649b0@bbrezillon>
Message-ID: <f7d161689217a8310ee34619b0dd5181@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-07 13:46, Boris Brezillon wrote:
> On Thu,  3 May 2018 17:50:28 +0530
> Abhishek Sahu <absahu@codeaurora.org> wrote:
> 
>> commit 2c8f8afa7f92 ("mtd: nand: add generic helpers to check,
>> match, maximize ECC settings") provides generic helpers which
>> drivers can use for setting up ECC parameters.
>> 
>> Since same board can have different ECC strength nand chips so
>> following is the logic for setting up ECC strength and ECC step
>> size, which can be used by most of the drivers.
>> 
>> 1. If both ECC step size and ECC strength are already set
>>    (usually by DT) then just check whether this setting
>>    is supported by NAND controller.
>> 2. If NAND_ECC_MAXIMIZE is set, then select maximum ECC strength
>>    supported by NAND controller.
>> 3. Otherwise, try to match the ECC step size and ECC strength closest
>>    to the chip's requirement. If available OOB size can't fit the chip
>>    requirement then select maximum ECC strength which can be fit with
>>    available OOB size with warning.
>> 
>> This patch introduces nand_ecc_param_setup function which calls the
>> required helper functions for the above logic. The drivers can use
>> this single function instead of calling the 3 helper functions
>> individually.
>> 
>> CC: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
>> ---
>> * Changes from v1:
>> 
>>   NEW PATCH
>> 
>>  drivers/mtd/nand/raw/nand_base.c | 42 
>> ++++++++++++++++++++++++++++++++++++++++
>>  include/linux/mtd/rawnand.h      |  3 +++
>>  2 files changed, 45 insertions(+)
>> 
>> diff --git a/drivers/mtd/nand/raw/nand_base.c 
>> b/drivers/mtd/nand/raw/nand_base.c
>> index 72f3a89..dd7a984 100644
>> --- a/drivers/mtd/nand/raw/nand_base.c
>> +++ b/drivers/mtd/nand/raw/nand_base.c
>> @@ -6249,6 +6249,48 @@ int nand_maximize_ecc(struct nand_chip *chip,
>>  }
>>  EXPORT_SYMBOL_GPL(nand_maximize_ecc);
>> 
>> +/**
>> + * nand_ecc_param_setup - Set the ECC strength and ECC step size
>> + * @chip: nand chip info structure
>> + * @caps: ECC engine caps info structure
>> + * @oobavail: OOB size that the ECC engine can use
>> + *
>> + * Choose the ECC strength according to following logic
>> + *
>> + * 1. If both ECC step size and ECC strength are already set (usually 
>> by DT)
>> + *    then check if it is supported by this controller.
>> + * 2. If NAND_ECC_MAXIMIZE is set, then select maximum ECC strength.
>> + * 3. Otherwise, try to match the ECC step size and ECC strength 
>> closest
>> + *    to the chip's requirement. If available OOB size can't fit the 
>> chip
>> + *    requirement then fallback to the maximum ECC step size and ECC 
>> strength
>> + *    and print the warning.
>> + *
>> + * On success, the chosen ECC settings are set.
>> + */
>> +int nand_ecc_param_setup(struct nand_chip *chip,
>> +			 const struct nand_ecc_caps *caps, int oobavail)
> 
> Can we rename this function "nand_ecc_choose_conf()".

  Thanks Boris.
  I will rename this function.

  Regards,
  Abhishek
