Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95802C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AE5720839
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNVhd2FK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE5720839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbeIFCBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:01:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbeIFCBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:01:52 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4730620659;
        Wed,  5 Sep 2018 21:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536182989;
        bh=KeeVlhzNm9iccp/6mmNAVCyxuuU5FU4x7z6UvOBL0Zw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LNVhd2FKzyg8DA1HG/Cf8yBUnxHzsPysCHu8xOj9PkHuafUtJRhEMUOZFxOZqjU8q
         mtX1wXGOuRdlZDdtMRIHa4ka/RDbyU/HFsUgZ4V3ut1AmU5E4X0zZ+oHgpC5jDFQvK
         I0UKqlHE1Dzf8co0uziwdKCA6EX/Y3hP7R9xxeEI=
Date:   Wed, 5 Sep 2018 16:29:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] switchtec: Fix potential Spectre v1
Message-ID: <20180905212947.GU107892@bhelgaas-glaptop.roam.corp.google.com>
References: <20180816190646.GA9610@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816190646.GA9610@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 02:06:46PM -0500, Gustavo A. R. Silva wrote:
> p.port can is indirectly controlled by user-space, hence leading to
> a potential exploitation of the Spectre variant 1 vulnerability.
> 
> This issue was detected with the help of Smatch:
> 
> drivers/pci/switch/switchtec.c:912 ioctl_port_to_pff() warn: potential
> spectre issue 'pcfg->dsp_pff_inst_id' [r]
> 
> Fix this by sanitizing p.port before using it to index
> pcfg->dsp_pff_inst_id
> 
> Notice that given that speculation windows are large, the policy is
> to kill the speculation on the first load and not worry if it can be
> completed with a dependent load/store [1].
> 
> [1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied with Logan's ack to for-linus for v4.19, thanks!

> ---
>  drivers/pci/switch/switchtec.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index 9940cc7..54a8b30 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -14,6 +14,8 @@
>  #include <linux/poll.h>
>  #include <linux/wait.h>
>  
> +#include <linux/nospec.h>
> +
>  MODULE_DESCRIPTION("Microsemi Switchtec(tm) PCIe Management Driver");
>  MODULE_VERSION("0.1");
>  MODULE_LICENSE("GPL");
> @@ -909,6 +911,8 @@ static int ioctl_port_to_pff(struct switchtec_dev *stdev,
>  	default:
>  		if (p.port > ARRAY_SIZE(pcfg->dsp_pff_inst_id))
>  			return -EINVAL;
> +		p.port = array_index_nospec(p.port,
> +					ARRAY_SIZE(pcfg->dsp_pff_inst_id) + 1);
>  		p.pff = ioread32(&pcfg->dsp_pff_inst_id[p.port - 1]);
>  		break;
>  	}
> -- 
> 2.7.4
> 
