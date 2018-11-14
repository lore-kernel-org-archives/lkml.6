Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53282C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CAD208E7
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 12:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bzhuKvTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05CAD208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732773AbeKNWC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 17:02:56 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49870 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbeKNWC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 17:02:56 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAEBxPCV070555;
        Wed, 14 Nov 2018 05:59:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542196765;
        bh=Ad/XGy8Elrqba3O8rswtRDXWpTn0YUHdcvUSArkakgA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bzhuKvTJKEhfJWWf+EmlBE3ns/RD2WpaljaX9ipsYLDkbFfcjqW842F9U7smK2WmE
         42d0xt/xl849R4XqYVYUm5xkpVhrO8SGAWEoaHP/v8HbJSrrVCbWVgUmpTPT8TQScj
         BQwaG+uWB3lUxoDtLJutFXCF4EZeFL7ljOhndy4M=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAEBxPJq004693
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Nov 2018 05:59:25 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 14
 Nov 2018 05:59:24 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 14 Nov 2018 05:59:24 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAEBxMVI028792;
        Wed, 14 Nov 2018 05:59:22 -0600
Subject: Re: [PATCH] mtd: spi-nor: Fix Cadence QSPI page fault kernel panic
To:     <thor.thayer@linux.intel.com>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <boris.brezillon@bootlin.com>, <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <1542130345-10005-1-git-send-email-thor.thayer@linux.intel.com>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <07a0fbce-d1fa-6ac0-0428-3123c19cd89b@ti.com>
Date:   Wed, 14 Nov 2018 17:30:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542130345-10005-1-git-send-email-thor.thayer@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13/11/18 11:02 PM, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> The current Cadence QSPI driver caused a kernel panic sporadically
> when writing to QSPI. The problem was caused by writing more bytes
> than needed because the QSPI operated on 4 bytes at a time.
> <snip>
> [   11.202044] Unable to handle kernel paging request at virtual address bffd3000
> [   11.209254] pgd = e463054d
> [   11.211948] [bffd3000] *pgd=2fffb811, *pte=00000000, *ppte=00000000
> [   11.218202] Internal error: Oops: 7 [#1] SMP ARM
> [   11.222797] Modules linked in:
> [   11.225844] CPU: 1 PID: 1317 Comm: systemd-hwdb Not tainted 4.17.7-d0c45cd44a8f
> [   11.235796] Hardware name: Altera SOCFPGA Arria10
> [   11.240487] PC is at __raw_writesl+0x70/0xd4
> [   11.244741] LR is at cqspi_write+0x1a0/0x2cc
> </snip>
> On a page boundary limit the number of bytes copied from the tx buffer
> to remain within the page.
> 
> This patch uses a temporary buffer to hold the 4 bytes to write and then
> copies only the bytes required from the tx buffer. A min() function is
> used to limit the length to prevent buffer indexing overflows.
> 
> Reported-by: Adrian Amborzewicz <adrian.ambrozewicz@intel.com>
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
>  drivers/mtd/spi-nor/cadence-quadspi.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
> index d846428ef038..3659d94b4d2f 100644
> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
> @@ -644,9 +644,23 @@ static int cqspi_indirect_write_execute(struct spi_nor *nor, loff_t to_addr,
>  		ndelay(cqspi->wr_delay);
>  
>  	while (remaining > 0) {
> +		size_t write_words, mod_bytes;
> +
>  		write_bytes = remaining > page_size ? page_size : remaining;
> -		iowrite32_rep(cqspi->ahb_base, txbuf,
> -			      DIV_ROUND_UP(write_bytes, 4));
> +		write_words = write_bytes / 4;
> +		mod_bytes = write_bytes % 4;
> +		/* Write 4 bytes at a time then single bytes. */
> +		if (write_words) {
> +			iowrite32_rep(cqspi->ahb_base, txbuf, write_words);
> +			txbuf += (write_words * 4);
> +		}
> +		if (mod_bytes) {
> +			unsigned int temp = 0xFFFFFFFF;
> +
> +			memcpy(&temp, txbuf, min(sizeof(temp), mod_bytes));

Sorry, I dont understand why min() is required here since:
	mod_bytes = write_bytes % 4;
Doesn't that ensure mod_bytes < sizeof(temp)?

> +			iowrite32(temp, cqspi->ahb_base);
> +			txbuf += mod_bytes;
> +		}
>  
>  		if (!wait_for_completion_timeout(&cqspi->transfer_complete,
>  					msecs_to_jiffies(CQSPI_TIMEOUT_MS))) {
> @@ -655,7 +669,6 @@ static int cqspi_indirect_write_execute(struct spi_nor *nor, loff_t to_addr,
>  			goto failwr;
>  		}
>  
> -		txbuf += write_bytes;
>  		remaining -= write_bytes;
>  
>  		if (remaining > 0)
> 

-- 
Regards
Vignesh
