Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F315EC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C169B217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 08:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548233215;
	bh=CA1tFwjafTrpMpiXu8TULEfduC4eQisyeYGlcekx0tQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aTKAqyI84idGr7Nl1HAWZWCPw/UodaBFeD6n4eYcB0rYxlu4SvnpN3YUJHNlZDqhi
	 I2L2jjNs9VLD2OGHyE5dHzOaBfYgV+Cy7dfupDvBtbdPxXMNzHGfO3RUe+Y9ND5taO
	 t6DeEkeMT3vxtbf6dgAbdMqSj1FFDcDY0itVLHKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfAWIqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 03:46:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:50938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbfAWIqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 03:46:54 -0500
Received: from bbrezillon (unknown [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0650E20861;
        Wed, 23 Jan 2019 08:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548233213;
        bh=CA1tFwjafTrpMpiXu8TULEfduC4eQisyeYGlcekx0tQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Lxv7R+jFHDvN/61Dzlm+UIMN4Q57Ou4E3E885mw1nBKrBHsMHR87TbFhjhIIJlz42
         iWqI6VCqq3aiuD7ee3EK2QDx90Ae7xrBUnJP6jMkPDnobnmqR4H0okamUdC9rN53f+
         +VWJNbgbF2bk+hpAusXu9tNuhFZz2c8Ako1HSzsQ=
Date:   Wed, 23 Jan 2019 09:46:44 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <robert.jarzmik@free.fr>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH -next] mtd: docg3: Fix a possible memory leak of
 mtd->name
Message-ID: <20190123094644.23f27c3e@bbrezillon>
In-Reply-To: <20190123065943.5868-1-yuehaibing@huawei.com>
References: <20190123065943.5868-1-yuehaibing@huawei.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019 14:59:43 +0800
YueHaibing <yuehaibing@huawei.com> wrote:

> In case DOC_CHIPID_G3, mtd->name should be freed in the
> err handling path, which is alloced by kasprintf.
> 
> Fixes: ae9d4934b2d7 ("mtd: docg3: add multiple floor support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/mtd/devices/docg3.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
> index 60ddc38..cbd25f9 100644
> --- a/drivers/mtd/devices/docg3.c
> +++ b/drivers/mtd/devices/docg3.c
> @@ -1867,6 +1867,7 @@ doc_probe_device(struct docg3_cascade *cascade, int floor, struct device *dev)
>  
>  nomem4:
>  	kfree(docg3->bbt);
> +	kfree(mtd->name);

Please use devm_kasprintf() instead.

>  nomem3:
>  	kfree(mtd);
>  nomem2:

