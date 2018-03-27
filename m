Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeC0D7x (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 23:59:53 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:56973 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752090AbeC0D7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 23:59:51 -0400
Subject: Re: [PATCH] Fixes in TI QSPI driver to allow more than one flash chip
To: "Kwiatkowski, Arkadiusz" <arkadiusz.kwiatkowski@aptiv.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <0ece6261f37a424cbde7122907548a9f@CO1PR6802MB0085.017d.mgd.msft.net>
From: Vignesh R <vigneshr@ti.com>
Message-ID: <496c162d-5e3c-e008-a14b-6b990e253e64@ti.com>
Date: Tue, 27 Mar 2018 09:30:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0ece6261f37a424cbde7122907548a9f@CO1PR6802MB0085.017d.mgd.msft.net>
Content-Type: text/plain; charset="iso-8859-2"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday 22 March 2018 06:03 PM, Kwiatkowski, Arkadiusz wrote:
> Add checking for which SPI device was memory-mapped to allow more than
> one flash device being used on QSPI bus. Fix parameters order in
> regmap_update_bits calls.
> 
> Signed-off-by: Arkadiusz Kwiatkowski <arkadiusz.kwiatkowski@aptiv.com>
> ---

Thanks for the patch! Fixes are legitimate but,
Your mailer has grabbled the patch (especially white spaces). Please use
git send-email to send patches.
Run scripts/checkpatch.pl --strict on the patch for kernel coding style
checks.
Please look at git log drivers/spi/spi-ti-qspi.c and fix up $subject
accordingly. Split this patch into two: One fixing up
regmap_update_bits() call and other fixing up mmap setup for more than
one CS.


>  drivers/spi/spi-ti-qspi.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
> index c24d9b4..3d1dc4f 100644
> --- a/drivers/spi/spi-ti-qspi.c
> +++ b/drivers/spi/spi-ti-qspi.c
> @@ -66,7 +66,7 @@ struct ti_qspi {
>  u32 cmd;
>  u32 dc;
> 
> -bool mmap_enabled;
> +struct spi_device*mmap_spi_device;
>  };
> 
>  #define QSPI_PID(0x0)
> @@ -490,10 +490,10 @@ static void ti_qspi_enable_memory_map(struct
> spi_device *spi)
>  ti_qspi_write(qspi, MM_SWITCH, QSPI_SPI_SWITCH_REG);
>  if (qspi->ctrl_base) {
>  regmap_update_bits(qspi->ctrl_base, qspi->ctrl_reg,
> -   MEM_CS_EN(spi->chip_select),
> -   MEM_CS_MASK);
> +   MEM_CS_MASK,
> +   MEM_CS_EN(spi->chip_select));
>  }
> -qspi->mmap_enabled = true;
> +qspi->mmap_spi_device = spi;
>  }
> 
>  static void ti_qspi_disable_memory_map(struct spi_device *spi)
> @@ -503,8 +503,8 @@ static void ti_qspi_disable_memory_map(struct
> spi_device *spi)
>  ti_qspi_write(qspi, 0, QSPI_SPI_SWITCH_REG);
>  if (qspi->ctrl_base)
>  regmap_update_bits(qspi->ctrl_base, qspi->ctrl_reg,
> -   0, MEM_CS_MASK);
> -qspi->mmap_enabled = false;
> +   MEM_CS_MASK, 0);
> +qspi->mmap_spi_device = NULL;
>  }
> 
>  static void ti_qspi_setup_mmap_read(struct spi_device *spi,
> @@ -544,8 +544,12 @@ static int ti_qspi_spi_flash_read(struct spi_device
> *spi,
> 
>  mutex_lock(&qspi->list_lock);
> 
> -if (!qspi->mmap_enabled)
> +if (qspi->mmap_spi_device != spi) {
> +if (qspi->mmap_spi_device != NULL)
> +ti_qspi_disable_memory_map(qspi->mmap_spi_device);
>  ti_qspi_enable_memory_map(spi);
> +}
> +
>  ti_qspi_setup_mmap_read(spi, msg);
> 
>  if (qspi->rx_chan) {
> @@ -600,7 +604,7 @@ static int ti_qspi_start_transfer_one(struct
> spi_master *master,
> 
>  mutex_lock(&qspi->list_lock);
> 
> -if (qspi->mmap_enabled)
> +if (qspi->mmap_spi_device != NULL)
>  ti_qspi_disable_memory_map(spi);
> 
>  list_for_each_entry(t, &m->transfers, transfer_list) {
> @@ -787,7 +791,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
>  master->spi_flash_read = NULL;
>  }
>  }
> -qspi->mmap_enabled = false;
> +qspi->mmap_spi_device = NULL;
> 
>  ret = devm_spi_register_master(&pdev->dev, master);
>  if (!ret)
> --
> 2.7.4
> ****************************************************************************************
> Note: If the reader of this message is not the intended recipient, or an
> employee or agent responsible for delivering this message to the
> intended recipient, you are hereby notified that any dissemination,
> distribution or copying of this communication is strictly prohibited. If
> you have received this communication in error, please notify us
> immediately by replying to the message and deleting it from your
> computer. Thank you.
> ****************************************************************************************

-- 
Regards
Vignesh
