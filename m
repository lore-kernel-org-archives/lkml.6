Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755935AbeCHThS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:37:18 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55790 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752072AbeCHThR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:37:17 -0500
Subject: Re: [PATCH v3 4/6] sysctl: Warn when a clamped sysctl parameter is
 set out of range
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
References: <1519926220-7453-1-git-send-email-longman@redhat.com>
 <1519926220-7453-5-git-send-email-longman@redhat.com>
 <20180308181136.GE4449@wotan.suse.de>
From: Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <081e17ae-3854-578d-af4c-3295e8a97e67@redhat.com>
Date: Thu, 8 Mar 2018 14:37:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20180308181136.GE4449@wotan.suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2018 01:11 PM, Luis R. Rodriguez wrote:
> On Thu, Mar 01, 2018 at 12:43:38PM -0500, Waiman Long wrote:
>> Even with clamped sysctl parameters, it is still not that straight
>> forward to figure out the exact range of those parameters. One may
>> try to write extreme parameter values to see if they get clamped.
>> To make it easier, a warning with the expected range will now be
>> printed in the kernel ring buffer when a clamped sysctl parameter
>> receives an out of range value.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  include/linux/sysctl.h |  3 +++
>>  kernel/sysctl.c        | 52 ++++++++++++++++++++++++++++++++++++++++++--------
>>  2 files changed, 47 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
>> index 448aa72..3db57af 100644
>> --- a/include/linux/sysctl.h
>> +++ b/include/linux/sysctl.h
>> @@ -130,11 +130,14 @@ struct ctl_table
>>   * @CTL_FLAGS_CLAMP_RANGE: Set to indicate that the entry should be
>>   *	flexibly clamped to min/max range in case the user provided
>>   *	an incorrect value.
>> + * @CTL_FLAGS_OOR_WARNED: Set to indicate that an out of range warning
>> + * 	had been issued for that entry.
>>   *
>>   * At most 16 different flags will be allowed.
>>   */
>>  enum ctl_table_flags {
>>  	CTL_FLAGS_CLAMP_RANGE		= BIT(0),
>> +	CTL_FLAGS_OOR_WARNED		= BIT(1),
>>  };
>>  
>>  struct ctl_node {
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index af351ed..6c68e77 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -2505,6 +2505,7 @@ static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
>>   * @min: pointer to minimum allowable value
>>   * @max: pointer to maximum allowable value
>>   * @flags: pointer to flags
>> + * @name: sysctl parameter name
>>   *
>>   * The do_proc_dointvec_minmax_conv_param structure provides the
>>   * minimum and maximum values for doing range checking for those sysctl
>> @@ -2514,31 +2515,50 @@ struct do_proc_dointvec_minmax_conv_param {
>>  	int *min;
>>  	int *max;
>>  	uint16_t *flags;
>> +	const char *name;
>>  };
>>  
>> +/* Out of range warning message */
>> +#define proc_ctl_warn(type, ...)				  \
>> +	pr_warn("Kernel parameter \"%s\" was set out of range [%" \
>> +	#type ", %" #type "], clamped to %" #type ".\n", __VA_ARGS__)
>> +
> Usage of pr_*() macros are best used if and when you first
> also define
>
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> Also if we can avoid adding a new define for a pr_warn wrapper
> even better. I'd much prefer to have a helper static void routine
> which gets some params and does the print than have a define.
>
> However you choose, I just don't want a #define around a simple
> pr_warn().
>
>    Luis

Sure. I will rework the patch to eliminate the define.

Cheers,
Longman
