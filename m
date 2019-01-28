Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFFEC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 04:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2941820870
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 04:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfA1E5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 23:57:25 -0500
Received: from mga03.intel.com ([134.134.136.65]:44741 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726607AbfA1E5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 23:57:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2019 20:57:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,532,1539673200"; 
   d="scan'208";a="113155840"
Received: from mandalpu-mobl.gar.corp.intel.com (HELO [10.66.97.14]) ([10.66.97.14])
  by orsmga008.jf.intel.com with ESMTP; 27 Jan 2019 20:57:22 -0800
Subject: Re: [PATCH] mtd: spi-nor: cadence-quadspi: write upto 8-bytes data in
 STIG mode
To:     Tudor.Ambarus@microchip.com, f.blogs@napier.co.nz,
        boris.brezillon@bootlin.com
Cc:     linux-kernel@vger.kernel.org, marek.vasut@gmail.com,
        computersforpeace@gmail.com, richard@nod.at,
        linux-mtd@lists.infradead.org, dwmw2@infradead.org, vigneshr@ti.com
References: <20181214021516.43609-1-purna.chandra.mandal@intel.com>
 <c627314d-fdf6-7e69-7c54-03a513f563fc@microchip.com>
From:   "Mandal, Purna Chandra" <purna.chandra.mandal@intel.com>
Message-ID: <76066a83-1cd2-5baf-1930-c290f66e73ba@intel.com>
Date:   Mon, 28 Jan 2019 10:27:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <c627314d-fdf6-7e69-7c54-03a513f563fc@microchip.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21-Jan-19 3:07 PM, Tudor.Ambarus@microchip.com wrote:
> Hi, Purna,
> 
> On 12/14/2018 04:15 AM, Purna Chandra Mandal wrote:
>> cadence-quadspi controller allows upto eight bytes of data to be transferred
>> in software Triggered Instruction generator (STIG) mode of operation. Lower
>> 4 bytes are written through writedatalower and upper 4 bytes by
>> writedataupper register.
> 
> Is this supported by all versions of the IP?
> 
Yes, it is supported on all versions of IP.
>>
>> This patch allows all the 8 bytes to be written.
>>
>> Signed-off-by: Purna Chandra Mandal <purna.chandra.mandal@intel.com>
>> ---
>>
>>   drivers/mtd/spi-nor/cadence-quadspi.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
>> index 04cedd3a2bf6..990934387fea 100644
>> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
>> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
>> @@ -420,7 +420,7 @@ static int cqspi_command_write(struct spi_nor *nor, const u8 opcode,
>>   	unsigned int data;
> 
> I know that this is not your change, but data should be u32 and not unsigned
> int. reg too ... probably one should submit a patch to change this, I see that
> the same error is done in cqspi_command_read().
ack. will be done in separate patch.
> 
>>   	int ret;
>>   
>> -	if (n_tx > 4 || (n_tx && !txbuf)) {
>> +	if (n_tx > CQSPI_STIG_DATA_LEN_MAX || (n_tx && !txbuf)) {
>>   		dev_err(nor->dev,
>>   			"Invalid input argument, cmdlen %d txbuf 0x%p\n",
>>   			n_tx, txbuf);
>> @@ -435,8 +435,13 @@ static int cqspi_command_write(struct spi_nor *nor, const u8 opcode,
>>   		data = 0;>  		memcpy(&data, txbuf, n_tx);
> 
> You should limit what is copied in data, similar to what is done in
> cqspi_command_read():
> 
> write_len = (n_tx > 4) ? 4 : n_tx;
> memcpy(&data, txbuf, write_len);
> txbuf += write_len;
ack.
> 
> 
> 
>>   		writel(data, reg_base + CQSPI_REG_CMDWRITEDATALOWER);
>> -	}
>>   
>> +		if (n_tx > 4) {
>> +			data = 0;
> and then:
> write_len = n_tx - 4;
> memcpy(&data, txbuf, write_len);
> 
ack.
> Cheers,
> ta
> 
>> +			memcpy(&data, txbuf + 4, n_tx - 4);
>> +			writel(data, reg_base + CQSPI_REG_CMDWRITEDATAUPPER);
>> +		}
>> +	}
>>   	ret = cqspi_exec_flash_cmd(cqspi, reg);
>>   	return ret;
>>   }
>>
