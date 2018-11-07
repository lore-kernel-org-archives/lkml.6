Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F186C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 11:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 251642081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 11:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 251642081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeKGUje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 15:39:34 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:16286 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726266AbeKGUje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 15:39:34 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id wA7B472v009089;
        Wed, 7 Nov 2018 12:09:02 +0100
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2nh211mgeq-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 07 Nov 2018 12:09:02 +0100
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 81F7331;
        Wed,  7 Nov 2018 11:09:00 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 361E05104;
        Wed,  7 Nov 2018 11:09:00 +0000 (GMT)
Received: from [10.201.23.29] (10.75.127.48) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 7 Nov
 2018 12:08:59 +0100
Subject: Re: [PATCH v2 2/3] mtd: rawnand: stm32_fmc2: add STM32 FMC2 NAND
 flash controller driver
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1538732520-2800-1-git-send-email-christophe.kerello@st.com>
 <1538732520-2800-3-git-send-email-christophe.kerello@st.com>
 <20181105173905.385dd06e@bbrezillon>
From:   Christophe Kerello <christophe.kerello@st.com>
Message-ID: <70f99d79-a9d8-0651-d464-2d81b334dbfb@st.com>
Date:   Wed, 7 Nov 2018 12:08:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105173905.385dd06e@bbrezillon>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-07_09:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,


On 11/5/18 5:39 PM, Boris Brezillon wrote:
> Hi Christophe,
> 
> On Fri, 5 Oct 2018 11:41:59 +0200
> <christophe.kerello@st.com> wrote:
> 
> A few more comments.
> 
>> +/* Sequencer read/write configuration */
>> +static void stm32_fmc2_rw_page_init(struct nand_chip *chip, int page,
>> +				    int raw, bool write_data)
>> +{
>> +	struct stm32_fmc2 *fmc2 = nand_get_controller_data(chip);
>> +	struct mtd_info *mtd = nand_to_mtd(chip);
>> +	u32 csqcfgr1, csqcfgr2, csqcfgr3;
>> +	u32 csqar1, csqar2;
>> +	u32 ecc_offset = mtd->writesize + FMC2_BBM_LEN;
>> +	u32 pcr = readl_relaxed(fmc2->io_base + FMC2_PCR);
>> +
>> +	if (write_data)
>> +		pcr |= FMC2_PCR_WEN;
>> +	else
>> +		pcr &= ~FMC2_PCR_WEN;
>> +	writel_relaxed(pcr, fmc2->io_base + FMC2_PCR);
>> +
>> +	/*
>> +	 * - Set Program Page/Page Read command
>> +	 * - Enable DMA request data
>> +	 * - Set timings
>> +	 */
>> +	csqcfgr1 = FMC2_CSQCFGR1_DMADEN | FMC2_CSQCFGR1_CMD1T;
>> +	if (write_data)
>> +		csqcfgr1 |= FMC2_CSQCFGR1_CMD1(NAND_CMD_SEQIN);
>> +	else
>> +		csqcfgr1 |= FMC2_CSQCFGR1_CMD1(NAND_CMD_READ0) |
>> +			    FMC2_CSQCFGR1_CMD2EN |
>> +			    FMC2_CSQCFGR1_CMD2(NAND_CMD_READSTART) |
>> +			    FMC2_CSQCFGR1_CMD2T;
>> +
>> +	/*
>> +	 * - Set Random Data Input/Random Data Read command
>> +	 * - Enable the sequencer to access the Spare data area
>> +	 * - Enable  DMA request status decoding for read
>> +	 * - Set timings
>> +	 */
>> +	if (write_data)
>> +		csqcfgr2 = FMC2_CSQCFGR2_RCMD1(NAND_CMD_RNDIN);
>> +	else
>> +		csqcfgr2 = FMC2_CSQCFGR2_RCMD1(NAND_CMD_RNDOUT) |
>> +			   FMC2_CSQCFGR2_RCMD2EN |
>> +			   FMC2_CSQCFGR2_RCMD2(NAND_CMD_RNDOUTSTART) |
>> +			   FMC2_CSQCFGR2_RCMD1T |
>> +			   FMC2_CSQCFGR2_RCMD2T;
>> +	if (!raw) {
>> +		csqcfgr2 |= write_data ? 0 : FMC2_CSQCFGR2_DMASEN;
>> +		csqcfgr2 |= FMC2_CSQCFGR2_SQSDTEN;
>> +	}
>> +
>> +	/*
>> +	 * - Set the number of sectors to be written
>> +	 * - Set timings
>> +	 */
>> +	csqcfgr3 = FMC2_CSQCFGR3_SNBR(chip->ecc.steps - 1);
>> +	if (write_data) {
>> +		csqcfgr3 |= FMC2_CSQCFGR3_RAC2T;
>> +		if (chip->chipsize > SZ_128M)
>> +			csqcfgr3 |= FMC2_CSQCFGR3_AC5T;
>> +		else
>> +			csqcfgr3 |= FMC2_CSQCFGR3_AC4T;
>> +	}
>> +
>> +	/*
>> +	 * Set the fourth first address cycles
>> +	 * Byte 1 and byte 2 => column, we start at 0x0
>> +	 * Byte 3 and byte 4 => page
>> +	 */
>> +	csqar1 = FMC2_CSQCAR1_ADDC3(page);
>> +	csqar1 |= FMC2_CSQCAR1_ADDC4(page >> 8);
>> +
>> +	/*
>> +	 * - Set chip enable number
>> +	 * - Set ecc byte offset in the spare area
>> +	 * - Calculate the number of address cycles to be issued
>> +	 * - Set byte 5 of address cycle if needed
>> +	 */
>> +	csqar2 = FMC2_CSQCAR2_NANDCEN(fmc2->cs_sel);
>> +	if (chip->options & NAND_BUSWIDTH_16)
>> +		csqar2 |= FMC2_CSQCAR2_SAO(ecc_offset >> 1);
>> +	else
>> +		csqar2 |= FMC2_CSQCAR2_SAO(ecc_offset);
>> +	if (chip->chipsize > SZ_128M) {
> 
> Can you use
> 
> 	if (chip->options & NAND_ROW_ADDR_3)
> 
> instead?
> 

Yes, it will part of v3.

>> +		csqcfgr1 |= FMC2_CSQCFGR1_ACYNBR(5);
>> +		csqar2 |= FMC2_CSQCAR2_ADDC5(page >> 16);
>> +	} else {
>> +		csqcfgr1 |= FMC2_CSQCFGR1_ACYNBR(4);
>> +	}
> 
> [...]
> 
>> +
>> +void stm32_fmc2_write_data(struct nand_chip *chip, const void *buf,
>> +			   unsigned int len, bool force_8bit)
>> +{
>> +	struct stm32_fmc2 *fmc2 = nand_get_controller_data(chip);
>> +	void __iomem *io_addr_w = fmc2->data_base[fmc2->cs_sel];
>> +	const u8 *p = buf;
>> +	unsigned int i;
>> +
>> +	if (force_8bit)
>> +		goto write_8bit;
>> +
>> +	if (IS_ALIGNED(len, sizeof(u32))) {
>> +		const u32 *p = buf;
> 
> I'm pretty sure the framework provides no alignment guarantee on buf.
> You'd better assume buf might not be aligned on 32 or 16 bits.
> 
>> +
>> +		len /= sizeof(u32);
>> +		for (i = 0; i < len; i++)
>> +			writel_relaxed(p[i], io_addr_w);
>> +		return;
>> +	}
>> +
>> +	if (chip->options & NAND_BUSWIDTH_16) {
>> +		const u16 *p = buf;
>> +
>> +		len /= sizeof(u16);
>> +		for (i = 0; i < len; i++)
>> +			writew_relaxed(p[i], io_addr_w);
>> +		return;
>> +	}
>> +
>> +write_8bit:
>> +	for (i = 0; i < len; i++)
>> +		writeb_relaxed(p[i], io_addr_w);
> 
> Is 8bit access really enforced by the byte accessor? In this case, how
> can you be sure 32-bit accesses are doing the right thing? Isn't there
> a bit somewhere in the config reg to configure the bus width?
> 

I have checked the framework after Miquèl comment sent on v1 => "If you 
selected BOUNCE_BUFFER in the options, buf is supposedly
aligned, or am I missing something?".

After checking the framework, my understanding was:
  - In case of 8-bit access is requested, the framework provides no 
guarantee on buf. To avoid any issue, I write byte per byte.
  - In case of 8-bit access is not requested, it means that the 
framework will try to write data in the page or in the oob. When writing 
to oob, chip->oob_poi will be used and this buffer is aligned. When 
writing to the page, as the driver enables NAND_USE_BOUNCE_BUFFER 
option, buf is guarantee aligned.

But, I agree that it would be safe to reconfigure the bus width in 8-bit 
before writing byte per byte in case of a 16-bit NAND is used.

write_8bit:
     if (chip->options & NAND_BUSWIDTH_16) {
         /* Reconfigure bus width to 8-bit */
         pcr = readl_relaxed(fmc2->io_base + FMC2_PCR);
         pcr &= ~FMC2_PCR_PWID_MASK;
         writel_relaxed(pcr, fmc2->io_base + FMC2_PCR);
     }

     for (i = 0; i < len; i++)
         writeb_relaxed(p[i], io_addr_w);

     if (chip->options & NAND_BUSWIDTH_16) {
         /* Reconfigure bus width to 16-bit */
         pcr = readl_relaxed(fmc2->io_base + FMC2_PCR);
         pcr |= FMC2_PCR_PWID(FMC2_PCR_PWID_BUSWIDTH_16);
         writel_relaxed(pcr, fmc2->io_base + FMC2_PCR);
     }

Regards,
Christophe Kerello.

>> +}
> 
> Regards,
> 
> Boris
> 
