Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F93ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 15:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B831C206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 15:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V5pMJ3b5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B831C206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbeGUQgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 12:36:00 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41436 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbeGUQgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 12:36:00 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6LFfuKe063957;
        Sat, 21 Jul 2018 10:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1532187716;
        bh=VXjp5xIGSjZ2HETFCNt6jj1ln/8mkBeGiln7dgps5UQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=V5pMJ3b5JPfJHhNyhwbTgoxFSNVVmGc5JryShnrhmN22xC4ly87dSzV05VM9uDvsv
         l1hQXYsen6CQZ2CaaI3zUm50yIxPb9PpG7QyFdHXNJvPx87D8uDFSNlfqIeAdcvx8f
         rxc/uza0Bed68OigznEFCTMIPbVzVjqkfjqQn8Vg=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6LFfuJN005800;
        Sat, 21 Jul 2018 10:41:56 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Sat, 21
 Jul 2018 10:41:55 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Sat, 21 Jul 2018 10:41:55 -0500
Received: from [172.22.218.0] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6LFfqRO005476;
        Sat, 21 Jul 2018 10:41:53 -0500
Subject: Re: [PATCH 1/2] mtd: spi-nor: cadence-quadspi: fix timeout handling
 in wait_for_completion_timeout
To:     Nicholas Mc Guire <hofrat@osadl.org>
CC:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>
References: <1532182912-3674-1-git-send-email-hofrat@osadl.org>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <a0644f99-b997-2a94-01ac-dcc2656e984b@ti.com>
Date:   Sat, 21 Jul 2018 21:11:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1532182912-3674-1-git-send-email-hofrat@osadl.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21-Jul-18 7:51 PM, Nicholas Mc Guire wrote:
> wait_for_completion_timeout returns unsigned long not int so a variable of
> proper type is introduced. Further the check for <= 0 is ambiguous and should
> be == 0 here.
>

Oops, my bad. Thanks for the fix! I see you have fixed similar bug in
cqspi_indirect_read_execute(). There is similar code in
cqspi_indirect_write_execute(). Could you fix that as well?

Regards
Vignesh


> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: ffa639e069fb ("mtd: spi-nor: cadence-quadspi: Add DMA support for direct mode reads")
> ---
> 
> Patch found by experimental coccinelle API conformance checker
>> Patch was compile tested with: socfpga_defconfig (implies
> CONFIG_SPI_CADENCE_QUADSPI=y)
> 
> Patch is against 4.18-rc5 (localversion-next is next-20180720)
> 
>  drivers/mtd/spi-nor/cadence-quadspi.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/cadence-quadspi.c b/drivers/mtd/spi-nor/cadence-quadspi.c
> index d7e10b3..79f6a54 100644
> --- a/drivers/mtd/spi-nor/cadence-quadspi.c
> +++ b/drivers/mtd/spi-nor/cadence-quadspi.c
> @@ -953,6 +953,7 @@ static int cqspi_direct_read_execute(struct spi_nor *nor, u_char *buf,
>  	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
>  	dma_addr_t dma_src = (dma_addr_t)cqspi->mmap_phys_base + from;
>  	int ret = 0;
> +	unsigned long timeout;
>  	struct dma_async_tx_descriptor *tx;
>  	dma_cookie_t cookie;
>  	dma_addr_t dma_dst;
> @@ -988,9 +989,9 @@ static int cqspi_direct_read_execute(struct spi_nor *nor, u_char *buf,
>  	}
>  
>  	dma_async_issue_pending(cqspi->rx_chan);
> -	ret = wait_for_completion_timeout(&cqspi->rx_dma_complete,
> -					  msecs_to_jiffies(len));
> -	if (ret <= 0) {
> +	timeout = wait_for_completion_timeout(&cqspi->rx_dma_complete,
> +					      msecs_to_jiffies(len));
> +	if (timeout == 0) {
>  		dmaengine_terminate_sync(cqspi->rx_chan);
>  		dev_err(nor->dev, "DMA wait_for_completion_timeout\n");
>  		ret = -ETIMEDOUT;
> 
