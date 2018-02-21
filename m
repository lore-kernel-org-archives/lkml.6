Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938708AbeBUQ6e convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:58:34 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55064 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932271AbeBUQ6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:58:32 -0500
Subject: Re: [PATCH 1/3] sysctl: Add range clamping intvec helper functions
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <1519059231-2456-1-git-send-email-longman@redhat.com>
 <1519059231-2456-2-git-send-email-longman@redhat.com>
 <20180220234146.GD1686@wotan.suse.de>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <23a98604-8be2-5055-fee1-9a0cf2068204@redhat.com>
Date: Wed, 21 Feb 2018 11:58:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180220234146.GD1686@wotan.suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20/2018 06:41 PM, Luis R. Rodriguez wrote:
> On Mon, Feb 19, 2018 at 11:53:49AM -0500, Waiman Long wrote:
>> The current intvec range helper functions will fail with error when
>> users try to assign an out-of-range value.
> As designed.
>
>> The following new non-failing range helper functions are now added:
>>  - proc_dointvec_clamp_minmax()
>>  - proc_douintvec_clamp_minmax()
>>
>> The new helper functions will clamp the value to within the given
>> min/max range without failing it.
> The commit log could be a bit more descriptive about that this is a
> supplemental additional functionality which is desired. That is, not that its a
> bug on the other callers.
>
> One has to read the code to get that the idea here of added functionality
> is to be more permissive with lower and upper values which the user inputs,
> that when the user input is below the min allowed we clamp down to the
> minimum allowed and likewise that when a user input is above the max allowed
> we camp to the max allowed.
>
> Adding something like this to the commit log and the documentation for the
> new functions should make it very clear to users, otherwise they have to go
> read the code.

I will provide more information about the need of additional API in the
patch log of the v2 patch.

>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  include/linux/sysctl.h |  6 ++++
>>  kernel/sysctl.c        | 97 ++++++++++++++++++++++++++++++++++++++++++++++----
>>  2 files changed, 96 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
>> index b769ecf..7684ea5 100644
>> --- a/include/linux/sysctl.h
>> +++ b/include/linux/sysctl.h
>> @@ -63,6 +63,12 @@ extern int proc_doulongvec_ms_jiffies_minmax(struct ctl_table *table, int,
>>  				      void __user *, size_t *, loff_t *);
>>  extern int proc_do_large_bitmap(struct ctl_table *, int,
>>  				void __user *, size_t *, loff_t *);
>> +extern int proc_dointvec_clamp_minmax(struct ctl_table *table, int write,
>> +				      void __user *buffer, size_t *lenp,
>> +				      loff_t *ppos);
>> +extern int proc_douintvec_clamp_minmax(struct ctl_table *table, int write,
>> +				       void __user *buffer, size_t *lenp,
>> +				       loff_t *ppos);
>>  
>>  /*
>>   * Register a set of sysctl names by calling register_sysctl_table
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index f98f28c..f86c3a7 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -2500,9 +2500,15 @@ static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
>>  }
>>  #endif
>>  
>> +/*
>> + * The clamping flag, if set, will clamp the input value to the range
>> + * specified by the given min/max values instead of returning error when
>> + * out of range.
>> + */
>>  struct do_proc_dointvec_minmax_conv_param {
>>  	int *min;
>>  	int *max;
>> +	bool clamp;
>>  };
> Thanks since you are driving by, do you mind first kdoc'ifying this struct, and then
> add your @clamp as a secondary patch with its documentation.

Sure. Could you provide pointers to some samples kdoc'ified structures?
I know what to do with functions, but not with structures.

>>  
>>  static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
>> @@ -2512,9 +2518,18 @@ static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
>>  	struct do_proc_dointvec_minmax_conv_param *param = data;
>>  	if (write) {
>>  		int val = *negp ? -*lvalp : *lvalp;
>> -		if ((param->min && *param->min > val) ||
>> -		    (param->max && *param->max < val))
>> -			return -EINVAL;
>> +		if (param->min && *param->min > val) {
>> +			if (param->clamp)
>> +				val = *param->min;
>> +			else
>> +				return -EINVAL;
>> +		}
>> +		if (param->max && *param->max < val) {
>> +			if (param->clamp)
>> +				val = *param->max;
>> +			else
>> +				return -EINVAL;
>> +		}
>>  		*valp = val;
>>  	} else {
>>  		int val = *valp;
>> @@ -2556,9 +2571,38 @@ int proc_dointvec_minmax(struct ctl_table *table, int write,
>>  				do_proc_dointvec_minmax_conv, &param);
>>  }
>>  
>> +/**
>> + * proc_dointvec_clamp_minmax - read a vector of integers with min/max values
>> + * @table: the sysctl table
>> + * @write: %TRUE if this is a write to the sysctl file
>> + * @buffer: the user buffer
>> + * @lenp: the size of the user buffer
>> + * @ppos: file position
>> + *
>> + * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
>> + * values from/to the user buffer, treated as an ASCII string.
>> + *
>> + * This routine will clamp the values to within the range specified by
>> + * table->extra1 (min) and table->extra2 (max).
>> + *
>> + * Returns 0 on success.
>> + */
>> +int proc_dointvec_clamp_minmax(struct ctl_table *table, int write,
>> +		  void __user *buffer, size_t *lenp, loff_t *ppos)
>> +{
>> +	struct do_proc_dointvec_minmax_conv_param param = {
>> +		.min = (int *) table->extra1,
>> +		.max = (int *) table->extra2,
>> +		.clamp = true,
>> +	};
>> +	return do_proc_dointvec(table, write, buffer, lenp, ppos,
>> +				do_proc_dointvec_minmax_conv, &param);
>> +}
>> +
>>  struct do_proc_douintvec_minmax_conv_param {
>>  	unsigned int *min;
>>  	unsigned int *max;
>> +	bool clamp;
>>  };
>>  
>>  static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
>> @@ -2573,10 +2617,18 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
>>  		if (*lvalp > UINT_MAX)
>>  			return -EINVAL;
>>  
>> -		if ((param->min && *param->min > val) ||
>> -		    (param->max && *param->max < val))
>> -			return -ERANGE;
>> -
>> +		if (param->min && *param->min > val) {
>> +			if (param->clamp)
>> +				val = *param->min;
>> +			else
>> +				return -ERANGE;
>> +		}
>> +		if (param->max && *param->max < val) {
>> +			if (param->clamp)
>> +				val = *param->max;
>> +			else
>> +				return -ERANGE;
>> +		}
>>  		*valp = val;
>>  	} else {
>>  		unsigned int val = *valp;
>> @@ -2616,6 +2668,37 @@ int proc_douintvec_minmax(struct ctl_table *table, int write,
>>  				 do_proc_douintvec_minmax_conv, &param);
>>  }
>>  
>> +/**
>> + * proc_douintvec_clamp_minmax - read a vector of uints with min/max values
>> + * @table: the sysctl table
>> + * @write: %TRUE if this is a write to the sysctl file
>> + * @buffer: the user buffer
>> + * @lenp: the size of the user buffer
>> + * @ppos: file position
>> + *
>> + * Reads/writes up to table->maxlen/sizeof(unsigned int) unsigned integer
>> + * values from/to the user buffer, treated as an ASCII string. Negative
>> + * strings are not allowed.
>> + *
>> + * This routine will clamp the values to within the range specified by
>> + * table->extra1 (min) and table->extra2 (max). There is a final sanity
>> + * check for UINT_MAX to avoid having to support wrap around uses from
>> + * userspace.
>> + *
>> + * Returns 0 on success.
>> + */
>> +int proc_douintvec_clamp_minmax(struct ctl_table *table, int write,
>> +			  void __user *buffer, size_t *lenp, loff_t *ppos)
>> +{
>> +	struct do_proc_douintvec_minmax_conv_param param = {
>> +		.min = (unsigned int *) table->extra1,
>> +		.max = (unsigned int *) table->extra2,
>> +		.clamp = true,
>> +	};
>> +	return do_proc_douintvec(table, write, buffer, lenp, ppos,
>> +				 do_proc_douintvec_minmax_conv, &param);
>> +}
>> +
>>  static int do_proc_dopipe_max_size_conv(unsigned long *lvalp,
>>  					unsigned int *valp,
>>  					int write, void *data)
> I realize your user is either built-in or not, as such a modular use is
> not yet in order, but can you still just go ahead and add the respective
> EXPORT_SYMBOL_GPL() callers as this very likely will get more users soon.

This patch is based on feedback from a customer that it is hard to know
the real range limit of what a sysctl parameter will be. This patch is
the first step in providing this kind of information by the warning in
the ring buffer as well as by reading back the sysctl parameters for
selected parameters. So far, I haven't received any request of using it
in a kernel module.

We can certainly add a patch later on to export the functions when there
is a need to do so.

-Longman
