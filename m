Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932410AbeCOPja (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:39:30 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:60727 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752738AbeCOPj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:39:29 -0400
Date: Thu, 15 Mar 2018 16:39:18 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20180315163620.6122d752@bbrezillon>
References: <20180304200602.11475-1-stefan@agner.ch> <20180315163620.6122d752@bbrezillon>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH v2 1/2] mtd: rawnand: gpmi: add support for specific ECC strength
To: Boris Brezillon <boris.brezillon@bootlin.com>, han.xu@nxp.com
CC: boris.brezillon@free-electrons.com, max.oss.09@gmail.com,
        richard@nod.at, linux-kernel@vger.kernel.org, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, cyrille.pitchen@wedev4u.fr,
        dwmw2@infradead.org
From: Stefan Agner <stefan@agner.ch>
Message-ID: <C8FA1701-52CE-46B6-9A3E-3249D1BDA4AC@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2FFdXSU015070



On March 15, 2018 4:36:20 PM GMT+01:00, Boris Brezillon <boris.brezillon@bootlin.com> wrote:
>Hi,
>
>On Sun,  4 Mar 2018 21:06:01 +0100
>Stefan Agner <stefan@agner.ch> wrote:
>
>> Add support for specified ECC strength/size using device tree
>> properties nand-ecc-strength/nand-ecc-step-size.
>
>Han, we didn't hear back from you on that. Are you okay with adding
>these new properties? IIRC, you feared there would be a delta between
>u-boot and linux support.
>
>Stephan, there's no changelog. Has anything changed in this version or
>is this just a RESEND?

Sorry forgot that. I just split documentation and driver changes.

--
Stefan

>
>Regards,
>
>Boris
>
>> 
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 30
>++++++++++++++++++++----------
>>  1 file changed, 20 insertions(+), 10 deletions(-)
>> 
>> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
>b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
>> index 61fdd733492f..d04754289c03 100644
>> --- a/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
>> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-nand.c
>> @@ -198,17 +198,16 @@ static inline bool gpmi_check_ecc(struct
>gpmi_nand_data *this)
>>   *
>>   * We may have available oob space in this case.
>>   */
>> -static int set_geometry_by_ecc_info(struct gpmi_nand_data *this)
>> +static int set_geometry_by_ecc_info(struct gpmi_nand_data *this,
>> +				    unsigned int ecc_strength,
>> +				    unsigned int ecc_step)
>>  {
>>  	struct bch_geometry *geo = &this->bch_geometry;
>>  	struct nand_chip *chip = &this->nand;
>>  	struct mtd_info *mtd = nand_to_mtd(chip);
>>  	unsigned int block_mark_bit_offset;
>>  
>> -	if (!(chip->ecc_strength_ds > 0 && chip->ecc_step_ds > 0))
>> -		return -EINVAL;
>> -
>> -	switch (chip->ecc_step_ds) {
>> +	switch (ecc_step) {
>>  	case SZ_512:
>>  		geo->gf_len = 13;
>>  		break;
>> @@ -221,8 +220,8 @@ static int set_geometry_by_ecc_info(struct
>gpmi_nand_data *this)
>>  			chip->ecc_strength_ds, chip->ecc_step_ds);
>>  		return -EINVAL;
>>  	}
>> -	geo->ecc_chunk_size = chip->ecc_step_ds;
>> -	geo->ecc_strength = round_up(chip->ecc_strength_ds, 2);
>> +	geo->ecc_chunk_size = ecc_step;
>> +	geo->ecc_strength = round_up(ecc_strength, 2);
>>  	if (!gpmi_check_ecc(this))
>>  		return -EINVAL;
>>  
>> @@ -230,7 +229,7 @@ static int set_geometry_by_ecc_info(struct
>gpmi_nand_data *this)
>>  	if (geo->ecc_chunk_size < mtd->oobsize) {
>>  		dev_err(this->dev,
>>  			"unsupported nand chip. ecc size: %d, oob size : %d\n",
>> -			chip->ecc_step_ds, mtd->oobsize);
>> +			ecc_step, mtd->oobsize);
>>  		return -EINVAL;
>>  	}
>>  
>> @@ -423,9 +422,20 @@ static int legacy_set_geometry(struct
>gpmi_nand_data *this)
>>  
>>  int common_nfc_set_geometry(struct gpmi_nand_data *this)
>>  {
>> +	struct nand_chip *chip = &this->nand;
>> +
>> +	if (chip->ecc.strength > 0 && chip->ecc.size > 0)
>> +		return set_geometry_by_ecc_info(this, chip->ecc.strength,
>> +						chip->ecc.size);
>> +
>>  	if ((of_property_read_bool(this->dev->of_node,
>"fsl,use-minimum-ecc"))
>> -				|| legacy_set_geometry(this))
>> -		return set_geometry_by_ecc_info(this);
>> +				|| legacy_set_geometry(this)) {
>> +		if (!(chip->ecc_strength_ds > 0 && chip->ecc_step_ds > 0))
>> +			return -EINVAL;
>> +
>> +		return set_geometry_by_ecc_info(this, chip->ecc_strength_ds,
>> +						chip->ecc_step_ds);
>> +	}
>>  
>>  	return 0;
>>  }

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
