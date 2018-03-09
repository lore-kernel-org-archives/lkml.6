Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbeCINdT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 08:33:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:54148 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751120AbeCINdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 08:33:17 -0500
Date: Fri, 9 Mar 2018 14:33:15 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Alex Hung <alex.hung@canonical.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] firmware: dmi_scan: add DMI_OEM_STRING support to
 dmi_matches
Message-ID: <20180309143315.354ad0be@endymion>
In-Reply-To: <1519800494-32107-1-git-send-email-alex.hung@canonical.com>
References: <1519800494-32107-1-git-send-email-alex.hung@canonical.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Tue, 27 Feb 2018 22:48:14 -0800, Alex Hung wrote:
> OEM strings are defined by each OEM and they contain customized and
> useful OEM information. Supporting it provides more flexible uses of
> the dmi_matches function.
> 
> Signed-off-by: Alex Hung <alex.hung@canonical.com>
> ---
>  drivers/firmware/dmi_scan.c     | 11 +++++++++--
>  include/linux/mod_devicetable.h |  1 +
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
> index e763e14..c712e66 100644
> --- a/drivers/firmware/dmi_scan.c
> +++ b/drivers/firmware/dmi_scan.c
> @@ -775,7 +775,15 @@ static bool dmi_matches(const struct dmi_system_id *dmi)
>  		int s = dmi->matches[i].slot;
>  		if (s == DMI_NONE)
>  			break;
> -		if (dmi_ident[s]) {
> +		if (s == DMI_OEM_STRING) {
> +			/* DMI_OEM_STRING must be exact match */
> +			const struct dmi_device *valid;
> +
> +			valid = dmi_find_device(DMI_DEV_TYPE_OEM_STRING,
> +						dmi->matches[i].substr, NULL);
> +			if (valid)
> +				continue;
> +		} else if (dmi_ident[s]) {
>  			if (dmi->matches[i].exact_match) {
>  				if (!strcmp(dmi_ident[s],
>  					    dmi->matches[i].substr))
> @@ -786,7 +794,6 @@ static bool dmi_matches(const struct dmi_system_id *dmi)
>  					continue;
>  			}
>  		}
> -
>  		/* No match */
>  		return false;
>  	}

Please avoid gratuitous blank line changes.

> diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
> index 48fb2b4..7d361be 100644
> --- a/include/linux/mod_devicetable.h
> +++ b/include/linux/mod_devicetable.h
> @@ -502,6 +502,7 @@ enum dmi_field {
>  	DMI_CHASSIS_SERIAL,
>  	DMI_CHASSIS_ASSET_TAG,
>  	DMI_STRING_MAX,
> +	DMI_OEM_STRING,	/* special case - will not be in dmi_ident */
>  };
>  
>  struct dmi_strmatch {

Other than this, I'm happy with this version, so with the blank line
restored:

Reviewed-by: Jean Delvare <jdelvare@suse.de>

However it doesn't make sense to commit this change unless there will
be at least one user of it. What is the status of the piece of code
which was supposed to use this new feature?

-- 
Jean Delvare
SUSE L3 Support
