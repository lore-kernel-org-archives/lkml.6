Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71402C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23BB7214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eekG71kQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23BB7214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeJIU37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 16:29:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbeJIU37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 16:29:59 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D19B721479;
        Tue,  9 Oct 2018 13:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539090786;
        bh=IAAp31vXdQIB0M0lzyG02JbDU3LHqYMM+Lxqiw+J1Qo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eekG71kQ53KK7naJdkz9LC+xBxsxuZcpboSoH1PYQwD4VazbPzEOsBcWqjBiLDvrM
         eZe/YQMMIO95oN8/vdoQJUHS2qBRYHDyb2domYNvp0Rw03LdGrgtvJQxPj3AKShOUf
         jwypHJM+saBsbhtpuD9w4DTvI76Rp/efSTaubQZk=
Date:   Tue, 9 Oct 2018 15:13:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Laurence Rochfort <laurence.rochfort@gmail.com>
Cc:     Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gasket: Fix sparse "incorrect type in
 assignment" warnings.
Message-ID: <20181009131303.GC25423@kroah.com>
References: <20181004175225.GA22487@minipc.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004175225.GA22487@minipc.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 06:52:25PM +0100, Laurence Rochfort wrote:
> Silence the below sparse warnings by casting betwen u8 __iomem *, and
> void *.
> 
> warning: incorrect type in assignment (different address spaces)
>    expected unsigned char [noderef] [usertype] <asn:2>*virt_base
>    got void *[assigned] mem
> warning: incorrect type in argument 3 (different address spaces)
>    expected void *cpu_addr
>    got unsigned char [noderef] [usertype] <asn:2>*virt_base
> 
> Signed-off-by: Laurence Rochfort <laurence.rochfort@gmail.com>
> ---
>  drivers/staging/gasket/gasket_page_table.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
> index d4c5f8a..7f5e5b3 100644
> --- a/drivers/staging/gasket/gasket_page_table.c
> +++ b/drivers/staging/gasket/gasket_page_table.c
> @@ -1278,7 +1278,7 @@ int gasket_alloc_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
>  				 dma_addr_t *dma_address, u64 index)
>  {
>  	dma_addr_t handle;
> -	void *mem;
> +	u8 __iomem *mem;
>  	int j;
>  	unsigned int num_pages = (size + PAGE_SIZE - 1) / PAGE_SIZE;
>  	const struct gasket_driver_desc *driver_desc =
> @@ -1290,7 +1290,7 @@ int gasket_alloc_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
>  	if (num_pages == 0)
>  		return -EINVAL;
>  
> -	mem = dma_alloc_coherent(gasket_get_device(gasket_dev),
> +	mem = (u8 __iomem *)dma_alloc_coherent(gasket_get_device(gasket_dev),
>  				 num_pages * PAGE_SIZE, &handle, 0);
>  	if (!mem)
>  		goto nomem;
> @@ -1325,7 +1325,7 @@ int gasket_alloc_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
>  nomem:
>  	if (mem) {
>  		dma_free_coherent(gasket_get_device(gasket_dev),
> -				  num_pages * PAGE_SIZE, mem, handle);
> +				  num_pages * PAGE_SIZE, (void __force *)mem, handle);
>  	}
>  
>  	if (gasket_dev->page_table[index]->coherent_pages) {
> @@ -1353,7 +1353,7 @@ int gasket_free_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
>  	if (gasket_dev->coherent_buffer.length_bytes) {
>  		dma_free_coherent(gasket_get_device(gasket_dev),
>  				  gasket_dev->coherent_buffer.length_bytes,
> -				  gasket_dev->coherent_buffer.virt_base,
> +				  (void __force *)gasket_dev->coherent_buffer.virt_base,

We should not have to "force" anything here.  Something feels wrong in
the definition of these variable types...

thanks,

greg k-h
