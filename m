Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7C0C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333BC218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548342060;
	bh=7GO927NVdjxAU7TuJ/Pe/QGB7sFlePmjsQMNCa+HFtk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qZdWUigYR1gBsS4236EAUiFY+gEGqtNZC8F3CocvscFI+Bq+cAX1+ITJu6hJPzbzF
	 pN45BnMfuYaDqRnmeuEUbRZvEyCfN3hUKIfuR+gvF4nUqimJ1/bKnHozjGZJKOL3EO
	 cEl63pD6vSIiR8AKKOMYkRZ0nS9ePdUGO+4fi6E8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbfAXPA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:00:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:34944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728010AbfAXPA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:00:58 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 602D621872;
        Thu, 24 Jan 2019 15:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548342057;
        bh=7GO927NVdjxAU7TuJ/Pe/QGB7sFlePmjsQMNCa+HFtk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=w8EKL/anIIpBhS1mJPYs2VrX49Fic9Yigok6eHlWFz7w9u7WhnUYDHvIakk93ChLc
         L+by6TU40Ky7thAyjVKvmfbid9FXDM5/I14kC8DRU31Nf5EDf318GvqCOUTycDbXaS
         gj9i1uOHlm9r5DFoFPFZnN3JzjhU9Ow1G2mWyUoc=
Date:   Thu, 24 Jan 2019 16:00:47 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <robert.jarzmik@free.fr>, <dwmw2@infradead.org>,
        <computersforpeace@gmail.com>, <marek.vasut@gmail.com>,
        <richard@nod.at>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v3 -next] mtd: docg3: Fix a possible memory leak of
 mtd->name
Message-ID: <20190124160047.6091b3e3@bbrezillon>
In-Reply-To: <20190123092819.5020-1-yuehaibing@huawei.com>
References: <20190123092819.5020-1-yuehaibing@huawei.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2019 17:28:19 +0800
YueHaibing <yuehaibing@huawei.com> wrote:

> In case DOC_CHIPID_G3, mtd->name is not freed in err handling path,
> which is alloced by kasprintf(). Fix this by using devm_kasprintf().
> 
> Fixes: ae9d4934b2d7 ("mtd: docg3: add multiple floor support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> v3: use devm_kasprintf
> ---
>  drivers/mtd/devices/docg3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
> index 4c94fc0..59ca4f5 100644
> --- a/drivers/mtd/devices/docg3.c
> +++ b/drivers/mtd/devices/docg3.c
> @@ -1767,8 +1767,8 @@ static int __init doc_set_driver_info(int chip_id, struct mtd_info *mtd)
>  
>  	switch (chip_id) {
>  	case DOC_CHIPID_G3:
> -		mtd->name = kasprintf(GFP_KERNEL, "docg3.%d",
> -				      docg3->device_id);
> +		mtd->name = devm_kasprintf(docg3->dev, GFP_KERNEL, "docg3.%d",
> +					   docg3->device_id);

You forgot to remove the kfree() in the ->remove() path.

>  		if (!mtd->name)
>  			return -ENOMEM;
>  		docg3->max_block = 2047;

