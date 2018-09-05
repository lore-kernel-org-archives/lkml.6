Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A096C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E057F2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E057F2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeIENQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:16:59 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:48307 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeIENQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:16:59 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 34D7F100E4162;
        Wed,  5 Sep 2018 10:47:47 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id CEFA8597FA; Wed,  5 Sep 2018 10:47:46 +0200 (CEST)
Date:   Wed, 5 Sep 2018 10:47:46 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 2/2] thunderbolt: Initialize after IOMMUs
Message-ID: <20180905084746.xmckzskxzsdliz3e@wunner.de>
References: <20180903132012.23531-1-mika.westerberg@linux.intel.com>
 <20180903132012.23531-2-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903132012.23531-2-mika.westerberg@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 04:20:12PM +0300, Mika Westerberg wrote:
> If IOMMU is enabled and Thunderbolt driver is built into the kernel
> image, it will be probed before IOMMUs are attached to the PCI bus.
> Because of this DMA mappings the driver does will not go through IOMMU
> and start failing right after IOMMUs are enabled.
> 
> For this reason move the Thunderbolt driver initialization happen at
> rootfs level.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/thunderbolt/nhi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> index 88cff05a1808..5cd6bdfa068f 100644
> --- a/drivers/thunderbolt/nhi.c
> +++ b/drivers/thunderbolt/nhi.c
> @@ -1191,5 +1191,5 @@ static void __exit nhi_unload(void)
>  	tb_domain_exit();
>  }
>  
> -fs_initcall(nhi_init);
> +rootfs_initcall(nhi_init);
>  module_exit(nhi_unload);

What if the rootfs is located on a Thunderbolt-attached drive and
the thunderbolt driver needs to establish tunnels to that drive
before rootfs can be accessed?  Doesn't the above break such a setup?

I think the dependency on the IOMMU should be open coded by returning
-EPROBE_DEFER from the ->probe hook if it's not yet attached.
Shuffling around initcall order is just applying duct tape.

Commit acb40d841257 already changed module_init() to fs_initcall()
and now it has to be changed again.  Shows how fragile this is.

Thanks,

Lukas
