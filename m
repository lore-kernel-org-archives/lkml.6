Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752292AbeC3PTE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 11:19:04 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43792 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbeC3PTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 11:19:02 -0400
X-Google-Smtp-Source: AIpwx4/NmWf/JrIJIieBmPAGxMG7EZMmc2T+Wy9JwJUYAFRraAau2hNDA0c6Ae55fTIiMi2lMTewSQ==
Date: Fri, 30 Mar 2018 07:55:40 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: davidwang <davidwang@zhaoxin.com>
Cc: jdelvare@suse.com, tglx@linutronix.de, mingo@redhat.com,
        rafel.j.wysocki@intel.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, brucechang@via-alliance.com,
        cooperyan@zhaoxin.com, qiyuanwang@zhaoxin.com, benjaminpan@viatech.com,
        lukelin@viacpu.com, timguo@zhaoxin.com
Subject: Re: [v3] hwmon, via-cputem: support new centaur CPUs
Message-ID: <20180330145540.GA13899@roeck-us.net>
References: <1522371888-30013-1-git-send-email-davidwang@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522371888-30013-1-git-send-email-davidwang@zhaoxin.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2018 at 09:04:48AM +0800, davidwang wrote:
> New centaur CPUs(Familiy == 7) also support this cpu temperature sensor.
> 
> Change from v2 to v3:
> *replace "goto" with "if...else.." according to suggestion from Guenter
>  
> Change from v1 to v2:
> *fixed the wrong if condition in patch v1.
> 	
> Signed-off-by: David Wang <davidwang@zhaoxin.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/via-cputemp.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/hwmon/via-cputemp.c b/drivers/hwmon/via-cputemp.c
> index 07a0cb0..0e81f28 100644
> --- a/drivers/hwmon/via-cputemp.c
> +++ b/drivers/hwmon/via-cputemp.c
> @@ -136,20 +136,24 @@ static int via_cputemp_probe(struct platform_device *pdev)
>  	data->id = pdev->id;
>  	data->name = "via_cputemp";
>  
> -	switch (c->x86_model) {
> -	case 0xA:
> -		/* C7 A */
> -	case 0xD:
> -		/* C7 D */
> -		data->msr_temp = 0x1169;
> -		data->msr_vid = 0x198;
> -		break;
> -	case 0xF:
> -		/* Nano */
> +	if (c->x86 == 7) {
>  		data->msr_temp = 0x1423;
> -		break;
> -	default:
> -		return -ENODEV;
> +	} else {
> +		switch (c->x86_model) {
> +		case 0xA:
> +			/* C7 A */
> +		case 0xD:
> +			/* C7 D */
> +			data->msr_temp = 0x1169;
> +			data->msr_vid = 0x198;
> +			break;
> +		case 0xF:
> +			/* Nano */
> +			data->msr_temp = 0x1423;
> +			break;
> +		default:
> +			return -ENODEV;
> +		}
>  	}
>  
>  	/* test if we can access the TEMPERATURE MSR */
> @@ -283,6 +287,7 @@ static int via_cputemp_down_prep(unsigned int cpu)
>  	{ X86_VENDOR_CENTAUR, 6, 0xa, }, /* C7 A */
>  	{ X86_VENDOR_CENTAUR, 6, 0xd, }, /* C7 D */
>  	{ X86_VENDOR_CENTAUR, 6, 0xf, }, /* Nano */
> +	{ X86_VENDOR_CENTAUR, 7, X86_MODEL_ANY, },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, cputemp_ids);
