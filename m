Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751410AbeBTXlt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 18:41:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:57011 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751053AbeBTXls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 18:41:48 -0500
Date: Tue, 20 Feb 2018 23:41:46 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 1/3] sysctl: Add range clamping intvec helper functions
Message-ID: <20180220234146.GD1686@wotan.suse.de>
References: <1519059231-2456-1-git-send-email-longman@redhat.com>
 <1519059231-2456-2-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519059231-2456-2-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 11:53:49AM -0500, Waiman Long wrote:
> The current intvec range helper functions will fail with error when
> users try to assign an out-of-range value.

As designed.

> The following new non-failing range helper functions are now added:
>  - proc_dointvec_clamp_minmax()
>  - proc_douintvec_clamp_minmax()
> 
> The new helper functions will clamp the value to within the given
> min/max range without failing it.

The commit log could be a bit more descriptive about that this is a
supplemental additional functionality which is desired. That is, not that its a
bug on the other callers.

One has to read the code to get that the idea here of added functionality
is to be more permissive with lower and upper values which the user inputs,
that when the user input is below the min allowed we clamp down to the
minimum allowed and likewise that when a user input is above the max allowed
we camp to the max allowed.

Adding something like this to the commit log and the documentation for the
new functions should make it very clear to users, otherwise they have to go
read the code.

> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/sysctl.h |  6 ++++
>  kernel/sysctl.c        | 97 ++++++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 96 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index b769ecf..7684ea5 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -63,6 +63,12 @@ extern int proc_doulongvec_ms_jiffies_minmax(struct ctl_table *table, int,
>  				      void __user *, size_t *, loff_t *);
>  extern int proc_do_large_bitmap(struct ctl_table *, int,
>  				void __user *, size_t *, loff_t *);
> +extern int proc_dointvec_clamp_minmax(struct ctl_table *table, int write,
> +				      void __user *buffer, size_t *lenp,
> +				      loff_t *ppos);
> +extern int proc_douintvec_clamp_minmax(struct ctl_table *table, int write,
> +				       void __user *buffer, size_t *lenp,
> +				       loff_t *ppos);
>  
>  /*
>   * Register a set of sysctl names by calling register_sysctl_table
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index f98f28c..f86c3a7 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -2500,9 +2500,15 @@ static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
>  }
>  #endif
>  
> +/*
> + * The clamping flag, if set, will clamp the input value to the range
> + * specified by the given min/max values instead of returning error when
> + * out of range.
> + */
>  struct do_proc_dointvec_minmax_conv_param {
>  	int *min;
>  	int *max;
> +	bool clamp;
>  };

Thanks since you are driving by, do you mind first kdoc'ifying this struct, and then
add your @clamp as a secondary patch with its documentation.

>  
>  static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
> @@ -2512,9 +2518,18 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
>  	struct do_proc_dointvec_minmax_conv_param *param = data;
>  	if (write) {
>  		int val = *negp ? -*lvalp : *lvalp;
> -		if ((param->min && *param->min > val) ||
> -		    (param->max && *param->max < val))
> -			return -EINVAL;
> +		if (param->min && *param->min > val) {
> +			if (param->clamp)
> +				val = *param->min;
> +			else
> +				return -EINVAL;
> +		}
> +		if (param->max && *param->max < val) {
> +			if (param->clamp)
> +				val = *param->max;
> +			else
> +				return -EINVAL;
> +		}
>  		*valp = val;
>  	} else {
>  		int val = *valp;
> @@ -2556,9 +2571,38 @@ int proc_dointvec_minmax(struct ctl_table *table, int write,
>  				do_proc_dointvec_minmax_conv, &param);
>  }
>  
> +/**
> + * proc_dointvec_clamp_minmax - read a vector of integers with min/max values
> + * @table: the sysctl table
> + * @write: %TRUE if this is a write to the sysctl file
> + * @buffer: the user buffer
> + * @lenp: the size of the user buffer
> + * @ppos: file position
> + *
> + * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
> + * values from/to the user buffer, treated as an ASCII string.
> + *
> + * This routine will clamp the values to within the range specified by
> + * table->extra1 (min) and table->extra2 (max).
> + *
> + * Returns 0 on success.
> + */
> +int proc_dointvec_clamp_minmax(struct ctl_table *table, int write,
> +		  void __user *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	struct do_proc_dointvec_minmax_conv_param param = {
> +		.min = (int *) table->extra1,
> +		.max = (int *) table->extra2,
> +		.clamp = true,
> +	};
> +	return do_proc_dointvec(table, write, buffer, lenp, ppos,
> +				do_proc_dointvec_minmax_conv, &param);
> +}
> +
>  struct do_proc_douintvec_minmax_conv_param {
>  	unsigned int *min;
>  	unsigned int *max;
> +	bool clamp;
>  };
>  
>  static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
> @@ -2573,10 +2617,18 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
>  		if (*lvalp > UINT_MAX)
>  			return -EINVAL;
>  
> -		if ((param->min && *param->min > val) ||
> -		    (param->max && *param->max < val))
> -			return -ERANGE;
> -
> +		if (param->min && *param->min > val) {
> +			if (param->clamp)
> +				val = *param->min;
> +			else
> +				return -ERANGE;
> +		}
> +		if (param->max && *param->max < val) {
> +			if (param->clamp)
> +				val = *param->max;
> +			else
> +				return -ERANGE;
> +		}
>  		*valp = val;
>  	} else {
>  		unsigned int val = *valp;
> @@ -2616,6 +2668,37 @@ int proc_douintvec_minmax(struct ctl_table *table, int write,
>  				 do_proc_douintvec_minmax_conv, &param);
>  }
>  
> +/**
> + * proc_douintvec_clamp_minmax - read a vector of uints with min/max values
> + * @table: the sysctl table
> + * @write: %TRUE if this is a write to the sysctl file
> + * @buffer: the user buffer
> + * @lenp: the size of the user buffer
> + * @ppos: file position
> + *
> + * Reads/writes up to table->maxlen/sizeof(unsigned int) unsigned integer
> + * values from/to the user buffer, treated as an ASCII string. Negative
> + * strings are not allowed.
> + *
> + * This routine will clamp the values to within the range specified by
> + * table->extra1 (min) and table->extra2 (max). There is a final sanity
> + * check for UINT_MAX to avoid having to support wrap around uses from
> + * userspace.
> + *
> + * Returns 0 on success.
> + */
> +int proc_douintvec_clamp_minmax(struct ctl_table *table, int write,
> +			  void __user *buffer, size_t *lenp, loff_t *ppos)
> +{
> +	struct do_proc_douintvec_minmax_conv_param param = {
> +		.min = (unsigned int *) table->extra1,
> +		.max = (unsigned int *) table->extra2,
> +		.clamp = true,
> +	};
> +	return do_proc_douintvec(table, write, buffer, lenp, ppos,
> +				 do_proc_douintvec_minmax_conv, &param);
> +}
> +
>  static int do_proc_dopipe_max_size_conv(unsigned long *lvalp,
>  					unsigned int *valp,
>  					int write, void *data)

I realize your user is either built-in or not, as such a modular use is
not yet in order, but can you still just go ahead and add the respective
EXPORT_SYMBOL_GPL() callers as this very likely will get more users soon.

  Luis
