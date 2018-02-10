Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbeBJJnW (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 04:43:22 -0500
Received: from mail.kmu-office.ch ([178.209.48.109]:46210 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751024AbeBJJnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 04:43:21 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Sat, 10 Feb 2018 10:43:19 +0100
From: Stefan Agner <stefan@agner.ch>
To: Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH v4 3/3] mtd: nand: vf610: check mtd_device_register()
 return code
In-Reply-To: <1518215316-21504-4-git-send-email-khoroshilov@ispras.ru>
References: <1518215316-21504-1-git-send-email-khoroshilov@ispras.ru>
 <1518215316-21504-4-git-send-email-khoroshilov@ispras.ru>
Message-ID: <8a096fc8dd3afbf9068a0b7856fc8a69@agner.ch>
User-Agent: Roundcube Webmail/1.3.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.02.2018 23:28, Alexey Khoroshilov wrote:
> vf610_nfc_probe() misses error handling of mtd_device_register().
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Looks good to me, and seems to work fine, thanks for fixing this!

For the complete patchset:

Reviewed-by: Stefan Agner <stefan@agner.ch>

--
Stefan


> ---
>  drivers/mtd/nand/vf610_nfc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/vf610_nfc.c b/drivers/mtd/nand/vf610_nfc.c
> index 9cc5992e88c8..64fed3d9e3d4 100644
> --- a/drivers/mtd/nand/vf610_nfc.c
> +++ b/drivers/mtd/nand/vf610_nfc.c
> @@ -782,8 +782,13 @@ static int vf610_nfc_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, mtd);
>  
>  	/* Register device in MTD */
> -	return mtd_device_register(mtd, NULL, 0);
> +	err = mtd_device_register(mtd, NULL, 0);
> +	if (err)
> +		goto err_cleanup_nand;
> +	return 0;
>  
> +err_cleanup_nand:
> +	nand_cleanup(chip);
>  err_disable_clk:
>  	clk_disable_unprepare(nfc->clk);
>  	return err;
