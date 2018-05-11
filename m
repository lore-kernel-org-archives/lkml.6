Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeEKPlE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 11:41:04 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56672 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752021AbeEKPlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 11:41:02 -0400
Date: Fri, 11 May 2018 17:40:39 +0200
From: Borislav Petkov <bp@alien8.de>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: alex_gagniuc@dellteam.com, austin_bolen@dell.com, shyam_iyer@dell.com,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
        Shiju Jose <shiju.jose@huawei.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        Dongjiu Geng <gengdongjiu@huawei.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        devel@acpica.org
Subject: Re: [RFC PATCH v4 3/3] acpi: apei: Do not panic() on PCIe errors
 reported through GHES
Message-ID: <20180511154039.GD12705@pd.tnic>
References: <20180430212836.7807-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-3-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180430213358.8319-3-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 04:33:52PM -0500, Alexandru Gagniuc wrote:
> The policy was to panic() when GHES said that an error is "Fatal".
> This logic is wrong for several reasons, as it doesn't take into
> account what caused the error.
> 
> PCIe fatal errors indicate that the link to a device is either
> unstable or unusable. They don't indicate that the machine is on fire,
> and they are not severe enough that we need to panic(). Instead of
> relying on crackmonkey firmware, evaluate the error severity based on
	     ^^^^^^^^^^^^

Please keep the smartass formulations for the ML only and do not let
them leak into commit messages.

> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/acpi/apei/ghes.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index c9f1971333c1..49318fba409c 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -425,8 +425,7 @@ static void ghes_handle_memory_failure(struct acpi_hest_generic_data *gdata, int
>   * GHES_SEV_RECOVERABLE -> AER_NONFATAL
>   * GHES_SEV_RECOVERABLE && CPER_SEC_RESET -> AER_FATAL
>   *     These both need to be reported and recovered from by the AER driver.
> - * GHES_SEV_PANIC does not make it to this handling since the kernel must
> - *     panic.
> + * GHES_SEV_PANIC -> AER_FATAL
>   */
>  static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
>  {
> @@ -459,6 +458,46 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
>  #endif
>  }
>  
> +/* PCIe errors should not cause a panic. */
> +static int ghes_sec_pcie_severity(struct acpi_hest_generic_data *gdata)
> +{
> +	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
> +
> +	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
> +	    pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO &&
> +	    IS_ENABLED(CONFIG_ACPI_APEI_PCIEAER))

How is PCIe error severity dependent on whether the AER error reporting
driver is enabled (and possibly not even loaded) on the system?

> +		return CPER_SEV_RECOVERABLE;
> +
> +	return ghes_cper_severity(gdata->error_severity);
> +}
> +/*

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
