Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 999BFC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 574F9205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 574F9205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbeKAUeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 16:34:17 -0400
Received: from foss.arm.com ([217.140.101.70]:55186 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727507AbeKAUeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 16:34:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3BFDA78;
        Thu,  1 Nov 2018 04:31:43 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C11A3F71D;
        Thu,  1 Nov 2018 04:31:41 -0700 (PDT)
Date:   Thu, 1 Nov 2018 11:31:36 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, rafael.j.wysocki@intel.com,
        takahiro.akashi@linaro.org, sudeep.holla@arm.com, ahs3@redhat.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: acpi: Prepare for longer MADTs
Message-ID: <20181101113136.GA6608@e107981-ln.cambridge.arm.com>
References: <20181012192937.3819951-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012192937.3819951-1-jeremy.linton@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 02:29:37PM -0500, Jeremy Linton wrote:
> The BAD_MADT_GICC_ENTRY check is a little too strict because
> it rejects MADT entries that don't match the currently known
> lengths. We should remove this restriction to avoid problems
> if the table length changes. Future code which might depend on
> additional fields should be written to validate those fields
> before using them, rather than trying to globally check
> known MADT version lengths.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/include/asm/acpi.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Hi Jeremy,

I assume there is no [PATCH 1/2] (to make sure I have not missed
anything).

> diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
> index 709208dfdc8b..4d0946bd485a 100644
> --- a/arch/arm64/include/asm/acpi.h
> +++ b/arch/arm64/include/asm/acpi.h
> @@ -22,12 +22,12 @@
>  #include <asm/tlbflush.h>
>  
>  /* Macros for consistency checks of the GICC subtable of MADT */
> -#define ACPI_MADT_GICC_LENGTH	\
> -	(acpi_gbl_FADT.header.revision < 6 ? 76 : 80)
> +#define ACPI_MADT_GICC_MIN_LENGTH   ACPI_OFFSET(  \
> +	struct acpi_madt_generic_interrupt, efficiency_class)

I would add a comment explaining why the efficiency_class offset
corresponds to the min length, I will do it myself before sending it
upstream.

I will take this patch and send it to Will/Catalin with ARM64 ACPI
material for v4.21.

Thanks,
Lorenzo

>  
>  #define BAD_MADT_GICC_ENTRY(entry, end)					\
> -	(!(entry) || (entry)->header.length != ACPI_MADT_GICC_LENGTH ||	\
> -	(unsigned long)(entry) + ACPI_MADT_GICC_LENGTH > (end))
> +	(!(entry) || (entry)->header.length < ACPI_MADT_GICC_MIN_LENGTH || \
> +	(unsigned long)(entry) + (entry)->header.length > (end))
>  
>  /* Basic configuration for ACPI */
>  #ifdef	CONFIG_ACPI
> -- 
> 2.14.3
> 
