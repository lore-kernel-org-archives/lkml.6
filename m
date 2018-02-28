Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934757AbeB1RzP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:55:15 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34538 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933542AbeB1RzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:55:11 -0500
Subject: Re: [PATCH v2 3/5] sysctl: Warn when a clamped sysctl parameter is
 set out of range
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <1519764591-27456-1-git-send-email-longman@redhat.com>
 <1519764591-27456-4-git-send-email-longman@redhat.com>
 <20180228005746.GZ14069@wotan.suse.de>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <e58ac951-e3b7-da9c-a5f6-bf98cbb05175@redhat.com>
Date: Wed, 28 Feb 2018 12:55:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180228005746.GZ14069@wotan.suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27/2018 07:57 PM, Luis R. Rodriguez wrote:
> On Tue, Feb 27, 2018 at 03:49:49PM -0500, Waiman Long wrote:
>> Even with clamped sysctl parameters, it is still not that straight
>> forward to figure out the exact range of those parameters. One may
>> try to write extreme parameter values to see if they get clamped.
>> To make it easier, a warning with the expected range will now be
>> printed in the kernel ring buffer when a clamped sysctl parameter
>> receives an out of range value.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  include/linux/sysctl.h |  1 +
>>  kernel/sysctl.c        | 55 ++++++++++++++++++++++++++++++++++++++++++--------
>>  2 files changed, 48 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
>> index eceeaee..4e4f74a2 100644
>> --- a/include/linux/sysctl.h
>> +++ b/include/linux/sysctl.h
>> @@ -128,6 +128,7 @@ struct ctl_table
>>   * ctl_table flags (16 different flags, at most)
>>   */
>>  #define CTL_FLAGS_CLAMP_RANGE	(1 << 0) /* Clamp to min/max range */
>> +#define CTL_FLAGS_OOR_WARNED	(1 << 1) /* Out-of-range warning issued */
> With the enum set you can then kdocify this too.

Yes, will do.

>>  struct ctl_node {
>>  	struct rb_node node;
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index 2b2b30c..f9f3373 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -2515,36 +2515,54 @@ static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
>>   *  min: ptr to minimum allowable value
>>   *  max: ptr to maximum allowable value
>>   *  flags: ptr to flags
>> + *  name: sysctl parameter name
>>   */
>>  struct do_proc_dointvec_minmax_conv_param {
>>  	int *min;
>>  	int *max;
>>  	uint16_t *flags;
>> +	const char *name;
>>  };
>>  
>>  static int do_proc_dointvec_minmax_conv(bool *negp, unsigned long *lvalp,
>>  					int *valp,
>>  					int write, void *data)
>>  {
>> +#define SYSCTL_WARN_MSG	\
>> +"Kernel parameter \"%s\" was set out of range [%d, %d], clamped to %d.\n"
> Please loose this define. What about a proc_ctl_warn() which takes the
> parameters and then does the checks?

Yes, I think that is better.

>> +
>>  	struct do_proc_douintvec_minmax_conv_param *param = data;
>>  
>>  	if (write) {
>>  		unsigned int val = *lvalp;
>> +		bool clamped = false;
>>  		bool clamp = param->flags &&
>>  			   (*param->flags & CTL_FLAGS_CLAMP_RANGE);
>>  
>> @@ -2623,24 +2649,36 @@ static int do_proc_douintvec_minmax_conv(unsigned long *lvalp,
>>  			return -EINVAL;
>>  
>>  		if (param->min && *param->min > val) {
>> -			if (clamp)
>> +			if (clamp) {
>>  				val = *param->min;
>> -			else
>> +				clamped = true;
>> +			} else {
>>  				return -ERANGE;
>> +			}
>>  		}
>>  		if (param->max && *param->max < val) {
>> -			if (clamp)
>> +			if (clamp) {
>>  				val = *param->max;
>> -			else
>> +				clamped = true;
>> +			} else {
>>  				return -ERANGE;
>> +			}
>>  		}
>>  		*valp = val;
>> +		if (clamped && param->name &&
>> +		   !(*param->flags & CTL_FLAGS_OOR_WARNED)) {
>> +			pr_warn(SYSCTL_WARN_MSG, param->name,
>> +				param->min ? *param->min : 0,
>> +				param->max ? *param->max : UINT_MAX, val);
>> +			*param->flags |= CTL_FLAGS_OOR_WARNED;
> Why not just use pr_warn_once()?
>
>   Luis

Right, pr_warn_once can be used in this case.

Cheers,
Longman
