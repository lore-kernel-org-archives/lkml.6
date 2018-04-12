Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbeDLHdk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 03:33:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36538 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751049AbeDLHdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 03:33:39 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Thu, 12 Apr 2018 13:03:37 +0530
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
Subject: Re: [PATCH 7/9] mtd: nand: qcom: check for operation errors in case
 of raw read
In-Reply-To: <20180410121230.1ffdd473@xps13>
References: <1522845745-6624-1-git-send-email-absahu@codeaurora.org>
 <1522845745-6624-8-git-send-email-absahu@codeaurora.org>
 <20180410121230.1ffdd473@xps13>
Message-ID: <321c3977cb4cc31e2e1591ed11588d06@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-10 15:42, Miquel Raynal wrote:
> Hi Abhishek,
> 
> On Wed,  4 Apr 2018 18:12:23 +0530, Abhishek Sahu
> <absahu@codeaurora.org> wrote:
> 
>> Currently there is no error checking for raw read. For raw
>> reads, there won’t be any ECC failure but the operational
>> failures are possible so schedule the NAND_FLASH_STATUS read
>> after each codeword.
>> 
>> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
>> ---
>>  drivers/mtd/nand/qcom_nandc.c | 56 
>> +++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 46 insertions(+), 10 deletions(-)
>> 
>> diff --git a/drivers/mtd/nand/qcom_nandc.c 
>> b/drivers/mtd/nand/qcom_nandc.c
>> index dce97e8..40c790e 100644
>> --- a/drivers/mtd/nand/qcom_nandc.c
>> +++ b/drivers/mtd/nand/qcom_nandc.c
>> @@ -1099,7 +1099,8 @@ static void config_nand_page_read(struct 
>> qcom_nand_controller *nandc)
>>   * Helper to prepare DMA descriptors for configuring registers
>>   * before reading each codeword in NAND page.
>>   */
>> -static void config_nand_cw_read(struct qcom_nand_controller *nandc)
>> +static void
>> +config_nand_cw_read(struct qcom_nand_controller *nandc, bool use_ecc)
>>  {
>>  	if (nandc->props->is_bam)
>>  		write_reg_dma(nandc, NAND_READ_LOCATION_0, 4,
>> @@ -1108,19 +1109,25 @@ static void config_nand_cw_read(struct 
>> qcom_nand_controller *nandc)
>>  	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
>>  	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
>> 
>> -	read_reg_dma(nandc, NAND_FLASH_STATUS, 2, 0);
>> -	read_reg_dma(nandc, NAND_ERASED_CW_DETECT_STATUS, 1,
>> -		     NAND_BAM_NEXT_SGL);
>> +	if (use_ecc) {
>> +		read_reg_dma(nandc, NAND_FLASH_STATUS, 2, 0);
>> +		read_reg_dma(nandc, NAND_ERASED_CW_DETECT_STATUS, 1,
>> +			     NAND_BAM_NEXT_SGL);
>> +	} else {
>> +		read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
>> +	}
>>  }
>> 
>>  /*
>>   * Helper to prepare dma descriptors to configure registers needed 
>> for reading a
>>   * single codeword in page
>>   */
>> -static void config_nand_single_cw_page_read(struct 
>> qcom_nand_controller *nandc)
>> +static void
>> +config_nand_single_cw_page_read(struct qcom_nand_controller *nandc,
>> +				bool use_ecc)
>>  {
>>  	config_nand_page_read(nandc);
>> -	config_nand_cw_read(nandc);
>> +	config_nand_cw_read(nandc, use_ecc);
>>  }
>> 
>>  /*
>> @@ -1201,7 +1208,7 @@ static int nandc_param(struct qcom_nand_host 
>> *host)
>>  	nandc->buf_count = 512;
>>  	memset(nandc->data_buffer, 0xff, nandc->buf_count);
>> 
>> -	config_nand_single_cw_page_read(nandc);
>> +	config_nand_single_cw_page_read(nandc, false);
>> 
>>  	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer,
>>  		      nandc->buf_count, 0);
>> @@ -1565,6 +1572,23 @@ struct read_stats {
>>  	__le32 erased_cw;
>>  };
>> 
>> +/* reads back FLASH_STATUS register set by the controller */
>> +static int check_flash_errors(struct qcom_nand_host *host, int 
>> cw_cnt)
>> +{
>> +	struct nand_chip *chip = &host->chip;
>> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> +	int i;
>> +
>> +	for (i = 0; i < cw_cnt; i++) {
>> +		u32 flash = le32_to_cpu(nandc->reg_read_buf[i]);
>> +
>> +		if (flash & (FS_OP_ERR | FS_MPU_ERR))
>> +			return -EIO;
> 
> This is already checked in parse_read_error(), maybe it would be
> preferable to have different path inside this function depending on the
> 'raw' nature of the operation?
> 

  Thanks Miquel,

  The parse_read_error will be called only for reads with ECC enabled
  which uses 3 status registers. It has other code also related with
  erased page detection and more code will be added in last patch
  for bitflip detection.

  For all others cases, only one status register FLASH_STATUS needs
  to be checked and this check_flash_errors does the same.

>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  /*
>>   * reads back status registers set by the controller to notify page 
>> read
>>   * errors. this is equivalent to what 'ecc->correct()' would do.
>> @@ -1707,7 +1731,7 @@ static int read_page_ecc(struct qcom_nand_host 
>> *host, u8 *data_buf,
>>  			}
>>  		}
>> 
>> -		config_nand_cw_read(nandc);
>> +		config_nand_cw_read(nandc, true);
>> 
>>  		if (data_buf)
>>  			read_data_dma(nandc, FLASH_BUF_ACC, data_buf,
>> @@ -1771,7 +1795,7 @@ static int copy_last_cw(struct qcom_nand_host 
>> *host, int page)
>>  	set_address(host, host->cw_size * (ecc->steps - 1), page);
>>  	update_rw_regs(host, 1, true);
>> 
>> -	config_nand_single_cw_page_read(nandc);
>> +	config_nand_single_cw_page_read(nandc, host->use_ecc);
>> 
>>  	read_data_dma(nandc, FLASH_BUF_ACC, nandc->data_buffer, size, 0);
>> 
>> @@ -1781,6 +1805,15 @@ static int copy_last_cw(struct qcom_nand_host 
>> *host, int page)
>> 
>>  	free_descs(nandc);
>> 
>> +	if (!ret) {
>> +		if (host->use_ecc)
>> +			ret = parse_read_errors(host, nandc->data_buffer,
>> +						nandc->data_buffer + size,
>> +						true);
>> +		else
>> +			ret = check_flash_errors(host, 1);
> 
> This way you would avoid this ^
> 
>> +	}
>> +
> 
> As a general way, I don't like very much this kind of error checking
> structure:
> 
> if (!ret)
>         ret = something();
> ...
> return ret;
> 
> I would rather prefer:
> 
> if (ret)
>         return ret;
> 
> return something();
> 
>>  	return ret;
>>  }
>> 

  Yes. That would make it more readable.
  I will fix that.

>> @@ -1854,7 +1887,7 @@ static int qcom_nandc_read_page_raw(struct 
>> mtd_info *mtd,
>>  			nandc_set_read_loc(nandc, 3, read_loc, oob_size2, 1);
>>  		}
>> 
>> -		config_nand_cw_read(nandc);
>> +		config_nand_cw_read(nandc, false);
>> 
>>  		read_data_dma(nandc, reg_off, data_buf, data_size1, 0);
>>  		reg_off += data_size1;
>> @@ -1878,6 +1911,9 @@ static int qcom_nandc_read_page_raw(struct 
>> mtd_info *mtd,
>> 
>>  	free_descs(nandc);
>> 
>> +	if (!ret)
>> +		ret = check_flash_errors(host, ecc->steps);
>> +
> 
> There is not point in doing ret = ... if you return 0 right after.
> Please check what would be the most appropriate.
> 

  Thanks Miquel for noticing it.
  This 'return 0' was present from the initial commit itself.
  I will raise separate patch to fix this.

  Thanks,
  Abhishek

>>  	return 0;
>>  }
>> 
> 
> Thanks,
> Miquèl
