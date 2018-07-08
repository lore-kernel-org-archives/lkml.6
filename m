Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1F3C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 11:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52AF2089F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 11:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52AF2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933039AbeGHLoe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 07:44:34 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33901 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932846AbeGHLod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 07:44:33 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C0FD520737; Sun,  8 Jul 2018 13:44:30 +0200 (CEST)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 4BF06203B4;
        Sun,  8 Jul 2018 13:44:30 +0200 (CEST)
Date:   Sun, 8 Jul 2018 13:44:30 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sergey Larin <cerg2010cerg2010@mail.ru>
Cc:     boris.brezillon@bootlin.com, richard@nod.at, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mtd: rawnand: docg4: fix NULL deref while probing
Message-ID: <20180708134430.2ad78f6e@xps13>
In-Reply-To: <30a41254ed09624a8972aa1daf14e4dd1efabed3.1531045014.git.cerg2010cerg2010@mail.ru>
References: <cover.1531045014.git.cerg2010cerg2010@mail.ru>
        <30a41254ed09624a8972aa1daf14e4dd1efabed3.1531045014.git.cerg2010cerg2010@mail.ru>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

Sergey Larin <cerg2010cerg2010@mail.ru> wrote on Sun,  8 Jul 2018
14:29:23 +0300:

> nand_scan_tail() invokes nand_chip->scan_bbt() at the end, which is not set
> by the driver. Use the default nand_default_bbt() function to avoid NULL
> dereferncing.

dereferencing

> 
> Signed-off-by: Sergey Larin <cerg2010cerg2010@mail.ru>

Maybe a Fixes/stable tags would be appropriate here if this is a real
runtime error?

> ---
>  drivers/mtd/nand/raw/docg4.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/nand/raw/docg4.c b/drivers/mtd/nand/raw/docg4.c
> index bb96cb33cd6b..bbed8ea7858c 100644
> --- a/drivers/mtd/nand/raw/docg4.c
> +++ b/drivers/mtd/nand/raw/docg4.c
> @@ -1269,6 +1269,7 @@ static void __init init_mtd_structs(struct mtd_info *mtd)
>  	nand->read_buf = docg4_read_buf;
>  	nand->write_buf = docg4_write_buf16;
>  	nand->erase = docg4_erase_block;
> +	nand->scan_bbt = nand_default_bbt;
>  	nand->set_features = nand_get_set_features_notsupp;
>  	nand->get_features = nand_get_set_features_notsupp;
>  	nand->ecc.read_page = docg4_read_page;



-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
