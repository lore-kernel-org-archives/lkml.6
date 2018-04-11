Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753383AbeDKPOf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 11:14:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:44874 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753223AbeDKPOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 11:14:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,436,1517904000";
   d="scan'208";a="219593716"
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCHv2] mtd: spi-nor: Fix Cadence QSPI page fault kernel panic
To: cyrille.pitchen@wedev4u.fr, marek.vasut@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        richard@nod.at
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1522073537-27386-1-git-send-email-thor.thayer@linux.intel.com>
From: Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <0b460613-4ac2-c4d8-429e-248a4742a408@linux.intel.com>
Date: Wed, 11 Apr 2018 10:17:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1522073537-27386-1-git-send-email-thor.thayer@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. Any comments on this patch?

On 03/26/2018 09:12 AM, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> The current Cadence QSPI driver caused a kernel panic when loading
> a Root Filesystem from QSPI. The problem was caused by reading more
> bytes than needed because the QSPI operated on 4 bytes at a time.
> <snip>
> [    7.947754] spi_nor_read[1048]:from 0x037cad74, len 1 [bfe07fff]
> [    7.956247] cqspi_read[910]:offset 0x58502516, buffer=bfe07fff
> [    7.956247]
> [    7.966046] Unable to handle kernel paging request at virtual
> address bfe08002
> [    7.973239] pgd = eebfc000
> [    7.975931] [bfe08002] *pgd=2fffb811, *pte=00000000, *ppte=00000000
> </snip>
> Notice above how only 1 byte needed to be read but by reading 4 bytes
> into the end of a mapped page, an unrecoverable page fault occurred.
> 
> This patch uses a temporary buffer to hold the 4 bytes read and then
> copies only the bytes required into the buffer. A min() function is
> used to limit the length to prevent buffer overflows.
> 
> Request testing of this patch on other platforms. This was tested
> on the Intel Arria10 SoCFPGA DevKit.
> 
> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
> ---
> v2  Changes to only write dangling bytes at end of transfer since
>        previous patch may have multiple dangling byte transfers.
>      Remove write patch since no errors reported and write timeout
>        needs more investigation.
> ---
>   drivers/mtd/spi-nor/cadence-quadspi.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
> index 4b8e9183489a..5872f31eaa60 100644
> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
> @@ -501,7 +501,9 @@ static int cqspi_indirect_read_execute(struct spi_nor *nor, u8 *rxbuf,
>   	void __iomem *reg_base = cqspi->iobase;
>   	void __iomem *ahb_base = cqspi->ahb_base;
>   	unsigned int remaining = n_rx;
> +	unsigned int mod_bytes = n_rx % 4;
>   	unsigned int bytes_to_read = 0;
> +	u8 *rxbuf_end = rxbuf + n_rx;
>   	int ret = 0;
>   
>   	writel(from_addr, reg_base + CQSPI_REG_INDIRECTRDSTARTADDR);
> @@ -530,11 +532,24 @@ static int cqspi_indirect_read_execute(struct spi_nor *nor, u8 *rxbuf,
>   		}
>   
>   		while (bytes_to_read != 0) {
> +			unsigned int word_remain = round_down(remaining, 4);
> +
>   			bytes_to_read *= cqspi->fifo_width;
>   			bytes_to_read = bytes_to_read > remaining ?
>   					remaining : bytes_to_read;
> -			ioread32_rep(ahb_base, rxbuf,
> -				     DIV_ROUND_UP(bytes_to_read, 4));
> +			bytes_to_read = round_down(bytes_to_read, 4);
> +			/* Read 4 byte word chunks then single bytes */
> +			if (bytes_to_read) {
> +				ioread32_rep(ahb_base, rxbuf,
> +					     (bytes_to_read / 4));
> +			} else if (!word_remain && mod_bytes) {
> +				unsigned int temp = ioread32(ahb_base);
> +
> +				bytes_to_read = mod_bytes;
> +				memcpy(rxbuf, &temp, min((unsigned int)
> +							 (rxbuf_end - rxbuf),
> +							 bytes_to_read));
> +			}
>   			rxbuf += bytes_to_read;
>   			remaining -= bytes_to_read;
>   			bytes_to_read = cqspi_get_rd_sram_level(cqspi);
> 
