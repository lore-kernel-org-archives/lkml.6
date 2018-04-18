Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753126AbeDRRyg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 13:54:36 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51258 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753071AbeDRRye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 13:54:34 -0400
Date: Wed, 18 Apr 2018 19:54:15 +0200
From: Borislav Petkov <bp@alien8.de>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: linux-acpi@vger.kernel.org, linux-edac@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com,
        tbaicar@codeaurora.org, will.deacon@arm.com, james.morse@arm.com,
        shiju.jose@huawei.com, zjzhang@codeaurora.org, gengdongjiu@huawei.com,
        linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, devel@acpica.org,
        mchehab@kernel.org, robert.moore@intel.com, erik.schmauss@intel.com
Subject: Re: [RFC PATCH v2 3/4] acpi: apei: Do not panic() when correctable
 errors are marked as fatal.
Message-ID: <20180418175415.GJ4795@pd.tnic>
References: <20180416215903.7318-1-mr.nuke.me@gmail.com>
 <20180416215903.7318-4-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180416215903.7318-4-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 04:59:02PM -0500, Alexandru Gagniuc wrote:
> Firmware is evil:
>  - ACPI was created to "try and make the 'ACPI' extensions somehow
>  Windows specific" in order to "work well with NT and not the others
>  even if they are open"
>  - EFI was created to hide "secret" registers from the OS.
>  - UEFI was created to allow compromising an otherwise secure OS.
> 
> Never has firmware been created to solve a problem or simplify an
> otherwise cumbersome process. It is of no surprise then, that
> firmware nowadays intentionally crashes an OS.

I don't believe I'm saying this but, get rid of that rant. Even though I
agree, it doesn't belong in a commit message.

> 
> One simple way to do that is to mark GHES errors as fatal. Firmware
> knows and even expects that an OS will crash in this case. And most
> OSes do.
> 
> PCIe errors are notorious for having different definitions of "fatal".
> In ACPI, and other firmware sandards, 'fatal' means the machine is
> about to explode and needs to be reset. In PCIe, on the other hand,
> fatal means that the link to a device has died. In the hotplug world
> of PCIe, this is akin to a USB disconnect. From that view, the "fatal"
> loss of a link is a normal event. To allow a machine to crash in this
> case is downright idiotic.
> 
> To solve this, implement an IRQ safe handler for AER. This makes sure
> we have enough information to invoke the full AER handler later down
> the road, and tells ghes_notify_nmi that "It's all cool".
> ghes_notify_nmi() then gets calmed down a little, and doesn't panic().
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/acpi/apei/ghes.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 2119c51b4a9e..e0528da4e8f8 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -481,12 +481,26 @@ static int ghes_handle_aer(struct acpi_hest_generic_data *gdata, int sev)
>  	return ghes_severity(gdata->error_severity);
>  }
>  
> +static int ghes_handle_aer_irqsafe(struct acpi_hest_generic_data *gdata,
> +				   int sev)
> +{
> +	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
> +
> +	/* The system can always recover from AER errors. */
> +	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
> +		pcie_err->validation_bits & CPER_PCIE_VALID_AER_INFO)
> +		return CPER_SEV_RECOVERABLE;
> +
> +	return ghes_severity(gdata->error_severity);
> +}

Well, Tyler touched that AER error severity handling recently and we had
it all nicely documented in the comment above ghes_handle_aer().

Your ghes_handle_aer_irqsafe() graft basically bypasses
ghes_handle_aer() instead of incorporating in it.

If all you wanna say is, the severity computation should go through all
the sections and look at each error's severity before making a decision,
then add that to ghes_severity() instead of doing that "deferrable"
severity dance.

And add the changes to the policy to the comment above
ghes_handle_aer(). I don't want any changes from people coming and going
and leaving us scratching heads why we did it this way.

And no need for those handlers and so on - make it simple first - then we
can talk more complex handling.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
