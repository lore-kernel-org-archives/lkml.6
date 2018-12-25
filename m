Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B6FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC5520851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 08:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfAQImb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 03:42:31 -0500
Received: from mo-csw1115.securemx.jp ([210.130.202.157]:58504 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbfAQImb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 03:42:31 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id x0H8fdNm022623; Thu, 17 Jan 2019 17:41:40 +0900
X-Iguazu-Qid: 2wGqmlbH9TVgC0r5TF
X-Iguazu-QSIG: v=2; s=0; t=1547714499; q=2wGqmlbH9TVgC0r5TF; m=WN6ym3wujnZFL+Xkjeai3fFXBiTNnGD8gNF4Ays+bJE=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1111) id x0H8fTuH036348;
        Thu, 17 Jan 2019 17:41:29 +0900
Received: from enc03.localdomain ([106.186.93.13])
        by imx2.toshiba.co.jp  with ESMTP id x0H8fSEX026706;
        Thu, 17 Jan 2019 17:41:28 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc03.localdomain  with ESMTP id x0H8fSbZ026843;
        Thu, 17 Jan 2019 17:41:28 +0900
Reply-To: tmcmc-mb-yfuruyama7@ml.toshiba.co.jp
Subject: Re: [PATCH] mtd: spinand: Add support for all Toshiba Memory products
To:     Schrempf Frieder <frieder.schrempf@kontron.de>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>
Cc:     "richard@nod.at" <richard@nod.at>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "peron.clem@gmail.com" <peron.clem@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190116055319.2755-1-tmcmc-mb-yfuruyama7@ml.toshiba.co.jp>
 <d6230005-5dfa-60f9-7eec-87d119aa415d@kontron.de>
From:   posting test <tmcmc-mb-yfuruyama7@ml.toshiba.co.jp>
X-TSB-HOP: ON
Message-ID: <fd127eea-ec2f-5d28-b8dc-40810f479e95@ml.toshiba.co.jp>
Date:   Tue, 25 Dec 2018 12:25:19 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d6230005-5dfa-60f9-7eec-87d119aa415d@kontron.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Schrempf, Miquel,

Thanks a lot.


On 2019年01月16日 21:58, Schrempf Frieder wrote:
> On 16.01.19 06:53, Yoshio Furuyama wrote:
>> Add device table for Toshiba Memory products.
>> Also, generalize OOB layout structure and function names.
>>
>> Signed-off-by: Yoshio Furuyama <tmcmc-mb-yfuruyama7@ml.toshiba.co.jp>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>
>> ---
>>    drivers/mtd/nand/spi/toshiba.c |   79 +++++++++++++++++++++++++++++++++-------
>>    1 file changed, 65 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
>> index 0812655..0916962 100644
>> --- a/drivers/mtd/nand/spi/toshiba.c
>> +++ b/drivers/mtd/nand/spi/toshiba.c
>> @@ -25,19 +25,19 @@ static SPINAND_OP_VARIANTS(write_cache_variants,
>>    static SPINAND_OP_VARIANTS(update_cache_variants,
>>    		SPINAND_PROG_LOAD(false, 0, NULL, 0));
>>    
>> -static int tc58cvg2s0h_ooblayout_ecc(struct mtd_info *mtd, int section,
>> +static int tc58cxgxsx_ooblayout_ecc(struct mtd_info *mtd, int section,
>>    				     struct mtd_oob_region *region)
>>    {
>> -	if (section > 7)
>> +	if (section > 0)
>>    		return -ERANGE;
>>    
>> -	region->offset = 128 + 16 * section;
>> -	region->length = 16;
>> +	region->offset = mtd->oobsize / 2;
>> +	region->length = mtd->oobsize / 2;
>>    
>>    	return 0;
>>    }
>>    
>> -static int tc58cvg2s0h_ooblayout_free(struct mtd_info *mtd, int section,
>> +static int tc58cxgxsx_ooblayout_free(struct mtd_info *mtd, int section,
>>    				      struct mtd_oob_region *region)
>>    {
>>    	if (section > 0)
>> @@ -45,17 +45,17 @@ static int tc58cvg2s0h_ooblayout_free(struct mtd_info *mtd, int section,
>>    
>>    	/* 2 bytes reserved for BBM */
>>    	region->offset = 2;
>> -	region->length = 126;
>> +	region->length = mtd->oobsize / 2 - 2;
>>    
>>    	return 0;
>>    }
>>    
>> -static const struct mtd_ooblayout_ops tc58cvg2s0h_ooblayout = {
>> -	.ecc = tc58cvg2s0h_ooblayout_ecc,
>> -	.free = tc58cvg2s0h_ooblayout_free,
>> +static const struct mtd_ooblayout_ops tc58cxgxsx_ooblayout = {
>> +	.ecc = tc58cxgxsx_ooblayout_ecc,
>> +	.free = tc58cxgxsx_ooblayout_free,
>>    };
>>    
>> -static int tc58cvg2s0h_ecc_get_status(struct spinand_device *spinand,
>> +static int tc58cxgxsx_ecc_get_status(struct spinand_device *spinand,
>>    				      u8 status)
>>    {
>>    	struct nand_device *nand = spinand_to_nand(spinand);
>> @@ -94,15 +94,66 @@ static int tc58cvg2s0h_ecc_get_status(struct spinand_device *spinand,
>>    }
>>    
>>    static const struct spinand_info toshiba_spinand_table[] = {
>> -	SPINAND_INFO("TC58CVG2S0H", 0xCD,
>> +	/* 3.3V 1Gb */
>> +	SPINAND_INFO("TC58CVG0S3", 0xC2,
>> +		     NAND_MEMORG(1, 2048, 128, 64, 1024, 1, 1, 1),
>> +		     NAND_ECCREQ(8, 512),
>> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>> +					      &write_cache_variants,
>> +					      &update_cache_variants),
>> +		     0,
>> +		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
>> +				     tc58cxgxsx_ecc_get_status)),
>> +	/* 3.3V 2Gb */
>> +	SPINAND_INFO("TC58CVG1S3", 0xCB,
>> +		     NAND_MEMORG(1, 2048, 128, 64, 2048, 1, 1, 1),
>> +		     NAND_ECCREQ(8, 512),
>> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>> +					      &write_cache_variants,
>> +					      &update_cache_variants),
>> +		     0,
>> +		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
>> +				     tc58cxgxsx_ecc_get_status)),
>> +	/* 3.3V 4Gb */
>> +	SPINAND_INFO("TC58CVG2S0", 0xCD,
>> +		     NAND_MEMORG(1, 4096, 256, 64, 2048, 1, 1, 1),
>> +		     NAND_ECCREQ(8, 512),
>> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>> +					      &write_cache_variants,
>> +					      &update_cache_variants),
>> +		     0,
>> +		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
>> +				     tc58cxgxsx_ecc_get_status)),
>> +	/* 1.8V 1Gb */
>> +	SPINAND_INFO("TC58CYG0S3", 0xB2,
>> +		     NAND_MEMORG(1, 2048, 128, 64, 1024, 1, 1, 1),
>> +		     NAND_ECCREQ(8, 512),
>> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>> +					      &write_cache_variants,
>> +					      &update_cache_variants),
>> +		     0,
>> +		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
>> +				     tc58cxgxsx_ecc_get_status)),
>> +	/* 1.8V 2Gb */
>> +	SPINAND_INFO("TC58CYG1S3", 0xBB,
>> +		     NAND_MEMORG(1, 2048, 128, 64, 2048, 1, 1, 1),
>> +		     NAND_ECCREQ(8, 512),
>> +		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>> +					      &write_cache_variants,
>> +					      &update_cache_variants),
>> +		     0,
>> +		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
>> +				     tc58cxgxsx_ecc_get_status)),
>> +	/* 1.8V 4Gb */
>> +	SPINAND_INFO("TC58CYG2S0", 0xBD,
>>    		     NAND_MEMORG(1, 4096, 256, 64, 2048, 1, 1, 1),
>>    		     NAND_ECCREQ(8, 512),
>>    		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
>>    					      &write_cache_variants,
>>    					      &update_cache_variants),
>> -		     SPINAND_HAS_QE_BIT,
>> -		     SPINAND_ECCINFO(&tc58cvg2s0h_ooblayout,
>> -				     tc58cvg2s0h_ecc_get_status)),
>> +		     0,
>> +		     SPINAND_ECCINFO(&tc58cxgxsx_ooblayout,
>> +				     tc58cxgxsx_ecc_get_status)),
>>    };
>>    
>>    static int toshiba_spinand_detect(struct spinand_device *spinand)
>>
>

