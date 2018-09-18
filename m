Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD57ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7BE52086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 10:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7BE52086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbeIRQSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 12:18:34 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42214 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbeIRQSe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 12:18:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5ED59ED1;
        Tue, 18 Sep 2018 03:46:33 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.Emea.Arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C44B3F5BD;
        Tue, 18 Sep 2018 03:46:32 -0700 (PDT)
Date:   Tue, 18 Sep 2018 11:46:29 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: mediatek: Fix unchecked return value
Message-ID: <20180918104629.GC26886@e107981-ln.cambridge.arm.com>
References: <20180720150158.GA10922@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720150158.GA10922@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 10:01:58AM -0500, Gustavo A. R. Silva wrote:
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

Applied to pci/mediatek for v4.20, thanks.

Lorenzo

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
> -- 
> 2.7.4
> 
