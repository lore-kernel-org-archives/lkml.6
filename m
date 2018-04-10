Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbeDJKF4 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 06:05:56 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43403 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752062AbeDJKFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 06:05:54 -0400
Date: Tue, 10 Apr 2018 12:05:42 +0200
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Abhishek Sahu <absahu@codeaurora.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
        Archit Taneja <architt@codeaurora.org>,
        Richard Weinberger <richard@nod.at>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Andy Gross <andy.gross@linaro.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH 6/9] mtd: nand: qcom: support for checking read errors
 for last codeword
Message-ID: <20180410120542.24ea9ddb@xps13>
In-Reply-To: <1522845745-6624-7-git-send-email-absahu@codeaurora.org>
References: <1522845745-6624-1-git-send-email-absahu@codeaurora.org>
        <1522845745-6624-7-git-send-email-absahu@codeaurora.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abhishek,

On Wed,  4 Apr 2018 18:12:22 +0530, Abhishek Sahu
<absahu@codeaurora.org> wrote:

> Add boolean function argument in parse_read_errors to identify
> whether the read error has been called for complete page read or
> only last codeword read. This will help in subsequent patches to
> detect ECC errors in case of last codeword read.

Can you explain when this happen: "last codeword read"? I don't see the
use case.

Thanks,
Miquèl

> 
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> ---
>  drivers/mtd/nand/qcom_nandc.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/qcom_nandc.c b/drivers/mtd/nand/qcom_nandc.c
> index ba43752..dce97e8 100644
> --- a/drivers/mtd/nand/qcom_nandc.c
> +++ b/drivers/mtd/nand/qcom_nandc.c
> @@ -1570,7 +1570,7 @@ struct read_stats {
>   * errors. this is equivalent to what 'ecc->correct()' would do.
>   */
>  static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
> -			     u8 *oob_buf)
> +			     u8 *oob_buf, bool last_cw)
>  {
>  	struct nand_chip *chip = &host->chip;
>  	struct qcom_nand_controller *nandc = get_qcom_nand_controller(chip);
> @@ -1579,12 +1579,12 @@ static int parse_read_errors(struct qcom_nand_host *host, u8 *data_buf,
>  	unsigned int max_bitflips = 0;
>  	struct read_stats *buf;
>  	bool flash_op_err = false;
> -	int i;
> +	int i, cw_cnt = last_cw ? 1 : ecc->steps;
>  
>  	buf = (struct read_stats *)nandc->reg_read_buf;
>  	nandc_read_buffer_sync(nandc, true);
>  
> -	for (i = 0; i < ecc->steps; i++, buf++) {
> +	for (i = 0; i < cw_cnt; i++, buf++) {
>  		u32 flash, buffer, erased_cw;
>  		int data_len, oob_len;
>  
> @@ -1743,7 +1743,8 @@ static int read_page_ecc(struct qcom_nand_host *host, u8 *data_buf,
>  	free_descs(nandc);
>  
>  	if (!ret)
> -		ret = parse_read_errors(host, data_buf_start, oob_buf_start);
> +		ret = parse_read_errors(host, data_buf_start, oob_buf_start,
> +					false);
>  
>  	return ret;
>  }



-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
