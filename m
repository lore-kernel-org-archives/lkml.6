Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752812AbeDRRwX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 13:52:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51148 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752280AbeDRRwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 13:52:21 -0400
Date: Wed, 18 Apr 2018 19:52:01 +0200
From: Borislav Petkov <bp@alien8.de>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com,
        shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com,
        linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org,
        mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com
Subject: Re: [RFC PATCH v2 2/4] acpi: apei: Split GHES handlers outside of
 ghes_do_proc
Message-ID: <20180418175201.GI4795@pd.tnic>
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
 <20180416215903.7318-3-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180416215903.7318-3-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 04:59:01PM -0500, Alexandru Gagniuc wrote:
>  static void ghes_do_proc(struct ghes *ghes,
>  			 const struct acpi_hest_generic_status *estatus)
>  {
>  	int sev, sec_sev;
>  	struct acpi_hest_generic_data *gdata;
> +	const struct ghes_handler *handler;
>  	guid_t *sec_type;
>  	guid_t *fru_id = &NULL_UUID_LE;
>  	char *fru_text = "";
> @@ -478,21 +537,10 @@ static void ghes_do_proc(struct ghes *ghes,
>  		if (gdata->validation_bits & CPER_SEC_VALID_FRU_TEXT)
>  			fru_text = gdata->fru_text;
>  
> -		if (guid_equal(sec_type, &CPER_SEC_PLATFORM_MEM)) {
> -			struct cper_sec_mem_err *mem_err = acpi_hest_get_payload(gdata);
> -
> -			ghes_edac_report_mem_error(sev, mem_err);
> -
> -			arch_apei_report_mem_error(sev, mem_err);
> -			ghes_handle_memory_failure(gdata, sev);
> -		}
> -		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
> -			ghes_handle_aer(gdata);
> -		}
> -		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
> -			struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
>  
> -			log_arm_hw_error(err);
> +		handler = get_handler(sec_type);

I don't like this - it was better and more readable before because I can
follow which handler gets called. This change makes is less readable.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
