Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935625AbeEJATI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 20:19:08 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41048 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934234AbeEJATG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 20:19:06 -0400
X-Google-Smtp-Source: AB8JxZqDn8x0tdJnUcJ6YSJUWG1TY1K7Sy4D2TV0P+UQ6F8h0gC6AkDjpeQFkxr/ej/HBmFRlkhldQ==
Date: Wed, 9 May 2018 17:19:03 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Loic Pallardy <loic.pallardy@st.com>
Cc: ohad@wizery.com, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com,
        benjamin.gaignard@linaro.org
Subject: Re: [PATCH v3 07/13] remoteproc: introduce
 rproc_find_carveout_by_name function
Message-ID: <20180510001903.GD29093@builder>
References: <1519921440-21356-1-git-send-email-loic.pallardy@st.com>
 <1519921440-21356-8-git-send-email-loic.pallardy@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519921440-21356-8-git-send-email-loic.pallardy@st.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01 Mar 08:23 PST 2018, Loic Pallardy wrote:

> This patch provides a new function to find a carveout according
> to a name.
> If match found, this function returns a pointer on the corresponding
> carveout (rproc_mem_entry structure).
> 
> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> ---
>  drivers/remoteproc/remoteproc_core.c | 43 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 91aa22b..7a500cb 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -216,6 +216,49 @@ void *rproc_da_to_va(struct rproc *rproc, u64 da, int len)
>  }
>  EXPORT_SYMBOL(rproc_da_to_va);
>  
> +/**
> + * rproc_find_carveout_by_name() - lookup the carveout region by a name
> + * @rproc: handle of a remote processor
> + * @name,..: carveout name to find (standard printf format)
> + *
> + * Platform driver has the capability to register some pre-allacoted carveout
> + * (physically contiguous memory regions) before rproc firmware loading and
> + * associated resource table analysis. These regions may be dedicated memory
> + * regions internal to the coprocessor or specified DDR region with specific
> + * attributes
> + *
> + * This function is a helper function with which we can go over the
> + * allocated carveouts and return associated region characteristics like
> + * coprocessor address, length or processor virtual address.
> + *
> + * The function returns a valid pointer on carveout entry on success
> + * or NULL on failure.

The kerneldoc format for describing the return value is

 * Return: description

> + */
> +struct rproc_mem_entry *
> +rproc_find_carveout_by_name(struct rproc *rproc, const char *name, ...)
> +{
> +	va_list args;
> +	char _name[32];
> +	struct rproc_mem_entry *carveout, *mem = NULL;
> +
> +	va_start(args, name);
> +	snprintf(_name, sizeof(_name), name, args);
> +	va_end(args);
> +
> +	if (!name)
> +		return NULL;

If you would like for it to actually be valid to pass NULL for name,
then I think you should move this check to the top of the function.

But I suspect that you're looking for (name[0] == '\0'), to check if we
where passed an empty string, e.g. from a resource table without
resource names.

> +
> +	list_for_each_entry(carveout, &rproc->carveouts, node) {
> +		/* Compare carveout and requested names */
> +		if (!strcmp(carveout->name, name)) {
> +			mem = carveout;
> +			break;

Just return carveout when you find it.

> +		}
> +	}
> +
> +	return mem;
> +}
> +

Regards,
Bjorn
