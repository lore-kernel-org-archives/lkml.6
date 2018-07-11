Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16E3C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63D4920C0F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63D4920C0F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389949AbeGKQ5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:57:45 -0400
Received: from ale.deltatee.com ([207.54.116.67]:59838 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387689AbeGKQ5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:57:44 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1fdILv-0005fm-FG; Wed, 11 Jul 2018 10:52:32 -0600
To:     Serge Semin <fancer.lancer@gmail.com>, jdmason@kudzu.us,
        dave.jiang@intel.com, allenbh@gmail.com
Cc:     Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org
References: <20180711163224.30892-1-fancer.lancer@gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <58db6cb1-c62e-bedd-6542-9a0e40e3dd86@deltatee.com>
Date:   Wed, 11 Jul 2018 10:52:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180711163224.30892-1-fancer.lancer@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Sergey.Semin@t-platforms.ru, allenbh@gmail.com, dave.jiang@intel.com, jdmason@kudzu.us, fancer.lancer@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] ntb: idt: Set PCIe bus address to BARLIMITx
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/07/18 10:32 AM, Serge Semin wrote:
> @@ -1320,7 +1321,9 @@ static int idt_ntb_peer_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
>  		idt_nt_write(ndev, bar->ltbase, (u32)addr);
>  		idt_nt_write(ndev, bar->utbase, (u32)(addr >> 32));
>  		/* Set the custom BAR aperture limit */
> -		limit = pci_resource_start(ntb->pdev, mw_cfg->bar) + size;
> +		pcibios_resource_to_bus(ntb->pdev->bus, &region,
> +					&ntb->pdev->resource[mw_cfg->bar]);
> +		limit = region.start + size;

You should use the pci_bus_address() helper instead. It's much simpler
and you don't need to delve into pci_dev internals to use it.

Logan
