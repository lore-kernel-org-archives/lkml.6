Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF782C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 443BA20652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="sB/MiKjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 443BA20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933268AbeFTVLE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 17:11:04 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:49626 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933053AbeFTVLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 17:11:02 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 6414B8365A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 09:11:00 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail; t=1529529060;
        bh=c/fkUrwLB0FXyY+7cFqreiACOIz81UGAjnATmshrtGI=;
        h=From:To:CC:Subject:Date:References;
        b=sB/MiKjVXzFVQUUHStTLpFgZOplEMxDAk7yzUMozrGtXfYHYxuFZhMZO7ml74tfqy
         th+pmikSX8m0tVMRsEVcQLnRyuspHRt+ewS3oDWWDQuPtZ/GBYZGJK6AogMI32iR5g
         nv7PyLGnop1AUWB8yB9gVLipI2sV4yC5jO8026yM=
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5b2ac2e40000>; Thu, 21 Jun 2018 09:11:00 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Thu, 21 Jun 2018 09:10:57 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1156.000; Thu, 21 Jun 2018 09:10:57 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "Marek Vasut" <marek.vasut@gmail.com>
Subject: Re: [PATCH v3 1/4] mtd: rawnand: marvell: Handle on-die ECC
Thread-Topic: [PATCH v3 1/4] mtd: rawnand: marvell: Handle on-die ECC
Thread-Index: AQHUCFRa1iVi57r+Ok6MnWcYHZYHOw==
Date:   Wed, 20 Jun 2018 21:10:56 +0000
Message-ID: <0bf16d760f6a468ebe4417bacc9fc6b4@svr-chch-ex1.atlnz.lc>
References: <20180620050544.31549-1-chris.packham@alliedtelesis.co.nz>
 <20180620050544.31549-2-chris.packham@alliedtelesis.co.nz>
 <20180620094654.4280caeb@bbrezillon>
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

On 20/06/18 19:47, Boris Brezillon wrote:=0A=
> Hi Chris,=0A=
> =0A=
> On Wed, 20 Jun 2018 17:05:41 +1200=0A=
> Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:=0A=
> =0A=
>>  From the controllers point of view this is the same as no or=0A=
>> software only ECC.=0A=
>>=0A=
>> Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>=0A=
> =0A=
> I'm nitpicking, but we usually put the R-b/A-b tags after the author=0A=
> SoB.=0A=
=0A=
Yeah sorry force of habit from using gerrit internally. I'll try to =0A=
re-train my fingers.=0A=
=0A=
>> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>=0A=
>> ---=0A=
>> Changes in v2:=0A=
>> - New=0A=
>> Changes in v3:=0A=
>> - Add review from Boris=0A=
>>=0A=
>>   drivers/mtd/nand/raw/marvell_nand.c | 1 +=0A=
>>   1 file changed, 1 insertion(+)=0A=
>>=0A=
>> diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/=
marvell_nand.c=0A=
>> index ebb1d141b900..ba6889bbe802 100644=0A=
>> --- a/drivers/mtd/nand/raw/marvell_nand.c=0A=
>> +++ b/drivers/mtd/nand/raw/marvell_nand.c=0A=
>> @@ -2157,6 +2157,7 @@ static int marvell_nand_ecc_init(struct mtd_info *=
mtd,=0A=
>>   		break;=0A=
>>   	case NAND_ECC_NONE:=0A=
>>   	case NAND_ECC_SOFT:=0A=
>> +	case NAND_ECC_ON_DIE:=0A=
>>   		if (!nfc->caps->is_nfcv2 && mtd->writesize !=3D SZ_512 &&=0A=
>>   		    mtd->writesize !=3D SZ_2K) {=0A=
>>   			dev_err(nfc->dev, "NFCv1 cannot write %d bytes pages\n",=0A=
> =0A=
> =0A=
=0A=
