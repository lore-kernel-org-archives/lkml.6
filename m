Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751301AbeC3Jcu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 05:32:50 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55548 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbeC3Jcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 05:32:48 -0400
Date: Fri, 30 Mar 2018 11:32:29 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Vikas Shivappa <vikas.shivappa@linux.intel.com>
cc: vikas.shivappa@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, fenghua.yu@intel.com,
        sai.praneeth.prakhya@intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com
Subject: Re: [PATCH 2/6] x86/intel_rdt/mba_sc: Add support to enable/disable
 via mount option
In-Reply-To: <1522362376-3505-3-git-send-email-vikas.shivappa@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1803301100280.1478@nanos.tec.linutronix.de>
References: <1522362376-3505-1-git-send-email-vikas.shivappa@linux.intel.com> <1522362376-3505-3-git-send-email-vikas.shivappa@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Mar 2018, Vikas Shivappa wrote:

Subject: x86/intel_rdt/mba_sc: Add support to enable/disable via mount option

Huch? From Documentation:

      The ``summary phrase`` in the email's Subject should concisely
      describe the patch which that email contains.

You're introducing somthing new: mba_sc

It's completely unclear what that is and what it means.

     x86/intel_rdt: Add mount option for bandwidth allocation in MB/s

or something like that. 

> Specify a new mount option "mba_MB" to enable the user to specify MBA
> bandwidth in Megabytes(Software Controller/SC) instead of b/w

You cannot specify bandwidth in Megabytes. Bandwidth is a bit-rate and the
units are multiples of bits per second and not Megabytes.

> --- a/arch/x86/kernel/cpu/intel_rdt.h
> +++ b/arch/x86/kernel/cpu/intel_rdt.h
> @@ -259,6 +259,7 @@ struct rdt_cache {
>   * @min_bw:		Minimum memory bandwidth percentage user can request
>   * @bw_gran:		Granularity at which the memory bandwidth is allocated
>   * @delay_linear:	True if memory B/W delay is in linear scale
> + * @bw_byte:		True if memory B/W is specified in bytes

So the mount parameter says Megabytes, but here you say bytes? What?

And bw_byte is a misnomer. bw_bytes if you really mean bytes. bw_mb if it's megabytes.

> +#define is_mba_linear() rdt_resources_all[RDT_RESOURCE_MBA].membw.delay_linear
> +#define is_mba_MBctrl() rdt_resources_all[RDT_RESOURCE_MBA].membw.bw_byte

Please use inlines and no camel case. That's horrible.

> +
>  /**
>   * struct rdt_resource - attributes of an RDT resource
>   * @rid:		The index of the resource
> diff --git a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
> index fca759d..0707191 100644
> --- a/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
> +++ b/arch/x86/kernel/cpu/intel_rdt_rdtgroup.c
> @@ -1041,6 +1041,24 @@ static int set_cache_qos_cfg(int level, bool enable)
>  	return 0;
>  }
>  
> +static void __set_mba_byte_ctrl(bool byte_ctrl)
> +{
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_MBA];
> +
> +	r->membw.bw_byte = byte_ctrl;

I don't see the point of this extra function. It has exactly one user.

> +}
> +
> +/*
> + * MBA allocation in bytes is only supported if
> + * MBM is supported and MBA is in linear scale.
> +*/

Hint: checkpatch.pl is not optional

> +static void set_mba_byte_ctrl(bool byte_ctrl)
> +{
> +	if ((is_mbm_enabled() && is_mba_linear()) &&
> +	    byte_ctrl != is_mba_MBctrl())
> +		__set_mba_byte_ctrl(byte_ctrl);

And that user is a small enough function. To avoid indentation you can
simply return when the condition is false.

Also if the user wants to mount with the MB option and it's not supported,
why are you not returning an error code and refuse the mount? That's just
wrong.

> +
>  static int cdp_enable(int level, int data_type, int code_type)
>  {
>  	struct rdt_resource *r_ldata = &rdt_resources_all[data_type];
> @@ -1104,7 +1122,7 @@ static void cdp_disable_all(void)
>  		cdpl2_disable();
>  }
>  
> -static int parse_rdtgroupfs_options(char *data)
> +static int parse_rdtgroupfs_options(char *data, bool *mba_MBctrl)

What?

>  {
>  	char *token, *o = data;
>  	int ret = 0;
> @@ -1123,6 +1141,8 @@ static int parse_rdtgroupfs_options(char *data)
>  			ret = cdpl2_enable();
>  			if (ret)
>  				goto out;
> +		} else if (!strcmp(token, "mba_MB")) {
> +			*mba_MBctrl = true;

That's mindless hackery. Really. What's wrong with setting the flag in the
resource and then add the actual register fiddling right in the

	if (is_mbm_enabled()) {

section in rdt_mount()? That would be too obvious and fit into the existing
code, right?

> +	/*Set the control values before the rest of reset*/

Space after '/*' and before '*/

Aside of that the comment is pretty useless. 'the control values' ??? Which
control values? 

> +	set_mba_byte_ctrl(false);

Thanks,

	tglx
