Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0A2C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 05:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2C92170A
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 05:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2C92170A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbeHDHxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 03:53:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33064 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbeHDHxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 03:53:18 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 744C220723; Sat,  4 Aug 2018 07:53:49 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 28AB2206A6;
        Sat,  4 Aug 2018 07:53:49 +0200 (CEST)
Date:   Sat, 4 Aug 2018 07:53:49 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] mtd: nand: toshiba: Add support for ->exec_op()
Message-ID: <20180804075349.2314ae81@bbrezillon>
In-Reply-To: <1533360378-2925-1-git-send-email-yoshitake.kobayashi@toshiba.co.jp>
References: <1533360378-2925-1-git-send-email-yoshitake.kobayashi@toshiba.co.jp>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  4 Aug 2018 14:26:18 +0900
KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp> wrote:

> This patch is a patch to support TOSHIBA MEMORY CORPORATION BENAND
> memory devices.  This use vendor specific command
> (TOSHIBA_NAND_CMD_ECC_STATUS) to know the exact bitflips.  However, I

					    ^ exact number of bitflips

> could not test this patch because I do not have a platform that
> supports chip-> exec_op.  Therefore, I post this patch as RFC.

	   ^ chip->exec_op()

How about adding ->exec_op() support to the controller driver you're
testing with?

> As soon as I get a platform that supports chip-> exec_op, I would like
> to test and re-post.

All the explanation about why this is an RFC should be placed after the
'---' separator so that it does not appear when we apply the patch.

> 
> Signed-off-by: KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>

With the commit message adjusted as suggested above,

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>


> ---
>  drivers/mtd/nand/raw/nand_toshiba.c | 53 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_toshiba.c b/drivers/mtd/nand/raw/nand_toshiba.c
> index 8aec3fa..3f4683b 100644
> --- a/drivers/mtd/nand/raw/nand_toshiba.c
> +++ b/drivers/mtd/nand/raw/nand_toshiba.c
> @@ -23,14 +23,65 @@
>  /* Recommended to rewrite for BENAND */
>  #define TOSHIBA_NAND_STATUS_REWRITE_RECOMMENDED	BIT(3)
>  
> +/* ECC Status Read Command for BENAND */
> +#define TOSHIBA_NAND_CMD_ECC_STATUS_READ	0x7A
> +
> +/* ECC Status Mask for BENAND */
> +#define TOSHIBA_NAND_ECC_STATUS_MASK		0x0F
> +
> +/* Uncorrectable Error for BENAND */
> +#define TOSHIBA_NAND_ECC_STATUS_UNCORR		0x0F
> +
> +static int toshiba_nand_benand_read_eccstatus_op(struct nand_chip *chip,
> +						 u8 *buf)
> +{
> +	u8 *ecc_status = buf;
> +
> +	if (chip->exec_op) {
> +		const struct nand_sdr_timings *sdr =
> +			nand_get_sdr_timings(&chip->data_interface);
> +		struct nand_op_instr instrs[] = {
> +			NAND_OP_CMD(TOSHIBA_NAND_CMD_ECC_STATUS_READ,
> +				    PSEC_TO_NSEC(sdr->tADL_min)),
> +			NAND_OP_8BIT_DATA_IN(chip->ecc.steps, ecc_status, 0),
> +		};
> +		struct nand_operation op = NAND_OPERATION(instrs);
> +
> +		return nand_exec_op(chip, &op);
> +	}
> +
> +	return -ENOTSUPP;
> +}
> +
>  static int toshiba_nand_benand_eccstatus(struct mtd_info *mtd,
>  					 struct nand_chip *chip)
>  {
>  	int ret;
>  	unsigned int max_bitflips = 0;
> -	u8 status;
> +	u8 status, ecc_status[8];
>  
>  	/* Check Status */
> +	ret = toshiba_nand_benand_read_eccstatus_op(chip, ecc_status);
> +	if (!ret) {
> +		unsigned int i, bitflips = 0;
> +
> +		for (i = 0; i < chip->ecc.steps; i++) {
> +			bitflips = ecc_status[i] & TOSHIBA_NAND_ECC_STATUS_MASK;
> +			if (bitflips == TOSHIBA_NAND_ECC_STATUS_UNCORR) {
> +				mtd->ecc_stats.failed++;
> +			} else {
> +				mtd->ecc_stats.corrected += bitflips;
> +				max_bitflips = max(max_bitflips, bitflips);
> +			}
> +		}
> +
> +		return max_bitflips;
> +	}
> +
> +	/*
> +	 * Fallback to regular status check if
> +	 * toshiba_nand_benand_read_eccstatus_op() failed.
> +	 */
>  	ret = nand_status_op(chip, &status);
>  	if (ret)
>  		return ret;

