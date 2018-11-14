Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE6DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8B822360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:22:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8B822360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733003AbeKOB0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:26:22 -0500
Received: from mga02.intel.com ([134.134.136.20]:3031 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725759AbeKOB0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:26:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2018 07:22:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,232,1539673200"; 
   d="scan'208";a="100194164"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by orsmga003.jf.intel.com with ESMTP; 14 Nov 2018 07:22:40 -0800
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCH] mtd: spi-nor: Fix Cadence QSPI page fault kernel panic
To:     Vignesh R <vigneshr@ti.com>, marek.vasut@gmail.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        boris.brezillon@bootlin.com, richard@nod.at
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1542130345-10005-1-git-send-email-thor.thayer@linux.intel.com>
 <07a0fbce-d1fa-6ac0-0428-3123c19cd89b@ti.com>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <08feb671-6976-5ec8-ade1-fc2d48b8aad7@linux.intel.com>
Date:   Wed, 14 Nov 2018 09:25:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <07a0fbce-d1fa-6ac0-0428-3123c19cd89b@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vignesh,

On 11/14/18 6:00 AM, Vignesh R wrote:
> Hi,
> 
> On 13/11/18 11:02 PM, thor.thayer@linux.intel.com wrote:
>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>
>> The current Cadence QSPI driver caused a kernel panic sporadically
>> when writing to QSPI. The problem was caused by writing more bytes
>> than needed because the QSPI operated on 4 bytes at a time.
>> <snip>
>> [   11.202044] Unable to handle kernel paging request at virtual address bffd3000
>> [   11.209254] pgd = e463054d
>> [   11.211948] [bffd3000] *pgd=2fffb811, *pte=00000000, *ppte=00000000
>> [   11.218202] Internal error: Oops: 7 [#1] SMP ARM
>> [   11.222797] Modules linked in:
>> [   11.225844] CPU: 1 PID: 1317 Comm: systemd-hwdb Not tainted 4.17.7-d0c45cd44a8f
>> [   11.235796] Hardware name: Altera SOCFPGA Arria10
>> [   11.240487] PC is at __raw_writesl+0x70/0xd4
>> [   11.244741] LR is at cqspi_write+0x1a0/0x2cc
>> </snip>
>> On a page boundary limit the number of bytes copied from the tx buffer
>> to remain within the page.
>>
>> This patch uses a temporary buffer to hold the 4 bytes to write and then
>> copies only the bytes required from the tx buffer. A min() function is
>> used to limit the length to prevent buffer indexing overflows.
>>
>> Reported-by: Adrian Amborzewicz <adrian.ambrozewicz@intel.com>
>> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
>> ---
>>   drivers/mtd/spi-nor/cadence-quadspi.c | 19 ++++++++++++++++---
>>   1 file changed, 16 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
>> index d846428ef038..3659d94b4d2f 100644
>> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
>> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
>> @@ -644,9 +644,23 @@ static int cqspi_indirect_write_execute(struct spi_nor *nor, loff_t to_addr,
>>   		ndelay(cqspi->wr_delay);
>>   
>>   	while (remaining > 0) {
>> +		size_t write_words, mod_bytes;
>> +
>>   		write_bytes = remaining > page_size ? page_size : remaining;
>> -		iowrite32_rep(cqspi->ahb_base, txbuf,
>> -			      DIV_ROUND_UP(write_bytes, 4));
>> +		write_words = write_bytes / 4;
>> +		mod_bytes = write_bytes % 4;
>> +		/* Write 4 bytes at a time then single bytes. */
>> +		if (write_words) {
>> +			iowrite32_rep(cqspi->ahb_base, txbuf, write_words);
>> +			txbuf += (write_words * 4);
>> +		}
>> +		if (mod_bytes) {
>> +			unsigned int temp = 0xFFFFFFFF;
>> +
>> +			memcpy(&temp, txbuf, min(sizeof(temp), mod_bytes));
> 
> Sorry, I dont understand why min() is required here since:
> 	mod_bytes = write_bytes % 4;
> Doesn't that ensure mod_bytes < sizeof(temp)?
> 

Yes, good point. I was being overly cautious with the memcpy buffers. I 
will re-spin and re-submit. Thanks!

>> +			iowrite32(temp, cqspi->ahb_base);
>> +			txbuf += mod_bytes;
>> +		}
>>   
>>   		if (!wait_for_completion_timeout(&cqspi->transfer_complete,
>>   					msecs_to_jiffies(CQSPI_TIMEOUT_MS))) {
>> @@ -655,7 +669,6 @@ static int cqspi_indirect_write_execute(struct spi_nor *nor, loff_t to_addr,
>>   			goto failwr;
>>   		}
>>   
>> -		txbuf += write_bytes;
>>   		remaining -= write_bytes;
>>   
>>   		if (remaining > 0)
>>
> 

