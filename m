Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71604ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E03D21480
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 16:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E03D21480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731877AbeIXWk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:40:59 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39601 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728846AbeIXWk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:40:58 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8OGakFA020049;
        Mon, 24 Sep 2018 18:36:56 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mncme3s67-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 24 Sep 2018 18:36:56 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6B7A538;
        Mon, 24 Sep 2018 16:36:55 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3DF41ABF8;
        Mon, 24 Sep 2018 16:36:55 +0000 (GMT)
Received: from [10.201.23.29] (10.75.127.44) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 24 Sep
 2018 18:36:54 +0200
Subject: Re: [PATCH 2/3] mtd: rawnand: stm32_fmc2: add STM32 FMC2 NAND flash
 controller driver
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <boris.brezillon@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1537199260-7280-1-git-send-email-christophe.kerello@st.com>
 <1537199260-7280-3-git-send-email-christophe.kerello@st.com>
 <20180923133451.78c95cef@xps13>
From:   Christophe Kerello <christophe.kerello@st.com>
Message-ID: <09a64e51-2d98-41bc-2a99-fa331ac3fc59@st.com>
Date:   Mon, 24 Sep 2018 18:36:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180923133451.78c95cef@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-24_10:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquèl,

On 09/23/2018 01:34 PM, Miquel Raynal wrote:
> Hi Christophe,
> 
> <christophe.kerello@st.com> wrote on Mon, 17 Sep 2018 17:47:39 +0200:
> 
>> From: Christophe Kerello <christophe.kerello@st.com>
>>
>> The driver adds the support for the STMicroelectronics FMC2 NAND
>> Controller found on STM32MP SOCs.
>>
>> This patch is based on FMC2 command sequencer.
>> The purpose of the command sequencer is to facilitate the programming
>> and the reading of NAND flash pages with the ECC and to free the CPU
>> of sequencing tasks.
>> It requires one DMA channel for write and two DMA channels for read
>> operations.
>>
>> Only NAND_ECC_HW mode is actually supported.
>> The driver supports a maximum 8k page size.
>> The following ECC strength and step size are currently supported:
>>   - nand-ecc-strength = <8>, nand-ecc-step-size = <512> (BCH8)
>>   - nand-ecc-strength = <4>, nand-ecc-step-size = <512> (BCH4)
>>   - nand-ecc-strength = <1>, nand-ecc-step-size = <512> (Extended ecc
>>     based on HAMMING)
>>
>> This patch has been tested on Micron MT29F8G08ABACAH4 and
>> MT29F8G16ABACAH4
>>
>> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
>> ---
> 
> 
> [...]
> 
>> +/* NAND callbacks setup */
>> +static void stm32_fmc2_nand_callbacks_setup(struct stm32_fmc2 *fmc2)
>> +{
>> +	struct nand_chip *chip = &fmc2->chip;
>> +
>> +	/* Specific callbacks to read/write a page */
>> +	chip->ecc.correct = stm32_fmc2_ham_correct;
>> +	chip->ecc.write_page = stm32_fmc2_sequencer_write_page;
>> +	chip->ecc.read_page = stm32_fmc2_sequencer_read_page;
>> +	chip->ecc.write_page_raw = stm32_fmc2_sequencer_write_page_raw;
>> +	chip->ecc.read_page_raw = stm32_fmc2_sequencer_read_page_raw;
> 
> Are you sure all the tests in mtd-utils are successful?

I am not sure to understand the question, so i have ran some of them: 
mtd_nandbiterrs.ko, mtd_speedtest.ko and mtd_oobtest.ko on a 2 MBytes 
partition.

# insmod mtd_nandbiterrs.ko dev=1
[  235.062876]
[  235.062904] ==================================================
[  235.068747] mtd_nandbiterrs: MTD device: 1
[  235.072904] mtd_nandbiterrs: MTD device size 2097152, 
eraseblock=262144, page=4096, oob=224
[  235.081177] mtd_nandbiterrs: Device uses 1 subpages of 4096 bytes
[  235.087284] mtd_nandbiterrs: Using page=0, offset=0, eraseblock=0
[  235.094109] mtd_nandbiterrs: incremental biterrors test
[  235.098778] mtd_nandbiterrs: write_page
[  235.103126] mtd_nandbiterrs: rewrite page
[  235.106793] mtd_nandbiterrs: read_page
[  235.110501] mtd_nandbiterrs: verify_page
[  235.114406] mtd_nandbiterrs: Successfully corrected 0 bit errors per 
subpage
[  235.121124] mtd_nandbiterrs: Inserted biterror @ 0/5
[  235.126117] mtd_nandbiterrs: rewrite page
[  235.130490] mtd_nandbiterrs: read_page
[  235.134247] mtd_nandbiterrs: Read reported 1 corrected bit errors
[  235.139923] mtd_nandbiterrs: verify_page
[  235.144124] mtd_nandbiterrs: Successfully corrected 1 bit errors per 
subpage
[  235.150891] mtd_nandbiterrs: Inserted biterror @ 0/2
[  235.155888] mtd_nandbiterrs: rewrite page
[  235.160244] mtd_nandbiterrs: read_page
[  235.164001] mtd_nandbiterrs: Read reported 2 corrected bit errors
[  235.169687] mtd_nandbiterrs: verify_page
[  235.173881] mtd_nandbiterrs: Successfully corrected 2 bit errors per 
subpage
[  235.180653] mtd_nandbiterrs: Inserted biterror @ 0/0
[  235.185631] mtd_nandbiterrs: rewrite page
[  235.190052] mtd_nandbiterrs: read_page
[  235.193743] mtd_nandbiterrs: Read reported 3 corrected bit errors
[  235.199449] mtd_nandbiterrs: verify_page
[  235.203631] mtd_nandbiterrs: Successfully corrected 3 bit errors per 
subpage
[  235.210415] mtd_nandbiterrs: Inserted biterror @ 1/7
[  235.215391] mtd_nandbiterrs: rewrite page
[  235.219760] mtd_nandbiterrs: read_page
[  235.223507] mtd_nandbiterrs: Read reported 4 corrected bit errors
[  235.229210] mtd_nandbiterrs: verify_page
[  235.233392] mtd_nandbiterrs: Successfully corrected 4 bit errors per 
subpage
[  235.240175] mtd_nandbiterrs: Inserted biterror @ 1/5
[  235.245149] mtd_nandbiterrs: rewrite page
[  235.249516] mtd_nandbiterrs: read_page
[  235.253272] mtd_nandbiterrs: Read reported 5 corrected bit errors
[  235.258968] mtd_nandbiterrs: verify_page
[  235.263151] mtd_nandbiterrs: Successfully corrected 5 bit errors per 
subpage
[  235.269933] mtd_nandbiterrs: Inserted biterror @ 1/2
[  235.274923] mtd_nandbiterrs: rewrite page
[  235.279272] mtd_nandbiterrs: read_page
[  235.283021] mtd_nandbiterrs: Read reported 6 corrected bit errors
[  235.288727] mtd_nandbiterrs: verify_page
[  235.292910] mtd_nandbiterrs: Successfully corrected 6 bit errors per 
subpage
[  235.299694] mtd_nandbiterrs: Inserted biterror @ 1/0
[  235.304671] mtd_nandbiterrs: rewrite page
[  235.309028] mtd_nandbiterrs: read_page
[  235.312780] mtd_nandbiterrs: Read reported 7 corrected bit errors
[  235.318489] mtd_nandbiterrs: verify_page
[  235.322673] mtd_nandbiterrs: Successfully corrected 7 bit errors per 
subpage
[  235.329457] mtd_nandbiterrs: Inserted biterror @ 2/6
[  235.334432] mtd_nandbiterrs: rewrite page
[  235.338796] mtd_nandbiterrs: read_page
[  235.342526] mtd_nandbiterrs: Read reported 8 corrected bit errors
[  235.348254] mtd_nandbiterrs: verify_page
[  235.352441] mtd_nandbiterrs: Successfully corrected 8 bit errors per 
subpage
[  235.359223] mtd_nandbiterrs: Inserted biterror @ 2/5
[  235.364197] mtd_nandbiterrs: rewrite page
[  235.368565] mtd_nandbiterrs: read_page
[  235.372283] mtd_nandbiterrs: error: read failed at 0x0
[  235.377087] mtd_nandbiterrs: After 9 biterrors per subpage, read 
reported error -74
[  235.386307] mtd_nandbiterrs: finished successfully.
[  235.389711] ==================================================

# insmod mtd_speedtest.ko dev=1
[  256.862822]
[  256.862850] =================================================
[  256.868608] mtd_speedtest: MTD device: 1
[  256.872562] mtd_speedtest: MTD device size 2097152, eraseblock size 
262144, page size 4096, count of eraseblocks 8, pages per eraseblock 64, 
OOB size 224
[  256.889840] mtd_test: scanning for bad eraseblocks
[  256.893233] mtd_test: scanned 8 eraseblocks, 0 are bad
[  256.904002] mtd_speedtest: testing eraseblock write speed
[  257.133918] mtd_speedtest: eraseblock write speed is 9102 KiB/s
[  257.138376] mtd_speedtest: testing eraseblock read speed
[  257.308241] mtd_speedtest: eraseblock read speed is 12487 KiB/s
[  257.332093] mtd_speedtest: testing page write speed
[  257.563379] mtd_speedtest: page write speed is 9022 KiB/s
[  257.567314] mtd_speedtest: testing page read speed
[  257.737934] mtd_speedtest: page read speed is 12412 KiB/s
[  257.761272] mtd_speedtest: testing 2 page write speed
[  257.991708] mtd_speedtest: 2 page write speed is 9061 KiB/s
[  257.995830] mtd_speedtest: testing 2 page read speed
[  258.165996] mtd_speedtest: 2 page read speed is 12412 KiB/s
[  258.170102] mtd_speedtest: Testing erase speed
[  258.193952] mtd_speedtest: erase speed is 107789 KiB/s
[  258.197620] mtd_speedtest: Testing 2x multi-block erase speed
[  258.209026] mtd_speedtest: 2x multi-block erase speed is 409600 KiB/s
[  258.214010] mtd_speedtest: Testing 4x multi-block erase speed
[  258.225402] mtd_speedtest: 4x multi-block erase speed is 409600 KiB/s
[  258.230374] mtd_speedtest: Testing 8x multi-block erase speed
[  258.241771] mtd_speedtest: 8x multi-block erase speed is 409600 KiB/s
[  258.246757] mtd_speedtest: Testing 16x multi-block erase speed
[  258.258227] mtd_speedtest: 16x multi-block erase speed is 409600 KiB/s
[  258.263297] mtd_speedtest: Testing 32x multi-block erase speed
[  258.274767] mtd_speedtest: 32x multi-block erase speed is 409600 KiB/s
[  258.279826] mtd_speedtest: Testing 64x multi-block erase speed
[  258.291307] mtd_speedtest: 64x multi-block erase speed is 409600 KiB/s
[  258.296384] mtd_speedtest: finished
[  258.299857] =================================================

# insmod mtd_oobtest.ko dev=1 bitflip_limit=2
[  993.770824]
[  993.770853] =================================================
[  993.776689] mtd_oobtest: MTD device: 1
[  993.780348] mtd_oobtest: MTD device size 2097152, eraseblock size 
262144, page size 4096, count of eraseblocks 8, pages per eraseblock 64, 
OOB size 224
[  993.793977] mtd_test: scanning for bad eraseblocks
[  993.798716] mtd_test: scanned 8 eraseblocks, 0 are bad
[  993.803855] mtd_oobtest: test 1 of 5
[  993.813081] mtd_oobtest: writing OOBs of whole device
[  993.830940] mtd_oobtest: written up to eraseblock 0
[  993.934094] mtd_oobtest: written 8 eraseblocks
[  993.937080] mtd_oobtest: verifying all eraseblocks
[  993.944908] mtd_oobtest: verified up to eraseblock 0
[  993.969427] mtd_oobtest: verified 8 eraseblocks
[  993.972499] mtd_oobtest: test 2 of 5
[  993.985613] mtd_oobtest: writing OOBs of whole device
[  994.003509] mtd_oobtest: written up to eraseblock 0
[  994.106738] mtd_oobtest: written 8 eraseblocks
[  994.109712] mtd_oobtest: verifying all eraseblocks
[  994.117442] mtd_oobtest: verified up to eraseblock 0
[  994.141342] mtd_oobtest: verified 8 eraseblocks
[  994.144421] mtd_oobtest: test 3 of 5
[  994.160526] mtd_oobtest: writing OOBs of whole device
[  994.178486] mtd_oobtest: written up to eraseblock 0
[  994.279164] mtd_oobtest: written 8 eraseblocks
[  994.282136] mtd_oobtest: verifying all eraseblocks
[  994.292790] mtd_oobtest: verified up to eraseblock 0
[  994.337322] mtd_oobtest: verified 8 eraseblocks
[  994.340379] mtd_oobtest: test 4 of 5
[  994.355692] mtd_oobtest: attempting to start write past end of OOB
[  994.360406] mtd_oobtest: an error is expected...
[  994.365036] mtd_oobtest: error occurred as expected
[  994.369895] mtd_oobtest: attempting to start read past end of OOB
[  994.376005] mtd_oobtest: an error is expected...
[  994.380604] mtd_oobtest: error occurred as expected
[  994.385494] mtd_oobtest: attempting to write past end of device
[  994.391398] mtd_oobtest: an error is expected...
[  994.396027] mtd_oobtest: error occurred as expected
[  994.400888] mtd_oobtest: attempting to read past end of device
[  994.406752] mtd_oobtest: an error is expected...
[  994.411335] mtd_oobtest: error occurred as expected
[  994.416936] mtd_oobtest: attempting to write past end of device
[  994.422127] mtd_oobtest: an error is expected...
[  994.426757] mtd_oobtest: error occurred as expected
[  994.431616] mtd_oobtest: attempting to read past end of device
[  994.437461] mtd_oobtest: an error is expected...
[  994.442061] mtd_oobtest: error occurred as expected
[  994.446948] mtd_oobtest: test 5 of 5
[  994.456172] mtd_oobtest: writing OOBs of whole device
[  994.459991] mtd_oobtest: written up to eraseblock 0
[  994.464842] mtd_oobtest: written up to eraseblock 0
[  994.472018] mtd_oobtest: written 7 eraseblocks
[  994.475007] mtd_oobtest: verifying all eraseblocks
[  994.479878] mtd_oobtest: verified up to eraseblock 0
[  994.485314] mtd_oobtest: verified 7 eraseblocks
[  994.489267] mtd_oobtest: finished with 0 errors
[  994.493828] =================================================

> 
> 
> Thanks,
> Miquèl
> 

Thanks,
Christophe Kerello.
