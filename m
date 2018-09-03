Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBEEC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E6720857
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 02:45:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E6720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeICHD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 03:03:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48292 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725949AbeICHD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 03:03:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7C7B040241C5;
        Mon,  3 Sep 2018 02:45:24 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-146.pek2.redhat.com [10.72.12.146])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4507F2027EA0;
        Mon,  3 Sep 2018 02:45:16 +0000 (UTC)
Date:   Mon, 3 Sep 2018 10:45:12 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, ebiederm@xmission.com, joro@8bytes.org,
        thomas.lendacky@amd.com, kexec@lists.infradead.org,
        iommu@lists.linux-foundation.org, bhe@redhat.com
Subject: Re: [PATCH 2/5 V6] x86/ioremap: strengthen the logic in
 early_memremap_pgprot_adjust() to adjust encryption mask
Message-ID: <20180903024512.GA2568@dhcp-128-65.nay.redhat.com>
References: <20180831081930.31561-1-lijiang@redhat.com>
 <20180831081930.31561-3-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831081930.31561-3-lijiang@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 03 Sep 2018 02:45:24 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 03 Sep 2018 02:45:24 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'dyoung@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/18 at 04:19pm, Lianbo Jiang wrote:
> For kdump kernel, when SME is enabled, the acpi table and dmi table will need
> to be remapped without the memory encryption mask. So we have to strengthen
> the logic in early_memremap_pgprot_adjust(), which makes us have an opportunity
> to adjust the memory encryption mask.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  arch/x86/mm/ioremap.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index e01e6c695add..f9d9a39955f3 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -689,8 +689,15 @@ pgprot_t __init early_memremap_pgprot_adjust(resource_size_t phys_addr,
>  	encrypted_prot = true;
>  
>  	if (sme_active()) {
> +                /*
> +                 * In kdump kernel, the acpi table and dmi table will need
> +                 * to be remapped without the memory encryption mask. Here
> +                 * we have to strengthen the logic to adjust the memory
> +                 * encryption mask.

Assume the acpi/dmi tables are identical for both 1st kernel and kdump
kernel, I'm not sure what is the difference, why need special handling
for kdump. Can you add more explanations?

> +                 */
>  		if (early_memremap_is_setup_data(phys_addr, size) ||
> -		    memremap_is_efi_data(phys_addr, size))
> +		    memremap_is_efi_data(phys_addr, size) ||
> +		    is_kdump_kernel())
>  			encrypted_prot = false;
>  	}
>  
> -- 
> 2.17.1
> 

Thanks
Dave
