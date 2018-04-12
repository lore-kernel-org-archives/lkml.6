Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752551AbeDLGeB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 02:34:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51012 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750730AbeDLGd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 02:33:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Apr 2018 12:03:58 +0530
From: Abhishek Sahu <absahu@codeaurora.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
        Archit Taneja <architt@codeaurora.org>,
        Richard Weinberger <richard@nod.at>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Andy Gross <andy.gross@linaro.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 3/9] mtd: nand: qcom: erased page detection for
 uncorrectable errors only
In-Reply-To: <20180410105945.65f2cade@xps13>
References: <1522845745-6624-1-git-send-email-absahu@codeaurora.org>
 <1522845745-6624-4-git-send-email-absahu@codeaurora.org>
 <20180410105945.65f2cade@xps13>
Message-ID: <2c93157a2982365ceaa8af17d5e3b97a@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-10 14:29, Miquel Raynal wrote:
> Hi Abhishek,
> 
> On Wed,  4 Apr 2018 18:12:19 +0530, Abhishek Sahu
> <absahu@codeaurora.org> wrote:
> 
>> The NAND flash controller generates ECC uncorrectable error
>> first in case of completely erased page. Currently driver
>> applies the erased page detection logic for other operation
>> errors also so fix this and return EIO for other operational
>> errors.
> 
> I am sorry I don't understand very well what is the purpose of this
> patch, could you please explain it again?
> 
> Do you mean that you want to avoid having rising ECC errors when you
> read erased pages?
> 
  Thanks Miquel for your review.

  QCOM NAND flash controller has in built erased page
  detection HW.
  Following is the flow in the HW if controller tries
  to read erased page

  1. First ECC uncorrectable error will be generated from
     ECC engine since ECC engine first calculates the ECC with
     all 0xff and match the calculated ECC with ECC code in OOB
     (which is again all 0xff).
  2. After getting ECC error, erased CW detection HW checks if
     all the bytes in page are 0xff and then it updates the
     status in separate register NAND_ERASED_CW_DETECT_STATUS

  So the erased CW detect status should be checked only if
  ECC engine generated the uncorrectable error.

  Currently for all other operational errors also (like TIMEOUT,
  MPU errors etc), the erased CW detect register was being
  checked.

>> 
>> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
>> ---
>>  drivers/mtd/nand/qcom_nandc.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/mtd/nand/qcom_nandc.c 
>> b/drivers/mtd/nand/qcom_nandc.c
>> index 17321fc..57c16a6 100644
>> --- a/drivers/mtd/nand/qcom_nandc.c
>> +++ b/drivers/mtd/nand/qcom_nandc.c
>> @@ -1578,6 +1578,7 @@ static int parse_read_errors(struct 
>> qcom_nand_host *host, u8 *data_buf,
>>  	struct nand_ecc_ctrl *ecc = &chip->ecc;
>>  	unsigned int max_bitflips = 0;
>>  	struct read_stats *buf;
>> +	bool flash_op_err = false;
>>  	int i;
>> 
>>  	buf = (struct read_stats *)nandc->reg_read_buf;
>> @@ -1599,7 +1600,7 @@ static int parse_read_errors(struct 
>> qcom_nand_host *host, u8 *data_buf,
>>  		buffer = le32_to_cpu(buf->buffer);
>>  		erased_cw = le32_to_cpu(buf->erased_cw);
>> 
>> -		if (flash & (FS_OP_ERR | FS_MPU_ERR)) {
>> +		if ((flash & FS_OP_ERR) && (buffer & BS_UNCORRECTABLE_BIT)) {
> 
> And later you have another "if (buffer & BS_UNCORRECTABLE_BIT)" which
> is then redundant, unless that is not what you actually want to do?

  Yes. That check seems to be redundant. I will fix that.

> 
> Maybe you can add comments before the if ()/ else if () to explain in
> which case you enter each branch.

  Sure. That would be better. Will add the same in next patch set.

> 
>>  			bool erased;
>> 
>>  			/* ignore erased codeword errors */
>> @@ -1641,6 +1642,8 @@ static int parse_read_errors(struct 
>> qcom_nand_host *host, u8 *data_buf,
>>  						max_t(unsigned int, max_bitflips, ret);
>>  				}
>>  			}
>> +		} else if (flash & (FS_OP_ERR | FS_MPU_ERR)) {
>> +			flash_op_err = true;
>>  		} else {
>>  			unsigned int stat;
>> 
>> @@ -1654,6 +1657,9 @@ static int parse_read_errors(struct 
>> qcom_nand_host *host, u8 *data_buf,
>>  			oob_buf += oob_len + ecc->bytes;
>>  	}
>> 
>> +	if (flash_op_err)
>> +		return -EIO;
>> +
> 
> In you are propagating an error related to the controller, this is
> fine, but I think you just want to raise the fact that a NAND
> uncorrectable error occurred, in this case you should just increment
> mtd->ecc_stats.failed and return 0 (returning max_bitflips here would 
> be
> fine too has it would be 0 too).

   The flash_op_err will be for other operational errors only (like 
timeout,
   MPU error, device failure etc). For correctable errors,

   ret = nand_check_erased_ecc_chunk(data_buf,
                           data_len, eccbuf, ecclen, oob_buf,
                           extraooblen, ecc->strength);
                   if (ret < 0) {
                           mtd->ecc_stats.failed++;
                   } else {
                           mtd->ecc_stats.corrected += ret;

  Already, it is incrementing mtd->ecc_stats.failed

  Thanks,
  Abhishek
