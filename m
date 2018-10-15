Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523E7C070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0DE2098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0DE2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbeJPRiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:38:16 -0400
Received: from foss.arm.com ([217.140.101.70]:60872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbeJPRiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:38:15 -0400
Received: by usa-sjc-mx-foss1.foss.arm.com (Postfix, from userid 105)
        id A76023598; Tue, 16 Oct 2018 03:03:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8458357B;
        Mon, 15 Oct 2018 02:29:46 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F58C3F5B3;
        Mon, 15 Oct 2018 02:29:24 -0700 (PDT)
Date:   Mon, 15 Oct 2018 10:29:19 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        james.morse@arm.com, rafael.j.wysocki@intel.com,
        takahiro.akashi@linaro.org, lorenzo.pieralisi@arm.com,
        ahs3@redhat.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/2] arm64: acpi: Prepare for longer MADTs
Message-ID: <20181015092919.GA1778@e107155-lin>
References: <20181012192937.3819951-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012192937.3819951-1-jeremy.linton@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
>
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
>

This makes it 76 always which is fine, just that the first user of
efficiency_class should check for the length before accessing it.
No user of efficiency_class yet, so I am fine with this change.

>  #define BAD_MADT_GICC_ENTRY(entry, end)					\
> -	(!(entry) || (entry)->header.length != ACPI_MADT_GICC_LENGTH ||	\
> -	(unsigned long)(entry) + ACPI_MADT_GICC_LENGTH > (end))
> +	(!(entry) || (entry)->header.length < ACPI_MADT_GICC_MIN_LENGTH || \
> +	(unsigned long)(entry) + (entry)->header.length > (end))
>

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep

