Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932541AbeCLUuE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 16:50:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:47857 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932397AbeCLUuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 16:50:02 -0400
Date: Mon, 12 Mar 2018 20:50:01 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 3/6] sysctl: Warn when a clamped sysctl parameter is
 set out of range
Message-ID: <20180312205001.GA4449@wotan.suse.de>
References: <1520885744-1546-1-git-send-email-longman@redhat.com>
 <1520885744-1546-4-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520885744-1546-4-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 04:15:41PM -0400, Waiman Long wrote:
> Even with clamped sysctl parameters, it is still not that straight
> forward to figure out the exact range of those parameters. One may
> try to write extreme parameter values to see if they get clamped.
> To make it easier, a warning with the expected range will now be
> printed into the kernel ring buffer when a clamped sysctl parameter
> receives an out of range value.
> 
> The pr_warn_ratelimited() macro is used to limit the number of warning
> messages that can be printed within a given period of time.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/sysctl.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 40 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 3d65f41..14aca92 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2505,6 +2505,7 @@ static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
>   * @min: pointer to minimum allowable value
>   * @max: pointer to maximum allowable value
>   * @flags: pointer to flags
> + * @name: sysctl parameter name
>   *
>   * The do_proc_dointvec_minmax_conv_param structure provides the
>   * minimum and maximum values for doing range checking for those sysctl
> @@ -2514,31 +2515,48 @@ struct do_proc_dointvec_minmax_conv_param {
>  	int *min;
>  	int *max;
>  	unsigned int *flags;
> +	const char *name;
>  };
>  
> +#ifdef pr_fmt
> +#undef pr_fmt
> +#endif
> +#define pr_fmt(fmt)	"sysctl: " fmt

No. This needs to be defined at the top of the file, please look
at other uses on kernel/*.c and just use:

#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

The filename already provides the name we want.

> +
>  static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
>  					int *valp,
>  					int write, void *data)
>  {
>  	struct do_proc_dointvec_minmax_conv_param *param = data;
> +
>  	if (write) {
>  		int val = *negp ? -*lvalp : *lvalp;
> +		bool clamped = false;
>  		bool clamp = param->flags &&
>  			   (*param->flags & CTL_FLAGS_CLAMP_RANGE);
>  
>  		if (param->min && *param->min > val) {
> -			if (clamp)
> +			if (clamp) {
>  				val = *param->min;
> -			else
> +				clamped = true;
> +			} else {
>  				return -EINVAL;
> +			}
>  		}
>  		if (param->max && *param->max < val) {
> -			if (clamp)
> +			if (clamp) {
>  				val = *param->max;
> -			else
> +				clamped = true;
> +			} else {
>  				return -EINVAL;
> +			}
>  		}
>  		*valp = val;
> +		if (clamped && param->name)
> +			pr_warn_ratelimited("\"%s\" was set out of range [%d, %d], clamped to %d.\n",
> +				param->name,
> +				param->min ? *param->min : -INT_MAX,
> +				param->max ? *param->max :  INT_MAX, val);

We already warn here but I see you also add yet-another warning for the driver....

  Luis
