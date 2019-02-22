Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAA6C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1AD2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 07:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550819096;
	bh=+0cqXhCCJq9OU3i1z9R3PxpDk96LEEZpNwJNtAmMqDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t628XRTRsmKIVFIRZBD+HorONMFmyYk1z+pvvivH4OGg5ACaXBEI/cLkilCANV/qr
	 Ra45533ltd9DnqGiYmnM8Mtydo57lbbkloA8HqjGxQyPPBdVZlCWivp2uxTuwLkJK+
	 fU12K1875SbB62cACAs7RjIMDwlgKufFGrQfb1RI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfBVHEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 02:04:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:51334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfBVHEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 02:04:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81251207E0;
        Fri, 22 Feb 2019 07:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550819093;
        bh=+0cqXhCCJq9OU3i1z9R3PxpDk96LEEZpNwJNtAmMqDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0ef6CQX7DB2p2Ic36zD9+YuiV6vV0Xh7zI1ve8OPZ4etw4859yEr3qrB2gEfGdg4p
         cgnvSpjIXYbbZxnuY4zN7reUPANG+Mh6QQGaFoFLrJ9ITB8osZtoXk876gdEt1pAH9
         D3HFB/LBrU02DaoDgSFdtwlRfOKgj9z+mrFOCq18=
Date:   Fri, 22 Feb 2019 08:04:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Oded Gabbay <oded.gabbay@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] habanalabs: use GFP_ATOMIC under spin lock
Message-ID: <20190222070450.GA22604@kroah.com>
References: <20190222054601.4396-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222054601.4396-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 05:46:01AM +0000, Wei Yongjun wrote:
> A spin lock is taken here so we should use GFP_ATOMIC.
> 
> Fixes: 0feaf86d4e69 ("habanalabs: add virtual memory and MMU modules")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/misc/habanalabs/memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
> index 9236e52852c6..9e3491dc3b55 100644
> --- a/drivers/misc/habanalabs/memory.c
> +++ b/drivers/misc/habanalabs/memory.c
> @@ -120,7 +120,7 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
>  
>  	spin_lock(&vm->idr_lock);
>  	handle = idr_alloc(&vm->phys_pg_pack_handles, phys_pg_pack, 1, 0,
> -				GFP_KERNEL);
> +				GFP_ATOMIC);
>  	spin_unlock(&vm->idr_lock);
>  
>  	if (handle < 0) {
> 
> 
> 

Ah, nice catch!

Oded, any objection to me taking this patch?

greg k-h
