Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334F6C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72E720837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72E720837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754605AbeFUB5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:57:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754192AbeFUB5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:57:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3100E40122CB;
        Thu, 21 Jun 2018 01:57:17 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DE0151117626;
        Thu, 21 Jun 2018 01:57:14 +0000 (UTC)
Date:   Thu, 21 Jun 2018 09:57:11 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
        iommu@lists.linux-foundation.org, dyoung@redhat.com,
        kexec@lists.infradead.org
Subject: Re: [PATCH 3/4 V3] Remap the device table of IOMMU in encrypted
 manner for kdump
Message-ID: <20180621015711.GH29979@MiWiFi-R3L-srv>
References: <20180616082714.32035-1-lijiang@redhat.com>
 <20180616082714.32035-4-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180616082714.32035-4-lijiang@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 21 Jun 2018 01:57:17 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.5]); Thu, 21 Jun 2018 01:57:17 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/16/18 at 04:27pm, Lianbo Jiang wrote:
> In kdump mode, it will copy the device table of IOMMU from the old
> device table, which is encrypted when SME is enabled in the first
> kernel. So we must remap it in encrypted manner in order to be
> automatically decrypted when we read.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
> Some changes:
> 1. add some comments
> 2. clean compile warning.
> 
>  drivers/iommu/amd_iommu_init.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 904c575..a20af4c 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -889,11 +889,24 @@ static bool copy_device_table(void)
>  	}
>  
>  	old_devtb_phys = entry & PAGE_MASK;
> +
> +	/*
> +	 *  When sme enable in the first kernel, old_devtb_phys includes the
> +	 *  memory encryption mask(sme_me_mask), we must remove the memory
> +	 *  encryption mask to obtain the true physical address in kdump mode.
> +	 */
> +	if (mem_encrypt_active() && is_kdump_kernel())
> +		old_devtb_phys = __sme_clr(old_devtb_phys);

This is my question asked in cover letter. If 1st kernel sme is off, 2nd
kernel sme is on, you remap it with sme enabled or disabled on purpose,
why does that not work? It's not concern to this patch.

> +
>  	if (old_devtb_phys >= 0x100000000ULL) {
>  		pr_err("The address of old device table is above 4G, not trustworthy!\n");
>  		return false;
>  	}
> -	old_devtb = memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
> +	old_devtb = (mem_encrypt_active() && is_kdump_kernel())
> +		    ? (__force void *)ioremap_encrypted(old_devtb_phys,
> +							dev_table_size)
> +		    : memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
> +
>  	if (!old_devtb)
>  		return false;
>  
> -- 
> 2.9.5
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
