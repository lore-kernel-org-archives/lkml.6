Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70855C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 07:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4550920821
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 07:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfBEHA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 02:00:58 -0500
Received: from mga06.intel.com ([134.134.136.31]:52568 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfBEHA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 02:00:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 23:00:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,562,1539673200"; 
   d="scan'208";a="120043642"
Received: from mandalpu-mobl.gar.corp.intel.com (HELO [10.252.77.33]) ([10.252.77.33])
  by fmsmga007.fm.intel.com with ESMTP; 04 Feb 2019 23:00:53 -0800
Subject: Re: [PATCH] mtd: spi-nor: cadence-quadspi: write upto 8-bytes data in
 STIG mode
To:     Vignesh R <vigneshr@ti.com>,
        "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "f.blogs@napier.co.nz" <f.blogs@napier.co.nz>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "richard@nod.at" <richard@nod.at>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
References: <20190128050229.44965-1-purna.chandra.mandal@intel.com>
 <82eafaf8-803e-36a9-49ca-83d84c55537a@microchip.com>
 <7655324a-9cd2-7ffe-56bb-83c44740265c@ti.com>
From:   "Mandal, Purna Chandra" <purna.chandra.mandal@intel.com>
Message-ID: <56748733-74f9-50a6-bcb7-ff4fd878a597@intel.com>
Date:   Tue, 5 Feb 2019 12:30:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <7655324a-9cd2-7ffe-56bb-83c44740265c@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04-Feb-19 7:07 PM, Vignesh R wrote:
> Hi,
> 
> On 03/02/19 5:50 PM, Tudor.Ambarus@microchip.com wrote:
>> + Vignesh
>>
> 
> Thanks for looping in.
> 
>> On 01/28/2019 07:02 AM, Purna Chandra Mandal wrote:
>>> cadence-quadspi controller allows upto eight bytes of data to
>>> be written in software Triggered Instruction generator (STIG) mode
>>> of operation. Lower 4 bytes are written through writedatalower and
>>> upper 4 bytes by writedataupper register.
>>>
>>> This patch allows all the 8 bytes to be written.
>>>
> 
> Code as such looks fine. But, how was this tested? How can I trigger
> this new code path with current linux-next? AFAICS, STIG mode write is
> used to in nor->write_reg() path, and I dont see any nor->write_reg()
> call with >4bytes len.
Currently there is no linux user of write_reg() for write_len > 4byte.

For volatile and non-volatile sector locking [1], we have one out of 
tree implementation and that is specific to flash chip "mt25qu02g". In 
this implementation we need additional sector address (4 byte) to be 
provided for each lock-bit write/erase operation. So total write len in 
write_reg() will be 6 bytes (=1 for opcode, 4 for sect addr, 1 for 
data). We are finalizing the patch for review.

Since cadence qspi controller do support the 8-byte read/write in STIG 
mode, I have tried here to enable that in write_reg(), similar to 
read_reg().

[1] 
https://www.micron.com/~/media/documents/products/data-sheet/nor-flash/serial-nor/n25q/n25q_128mb_3v_65nm.pdf

> 
>>> Signed-off-by: Purna Chandra Mandal <purna.chandra.mandal@intel.com>
>>
>> Looks good for me:
>> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
>>
>> Vignesh, can we have your R-b or T-b tag?
>>
>> Cheers,
>> ta
>>
>>> ---
>>>
>>>   drivers/mtd/spi-nor/cadence-quadspi.c | 15 ++++++++++++---
>>>   1 file changed, 12 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
>>> index 04cedd3a2bf6..7f78f9409ddd 100644
>>> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
>>> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
>>> @@ -418,9 +418,10 @@ static int cqspi_command_write(struct spi_nor *nor, const u8 opcode,
>>>   	void __iomem *reg_base = cqspi->iobase;
>>>   	unsigned int reg;
>>>   	unsigned int data;
>>> +	u32 write_len;
>>>   	int ret;
>>>   
>>> -	if (n_tx > 4 || (n_tx && !txbuf)) {
>>> +	if (n_tx > CQSPI_STIG_DATA_LEN_MAX || (n_tx && !txbuf)) {
>>>   		dev_err(nor->dev,
>>>   			"Invalid input argument, cmdlen %d txbuf 0x%p\n",
>>>   			n_tx, txbuf);
>>> @@ -433,10 +434,18 @@ static int cqspi_command_write(struct spi_nor *nor, const u8 opcode,
>>>   		reg |= ((n_tx - 1) & CQSPI_REG_CMDCTRL_WR_BYTES_MASK)
>>>   			<< CQSPI_REG_CMDCTRL_WR_BYTES_LSB;
>>>   		data = 0;
>>> -		memcpy(&data, txbuf, n_tx);
>>> +		write_len = (n_tx > 4) ? 4 : n_tx;
>>> +		memcpy(&data, txbuf, write_len);
>>> +		txbuf += write_len;
>>>   		writel(data, reg_base + CQSPI_REG_CMDWRITEDATALOWER);
>>> -	}
>>>   
>>> +		if (n_tx > 4) {
>>> +			data = 0;
>>> +			write_len = n_tx - 4;
>>> +			memcpy(&data, txbuf, write_len);
>>> +			writel(data, reg_base + CQSPI_REG_CMDWRITEDATAUPPER);
>>> +		}
>>> +	}
>>>   	ret = cqspi_exec_flash_cmd(cqspi, reg);
>>>   	return ret;
>>>   }
>>>
> 
