Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859CDC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32B020875
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 22:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="oBblff6n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32B020875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933715AbeFTWWL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 18:22:11 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:49810 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933308AbeFTWWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 18:22:10 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 91FE08365F
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 10:22:07 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1529533327;
        bh=/jaS+xWjDYSYSI7G7mQZTsmnzPipSpKq1Q4aobodclc=;
        h=From:To:CC:Subject:Date:References;
        b=oBblff6n71MYSi4QVYpBr+5BC5D5dooFEhw5YFAxyjchCCjN5uIko7agyJWLbtAxs
         UV4PV2cPPnF/UYHUQQid8oTqHTCiuepImz4MljOnrwGyBJjKxjf6b5o2NVnCzWVVLK
         5Gwp4S1UVZ2FmPLzFFzBGoj1HMIfbIJ3pYFICGpI=
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b2ad38f0000>; Thu, 21 Jun 2018 10:22:07 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Thu, 21 Jun 2018 10:22:06 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Thu, 21 Jun 2018 10:22:06 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "Marek Vasut" <marek.vasut@gmail.com>
Subject: Re: [PATCH v3 4/4] mtd: rawnand: micron: support 8/512 on-die ECC
Thread-Topic: [PATCH v3 4/4] mtd: rawnand: micron: support 8/512 on-die ECC
Thread-Index: AQHUCFRaDJuMXtpbOUaNvMbwfuP7uA==
Date:   Wed, 20 Jun 2018 22:22:05 +0000
Message-ID: <ee9e30c5c95e49a7b0a3692db7c85338@svr-chch-ex1.atlnz.lc>
References: <20180620050544.31549-1-chris.packham@alliedtelesis.co.nz>
 <20180620050544.31549-5-chris.packham@alliedtelesis.co.nz>
 <20180620100232.0ad18adc@bbrezillon>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [2001:df5:b000:22:3a2c:4aff:fe70:2b02]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/18 20:02, Boris Brezillon wrote:=0A=
> On Wed, 20 Jun 2018 17:05:44 +1200=0A=
> Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:=0A=
> =0A=
>> Micron MT29F1G08ABAFAWP-ITE:F supports an on-die ECC with 8 bits=0A=
>> per 512 bytes. Add support for this combination.=0A=
>>=0A=
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
>> ---=0A=
>> Changes in v2:=0A=
>> - New=0A=
>> Changes in v3:=0A=
>> - Handle reporting of corrected errors that don't require a rewrite, exp=
and=0A=
>>    comment for the ECC status bits.=0A=
>>=0A=
>>   drivers/mtd/nand/raw/nand_micron.c | 34 ++++++++++++++++++++++++------=
=0A=
>>   1 file changed, 27 insertions(+), 7 deletions(-)=0A=
>>=0A=
>> diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/n=
and_micron.c=0A=
>> index 5cec79372181..0c2bde4411d7 100644=0A=
>> --- a/drivers/mtd/nand/raw/nand_micron.c=0A=
>> +++ b/drivers/mtd/nand/raw/nand_micron.c=0A=
>> @@ -18,10 +18,24 @@=0A=
>>   #include <linux/mtd/rawnand.h>=0A=
>>   =0A=
>>   /*=0A=
>> - * Special Micron status bit that indicates when the block has been=0A=
>> - * corrected by on-die ECC and should be rewritten=0A=
>> + * Special Micron status bit 3 indicates that the block has been=0A=
>> + * corrected by on-die ECC and should be rewritten.=0A=
>> + *=0A=
>> + * On chips with 8-bit ECC and additional bit can be used to distinguis=
h=0A=
>> + * cases where a errors were corrected without needing a rewrite=0A=
>> + *=0A=
>> + * Bit 4 Bit 3 Bit 0 Description=0A=
>> + * ----- ----- ----- -----------=0A=
>> + * 0     0     0     No Errors=0A=
>> + * 0     0     1     Multiple uncorrected errors=0A=
>> + * 0     1     0     4 - 6 errors corrected, recommend rewrite=0A=
>> + * 0     0     1     Reserved=0A=
>> + * 1     0     0     1 - 3 errors corrected=0A=
>> + * 1     0     1     Reserved=0A=
>> + * 1     1     0     7 - 8 errors corrected, recommend rewrite=0A=
>>    */=0A=
>>   #define NAND_STATUS_WRITE_RECOMMENDED	BIT(3)=0A=
>> +#define NAND_STATUS_ERRORS_CORRECTED	BIT(4)=0A=
>>   =0A=
>>   struct nand_onfi_vendor_micron {=0A=
>>   	u8 two_plane_read;=0A=
>> @@ -141,7 +155,7 @@ micron_nand_read_page_on_die_ecc(struct mtd_info *mt=
d, struct nand_chip *chip,=0A=
>>   		mtd->ecc_stats.failed++;=0A=
>>   =0A=
>>   	/*=0A=
>> -	 * The internal ECC doesn't tell us the number of bitflips=0A=
>> +	 * The internal 4-bit ECC doesn't tell us the number of bitflips=0A=
>>   	 * that have been corrected, but tells us if it recommends to=0A=
>>   	 * rewrite the block. If it's the case, then we pretend we had=0A=
>>   	 * a number of bitflips equal to the ECC strength, which will=0A=
>> @@ -149,6 +163,12 @@ micron_nand_read_page_on_die_ecc(struct mtd_info *m=
td, struct nand_chip *chip,=0A=
>>   	 */=0A=
>>   	else if (status & NAND_STATUS_WRITE_RECOMMENDED)=0A=
>>   		max_bitflips =3D chip->ecc.strength;=0A=
>> +	/*=0A=
>> +	 * Chips with 8-bit internal ECC do tell us if errors 1 to 3 bit=0A=
>> +	 * errors have been corrected without recommending a rewrite.=0A=
>> +	 */=0A=
>> +	else if (status & NAND_STATUS_ERRORS_CORRECTED)=0A=
>> +		max_bitflips =3D 3;=0A=
> =0A=
> Why not masking bit 3, 4 and 0 and having a switch-case block?=0A=
=0A=
Mainly because the existing code was just checking bit 3 and that =0A=
happened to worked for my use-case.=0A=
=0A=
I'm happy to re-work it as you've suggested can anyone point me at the =0A=
datasheet for a 4/512 on-die chip (or just the part number I can lookup =0A=
on mircon's site).=0A=
=0A=
> =0A=
> Also, you should update ecc_stats.corrected (see the patch I just sent=0A=
> [1]).=0A=
> =0A=
=0A=
Will do. I'll pull in your patch and base v4 on top of that.=0A=
=0A=
>>   =0A=
>>   	ret =3D nand_read_data_op(chip, buf, mtd->writesize, false);=0A=
>>   	if (!ret && oob_required)=0A=
>> @@ -240,9 +260,9 @@ static int micron_supports_on_die_ecc(struct nand_ch=
ip *chip)=0A=
>>   =0A=
>>   	/*=0A=
>>   	 * Some Micron NANDs have an on-die ECC of 4/512, some other=0A=
>> -	 * 8/512. We only support the former.=0A=
>> +	 * 8/512.=0A=
>>   	 */=0A=
>> -	if (chip->ecc_strength_ds !=3D 4)=0A=
>> +	if (chip->ecc_strength_ds !=3D 4 && chip->ecc_strength_ds !=3D 8)=0A=
>>   		return MICRON_ON_DIE_UNSUPPORTED;=0A=
=0A=
I was thinking about removing this. The original code excluded 8/512 due =
=0A=
to lack of access to a chip that implements this, which I now have.=0A=
=0A=
> Given that our on-die-support detection procedure is not reliable, I'd=0A=
> recommend changing the way we do it and instead base this detection=0A=
> logic on the model name (in the ONFI param page) or the READ_ID bytes.=0A=
> =0A=
=0A=
The problem is I don't know an exhaustive list of IDs that this applies =0A=
to. I guess having a list of known IDs and falling back to the current =0A=
detection is probably the best approach unless Micron get back to us =0A=
with some other method of detecting these and determining if it is =0A=
forceably enabled.=0A=
=0A=
>>   =0A=
>>   	return MICRON_ON_DIE_SUPPORTED;=0A=
>> @@ -274,9 +294,9 @@ static int micron_nand_init(struct nand_chip *chip)=
=0A=
>>   			return -EINVAL;=0A=
>>   		}=0A=
>>   =0A=
>> -		chip->ecc.bytes =3D 8;=0A=
>> +		chip->ecc.bytes =3D chip->ecc_strength_ds * 2;=0A=
>>   		chip->ecc.size =3D 512;=0A=
>> -		chip->ecc.strength =3D 4;=0A=
>> +		chip->ecc.strength =3D chip->ecc_strength_ds;=0A=
>>   		chip->ecc.algo =3D NAND_ECC_BCH;=0A=
>>   		chip->ecc.read_page =3D micron_nand_read_page_on_die_ecc;=0A=
>>   		chip->ecc.write_page =3D micron_nand_write_page_on_die_ecc;=0A=
> =0A=
> [1]http://patchwork.ozlabs.org/patch/932006/=0A=
> =0A=
=0A=
