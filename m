Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826D3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517EB21852
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 06:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbfB0GWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 01:22:11 -0500
Received: from smtprelay0230.hostedemail.com ([216.40.44.230]:41647 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729529AbfB0GWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 01:22:10 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 2C6C3C1DCAF;
        Wed, 27 Feb 2019 06:22:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crack31_4cd183cdee063
X-Filterd-Recvd-Size: 2007
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed, 27 Feb 2019 06:22:07 +0000 (UTC)
Message-ID: <ce11feb21863662cf2ad96f0f7b69f0edcabfcf7.camel@perches.com>
Subject: Re: [PATCH 3/8] tlan: use pci_zalloc instead of pci_alloc
From:   Joe Perches <joe@perches.com>
To:     Robert Eshleman <bobbyeshleman@gmail.com>
Cc:     Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Samuel Chessman <chessman@tux.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 26 Feb 2019 22:22:06 -0800
In-Reply-To: <51125a3daac49f7b5bb360a422663aee26e6776b.1551246708.git.bobbyeshleman@gmail.com>
References: <cover.1551246708.git.bobbyeshleman@gmail.com>
         <51125a3daac49f7b5bb360a422663aee26e6776b.1551246708.git.bobbyeshleman@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-02-26 at 22:09 -0800, Robert Eshleman wrote:
> This patch replaces a pci_alloc_consistent and memset(,0) call
> with a single call to pci_zalloc_consistent.
[]
> diff --git a/drivers/net/ethernet/ti/tlan.c b/drivers/net/ethernet/ti/tlan.c
[]
> @@ -845,17 +845,16 @@ static int tlan_init(struct net_device *dev)
>  
>  	dma_size = (TLAN_NUM_RX_LISTS + TLAN_NUM_TX_LISTS)
>  		* (sizeof(struct tlan_list));
> -	priv->dma_storage = pci_alloc_consistent(priv->pci_dev,
> -						 dma_size,
> -						 &priv->dma_storage_dma);
> +	priv->dma_storage = pci_zalloc_consistent(priv->pci_dev,
> +						  dma_size,
> +						  &priv->dma_storage_dma);
>  	priv->dma_size = dma_size;
>  
> -	if (priv->dma_storage == NULL) {
> +	if (!priv->dma_storage) {
>  		pr_err("Could not allocate lists and buffers for %s\n",
>  		       dev->name);

unrelated trivia:

This pr_err (and likely others in this file)
could be replace by netdev_err


