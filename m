Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756412AbeEIOCx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:02:53 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59055 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934630AbeEIOCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:02:52 -0400
Date: Wed, 9 May 2018 16:02:40 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: NeilBrown <neil@brown.name>, Marek Vasut <marek.vasut@gmail.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] mtd: spi-nor: honour max_message_size for spi-nor
 writes.
Message-ID: <20180509160240.23ef11f2@bbrezillon>
In-Reply-To: <87efj1kw9u.fsf@notabene.neil.brown.name>
References: <87efj1kw9u.fsf@notabene.neil.brown.name>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Apr 2018 16:18:05 +1000
NeilBrown <neil@brown.name> wrote:

> Hi,
>  I've labeled this an RFC because I'm really not sure about removing the
>  error path from spi_nor_write() -- maybe that really matters.  But on
>  my hardware, performing multiple small spi writes to the flash seems
>  to work.
> 
>  The spi driver is drivers/staging/mt7621-spi.  Possibly this needs to
>  use DMA instead of a FIFO (assuming the hardware can) - or maybe
>  drivers/spi/spi-mt65xx.c can be made to work on this hardware, though
>  that is for an ARM SOC and mt7621 is a MIPS SOC.
> 
>  I note that openwrt has similar patches:
>   target/linux/generic/pending-4.14/450-mtd-spi-nor-allow-NOR-driver-to-write-fewer-bytes-th.patch
> 
>  They also change the spi driver to do a short write, rather
>  than change m25p80 to request a short write.
> 
>  Is there something horribly wrong with this?

Marek, any opinion on this patch?

> 
> Thanks,
> NeilBrown
> 
> -----------------------8<------------------------
> 
> m25p80 honours max_message_size and max_transfer_size
> for reads, but not for writes.
> I have a driver that has a max message size of 36 bytes
> (command, address, 32 bytes data, all places in a FIFO
> in the controller).
> This requires m25p80_write() to honour the size limits.
> For that to work, spi-nor needs to quietly accept partial
> writes.
> 
> With this, I can successfully re-flash my device.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  drivers/mtd/devices/m25p80.c  | 3 ++-
>  drivers/mtd/spi-nor/spi-nor.c | 7 -------
>  2 files changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index a4e18f6aaa33..7ded13507604 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -117,7 +117,8 @@ static ssize_t m25p80_write(struct spi_nor *nor, loff_t to, size_t len,
>  
>  	t[data_idx].tx_buf = buf;
>  	t[data_idx].tx_nbits = data_nbits;
> -	t[data_idx].len = len;
> +	t[data_idx].len = min3(len, spi_max_transfer_size(spi),
> +			       spi_max_message_size(spi) - cmd_sz);
>  	spi_message_add_tail(&t[data_idx], &m);
>  
>  	ret = spi_sync(spi, &m);
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 42ae9a1529bb..cfa15f2801ad 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1445,13 +1445,6 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
>  			goto write_err;
>  		*retlen += written;
>  		i += written;
> -		if (written != page_remain) {
> -			dev_err(nor->dev,
> -				"While writing %zu bytes written %zd bytes\n",
> -				page_remain, written);
> -			ret = -EIO;
> -			goto write_err;
> -		}
>  	}
>  
>  write_err:
