Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E93C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2234F20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2234F20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbeGZA7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 20:59:47 -0400
Received: from gate.crashing.org ([63.228.1.57]:40121 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731618AbeGZA7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 20:59:47 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w6PNjRVY023813;
        Wed, 25 Jul 2018 18:45:28 -0500
Message-ID: <8fb34eab67d3c594fd49690a25c5c8072105417d.camel@kernel.crashing.org>
Subject: Re: [PATCH] fsi: master-ast-cf: Fix memory leak
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 26 Jul 2018 09:45:27 +1000
In-Reply-To: <20180725133832.GA20837@embeddedor.com>
References: <20180725133832.GA20837@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.4 (3.28.4-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-25 at 08:38 -0500, Gustavo A. R. Silva wrote:
> In case memory resources for *fw* were allocated, release them
> before return.
> 
> Addresses-Coverity-ID: 1472044 ("Resource leak")
> Fixes: 6a794a27daca ("fsi: master-ast-cf: Add new FSI master using Aspeed ColdFire")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks Gustavo !

I'll apply before I send my next pull request to Greg !

Cheers,
Ben.

> ---
>  drivers/fsi/fsi-master-ast-cf.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
> index c4a3557..e39a4630 100644
> --- a/drivers/fsi/fsi-master-ast-cf.c
> +++ b/drivers/fsi/fsi-master-ast-cf.c
> @@ -861,7 +861,8 @@ static int load_copro_firmware(struct fsi_master_acf *master)
>  	if (sig != wanted_sig) {
>  		dev_err(master->dev, "Failed to locate image sig %04x in FW blob\n",
>  			wanted_sig);
> -		return -ENODEV;
> +		rc = -ENODEV;
> +		goto release_fw;
>  	}
>  	if (size > master->cf_mem_size) {
>  		dev_err(master->dev, "FW size (%zd) bigger than memory reserve (%zd)\n",
> @@ -870,8 +871,9 @@ static int load_copro_firmware(struct fsi_master_acf *master)
>  	} else {
>  		memcpy_toio(master->cf_mem, data, size);
>  	}
> -	release_firmware(fw);
>  
> +release_fw:
> +	release_firmware(fw);
>  	return rc;
>  }
>  

