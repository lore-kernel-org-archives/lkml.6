Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3127FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3FF42086D
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ots/qzZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfANKn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:43:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55522 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbfANKn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:43:58 -0500
Received: from zn.tnic (p200300EC2BC4CA00C95BD7F0398E53C6.dip0.t-ipconnect.de [IPv6:2003:ec:2bc4:ca00:c95b:d7f0:398e:53c6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8DD151EC0543;
        Mon, 14 Jan 2019 11:43:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1547462636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cX8LKyJvsNrHgHS78ZuZm4eq19UbNYdF9joR49yc6ig=;
        b=Ots/qzZsYY7YrIcIWjz30fhUJzq3QVYICD2+7VSSXd6+yg4AdReO5D30b/faFk+Al1LDvV
        W3WBasU0Y1kKEeActecwPFDluN4r8MsMy9h7kycddvLayVQY8Q7sRgiSwuW7VlTMvdjJTp
        UI0gOYuacNswNKAnGJ9KyVSbq8uT24I=
Date:   Mon, 14 Jan 2019 11:43:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
Cc:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "keescook@chromium.org" <keescook@chromium.org>
Subject: Re: [PATCH] ACPI / APEI: Fix parsing HEST that includes Deferred
 Machine Check subtable
Message-ID: <20190114104350.GH2773@zn.tnic>
References: <20181112190029.41760-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181112190029.41760-1-Yazen.Ghannam@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 07:00:55PM +0000, Ghannam, Yazen wrote:
> From: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> ACPI 6.2 includes a new definition for a Deferred Machine Check "DMC"
> subtable.
> 
> The definition of this subtable was included in following commit:
> 
> c042933df2b1 ("ACPICA: Add support for new HEST subtable")
> 
> However, the HEST parsing function was not updated to include this new
> subtable. Therefore, Linux will fail to parse the HEST on systems that
> include a DMC entry.
> 
> Add the length check for the new DMC subtable so that HEST parsing
> doesn't fail on systems that include it.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/acpi/apei/hest.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
> index b1e9f81ebeea..0935a0ef37e5 100644
> --- a/drivers/acpi/apei/hest.c
> +++ b/drivers/acpi/apei/hest.c
> @@ -53,6 +53,7 @@ static const int hest_esrc_len_tab[ACPI_HEST_TYPE_RESERVED] = {
>  	[ACPI_HEST_TYPE_AER_BRIDGE] = sizeof(struct acpi_hest_aer_bridge),
>  	[ACPI_HEST_TYPE_GENERIC_ERROR] = sizeof(struct acpi_hest_generic),
>  	[ACPI_HEST_TYPE_GENERIC_ERROR_V2] = sizeof(struct acpi_hest_generic_v2),
> +	[ACPI_HEST_TYPE_IA32_DEFERRED_CHECK] = -1,
>  };
>  
>  static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
> @@ -75,6 +76,11 @@ static int hest_esrc_len(struct acpi_hest_header *hest_hdr)
>  		mc = (struct acpi_hest_ia_machine_check *)hest_hdr;
>  		len = sizeof(*mc) + mc->num_hardware_banks *
>  			sizeof(struct acpi_hest_ia_error_bank);
> +	} else if (hest_type == ACPI_HEST_TYPE_IA32_DEFERRED_CHECK) {
> +		struct acpi_hest_ia_deferred_check *mc;
> +		mc = (struct acpi_hest_ia_deferred_check *)hest_hdr;
> +		len = sizeof(*mc) + mc->num_hardware_banks *
> +			sizeof(struct acpi_hest_ia_error_bank);
>  	}
>  	BUG_ON(len == -1);
>  
> -- 

Reviewed-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
