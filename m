Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3028BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F4420894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 06:02:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F4420894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733291AbeHAHpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 03:45:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58550 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbeHAHpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 03:45:16 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6AFCB207AB; Wed,  1 Aug 2018 08:01:18 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2E00F20799;
        Wed,  1 Aug 2018 08:01:18 +0200 (CEST)
Date:   Wed, 1 Aug 2018 08:01:17 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Jheng-Jhong Wu <goodwater.wu@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arun Nagendran <arunrasppi@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Palle Christensen <palle.christensen@microsemi.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging:mt29f_spinand: MT29F2G failing as only 16-bit
 arguments and variables used for addressing.
Message-ID: <20180801080117.5386e9f1@bbrezillon>
In-Reply-To: <1533093861-9761-1-git-send-email-goodwater.wu@gmail.com>
References: <1533093861-9761-1-git-send-email-goodwater.wu@gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jheng-Jhong,

On Wed,  1 Aug 2018 11:24:19 +0800
Jheng-Jhong Wu <goodwater.wu@gmail.com> wrote:

> For NAND flash chips with more than 1Gbit (e.g. MT29F2G) more than 16 bits
> are necessary to address the correct page. The driver sets the address for
> more than 16 bits, but it uses 16-bit arguments and variables (these are
> page_id, block_id, row) to do address operations. Obviously, these
> arguments and variables cannot deal with more than 16-bit address.

I plan to remove this driver soon (after 4.19-rc1 is out). It's now
been replaced by the SPI framework [1]. Can you check if your NAND SPI
NAND is supported, if it's not add support for it, and if you find a
bug report/fix it.

Thanks,

Boris

[1]https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/mtd/nand/spi?h=next-20180731

> 
> Signed-off-by: Jheng-Jhong Wu <goodwater.wu@gmail.com>
> ---
>  drivers/staging/mt29f_spinand/mt29f_spinand.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
> index 4484784..a0f4cbcb 100644
> --- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
> +++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
> @@ -308,10 +308,10 @@ static int spinand_write_enable(struct spi_device *spi_nand)
>  	return spinand_cmd(spi_nand, &cmd);
>  }
>  
> -static int spinand_read_page_to_cache(struct spi_device *spi_nand, u16 page_id)
> +static int spinand_read_page_to_cache(struct spi_device *spi_nand, u32 page_id)
>  {
>  	struct spinand_cmd cmd = {0};
> -	u16 row;
> +	u32 row;
>  
>  	row = page_id;
>  	cmd.cmd = CMD_READ;
> @@ -331,7 +331,7 @@ static int spinand_read_page_to_cache(struct spi_device *spi_nand, u16 page_id)
>   *   locations.
>   *   No tRd delay.
>   */
> -static int spinand_read_from_cache(struct spi_device *spi_nand, u16 page_id,
> +static int spinand_read_from_cache(struct spi_device *spi_nand, u32 page_id,
>  				   u16 byte_id, u16 len, u8 *rbuf)
>  {
>  	struct spinand_cmd cmd = {0};
> @@ -362,7 +362,7 @@ static int spinand_read_from_cache(struct spi_device *spi_nand, u16 page_id,
>   *   The read includes two commands to the Nand - 0x13 and 0x03 commands
>   *   Poll to read status to wait for tRD time.
>   */
> -static int spinand_read_page(struct spi_device *spi_nand, u16 page_id,
> +static int spinand_read_page(struct spi_device *spi_nand, u32 page_id,
>  			     u16 offset, u16 len, u8 *rbuf)
>  {
>  	int ret;
> @@ -430,7 +430,7 @@ static int spinand_read_page(struct spi_device *spi_nand, u16 page_id,
>   *   Since it is writing the data to cache, there is no tPROG time.
>   */
>  static int spinand_program_data_to_cache(struct spi_device *spi_nand,
> -					 u16 page_id, u16 byte_id,
> +					 u32 page_id, u16 byte_id,
>  					 u16 len, u8 *wbuf)
>  {
>  	struct spinand_cmd cmd = {0};
> @@ -457,10 +457,10 @@ static int spinand_program_data_to_cache(struct spi_device *spi_nand,
>   *   the Nand array.
>   *   Need to wait for tPROG time to finish the transaction.
>   */
> -static int spinand_program_execute(struct spi_device *spi_nand, u16 page_id)
> +static int spinand_program_execute(struct spi_device *spi_nand, u32 page_id)
>  {
>  	struct spinand_cmd cmd = {0};
> -	u16 row;
> +	u32 row;
>  
>  	row = page_id;
>  	cmd.cmd = CMD_PROG_PAGE_EXC;
> @@ -486,7 +486,7 @@ static int spinand_program_execute(struct spi_device *spi_nand, u16 page_id)
>   *   Poll to wait for the tPROG time to finish the transaction.
>   */
>  static int spinand_program_page(struct spi_device *spi_nand,
> -				u16 page_id, u16 offset, u16 len, u8 *buf)
> +				u32 page_id, u16 offset, u16 len, u8 *buf)
>  {
>  	int retval;
>  	u8 status = 0;
> @@ -573,10 +573,10 @@ static int spinand_program_page(struct spi_device *spi_nand,
>   *   one block--64 pages
>   *   Need to wait for tERS.
>   */
> -static int spinand_erase_block_erase(struct spi_device *spi_nand, u16 block_id)
> +static int spinand_erase_block_erase(struct spi_device *spi_nand, u32 block_id)
>  {
>  	struct spinand_cmd cmd = {0};
> -	u16 row;
> +	u32 row;
>  
>  	row = block_id;
>  	cmd.cmd = CMD_ERASE_BLK;
> @@ -599,7 +599,7 @@ static int spinand_erase_block_erase(struct spi_device *spi_nand, u16 block_id)
>   *   and then send the 0xd8 erase command
>   *   Poll to wait for the tERS time to complete the tranaction.
>   */
> -static int spinand_erase_block(struct spi_device *spi_nand, u16 block_id)
> +static int spinand_erase_block(struct spi_device *spi_nand, u32 block_id)
>  {
>  	int retval;
>  	u8 status = 0;

