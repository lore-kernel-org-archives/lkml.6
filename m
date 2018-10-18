Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB23C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDCF720658
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDCF720658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbeJSExL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:53:11 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46967 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725738AbeJSExK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:53:10 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 00C1E20789; Thu, 18 Oct 2018 22:50:20 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 78F9920723;
        Thu, 18 Oct 2018 22:50:10 +0200 (CEST)
Date:   Thu, 18 Oct 2018 22:50:09 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     <linux-mtd@lists.infradead.org>,
        Liang Yang <liang.yang@amlogic.com>,
        Yixun Lan <yixun.lan@amlogic.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] mtd: rawnand: meson: add support for Amlogic
 NAND flash controller
Message-ID: <20181018225009.59d94aee@bbrezillon>
In-Reply-To: <1539839345-14021-3-git-send-email-jianxin.pan@amlogic.com>
References: <1539839345-14021-1-git-send-email-jianxin.pan@amlogic.com>
        <1539839345-14021-3-git-send-email-jianxin.pan@amlogic.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018 13:09:05 +0800
Jianxin Pan <jianxin.pan@amlogic.com> wrote:

> +static int meson_nfc_buffer_init(struct mtd_info *mtd)
> +{
> +	struct nand_chip *nand = mtd_to_nand(mtd);
> +	struct meson_nfc *nfc = nand_get_controller_data(nand);
> +	static int max_page_bytes, max_info_bytes;
> +	int page_bytes, info_bytes;
> +	int nsectors;
> +
> +	nsectors = mtd->writesize / nand->ecc.size;
> +	page_bytes =  mtd->writesize + mtd->oobsize;
> +	info_bytes = nsectors * PER_INFO_BYTE;
> +
> +	if (nfc->data_buf && nfc->info_buf) {
> +		if (max_page_bytes < page_bytes)
> +			meson_nfc_free_buffer(nfc);
> +		else
> +			return 0;
> +	}
> +
> +	max_page_bytes = max_t(int, max_page_bytes, page_bytes);
> +	max_info_bytes = max_t(int, max_info_bytes, info_bytes);
> +
> +	nfc->data_buf = kmalloc(max_page_bytes, GFP_KERNEL);

Is there a good reason for not using chip->data_buf and allocating a
new buffer here?

> +	if (!nfc->data_buf)
> +		return -ENOMEM;
> +
> +	nfc->info_buf = kmalloc(max_info_bytes, GFP_KERNEL);
> +	if (!nfc->info_buf) {
> +		kfree(nfc->data_buf);
> +		return -ENOMEM;
> +	}

I'd recommend moving this info_buf in the priv chip struct, otherwise
you'll have to protect nfc->info_buf with a lock to prevent an already
register chip from using this pointer while you're reallocating the
buffer. Also, I think you have a memleak here.

> +
> +	return 0;
> +}
