Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0ECC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEB5C20897
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB5C20897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389051AbeG0L13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:27:29 -0400
Received: from foss.arm.com ([217.140.101.70]:40594 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732111AbeG0L12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:27:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DDA515AD;
        Fri, 27 Jul 2018 03:06:18 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D29D33F575;
        Fri, 27 Jul 2018 03:06:17 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 564FD1AE13AE; Fri, 27 Jul 2018 11:06:18 +0100 (BST)
Date:   Fri, 27 Jul 2018 11:06:18 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Dongjiu Geng <gengdongjiu@huawei.com>
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com, lenb@kernel.org,
        rafael.j.wysocki@intel.com, erik.schmauss@intel.com,
        robert.moore@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        devel@acpica.org
Subject: Re: [PATCH] arm64: clean the additional checks before calling
 ghes_notify_sea()
Message-ID: <20180727100617.GB25592@arm.com>
References: <1532638907-46129-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532638907-46129-1-git-send-email-gengdongjiu@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 05:01:47PM -0400, Dongjiu Geng wrote:
> In order to remove the additional check before calling the
> ghes_notify_sea(), make stub definition when !CONFIG_ACPI_APEI_SEA.
> 
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---

Acked-by: Will Deacon <will.deacon@arm.com>

Will

> This cleanup is ever mentioned by Mark Rutland in [1]
> 
> [1]:
> https://lkml.org/lkml/2018/5/31/289
> ---
>  arch/arm64/mm/fault.c | 7 +------
>  include/acpi/ghes.h   | 4 ++++
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index b8eecc7..9ffe01d 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -727,12 +727,7 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>  
>  int handle_guest_sea(phys_addr_t addr, unsigned int esr)
>  {
> -	int ret = -ENOENT;
> -
> -	if (IS_ENABLED(CONFIG_ACPI_APEI_SEA))
> -		ret = ghes_notify_sea();
> -
> -	return ret;
> +	return ghes_notify_sea();
>  }
>  
>  asmlinkage void __exception do_mem_abort(unsigned long addr, unsigned int esr,
> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
> index 1624e2b..82cb4eb 100644
> --- a/include/acpi/ghes.h
> +++ b/include/acpi/ghes.h
> @@ -118,6 +118,10 @@ static inline void *acpi_hest_get_next(struct acpi_hest_generic_data *gdata)
>  	     (void *)section - (void *)(estatus + 1) < estatus->data_length; \
>  	     section = acpi_hest_get_next(section))
>  
> +#ifdef CONFIG_ACPI_APEI_SEA
>  int ghes_notify_sea(void);
> +#else
> +static inline int ghes_notify_sea(void) { return -ENOENT; }
> +#endif
>  
>  #endif /* GHES_H */
> -- 
> 1.9.1
> 
