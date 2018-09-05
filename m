Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FE9C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D19EE2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19EE2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeIENTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:19:53 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:65511 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726401AbeIENTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:19:53 -0400
X-UUID: 70f6b2a713e54af287959e973471d185-20180905
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <honghui.zhang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1548811753; Wed, 05 Sep 2018 16:50:37 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs08n2.mediatek.inc
 (172.21.101.56) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Wed, 5 Sep
 2018 16:50:34 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 5 Sep 2018 16:50:33 +0800
Message-ID: <1536137433.31406.17.camel@mhfsdcap03>
Subject: Re: [PATCH] PCI: mediatek: Fix unchecked return value
From:   Honghui Zhang <honghui.zhang@mediatek.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
CC:     Ryder Lee <ryder.lee@mediatek.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Wed, 5 Sep 2018 16:50:33 +0800
In-Reply-To: <20180720150158.GA10922@embeddedor.com>
References: <20180720150158.GA10922@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-07-20 at 10:01 -0500, Gustavo A. R. Silva wrote:
> Check return value of devm_pci_remap_iospace.
> 
> Notice that, currently, all instances of devm_pci_remap_iospace
> are being checked.
> 
> Addresses-Coverity-ID: 1471965 ("Unchecked return value")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Hi, Gustavo, thanks for your help.

Acked-by: Honghui Zhang <honghui.zhang@mediatek.com>

> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 861dda6..1477939 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -1109,7 +1109,9 @@ static int mtk_pcie_request_resources(struct mtk_pcie *pcie)
>  	if (err < 0)
>  		return err;
>  
> -	devm_pci_remap_iospace(dev, &pcie->pio, pcie->io.start);
> +	err = devm_pci_remap_iospace(dev, &pcie->pio, pcie->io.start);
> +	if (err)
> +		return err;
>  
>  	return 0;
>  }


