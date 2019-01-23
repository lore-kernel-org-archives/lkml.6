Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F4CC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533BD21019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 11:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ozriKLMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbfAWLyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 06:54:11 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34446 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbfAWLyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 06:54:11 -0500
Received: from zn.tnic (p200300EC2BCA6A00E10FD21FCC1A9F7B.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:6a00:e10f:d21f:cc1a:9f7b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5CD641EC05A1;
        Wed, 23 Jan 2019 12:54:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548244449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Sj/DTan/IH2RaxNYamagDLmM/z5EzjVodRYC6RBzHtM=;
        b=ozriKLMDSEjfuUTq43FHNMn1LhcoMU7bSFsyhMPoRSnVxcfbYkibJRAq/NobVyCvTzkxCU
        evdLmhdXubifCF5zCncEo3CQRn3sjVRiWi3qquohZ+CDid26+lxSlA3pusD/Qka+NOCski
        CMBEKF0cRX3gAFhA6FnACg/njapm2pY=
Date:   Wed, 23 Jan 2019 12:54:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ross Lagerwall <ross.lagerwall@citrix.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-efi@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH 2/2] efi/cper: Avoid possible OOB when checking generic
 data block
Message-ID: <20190123115402.GB3227@zn.tnic>
References: <20190122160912.27312-1-ross.lagerwall@citrix.com>
 <20190122160912.27312-3-ross.lagerwall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190122160912.27312-3-ross.lagerwall@citrix.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 04:09:12PM +0000, Ross Lagerwall wrote:
> When checking a generic status block, we iterate over all the generic
> data blocks. The loop condition only checks that the start of the
> generic data block is valid (within estatus->data_length) but not the
> whole block. Because the size of data blocks (excluding error data) may
> vary depending on the revision and the revision is contained within the
> data block, ensure that enough of the current data block is valid before
> dereferencing any members otherwise an OOB access may occur if

Please write out the OOB abbreviation in your commit messages.

> estatus->data_length is invalid. This relies on the fact that
> struct acpi_hest_generic_data_v300 is a superset of the earlier version.
> Also rework the other checks to avoid potential underflow.
> 
> Signed-off-by: Ross Lagerwall <ross.lagerwall@citrix.com>
> ---
>  drivers/firmware/efi/cper.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
> index a7902fccdcfa..7cc18874b9d0 100644
> --- a/drivers/firmware/efi/cper.c
> +++ b/drivers/firmware/efi/cper.c
> @@ -546,7 +546,7 @@ EXPORT_SYMBOL_GPL(cper_estatus_check_header);
>  int cper_estatus_check(const struct acpi_hest_generic_status *estatus)
>  {
>  	struct acpi_hest_generic_data *gdata;
> -	unsigned int data_len, gedata_len;
> +	unsigned int data_len, record_len;
>  	int rc;
>  
>  	rc = cper_estatus_check_header(estatus);
> @@ -555,10 +555,12 @@ int cper_estatus_check(const struct acpi_hest_generic_status *estatus)
>  	data_len = estatus->data_length;
>  
>  	apei_estatus_for_each_section(estatus, gdata) {
> -		gedata_len = acpi_hest_get_error_length(gdata);
> -		if (gedata_len > data_len - acpi_hest_get_size(gdata))
> +		if (sizeof(struct acpi_hest_generic_data) > data_len)
>  			return -EINVAL;

<---- newline here.

Also, add a new line before the data_len assignment above, in the function.

> -		data_len -= acpi_hest_get_record_size(gdata);
> +		record_len = acpi_hest_get_record_size(gdata);

record_size so that it matches the function name it is used to compute
this.

Btw, trying to grok this code is making my head spin.

> +		if (record_len > data_len)
> +			return -EINVAL;

<---- newline here.

Btw, those checks in the loop you can abstract away into a separate
function so that you end up with something more readable like:

        apei_estatus_for_each_section(estatus, gdata) {
                record_size = check_hest_record_size(gdata, data_len);
                if (!record_size)
                        return -EINVAL;

                data_len -= record_size;
        }

for example.

> +		data_len -= record_len;
>  	}
>  	if (data_len)
>  		return -EINVAL;
> -- 

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
