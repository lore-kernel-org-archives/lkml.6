Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157D4C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 10:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E9502088E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 10:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Bjg2jxWr";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WKXNJuso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9502088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbeG1Lqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 07:46:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55732 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbeG1Lq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 07:46:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id DA1E960B62; Sat, 28 Jul 2018 10:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532773229;
        bh=jHFVeAX6P/r8WCchjU5+JtVY3bDuGM77JVwhTDK8srY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bjg2jxWru53nU2tuw0sg8B9/cFo/BrbHmQxhR3ruwvvMHl5ydb0fdkZckBE3BCBVP
         x3DRfcH/T10X+2pWs1nkuGVszbMMDIyIC0fZIOoHFx7sXL6hlZxGX+306HA2dnn2Mk
         39m/1/cywQsBxTpj6goNJiR4Gp8x+91RBiX20EII=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 6F6DA605BD;
        Sat, 28 Jul 2018 10:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532773217;
        bh=jHFVeAX6P/r8WCchjU5+JtVY3bDuGM77JVwhTDK8srY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WKXNJusoOiSsn1efWjlaIMUcCXBHqmTI978QdzWiiSYe6UTtUSv+w7knTD2rWKccT
         QT805Kk3QYoBbmoX4xZRtkoVv+O2dEB2vfyGzSSILo0RkOL0YDVUnL3iS8/Ajc04GS
         uEu89a09UY+54Ugy41pvWGaprWRaLXnmAEkpwWWY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 28 Jul 2018 15:50:15 +0530
From:   Abhishek Sahu <absahu@codeaurora.org>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH 5/5] mtd: rawnand: qcom: reorganization by removing
 read/write helpers
In-Reply-To: <20180718235401.5ef2ce74@bbrezillon>
References: <1530863519-5564-1-git-send-email-absahu@codeaurora.org>
 <1530863519-5564-6-git-send-email-absahu@codeaurora.org>
 <20180718235401.5ef2ce74@bbrezillon>
Message-ID: <53d6e0f9832f06967248b300fb24fdfd@codeaurora.org>
X-Sender: absahu@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-19 03:24, Boris Brezillon wrote:
> On Fri,  6 Jul 2018 13:21:59 +0530
> Abhishek Sahu <absahu@codeaurora.org> wrote:
> 
>> Driver does not send the commands to NAND device for page
>> read/write operations in ->cmdfunc(). It just does some
>> minor variable initialization and rest of the things
>> are being done in actual ->read/write_oob[_raw].
>> 
>> The generic helper function calls for invoking commands during
>> page read/write are making this driver complicated. For QCOM NAND
>> driver, ->cmdfunc() does minor part of initialization and rest of
>> the initialization is performed by actual page read/write
>> functions. Also, ->read/write_oob() does not calls helper
>> function and all the initialization is being done in
>> ->read/write_oob() itself.
> 
> This sounds hazardous in the long run. Some vendor specific commands
> are re-using the READ0/READSTART semantic to read particular
> registers/OTP sections programmed at flash production time. For these
> operations, we don't want to go through the regular
> chip->ecc.read_page[_raw]() hooks, and instead use
> ->cmdfunc()/->exec_op(). You probably don't have setups with such
> NANDs yet, but that might be the case at some point.
> 

  Thanks Boris and Miquel for pointing this out.

  Yes. We don't have that setup yet and the current driver code
  also can't handle that condition since the command function was
  not doing anything in this regard.

  Since the current driver code was complicated with lot of
  code duplication, so this patch was raised to cleanup few things.

> As already suggested by Miqule, I strongly recommend that you work on
> supporting ->exec_op() instead of trying to clean things up 
> prematurely.
> 

  I did some analysis and it seems moving to ->exec_op() will help in
  long run. I will start working on that but it will take some
  time for us since It requires major code changes with lot of
  testing. I will update you when we have RFC patch ready for this.

  Meanwhile, I will address review comments in other patches of this
  series and will post v2 after removing this patch from patch series.

  Regards,
  Abhishek

>> 
>> Since after 'commit 25f815f66a14 ("mtd: nand: force drivers to
>> explicitly send READ/PROG commands")', sending of commands has
>> been moved to driver for page read/write, so this patch does
>> following changes to make code more readable:
>> 
>> 1. Introduce qcom_nand_init_page_op() and qcom_nand_start_page_op()
>>    helper functions which helps in removing code duplication in each
>>    operation.
>> 
>> 2. After issuing PROGRAM PAGE/BLOCK ERASE, QCOM NAND
>>    controller waits for BUSY signal to be de asserted and
>>    automatically issues the READ STATUS command. Currently, driver
>>    is storing this status privately and returns the same when status
>>    command comes from helper function after program/erase operation.
>>    Now, for write operations, the status can be returned from main
>>    function itself, so storing status can be removed for program
>>    operations.
>> 
>> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
>> ---
>>  drivers/mtd/nand/raw/qcom_nandc.c | 222 
>> ++++++++++++++++----------------------
>>  1 file changed, 91 insertions(+), 131 deletions(-)
>> 
>> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c 
>> b/drivers/mtd/nand/raw/qcom_nandc.c
>> index 6fb85d3..f73ee0e 100644
>> --- a/drivers/mtd/nand/raw/qcom_nandc.c
>> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
>> @@ -1382,39 +1382,37 @@ static void pre_command(struct qcom_nand_host 
>> *host, int command)
>>  	host->last_command = command;
>> 
>>  	clear_read_regs(nandc);
>> -
>> -	if (command == NAND_CMD_RESET || command == NAND_CMD_READID ||
>> -	    command == NAND_CMD_PARAM || command == NAND_CMD_ERASE1)
>> -		clear_bam_transaction(nandc);
>> +	clear_bam_transaction(nandc);
>>  }
>> 
>>  /*
>> - * this is called after NAND_CMD_PAGEPROG and NAND_CMD_ERASE1 to set 
>> our
>> - * privately maintained status byte, this status byte can be read 
>> after
>> - * NAND_CMD_STATUS is called
>> + * QCOM NAND controller by default issues READ STATUS command after 
>> PROGRAM
>> + * PAGE/BLOCK ERASE operation and updates the same in its internal 
>> status
>> + * register for last codeword. This function parses status for each 
>> CW and
>> + * return actual status byte for write/erase operation.
>>   */
>> -static void parse_erase_write_errors(struct qcom_nand_host *host, int 
>> command)
>> +static u8 parse_erase_write_errors(struct qcom_nand_host *host, int 
>> num_cw)
>>  {
>>  	struct nand_chip *chip = &host->chip;
>>  	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> -	struct nand_ecc_ctrl *ecc = &chip->ecc;
>> -	int num_cw;
>>  	int i;
>> +	u8 status = 0;
>> 
>> -	num_cw = command == NAND_CMD_PAGEPROG ? ecc->steps : 1;
>>  	nandc_read_buffer_sync(nandc, true);
>> 
>>  	for (i = 0; i < num_cw; i++) {
>>  		u32 flash_status = le32_to_cpu(nandc->reg_read_buf[i]);
>> 
>>  		if (flash_status & FS_MPU_ERR)
>> -			host->status &= ~NAND_STATUS_WP;
>> +			status &= ~NAND_STATUS_WP;
>> 
>>  		if (flash_status & FS_OP_ERR || (i == (num_cw - 1) &&
>>  						 (flash_status &
>>  						  FS_DEVICE_STS_ERR)))
>> -			host->status |= NAND_STATUS_FAIL;
>> +			status |= NAND_STATUS_FAIL;
>>  	}
>> +
>> +	return status;
>>  }
>> 
>>  static void post_command(struct qcom_nand_host *host, int command)
>> @@ -1428,9 +1426,12 @@ static void post_command(struct qcom_nand_host 
>> *host, int command)
>>  		memcpy(nandc->data_buffer, nandc->reg_read_buf,
>>  		       nandc->buf_count);
>>  		break;
>> -	case NAND_CMD_PAGEPROG:
>>  	case NAND_CMD_ERASE1:
>> -		parse_erase_write_errors(host, command);
>> +		/*
>> +		 * update privately maintained status byte, this status byte can
>> +		 * be read after NAND_CMD_STATUS is called.
>> +		 */
>> +		host->status = parse_erase_write_errors(host, 1);
>>  		break;
>>  	default:
>>  		break;
>> @@ -1448,7 +1449,6 @@ static void qcom_nandc_command(struct mtd_info 
>> *mtd, unsigned int command,
>>  {
>>  	struct nand_chip *chip = mtd_to_nand(mtd);
>>  	struct qcom_nand_host *host = to_qcom_nand_host(chip);
>> -	struct nand_ecc_ctrl *ecc = &chip->ecc;
>>  	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>>  	bool wait = false;
>>  	int ret = 0;
>> @@ -1477,23 +1477,6 @@ static void qcom_nandc_command(struct mtd_info 
>> *mtd, unsigned int command,
>>  		wait = true;
>>  		break;
>> 
>> -	case NAND_CMD_READ0:
>> -		/* we read the entire page for now */
>> -		WARN_ON(column != 0);
>> -
>> -		host->use_ecc = true;
>> -		set_address(host, 0, page_addr);
>> -		update_rw_regs(host, ecc->steps, true);
>> -		break;
>> -
>> -	case NAND_CMD_SEQIN:
>> -		WARN_ON(column != 0);
>> -		set_address(host, 0, page_addr);
>> -		break;
>> -
>> -	case NAND_CMD_PAGEPROG:
>> -	case NAND_CMD_STATUS:
>> -	case NAND_CMD_NONE:
>>  	default:
>>  		break;
>>  	}
>> @@ -1589,6 +1572,61 @@ static int check_flash_errors(struct 
>> qcom_nand_host *host, int cw_cnt)
>>  	return 0;
>>  }
>> 
>> +/* check if page write is successful */
>> +static int check_write_errors(struct qcom_nand_host *host, int 
>> cw_cnt)
>> +{
>> +	u8 status = parse_erase_write_errors(host, cw_cnt);
>> +
>> +	return (status & NAND_STATUS_FAIL) ? -EIO : 0;
>> +}
>> +
>> +/* performs the common init for page read/write operations */
>> +static void
>> +qcom_nand_init_page_op(struct qcom_nand_host *host, int num_cw, int 
>> page,
>> +		       u16 addr, bool read)
>> +{
>> +	struct nand_chip *chip = &host->chip;
>> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> +
>> +	clear_read_regs(nandc);
>> +	clear_bam_transaction(nandc);
>> +	set_address(host, addr, page);
>> +	update_rw_regs(host, num_cw, read);
>> +	if (read)
>> +		config_nand_page_read(nandc);
>> +	else
>> +		config_nand_page_write(nandc);
>> +}
>> +
>> +/*
>> + * Performs the page operation by submitting DMA descriptors and 
>> checks
>> + * the errors. For read with ecc, the read function needs to do 
>> erased
>> + * page detection so skips the error check.
>> + */
>> +static int
>> +qcom_nand_start_page_op(struct qcom_nand_host *host, int num_cw, bool 
>> read)
>> +{
>> +	struct nand_chip *chip = &host->chip;
>> +	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> +	int ret;
>> +
>> +	ret = submit_descs(nandc);
>> +	free_descs(nandc);
>> +	if (ret) {
>> +		dev_err(nandc->dev, "%s operation failure\n",
>> +			read ? "READ" : "WRITE");
>> +		return ret;
>> +	}
>> +
>> +	if (!read)
>> +		return check_write_errors(host, num_cw);
>> +
>> +	if (!host->use_ecc)
>> +		return check_flash_errors(host, num_cw);
>> +
>> +	return 0;
>> +}
>> +
>>  /* performs raw read for one codeword */
>>  static int
>>  qcom_nandc_read_cw_raw(struct mtd_info *mtd, struct nand_chip *chip,
>> @@ -1598,15 +1636,10 @@ static int check_flash_errors(struct 
>> qcom_nand_host *host, int cw_cnt)
>>  	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>>  	struct nand_ecc_ctrl *ecc = &chip->ecc;
>>  	int data_size1, data_size2, oob_size1, oob_size2;
>> -	int ret, reg_off = FLASH_BUF_ACC, read_loc = 0;
>> +	int reg_off = FLASH_BUF_ACC, read_loc = 0;
>> 
>> -	nand_read_page_op(chip, page, 0, NULL, 0);
>>  	host->use_ecc = false;
>> -
>> -	clear_bam_transaction(nandc);
>> -	set_address(host, host->cw_size * cw, page);
>> -	update_rw_regs(host, 1, true);
>> -	config_nand_page_read(nandc);
>> +	qcom_nand_init_page_op(host, 1, page, host->cw_size * cw, true);
>> 
>>  	data_size1 = mtd->writesize - host->cw_size * (ecc->steps - 1);
>>  	oob_size1 = host->bbm_size;
>> @@ -1647,14 +1680,7 @@ static int check_flash_errors(struct 
>> qcom_nand_host *host, int cw_cnt)
>> 
>>  	read_data_dma(nandc, reg_off, oob_buf + oob_size1, oob_size2, 0);
>> 
>> -	ret = submit_descs(nandc);
>> -	free_descs(nandc);
>> -	if (ret) {
>> -		dev_err(nandc->dev, "failure to read raw cw %d\n", cw);
>> -		return ret;
>> -	}
>> -
>> -	return check_flash_errors(host, 1);
>> +	return qcom_nand_start_page_op(host, 1, true);
>>  }
>> 
>>  /*
>> @@ -1857,7 +1883,8 @@ static int read_page_ecc(struct qcom_nand_host 
>> *host, u8 *data_buf,
>>  	u8 *data_buf_start = data_buf, *oob_buf_start = oob_buf;
>>  	int i, ret;
>> 
>> -	config_nand_page_read(nandc);
>> +	host->use_ecc = true;
>> +	qcom_nand_init_page_op(host, ecc->steps, page, 0, true);
>> 
>>  	/* queue cmd descs for each codeword */
>>  	for (i = 0; i < ecc->steps; i++) {
>> @@ -1914,13 +1941,9 @@ static int read_page_ecc(struct qcom_nand_host 
>> *host, u8 *data_buf,
>>  			oob_buf += oob_size;
>>  	}
>> 
>> -	ret = submit_descs(nandc);
>> -	free_descs(nandc);
>> -
>> -	if (ret) {
>> -		dev_err(nandc->dev, "failure to read page/oob\n");
>> +	ret = qcom_nand_start_page_op(host, ecc->steps, true);
>> +	if (ret)
>>  		return ret;
>> -	}
>> 
>>  	return parse_read_errors(host, data_buf_start, oob_buf_start, page);
>>  }
>> @@ -1929,17 +1952,8 @@ static int read_page_ecc(struct qcom_nand_host 
>> *host, u8 *data_buf,
>>  static int qcom_nandc_read_page(struct mtd_info *mtd, struct 
>> nand_chip *chip,
>>  				uint8_t *buf, int oob_required, int page)
>>  {
>> -	struct qcom_nand_host *host = to_qcom_nand_host(chip);
>> -	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> -	u8 *data_buf, *oob_buf = NULL;
>> -
>> -	nand_read_page_op(chip, page, 0, NULL, 0);
>> -	data_buf = buf;
>> -	oob_buf = oob_required ? chip->oob_poi : NULL;
>> -
>> -	clear_bam_transaction(nandc);
>> -
>> -	return read_page_ecc(host, data_buf, oob_buf, page);
>> +	return read_page_ecc(to_qcom_nand_host(chip), buf,
>> +			     oob_required ? chip->oob_poi : NULL, page);
>>  }
>> 
>>  /* implements ecc->read_page_raw() */
>> @@ -1969,18 +1983,8 @@ static int qcom_nandc_read_page_raw(struct 
>> mtd_info *mtd,
>>  static int qcom_nandc_read_oob(struct mtd_info *mtd, struct nand_chip 
>> *chip,
>>  			       int page)
>>  {
>> -	struct qcom_nand_host *host = to_qcom_nand_host(chip);
>> -	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>> -	struct nand_ecc_ctrl *ecc = &chip->ecc;
>> -
>> -	clear_read_regs(nandc);
>> -	clear_bam_transaction(nandc);
>> -
>> -	host->use_ecc = true;
>> -	set_address(host, 0, page);
>> -	update_rw_regs(host, ecc->steps, true);
>> -
>> -	return read_page_ecc(host, NULL, chip->oob_poi, page);
>> +	return read_page_ecc(to_qcom_nand_host(chip), NULL,
>> +			     chip->oob_poi, page);
>>  }
>> 
>>  /* implements ecc->write_page() */
>> @@ -1991,19 +1995,12 @@ static int qcom_nandc_write_page(struct 
>> mtd_info *mtd, struct nand_chip *chip,
>>  	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>>  	struct nand_ecc_ctrl *ecc = &chip->ecc;
>>  	u8 *data_buf, *oob_buf;
>> -	int i, ret;
>> -
>> -	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
>> -
>> -	clear_read_regs(nandc);
>> -	clear_bam_transaction(nandc);
>> +	int i;
>> 
>>  	data_buf = (u8 *)buf;
>>  	oob_buf = chip->oob_poi;
>> -
>>  	host->use_ecc = true;
>> -	update_rw_regs(host, ecc->steps, false);
>> -	config_nand_page_write(nandc);
>> +	qcom_nand_init_page_op(host, ecc->steps, page, 0, false);
>> 
>>  	for (i = 0; i < ecc->steps; i++) {
>>  		int data_size, oob_size;
>> @@ -2041,16 +2038,7 @@ static int qcom_nandc_write_page(struct 
>> mtd_info *mtd, struct nand_chip *chip,
>>  		oob_buf += oob_size;
>>  	}
>> 
>> -	ret = submit_descs(nandc);
>> -	if (ret)
>> -		dev_err(nandc->dev, "failure to write page\n");
>> -
>> -	free_descs(nandc);
>> -
>> -	if (!ret)
>> -		ret = nand_prog_page_end_op(chip);
>> -
>> -	return ret;
>> +	return qcom_nand_start_page_op(host, ecc->steps, false);
>>  }
>> 
>>  /* implements ecc->write_page_raw() */
>> @@ -2062,18 +2050,13 @@ static int qcom_nandc_write_page_raw(struct 
>> mtd_info *mtd,
>>  	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
>>  	struct nand_ecc_ctrl *ecc = &chip->ecc;
>>  	u8 *data_buf, *oob_buf;
>> -	int i, ret;
>> -
>> -	nand_prog_page_begin_op(chip, page, 0, NULL, 0);
>> -	clear_read_regs(nandc);
>> -	clear_bam_transaction(nandc);
>> +	int i;
>> 
>>  	data_buf = (u8 *)buf;
>>  	oob_buf = chip->oob_poi;
>> 
>>  	host->use_ecc = false;
>> -	update_rw_regs(host, ecc->steps, false);
>> -	config_nand_page_write(nandc);
>> +	qcom_nand_init_page_op(host, ecc->steps, page, 0, false);
>> 
>>  	for (i = 0; i < ecc->steps; i++) {
>>  		int data_size1, data_size2, oob_size1, oob_size2;
>> @@ -2113,16 +2096,7 @@ static int qcom_nandc_write_page_raw(struct 
>> mtd_info *mtd,
>>  		config_nand_cw_write(nandc);
>>  	}
>> 
>> -	ret = submit_descs(nandc);
>> -	if (ret)
>> -		dev_err(nandc->dev, "failure to write raw page\n");
>> -
>> -	free_descs(nandc);
>> -
>> -	if (!ret)
>> -		ret = nand_prog_page_end_op(chip);
>> -
>> -	return ret;
>> +	return qcom_nand_start_page_op(host, ecc->steps, false);
>>  }
>> 
>>  /*
>> @@ -2140,9 +2114,6 @@ static int qcom_nandc_write_oob(struct mtd_info 
>> *mtd, struct nand_chip *chip,
>>  	struct nand_ecc_ctrl *ecc = &chip->ecc;
>>  	u8 *oob = chip->oob_poi, bbm_byte;
>>  	int data_size, oob_size, bbm_offset, write_size;
>> -	int ret;
>> -
>> -	clear_bam_transaction(nandc);
>> 
>>  	/*
>>  	 * The NAND base layer calls ecc->write_oob() by setting bytes at
>> @@ -2183,24 +2154,13 @@ static int qcom_nandc_write_oob(struct 
>> mtd_info *mtd, struct nand_chip *chip,
>>  		write_size = data_size + oob_size;
>>  	}
>> 
>> -	set_address(host, host->cw_size * (ecc->steps - 1), page);
>> -	update_rw_regs(host, 1, false);
>> -
>> -	config_nand_page_write(nandc);
>> +	qcom_nand_init_page_op(host, 1, page,
>> +			       host->cw_size * (ecc->steps - 1), false);
>>  	write_data_dma(nandc, FLASH_BUF_ACC,
>>  		       nandc->data_buffer, write_size, 0);
>>  	config_nand_cw_write(nandc);
>> 
>> -	ret = submit_descs(nandc);
>> -
>> -	free_descs(nandc);
>> -
>> -	if (ret) {
>> -		dev_err(nandc->dev, "failure to write oob\n");
>> -		return -EIO;
>> -	}
>> -
>> -	return nand_prog_page_end_op(chip);
>> +	return qcom_nand_start_page_op(host, 1, false);
>>  }
>> 
>>  /*
